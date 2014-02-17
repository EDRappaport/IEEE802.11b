classdef LTEMIMOChannel< handle
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

    methods
        function out=LTEMIMOChannel
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
        end

        function getHeaderImpl(in) %#ok<MANU>
        end

        function getNumTxAndRx(in) %#ok<MANU>
        end

        function getPropertyGroupsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupSQRTCorrelationMatrix(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %AntennaConfiguration Antenna configuration
        %   Specify the antenna configuration of the LTE MIMO channel as one of
        %   '1x2' | '2x2' | '4x2' | '4x4', which are supported configurations
        %   in the LTE specification Release 10. The property value is in the
        %   format of 'NtxNr', where Nt is the number of transmit antennas and
        %   Nr is the number of receive antennas. The default value of this
        %   property is '2x2'.
        AntennaConfiguration;

        %AntennaSelection Antenna selection
        %   Specify the antenna selection scheme as one of 'Off' | 'Tx' | 'Rx'
        %   | 'Tx and Rx', where Tx means transmit antennas and Rx means
        %   receive antennas. When antenna selection is on at Tx and/or Rx,
        %   additional input(s) is required to specify which antennas are
        %   selected for signal transmission. The default value of this
        %   property is 'Off'.
        AntennaSelection;

        %CorrelationLevel Spatial correlation strength
        %   Specify the spatial correlation strength of the LTE MIMO channel as
        %   one of 'Low' | 'Medium' | 'High'. The transmit and receive spatial
        %   correlation matrices are correspondingly defined from this property
        %   according to the LTE specification Release 10. The MIMO channel is
        %   spatially uncorrelated when you set this property to 'Low', which
        %   is the default value of this property.
        CorrelationLevel;

        %NormalizeChannelOutputs Normalize outputs by number of receive antennas
        %   Set this property to true to normalize the channel outputs by the
        %   number of receive antennas. The default value of this property is
        %   true.
        NormalizeChannelOutputs;

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
        Profile;

        %SampleRate Sample rate
        %   Specify the sample rate of the input signal in Hz as a double
        %   precision, real, positive scalar. The default value of this
        %   property is 30.72 MHz as in the LTE specification.
        SampleRate;

    end
end
