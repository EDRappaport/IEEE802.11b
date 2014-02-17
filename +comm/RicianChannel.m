classdef RicianChannel < comm.internal.FadingChannel
%RicianChannel Filter input signal through a Rician fading channel
%   H = comm.RicianChannel creates a frequency-selective or frequency-flat
%   multipath Rician fading channel System object, H. This object filters a
%   real or complex input signal through the multipath channel to obtain
%   the channel impaired signal.
%
%   H = comm.RicianChannel(Name,Value) creates a multipath Rician fading
%   channel object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments
%   in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) filters input signal X through a multipath Rician 
%   fading channel and returns the result in Y. Both the input X and the
%   output signal Y are of size Ns x 1, where Ns is the number of samples.
%   The input X can be of double precision data type with real or complex
%   values. Y is of double precision data type with complex values.
%
%   [Y,PATHGAINS] = step(H,X) returns the channel path gains of the
%   underlying Rician fading process in PATHGAINS. This syntax applies when
%   you set the PathGainsOutputPort property of H to true. PATHGAINS is of
%   size Ns x Np, where Np is the number of paths, i.e., the length of the
%   PathDelays property value of H. PATHGAINS is of double precision data
%   type with complex values.
% 
%   RicianChannel methods:
%
%   step     - Filter input signal through a Rician fading channel (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Rician channel object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of filters, and random stream if the
%              RandomStream property is set to 'mt19937ar with seed'
%   info     - Return characteristic information about the Rician channel
%
%   RicianChannel properties:
%
%   SampleRate              - Input signal sample rate (Hz)
%   PathDelays              - Discrete path delay vector (s)
%   AveragePathGains        - Average path gain vector (dB)
%   NormalizePathGains      - Normalize path gains (logical)
%   KFactor                 - Rician K-factor scalar or vector (linear scale)
%   DirectPathDopplerShift  - Doppler shift(s) of line-of-sight component(s) (Hz)
%   DirectPathInitialPhase  - Initial phase(s) of line-of-sight component(s) (rad)
%   MaximumDopplerShift     - Maximum Doppler shift (Hz)
%   DopplerSpectrum         - Doppler spectrum 
%   RandomStream            - Source of random number stream
%   Seed                    - Initial seed of mt19937ar random number stream
%   PathGainsOutputPort     - Enable path gain output (logical)
%
%   % Example: 
%   %   How to produce repeatable outputs when a comm.RicianChannel System
%   %   object uses the global stream for random number generation.
%   
%   hMod = comm.PSKModulator;
%   channelInput = step(hMod, randi([0 hMod.ModulationOrder-1],512,1));
%   hRicianChan = comm.RicianChannel(...
%       'SampleRate',             1e6,...
%       'PathDelays',             [0.0 0.5 1.2]*1e-6,...
%       'AveragePathGains',       [0.1 0.5 0.2],...
%       'KFactor',                2.8,...
%       'DirectPathDopplerShift', 5.0,...
%       'DirectPathInitialPhase', 0.5,...
%       'MaximumDopplerShift',    50,...
%       'DopplerSpectrum',        doppler('Bell', 8),...
%       'PathGainsOutputPort',    true);
% 
%   % Log current global stream state
%   globalStream = RandStream.getGlobalStream; 
%   loggedState  = globalStream.State;
%   
%   % Filter the modulated data using hRicianChan for the first time
%   [RicianChanOut1, RicianPathGains1] = step(hRicianChan, channelInput);
%
%   % Set global stream back to the logged state and reset hRicianChan
%   globalStream.State = loggedState;
%   reset(hRicianChan);
%
%   % Filter the modulated data using hRicianChan for the second time
%   [RicianChanOut2, RicianPathGains2] = step(hRicianChan, channelInput);
%  
%   % Verify channel and path gain outputs are the same for two step calls
%   display(isequal(RicianChanOut1, RicianChanOut2));
%   display(isequal(RicianPathGains1, RicianPathGains2));
%     
%   See also comm.AWGNChannel, comm.RayleighChannel, comm.MIMOChannel,
%   comm.LTEMIMOChannel, doppler.

% Copyright 2012-2013 The MathWorks, Inc.
% $Revision: 1.1.6.2 $  $Date: 2013/04/16 04:14:30 $

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
    %KFactor K-factors
    %   Specify the K factor of a Rician fading channel as a double
    %   precision, real, positive scalar or nonnegative, non-zero row
    %   vector of the same length as PathDelays. If KFactor is a scalar,
    %   the first discrete path is a Rician fading process with a Rician
    %   K-factor of KFactor and the remaining discrete paths are
    %   independent Rayleigh fading processes. If KFactor is a row vector,
    %   the discrete path corresponding to a positive element of the
    %   KFactor vector is a Rician fading process with a Rician K-factor
    %   specified by that element and the discrete path corresponding to a
    %   zero-valued element of the KFactor vector is a Rayleigh fading
    %   process. The default value of this property is 3.
    KFactor = 3;
    %DirectPathDopplerShift LOS path Doppler shifts (Hz)
    %   Specify the Doppler shift(s) of the line-of-sight component(s) of a
    %   Rician fading channel in Hz as a double precision, real scalar or
    %   row vector. DirectPathDopplerShift must have the same size as
    %   KFactor. If DirectPathDopplerShift is a scalar, it is the
    %   line-of-sight component Doppler shift of the first discrete path
    %   that is a Rician fading process. If DirectPathDopplerShift is a row
    %   vector, the discrete path that is a Rician fading process indicated
    %   by a positive element of the KFactor vector has its line-of-sight
    %   component Doppler shift specified by the corresponding element of
    %   DirectPathDopplerShift. The default value of this property is 0.
    DirectPathDopplerShift = 0;
    %DirectPathInitialPhase LOS path initial phases (rad)
    %   Specify the initial phase(s) of the line-of-sight component(s) of a
    %   Rician fading channel in radians as a double precision, real scalar
    %   or row vector. DirectPathInitialPhase must have the same size as
    %   KFactor. If DirectPathInitialPhase is a scalar, it is the
    %   line-of-sight component initial phase of the first discrete path
    %   that is a Rician fading process. If DirectPathInitialPhase is a row
    %   vector, the discrete path that is a Rician fading process indicated
    %   by a positive element of the KFactor vector has its line-of-sight
    %   component initial phase specified by the corresponding element of
    %   DirectPathInitialPhase. The default value of this property is 0.
    DirectPathInitialPhase = 0;    
end

properties(Constant, Hidden)
    FadingDistribution        = 'Rician';
    SpatialCorrelation        = false;
    NumTransmitAntennas       = 1;
    NumReceiveAntennas        = 1;
    AntennaSelection          = 'Off';
    NormalizeChannelOutputs   = false;
end

methods
  function obj = RicianChannel(varargin) % Constructor
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
  
  function set.KFactor(obj, K)
    propName = 'KFactor'; 
    validateattributes(K, {'double'}, ...         
         {'real','row','finite','nonnegative'}, ...
         [class(obj) '.' propName], propName); 
    
    coder.internal.errorIf(all(K == 0), 'comm:FadingChannel:KFactorAllZero');
    
    obj.KFactor = K;
  end
        
  function set.DirectPathDopplerShift(obj, LOSShift)
    propName = 'DirectPathDopplerShift';
    validateattributes(LOSShift, {'double'}, {'real','row','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.DirectPathDopplerShift = LOSShift;
  end
    
  function set.DirectPathInitialPhase(obj, LOSPhase)
    propName = 'DirectPathInitialPhase';
    validateattributes(LOSPhase, {'double'}, {'real','row','finite'}, ...
        [class(obj) '.' propName], propName); 

    obj.DirectPathInitialPhase = LOSPhase;
  end  
end

methods(Access = protected)   
  function validatePropertiesImpl(obj)
    % Check AveragePathGains and DopplerSpectrum sizes
    validateDelayProfileAndDoppler(obj);
    
    % Check KFactor, DirectPathDopplerShift, DirectPathInitialPhase sizes
    validateRicianProperties(obj);
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
    %info Returns characteristic information about the Rician channel
    %   S = info(OBJ) returns a structure containing characteristic
    %   information, S, about the Rician fading channel. A description of
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
    header = matlab.system.display.Header('comm.RicianChannel', ...
        'Title', 'Rician Channel');
  end

  function groups = getPropertyGroupsImpl
    multipath = matlab.system.display.Section( ...
        'Title', 'Multipath parameters (frequency selectivity)', ...
        'PropertyList', {'SampleRate', 'PathDelays', 'AveragePathGains', ...
        'NormalizePathGains', 'KFactor', 'DirectPathDopplerShift', ...
        'DirectPathInitialPhase'});
        
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