classdef RayleighChannel < comm.internal.FadingChannel
%RayleighChannel Filter input signal through a Rayleigh fading channel
%   H = comm.RayleighChannel creates a frequency-selective or
%   frequency-flat multipath Rayleigh fading channel System object, H. This
%   object filters a real or complex input signal through the multipath
%   channel to obtain the channel impaired signal.
%
%   H = comm.RayleighChannel(Name,Value) creates a multipath Rayleigh 
%   fading channel object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments
%   in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) filters input signal X through a multipath Rayleigh 
%   fading channel and returns the result in Y. Both the input X and the
%   output signal Y are of size Ns x 1, where Ns is the number of samples.
%   The input X can be of double precision data type with real or complex
%   values. Y is of double precision data type with complex values.
%
%   [Y,PATHGAINS] = step(H,X) returns the channel path gains of the
%   underlying Rayleigh fading process in PATHGAINS. This syntax applies
%   when you set the PathGainsOutputPort property of H to true. PATHGAINS
%   is of size Ns x Np, where Np is the number of paths, i.e., the length
%   of the PathDelays property value of H. PATHGAINS is of double precision
%   data type with complex values.
% 
%   RayleighChannel methods:
%
%   step     - Filter input signal through a Rayleigh fading channel (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Rayleigh channel object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of filters, and random stream if the
%              RandomStream property is set to 'mt19937ar with seed'
%   info     - Return characteristic information about the Rayleigh channel
%
%   RayleighChannel properties:
%
%   SampleRate            - Input signal sample rate (Hz)
%   PathDelays            - Discrete path delay vector (s)
%   AveragePathGains      - Average path gain vector (dB)
%   NormalizePathGains    - Normalize path gains (logical)
%   MaximumDopplerShift   - Maximum Doppler shift (Hz)
%   DopplerSpectrum       - Doppler spectrum 
%   RandomStream          - Source of random number stream
%   Seed                  - Initial seed of mt19937ar random number stream
%   PathGainsOutputPort   - Enable path gain output (logical)
%
%   % Example: 
%   %   The System object has two methods for random number generation:
%   %   using the current global stream or the mt19937ar algorithm with a 
%   %   specified seed. By interacting with the global stream, the object 
%   %   can produce the same outputs from the two methods.
% 
%   hMod = comm.PSKModulator;
%   channelInput = step(hMod, randi([0 hMod.ModulationOrder-1],1024,1));
%   hRayleighChan = comm.RayleighChannel(...
%       'SampleRate',          10e3,...
%       'PathDelays',          [0 1.5e-4],...
%       'AveragePathGains',    [2 3],...
%       'NormalizePathGains',  true,...
%       'MaximumDopplerShift', 30,...
%       'DopplerSpectrum',     {doppler('Gaussian',0.6), doppler('Flat')},...
%       'RandomStream',        'mt19937ar with seed',...
%       'Seed',                22,...
%       'PathGainsOutputPort', true);
%
%   % Filter the modulated data using hRayleighChan
%   [chanOut1, pathGains1] = step(hRayleighChan, channelInput);
% 
%   % Now use global stream for random number generation of hRayleighChan
%   release(hRayleighChan);
%   hRayleighChan.RandomStream = 'Global stream';
% 
%   % Log the current global stream
%   loggedStream = RandStream.getGlobalStream; 
% 
%   % Create a mt19937ar stream and designate it as current global stream
%   s = RandStream('mt19937ar','Seed',22);
%   RandStream.setGlobalStream(s);
% 
%   % Filter the modulated data using hRayleighChan for the second time
%   [chanOut2, pathGains2] = step(hRayleighChan, channelInput);
%   
%   % Restore the logged global stream
%   RandStream.setGlobalStream(loggedStream);
% 
%   % Verify channel and path gain outputs are the same for two step calls
%   display(isequal(chanOut1, chanOut2));
%   display(isequal(pathGains1, pathGains2));
%
%   See also comm.AWGNChannel, comm.RicianChannel, comm.MIMOChannel,
%   comm.LTEMIMOChannel, doppler.

% Copyright 2012-2013 The MathWorks, Inc.
% $Revision: 1.1.6.3 $  $Date: 2013/05/07 07:43:13 $

%#codegen
%#ok<*EMCA>

properties (Nontunable)
    %SampleRate Sample rate (Hz)
    %   Specify the sample rate of the input signal in Hz as a double
    %   precision, real, positive scalar. The default value of this
    %   property is 1 Hz.
    SampleRate = 1;
    %PathDelays Discrete path delays (s)
    %   Specify the delays of the discrete paths in seconds as a double
    %   precision, real, scalar or row vector. When PathDelays is a scalar,
    %   the channel is frequency-flat; When PathDelays is a vector, the
    %   channel is frequency-selective. The default value of this property
    %   is 0.
    PathDelays = 0;
    %AveragePathGains Average path gains (dB)
    %   Specify the average gains of the discrete paths in dB as a double
    %   precision, real, scalar or row vector. AveragePathGains must have
    %   the same size as PathDelays. The default value of this property is
    %   0.
    AveragePathGains = 0;
    %MaximumDopplerShift Maximum Doppler shift (Hz)
    %   Specify the maximum Doppler shift for the path(s) of the channel in
    %   Hz as a double precision, real, nonnegative scalar. It applies to
    %   all the paths of the channel. When MaximumDopplerShift is 0, the
    %   channel is static for the entire input and you can use the reset
    %   method to generate a new channel realization. The
    %   MaximumDopplerShift must be smaller than SampleRate/10/fc for each
    %   path, where fc is the cutoff frequency factor of the path. For a
    %   Doppler spectrum type other than Gaussian and BiGaussian, the value
    %   of fc is 1; Otherwise, the value of fc is dependent on the Doppler
    %   spectrum structure fields. Refer to the documentation of this
    %   System object for more details about how fc is defined. The default
    %   value of this property is 0.001.
    MaximumDopplerShift = 1e-3;
    % DopplerSpectrum Doppler spectrum
    %   Specify the Doppler spectrum shape for the path(s) of the channel.
    %   This property accepts a single Doppler spectrum structure returned
    %   from the doppler function or a row cell array of such structures.
    %   The maximum Doppler shift value necessary to specify the Doppler
    %   spectrum/spectra is given by the MaximumDopplerShift property. This
    %   property applies when the MaximumDopplerShift property value is
    %   greater than 0.
    %   
    %   If you assign a single Doppler spectrum structure to 
    %   DopplerSpectrum, all paths have the same specified Doppler
    %   spectrum. The possible Doppler spectrum structures are
    %       doppler('Jakes')
    %       doppler('Flat')
    %       doppler('Rounded', ...)
    %       doppler('Bell', ...)
    %       doppler('Asymmetric Jakes', ...)
    %       doppler('Restricted Jakes', ...)
    %       doppler('Gaussian', ...) 
    %       doppler('BiGaussian', ...)
    %   
    %   If you assign a row cell array of different Doppler spectrum
    %   structures (which can be chosen from any of those listed above) to
    %   DopplerSpectrum, each path has the Doppler spectrum specified by
    %   the corresponding structure in the cell array. In this case, the
    %   length of DopplerSpectrum must be equal to the length of
    %   PathDelays.
    % 
    %   To generate code, specify this property to a single Doppler
    %   spectrum structure. The default value of this property is
    %   doppler('Jakes').
    DopplerSpectrum = doppler('Jakes'); 
end

properties(Constant, Hidden)
    FadingDistribution        = 'Rayleigh';
    SpatialCorrelation        = false;
    NumTransmitAntennas       = 1;
    NumReceiveAntennas        = 1;
    AntennaSelection          = 'Off';
    NormalizeChannelOutputs   = false;
end

methods
  function obj = RayleighChannel(varargin) % Constructor
    setProperties(obj, nargin, varargin{:});
  end
  
  function set.SampleRate(obj, Rs)
    propName = 'SampleRate';
    validateattributes(Rs, {'double'}, ...
        {'real','scalar','positive','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.SampleRate = Rs;
  end
  
  function set.PathDelays(obj, tau)
    propName = 'PathDelays';
    validateattributes(tau, {'double'}, {'real','row','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.PathDelays = tau;
  end
  
  function set.AveragePathGains(obj, PdB)
    propName = 'AveragePathGains';
    validateattributes(PdB, {'double'}, {'real','row','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.AveragePathGains = PdB;
  end

  function set.MaximumDopplerShift(obj, fd)
    propName = 'MaximumDopplerShift';
    validateattributes(fd, {'double'}, ...
        {'real','scalar','nonnegative','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.MaximumDopplerShift = fd;
  end
   
  function set.DopplerSpectrum(obj, ds)
    coder.extrinsic('fadingChanGetFcFactor');
    
    propName = 'DopplerSpectrum';
    validateattributes(ds, {'struct','cell'}, {'row'}, ... 
         [class(obj) '.' propName], propName);     
    
    if isa(ds, 'cell') 
        for idx = 1:length(ds)
            validateattributes(ds{idx}, {'struct'}, {}, ... 
                 [class(obj) '.' propName], [propName, '{', num2str(idx), '}']);
        end
    end
    
    % Set up cutoff frequency factor (not equal to 0) for each discrete
    % path. The structure field(s) is validated in the extrinsic function. 
    if isempty(coder.target)
        obj.pFcFactor = fadingChanGetFcFactor(ds); 
    else
        obj.pFcFactor = coder.internal.const(double(fadingChanGetFcFactor(ds))); 
    end
    
    obj.DopplerSpectrum = ds;
  end    
end

methods(Access = protected)   
  function validatePropertiesImpl(obj)
    % Check AveragePathGains and DopplerSpectrum sizes
    validateDelayProfileAndDoppler(obj);
  end
    
  function flag = isInactivePropertyImpl(obj, prop)
    % Use the if-else format for codegen
    if strcmp(prop, 'Seed')
        flag = strcmp(obj.RandomStream, 'Global stream');
    else
        flag = false;
    end
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@comm.internal.FadingChannel(obj);
  end
  
  function loadObjectImpl(obj, s, wasLocked)
    loadObjectImpl@comm.internal.FadingChannel(obj, s, wasLocked);
  end
  
  function s = infoImpl(obj)
    %info Returns characteristic information about the Rayleigh channel
    %   S = info(OBJ) returns a structure containing characteristic
    %   information, S, about the Rayleigh fading channel. A description of
    %   the fields and their values is as follows:
    % 
    %   ChannelFilterDelay  - Channel filter delay, measured in samples 
    %   NumSamplesProcessed - Number of samples the channel has processed 
    %                         since the last reset
    
    if ~isLocked(obj) 
        setup(obj, 1);
        release(obj);
    end
    s.ChannelFilterDelay  = obj.pChannelFilterDelay;
    s.NumSamplesProcessed = obj.pNumSamplesProcessed;
  end  
end

methods(Static, Access = protected)
  function header = getHeaderImpl
    header = matlab.system.display.Header('comm.RayleighChannel', ...
        'Title', 'Rayleigh Channel');
  end

  function groups = getPropertyGroupsImpl
    multipath = matlab.system.display.Section( ...
        'Title', 'Multipath parameters (frequency selectivity)', ...
        'PropertyList', {'SampleRate', 'PathDelays', ...
        'AveragePathGains', 'NormalizePathGains'});
        
    doppler = matlab.system.display.Section( ...
        'Title', 'Doppler parameters (time dispersion)', ...
        'PropertyList', {'MaximumDopplerShift', 'DopplerSpectrum'});
        
    randomization = matlab.system.display.Section(...
        'PropertyList', {'RandomStream', 'Seed', 'PathGainsOutputPort'});
        
    groups = [multipath doppler randomization];
  end
end

end

% [EOF]