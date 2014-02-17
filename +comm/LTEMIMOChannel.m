classdef LTEMIMOChannel < comm.internal.FadingChannel
%LTEMIMOChannel Filter input signal through a LTE MIMO fading channel
%
%   H = comm.LTEMIMOChannel creates a 3GPP Long Term Evolution (LTE)
%   Release 10 specified multiple-input multiple-output (MIMO) multipath
%   fading channel System object, H. This object filters a real or complex
%   input signal through the multipath MIMO channel to obtain the channel
%   impaired signal.
%
%   H = comm.LTEMIMOChannel(Name,Value) creates a LTE MIMO multipath fading
%   channel object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments
%   in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) filters input signal X through a LTE MIMO multipath
%   fading channel and returns the result in Y. The input X can be a double
%   precision data type scalar, vector, or 2D matrix with real or complex
%   values. X is of size Ns x Nt, where Ns is the number of samples and Nt
%   is the number of transmit antennas that must match the
%   AntennaConfiguration property setting of H. Y is the output signal of
%   size Ns x Nr, where Nr is the number of receive antennas that is
%   specified by the AntennaConfiguration property of H. Y is of double
%   precision data type with complex values.
%  
%   Y = step(H,X,SELTX) turns on selected transmit antennas for X
%   transmission. This syntax applies when you set the AntennaSelection
%   property of H to 'Tx'. SELTX is a numeric type binary-valued 1 x Nt row
%   vector, in which the ones indicate the selected transmit antennas. X is
%   of size Ns x Nst, where Nst is the number of selected transmit
%   antennas, i.e., the number of ones in SELTX. Y is of size Ns x Nr.
%   
%   Y = step(H,X,SELRX) turns on selected receive antennas for X
%   transmission. This syntax applies when you set the AntennaSelection
%   property of H to 'Rx'. SELRX is a numeric type binary-valued 1 x Nr row
%   vector, in which the ones indicate the selected receive antennas. X is
%   of size Ns x Nt. Y is of size Ns x Nsr, where Nsr is the number of
%   selected receive antennas, i.e., the number of ones in SELRX.
% 
%   Y = step(H,X,SELTX,SELRX) turns on selected transmit and receive
%   antennas for X transmission. This syntax applies when you set the
%   AntennaSelection property of H to 'Tx and Rx'. X is of size Ns x Nst,
%   and Y is of size Ns x Nsr.
% 
%   [Y,PATHGAINS] = step(H,X) returns the LTE MIMO channel path gains of
%   the underlying fading process in PATHGAINS. This applies when you set
%   the PathGainsOutputPort property to true. PATHGAINS is of size Ns x Np
%   x Nt x Nr, where Np is the number of discrete paths of the channel
%   implicitly defined by the Profile property of H. PATHGAINS is of
%   double precision data type with complex values.
%
%   [Y,PATHGAINS] = step(H,X,SELTX/SELRX) or step(H,X,SELTX,SELRX) returns
%   the LTE MIMO channel path gains for antenna selection schemes.
%   PATHGAINS is still of size Ns x Np x Nt x Nr with NaN values for those
%   unselected transmit-receive antenna pairs.
% 
%   LTEMIMOChannel methods:
%
%   step     - Filter input signal through a LTE MIMO multipath fading channel (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create LTE MIMO channel object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of filters, and random stream if the
%              RandomStream property is set to 'mt19937ar with seed'
%
%   LTEMIMOChannel properties:
%
%   SampleRate              - Input signal sample rate (Hz)
%   Profile                 - Channel propagation profile
%   AntennaConfiguration    - Antenna configuration
%   CorrelationLevel        - Spatial correlation strength
%   AntennaSelection        - Optional transmit and/or receive antenna selection
%   RandomStream            - Source of random number stream
%   Seed                    - Initial seed of mt19937ar random number stream
%   NormalizePathGains      - Normalize path gains (logical)
%   NormalizeChannelOutputs - Normalize channel outputs (logical)
%   PathGainsOutputPort     - Enable path gain output (logical)
%
%   % Example: 
%   %   Configure a LTEMIMOChannel System object and an equivalent 
%   %   MIMOChannel System object, and verify they behave the same.
%
%   hMod = comm.PSKModulator; 
%   modData = step(hMod, randi([0 hMod.ModulationOrder-1],2e3,1));
%   % Split modulated data into two spatial streams
%   channelInput = reshape(modData, [2, 1e3]).';
%   hLTEChan = comm.LTEMIMOChannel(...
%       'Profile',              'EVA 5Hz',...
%       'AntennaConfiguration', '2x2',...
%       'CorrelationLevel',     'Medium',...
%       'AntennaSelection',     'Off',...
%       'RandomStream',         'mt19937ar with seed',...
%       'Seed',                 99,...
%       'PathGainsOutputPort',  true);
% 
%   % Filter the modulated data using hLTEChan
%   [LTEChanOut, LTEPathGains] = step(hLTEChan, channelInput);
% 
%   % All the properties of a comm.MIMOChannel System object also exist in
%   % a comm.LTEMIMOChannel System object except for KFactor,
%   % DirectPathDopplerShift and DirectPathInitialPhase, but some of them
%   % are hidden and read-only. Now configure a comm.MIMOChannel System 
%   % object using the properties of hLTEChan.
%   hMIMOChan = comm.MIMOChannel(...
%       'SampleRate',                hLTEChan.SampleRate,...
%       'PathDelays',                hLTEChan.PathDelays,...
%       'AveragePathGains',          hLTEChan.AveragePathGains,...
%       'NormalizePathGains',        hLTEChan.NormalizePathGains,...
%       'FadingDistribution',        hLTEChan.FadingDistribution,...
%       'MaximumDopplerShift',       hLTEChan.MaximumDopplerShift,...
%       'DopplerSpectrum',           hLTEChan.DopplerSpectrum,...
%       'SpatialCorrelation',        hLTEChan.SpatialCorrelation,...
%       'TransmitCorrelationMatrix', hLTEChan.TransmitCorrelationMatrix,...
%       'ReceiveCorrelationMatrix',  hLTEChan.ReceiveCorrelationMatrix,...
%       'AntennaSelection',          hLTEChan.AntennaSelection,...
%       'NormalizeChannelOutputs',   hLTEChan.NormalizeChannelOutputs,...
%       'RandomStream',              hLTEChan.RandomStream,...
%       'Seed',                      hLTEChan.Seed,...
%       'PathGainsOutputPort',       hLTEChan.PathGainsOutputPort);
%   
%   % Filter the modulated data using hMIMOChan and verify the channel 
%   % and path gain outputs are the same as those from hLTEChan.
%   [MIMOChanOut, MIMOPathGains] = step(hMIMOChan, channelInput);
%   display(isequal(LTEChanOut, MIMOChanOut));
%   display(isequal(LTEPathGains, MIMOPathGains));   
%   
%   % Note that if you repeat the above process with AntennaConfiguration
%   % set to '4x2' or '4x4' and CorrelationLevel set to 'Medium' or 'High'
%   % for hLTEChan, the channel and path gain outputs from the two objects
%   % are a little different. This is because a LTE channel with such
%   % configurations has its spatial correlation matrix rounded to
%   % 4-digital precision. See LTE specification Release 10 for more
%   % details.
%
%   References: 
%   1. 3rd Generation Partnership Project, Technical Specification Group
%   Radio Access Network, Evolved Universal Terrestrial Radio Access
%   (E-UTRA), Base Station (BS) radio transmission and reception, Release
%   10, 3GPP TS 36.104, v10.0.0, 2010-09.
%   2. 3rd Generation Partnership Project, Technical Specification Group
%   Radio Access Network, Evolved Universal Terrestrial Radio Access
%   (E-UTRA), User Equipment (UE) radio transmission and reception,
%   Release 10, 3GPP TS 36.101, v10.0.0, 2010-10.
% 
%   See also comm.AWGNChannel, comm.RayleighChannel, comm.RicianChannel,
%   comm.MIMOChannel, doppler.

% Copyright 2011-2013 The MathWorks, Inc.
% $Revision: 1.1.6.10 $  $Date: 2013/04/16 04:14:17 $

%#codegen
%#ok<*EMCLS>
%#ok<*EMCA>

% Public properties
properties (Nontunable)
    %SampleRate Sample rate
    %   Specify the sample rate of the input signal in Hz as a double
    %   precision, real, positive scalar. The default value of this
    %   property is 30.72 MHz as in the LTE specification.
    SampleRate = 30.72e6;
    %Profile Channel propagation conditions
    %   Specify the propagation conditions of the LTE multipath fading
    %   channel as one of 'EPA 5Hz' | 'EVA 5Hz' | 'EVA 70Hz' | 'ETU 70Hz' |
    %   'ETU 300Hz', which are supported in the LTE specification Release
    %   10. This property defines the delay profile of the channel to be
    %   one of EPA, EVA and ETU, and the maximum Doppler shift of the
    %   channel to be 5Hz, 70Hz or 300Hz. Note that the Doppler spectrum
    %   always has a Jakes shape in the LTE specification. The EPA profile
    %   has 7 paths, and the EVA and ETU profiles have 9 paths. The default
    %   value of this property is 'EPA 5Hz'.
    Profile = 'EPA 5Hz';
    %AntennaConfiguration Antenna configuration
    %   Specify the antenna configuration of the LTE MIMO channel as one of
    %   '1x2' | '2x2' | '4x2' | '4x4', which are supported configurations
    %   in the LTE specification Release 10. The property value is in the
    %   format of 'NtxNr', where Nt is the number of transmit antennas and
    %   Nr is the number of receive antennas. The default value of this
    %   property is '2x2'.
    AntennaConfiguration = '2x2';
    %CorrelationLevel Spatial correlation strength
    %   Specify the spatial correlation strength of the LTE MIMO channel as
    %   one of 'Low' | 'Medium' | 'High'. The transmit and receive spatial
    %   correlation matrices are correspondingly defined from this property
    %   according to the LTE specification Release 10. The MIMO channel is
    %   spatially uncorrelated when you set this property to 'Low', which
    %   is the default value of this property.
    CorrelationLevel = 'Low';
    %AntennaSelection Antenna selection
    %   Specify the antenna selection scheme as one of 'Off' | 'Tx' | 'Rx'
    %   | 'Tx and Rx', where Tx means transmit antennas and Rx means
    %   receive antennas. When antenna selection is on at Tx and/or Rx,
    %   additional input(s) is required to specify which antennas are
    %   selected for signal transmission. The default value of this
    %   property is 'Off'.
    AntennaSelection = 'Off';   
end

properties (Nontunable, Logical)
    %NormalizeChannelOutputs Normalize outputs by number of receive antennas
    %   Set this property to true to normalize the channel outputs by the
    %   number of receive antennas. The default value of this property is
    %   true.
    NormalizeChannelOutputs = true;
end

properties (Nontunable, Hidden, SetAccess = private)
    % Hidden property default values match with the default values of the
    % Profile, AntennaConfiguration and CorrelationLevel properties.
    PathDelays = [0 30 70 90 110 190 410]*1e-9;
    AveragePathGains = [0 -1 -2 -3 -8 -17.2 -20.8];
    MaximumDopplerShift = 5;
    SpatialCorrelation = true;
    NumTransmitAntennas = 2;
    NumReceiveAntennas = 2;
    TransmitCorrelationMatrix = eye(2);
    ReceiveCorrelationMatrix = eye(2);
end

properties (Access = private, Nontunable)
    % Transmit correlation coefficient
    pTxCorrelationCoeff = 0;
    % Receive correlation coefficient
    pRxCorrelationCoeff = 0;
end

properties(Constant, Hidden)
    DopplerSpectrum = doppler('Jakes');
    FadingDistribution = 'Rayleigh';
    ProfileSet = matlab.system.StringSet({'EPA 5Hz', 'EVA 5Hz', 'EVA 70Hz', 'ETU 70Hz', 'ETU 300Hz'});
    AntennaConfigurationSet = matlab.system.StringSet({'1x2', '2x2', '4x2', '4x4'});
    AntennaSelectionSet   = matlab.system.StringSet({'Off', 'Tx', 'Rx', 'Tx and Rx'});    
    CorrelationLevelSet = matlab.system.StringSet({'Low', 'Medium', 'High'});
end

methods
  function obj = LTEMIMOChannel(varargin) % Constructor
    setProperties(obj, nargin, varargin{:});
  end

  function set.SampleRate(obj, Rs)
    propName = 'SampleRate';
    validateattributes(Rs, {'double'}, ...
        {'real','scalar','positive','finite'}, ...
        [class(obj) '.' propName], propName);  

    obj.SampleRate = Rs;
  end
  
  function set.Profile(obj, profile)
    obj.Profile = profile; 
    setDelayDopplerProfiles(obj);
  end
   
  function set.AntennaConfiguration(obj, TxRxConfig)
    obj.AntennaConfiguration = TxRxConfig;
    setNumAntennas(obj);
  end
  
  function set.CorrelationLevel(obj, corrStrength)
    obj.CorrelationLevel = corrStrength;
    setCorrelationCoeffs(obj);
  end 
  
  function set.NormalizeChannelOutputs(obj, v)
    propName = 'NormalizeChannelOutputs';
    validateattributes(v, {'logical'}, {'scalar'}, ...
        [class(obj) '.' propName], propName); 

    obj.NormalizeChannelOutputs = v;
  end      
end

methods(Access = protected)  
  function validatePropertiesImpl(obj)
    coder.internal.errorIf(strcmp(obj.AntennaConfiguration, '1x2') && ...
       strcmp(obj.CorrelationLevel, 'Medium'), ...
       'comm:LTEMIMOChannel:OneByTwoMedCorrNotSupported'); 
   
    coder.internal.errorIf(strcmp(obj.AntennaConfiguration, '1x2') && ...
       any(strcmp(obj.AntennaSelection, {'Tx','Tx and Rx'})), ...
       'comm:LTEMIMOChannel:OneByTwoTxSelectionNotSupported'); 
  end
  
  function [Nt, Nr] = getNumTxAndRx(obj)
    Nt = obj.NumTransmitAntennas;
    Nr = obj.NumReceiveAntennas;
  end
  
  function setupSQRTCorrelationMatrix(obj)
    NP = length(obj.PathDelays); 
    NL = obj.NumTransmitAntennas * obj.NumReceiveAntennas; 
    Rt = getCorrelationMatrix(obj.NumTransmitAntennas, ...
                              obj.pTxCorrelationCoeff);
    Rr = getCorrelationMatrix(obj.NumReceiveAntennas, ...
                              obj.pRxCorrelationCoeff);

    obj.TransmitCorrelationMatrix = Rt;
    obj.ReceiveCorrelationMatrix  = Rr;
    
    obj.pIsRHIdentity = strcmp(obj.CorrelationLevel, 'Low');

    if ~obj.pIsRHIdentity
        RHPerPath = kron(Rt, Rr);

        if strcmp(obj.AntennaConfiguration, '4x2') || ...
           strcmp(obj.AntennaConfiguration, '4x4')
            if strcmp(obj.AntennaConfiguration, '4x4') 
                % 4x4, medium and high correlation level
                cf = 0.00012;
            elseif strcmp(obj.AntennaConfiguration, '4x2') && ...
                   strcmp(obj.CorrelationLevel, 'High')
                cf = 0.0001;
            else % 4x2, medium correlation level
                cf = 0;
            end
        
            RHPerPath = round((RHPerPath + cf*eye(NL))/(1 + cf)*1e4)/1e4;
        end
        
        obj.pSQRTCorrelationMatrix = kron(eye(NP), (sqrtm(RHPerPath)).');
    end
  end  
  
  function flag = isInactivePropertyImpl(obj, prop)
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
end

methods(Static, Access = protected)
  function header = getHeaderImpl
    header = matlab.system.display.Header('comm.LTEMIMOChannel', ...
        'Title', 'LTE MIMO Channel');
  end

  function groups = getPropertyGroupsImpl
    groups = matlab.system.display.Section( ...
        'Title', 'Parameters', ...
        'PropertyList', {'SampleRate', 'Profile', 'AntennaConfiguration', ...
        'CorrelationLevel', 'AntennaSelection', 'RandomStream', 'Seed', ...
        'NormalizePathGains', 'NormalizeChannelOutputs', 'PathGainsOutputPort'});        
  end
end

methods(Access = private)
  function setDelayDopplerProfiles(obj)
    EPAPathDelays = [0 30 70 90 110 190 410]*1e-9;
    EPAPathGains  = [0 -1 -2 -3 -8 -17.2 -20.8];
    EVAPathDelays = [0 30 150 310 370 710 1090 1730 2510]*1e-9;
    EVAPathGains  = [0 -1.5 -1.4 -3.6 -0.6 -9.1 -7 -12 -16.9];
    ETUPathDelays = [0 50 120 200 230 500 1600 2300 5000]*1e-9;
    ETUPathGains  = [-1 -1 -1 0 0 0 -3 -5 -7];
    
    switch obj.Profile
    case 'EPA 5Hz'
        obj.PathDelays          = EPAPathDelays;
        obj.AveragePathGains    = EPAPathGains;
        obj.MaximumDopplerShift = 5;
    case 'EVA 5Hz'
        obj.PathDelays          = EVAPathDelays;
        obj.AveragePathGains    = EVAPathGains;
        obj.MaximumDopplerShift = 5;
    case 'EVA 70Hz'
        obj.PathDelays          = EVAPathDelays;
        obj.AveragePathGains    = EVAPathGains;
        obj.MaximumDopplerShift = 70;
    case 'ETU 70Hz'
        obj.PathDelays          = ETUPathDelays;
        obj.AveragePathGains    = ETUPathGains;
        obj.MaximumDopplerShift = 70;
    case 'ETU 300Hz'
        obj.PathDelays          = ETUPathDelays;
        obj.AveragePathGains    = ETUPathGains;
        obj.MaximumDopplerShift = 300;
    end
  end
  
  function setNumAntennas(obj)
    switch obj.AntennaConfiguration
    case '1x2'
        obj.NumTransmitAntennas = 1;
        obj.NumReceiveAntennas  = 2;
    case '2x2'
        obj.NumTransmitAntennas = 2;
        obj.NumReceiveAntennas  = 2;
    case '4x2'
        obj.NumTransmitAntennas = 4;
        obj.NumReceiveAntennas  = 2;        
    case '4x4'
        obj.NumTransmitAntennas = 4;
        obj.NumReceiveAntennas  = 4;
    end
  end
  
  function setCorrelationCoeffs(obj)
     switch obj.CorrelationLevel
     case 'Low'
        obj.pTxCorrelationCoeff = 0;
        obj.pRxCorrelationCoeff = 0;
     case 'Medium'
        obj.pTxCorrelationCoeff = 0.3;
        obj.pRxCorrelationCoeff = 0.9;
     case 'High'
        obj.pTxCorrelationCoeff = 0.9;
        obj.pRxCorrelationCoeff = 0.9;
     end
  end
end  

end
%==========================================================================
% Support functions
%==========================================================================
function R = getCorrelationMatrix(NumAntennas, r)
  switch NumAntennas
  case 1
    R = 1;
  case 2
    R = [1 r; r 1];
  case 4
    R = [1          r^(1/9)    r^(4/9)    r;       ...
         (r^(1/9))  1          r^(1/9)    r^(4/9); ...
         (r^(4/9))  (r^(1/9))  1          r^(1/9); ...
         r          (r^(4/9))  (r^(1/9))  1];
  end
end

% [EOF]
