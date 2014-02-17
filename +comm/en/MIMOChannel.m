classdef MIMOChannel< handle
%MIMOChannel Filter input signal through a MIMO multipath fading channel
%   H = comm.MIMOChannel creates a multiple-input multiple-output (MIMO)
%   frequency-selective or frequency-flat fading channel System object, H.
%   This object filters a real or complex input signal through the
%   multipath MIMO channel to obtain the channel impaired signal.
%
%   H = comm.MIMOChannel(Name,Value) creates a MIMO channel object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) filters input signal X through a MIMO fading channel and
%   returns the result in Y. The input X can be a double precision data
%   type scalar, vector, or 2D matrix with real or complex values. X is of
%   size Ns x Nt, where Ns is the number of samples and Nt is the number of
%   transmit antennas that is determined by the NumTransmitAntennas or
%   TransmitCorrelationMatrix property value of H. Y is the output signal
%   of size Ns x Nr, where Nr is the number of receive antennas that is
%   determined by the NumReceiveAntennas or ReceiveCorrelationMatrix
%   property value of H. Y is of double precision data type with complex
%   values.
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
%   [Y,PATHGAINS] = step(H,X) returns the MIMO channel path gains of the
%   underlying fading process in PATHGAINS. This syntax applies when you
%   set the PathGainsOutputPort property of H to true. PATHGAINS is of size
%   Ns x Np x Nt x Nr, where Np is the number of paths, i.e., the length of
%   the PathDelays property value of H. PATHGAINS is of double precision
%   data type with complex values.
%
%   [Y,PATHGAINS] = step(H,X,SELTX/SELRX) or step(H,X,SELTX,SELRX) returns
%   the MIMO channel path gains for antenna selection schemes. PATHGAINS is
%   still of size Ns x Np x Nt x Nr with NaN values for the unselected
%   transmit-receive antenna pairs.
% 
%   MIMOChannel methods:
%
%   step     - Filter input signal through a MIMO fading channel (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create MIMO channel object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of filters, and random stream if the
%              RandomStream property is set to 'mt19937ar with seed'
%   info     - Return characteristic information about the MIMO channel
%
%   MIMOChannel properties:
%
%   SampleRate                  - Input signal sample rate (Hz)
%   PathDelays                  - Discrete path delay vector (s)
%   AveragePathGains            - Average path gain vector (dB)
%   NormalizePathGains          - Normalize path gains (logical)
%   FadingDistribution          - Rayleigh or Rician fading
%   KFactor                     - Rician K-factor scalar or vector (linear scale)
%   DirectPathDopplerShift      - Doppler shift(s) of line-of-sight component(s) (Hz)
%   DirectPathInitialPhase      - Initial phase(s) of line-of-sight component(s) (rad)
%   MaximumDopplerShift         - Maximum Doppler shift (Hz)
%   DopplerSpectrum             - Doppler spectrum 
%   SpatialCorrelation          - Spatially correlated
%   NumTransmitAntennas         - Number of transmit antennas
%   NumReceiveAntennas          - Number of receive antennas    
%   TransmitCorrelationMatrix   - Transmit correlation matrix (or 3-D array)
%   ReceiveCorrelationMatrix    - Receive correlation matrix (or 3-D array)
%   AntennaSelection            - Optional transmit and/or receive antenna selection
%   NormalizeChannelOutputs     - Normalize channel outputs (logical)
%   RandomStream                - Source of random number stream
%   Seed                        - Initial seed of mt19937ar random number stream
%   PathGainsOutputPort         - Enable path gain output (logical)
%
%   % Example: 
%   %   Filter a 1000Hz input signal through a 2x2 Rayleigh
%   %   frequency-selective spatially correlated fading channel with a  
%   %   Jakes Doppler spectrum with a maximum frequency of 5Hz.
%
%   hMod = comm.PSKModulator; 
%   modData = step(hMod, randi([0 hMod.ModulationOrder-1],1e5,1));
%   % Split modulated data into two spatial streams
%   channelInput = reshape(modData, [2, 5e4]).';
%   hMIMOChan = comm.MIMOChannel(...
%       'SampleRate',                1000,...
%       'PathDelays',                [0 1e-3],...
%       'AveragePathGains',          [3 5],...
%       'NormalizePathGains',        false,...
%       'MaximumDopplerShift',       5,...
%       'TransmitCorrelationMatrix', cat(3, eye(2), [1 0.1;0.1 1]),...
%       'ReceiveCorrelationMatrix',  cat(3, [1 0.2;0.2 1], eye(2)),...
%       'RandomStream',              'mt19937ar with seed',...
%       'Seed',                      33,...
%       'PathGainsOutputPort',       true);
%   [channelOutput, pathGains] = step(hMIMOChan, channelInput);
%   % Check transmit and receive spatial correlation that should be close
%   % to the values of the TransmitCorrelationMatrix and
%   % ReceiveCorrelationMatrix properties of hMIMOChan, respectively.
%   disp('Tx spatial correlation, first path, first Rx:');
%   disp(corrcoef(squeeze(pathGains(:,1,:,1)))); % Close to an identity matrix
%   disp('Tx spatial correlation, second path, second Rx:');
%   disp(corrcoef(squeeze(pathGains(:,2,:,2)))); % Close to [1 0.1;0.1 1]
%   disp('Rx spatial correlation, first path, second Tx:');
%   disp(corrcoef(squeeze(pathGains(:,1,2,:)))); % Close to [1 0.2;0.2 1]
%   disp('Rx spatial correlation, second path, first Tx:');
%   disp(corrcoef(squeeze(pathGains(:,2,1,:)))); % Close to an identity matrix
%
%   % Now enable transmit and receive antenna selection for the System 
%   % object hMIMOChan. The input frame size is shortened to 100.
%   release(hMIMOChan);
%   hMIMOChan.AntennaSelection = 'Tx and Rx';
%   modData = step(hMod,randi([0 hMod.ModulationOrder-1],1e2,1)); 
%   % First transmit and second receive antennas are selected 
%   [channelOutput, pathGains] = step(hMIMOChan, modData, [1 0], [0 1]); 
%   % Check the returned path gains have NaN values for those unselected 
%   % transmit-receive antenna pairs.
%   disp('Return 1 if the path gains for the second transmit antenna are NaN:');
%   disp(isequal(isnan(squeeze(pathGains(:,:,2,:))), ones(1e2, 2, 2)));
%   disp('Return 1 if the path gains for the first receive antenna are NaN:');
%   disp(isequal(isnan(squeeze(pathGains(:,:,:,1))), ones(1e2, 2, 2)));
%   
%   See also comm.AWGNChannel, comm.RayleighChannel, comm.RicianChannel,
%   comm.LTEMIMOChannel, doppler.

 
% Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=MIMOChannel
            %MIMOChannel Filter input signal through a MIMO multipath fading channel
            %   H = comm.MIMOChannel creates a multiple-input multiple-output (MIMO)
            %   frequency-selective or frequency-flat fading channel System object, H.
            %   This object filters a real or complex input signal through the
            %   multipath MIMO channel to obtain the channel impaired signal.
            %
            %   H = comm.MIMOChannel(Name,Value) creates a MIMO channel object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) filters input signal X through a MIMO fading channel and
            %   returns the result in Y. The input X can be a double precision data
            %   type scalar, vector, or 2D matrix with real or complex values. X is of
            %   size Ns x Nt, where Ns is the number of samples and Nt is the number of
            %   transmit antennas that is determined by the NumTransmitAntennas or
            %   TransmitCorrelationMatrix property value of H. Y is the output signal
            %   of size Ns x Nr, where Nr is the number of receive antennas that is
            %   determined by the NumReceiveAntennas or ReceiveCorrelationMatrix
            %   property value of H. Y is of double precision data type with complex
            %   values.
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
            %   [Y,PATHGAINS] = step(H,X) returns the MIMO channel path gains of the
            %   underlying fading process in PATHGAINS. This syntax applies when you
            %   set the PathGainsOutputPort property of H to true. PATHGAINS is of size
            %   Ns x Np x Nt x Nr, where Np is the number of paths, i.e., the length of
            %   the PathDelays property value of H. PATHGAINS is of double precision
            %   data type with complex values.
            %
            %   [Y,PATHGAINS] = step(H,X,SELTX/SELRX) or step(H,X,SELTX,SELRX) returns
            %   the MIMO channel path gains for antenna selection schemes. PATHGAINS is
            %   still of size Ns x Np x Nt x Nr with NaN values for the unselected
            %   transmit-receive antenna pairs.
            % 
            %   MIMOChannel methods:
            %
            %   step     - Filter input signal through a MIMO fading channel (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create MIMO channel object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of filters, and random stream if the
            %              RandomStream property is set to 'mt19937ar with seed'
            %   info     - Return characteristic information about the MIMO channel
            %
            %   MIMOChannel properties:
            %
            %   SampleRate                  - Input signal sample rate (Hz)
            %   PathDelays                  - Discrete path delay vector (s)
            %   AveragePathGains            - Average path gain vector (dB)
            %   NormalizePathGains          - Normalize path gains (logical)
            %   FadingDistribution          - Rayleigh or Rician fading
            %   KFactor                     - Rician K-factor scalar or vector (linear scale)
            %   DirectPathDopplerShift      - Doppler shift(s) of line-of-sight component(s) (Hz)
            %   DirectPathInitialPhase      - Initial phase(s) of line-of-sight component(s) (rad)
            %   MaximumDopplerShift         - Maximum Doppler shift (Hz)
            %   DopplerSpectrum             - Doppler spectrum 
            %   SpatialCorrelation          - Spatially correlated
            %   NumTransmitAntennas         - Number of transmit antennas
            %   NumReceiveAntennas          - Number of receive antennas    
            %   TransmitCorrelationMatrix   - Transmit correlation matrix (or 3-D array)
            %   ReceiveCorrelationMatrix    - Receive correlation matrix (or 3-D array)
            %   AntennaSelection            - Optional transmit and/or receive antenna selection
            %   NormalizeChannelOutputs     - Normalize channel outputs (logical)
            %   RandomStream                - Source of random number stream
            %   Seed                        - Initial seed of mt19937ar random number stream
            %   PathGainsOutputPort         - Enable path gain output (logical)
            %
            %   % Example: 
            %   %   Filter a 1000Hz input signal through a 2x2 Rayleigh
            %   %   frequency-selective spatially correlated fading channel with a  
            %   %   Jakes Doppler spectrum with a maximum frequency of 5Hz.
            %
            %   hMod = comm.PSKModulator; 
            %   modData = step(hMod, randi([0 hMod.ModulationOrder-1],1e5,1));
            %   % Split modulated data into two spatial streams
            %   channelInput = reshape(modData, [2, 5e4]).';
            %   hMIMOChan = comm.MIMOChannel(...
            %       'SampleRate',                1000,...
            %       'PathDelays',                [0 1e-3],...
            %       'AveragePathGains',          [3 5],...
            %       'NormalizePathGains',        false,...
            %       'MaximumDopplerShift',       5,...
            %       'TransmitCorrelationMatrix', cat(3, eye(2), [1 0.1;0.1 1]),...
            %       'ReceiveCorrelationMatrix',  cat(3, [1 0.2;0.2 1], eye(2)),...
            %       'RandomStream',              'mt19937ar with seed',...
            %       'Seed',                      33,...
            %       'PathGainsOutputPort',       true);
            %   [channelOutput, pathGains] = step(hMIMOChan, channelInput);
            %   % Check transmit and receive spatial correlation that should be close
            %   % to the values of the TransmitCorrelationMatrix and
            %   % ReceiveCorrelationMatrix properties of hMIMOChan, respectively.
            %   disp('Tx spatial correlation, first path, first Rx:');
            %   disp(corrcoef(squeeze(pathGains(:,1,:,1)))); % Close to an identity matrix
            %   disp('Tx spatial correlation, second path, second Rx:');
            %   disp(corrcoef(squeeze(pathGains(:,2,:,2)))); % Close to [1 0.1;0.1 1]
            %   disp('Rx spatial correlation, first path, second Tx:');
            %   disp(corrcoef(squeeze(pathGains(:,1,2,:)))); % Close to [1 0.2;0.2 1]
            %   disp('Rx spatial correlation, second path, first Tx:');
            %   disp(corrcoef(squeeze(pathGains(:,2,1,:)))); % Close to an identity matrix
            %
            %   % Now enable transmit and receive antenna selection for the System 
            %   % object hMIMOChan. The input frame size is shortened to 100.
            %   release(hMIMOChan);
            %   hMIMOChan.AntennaSelection = 'Tx and Rx';
            %   modData = step(hMod,randi([0 hMod.ModulationOrder-1],1e2,1)); 
            %   % First transmit and second receive antennas are selected 
            %   [channelOutput, pathGains] = step(hMIMOChan, modData, [1 0], [0 1]); 
            %   % Check the returned path gains have NaN values for those unselected 
            %   % transmit-receive antenna pairs.
            %   disp('Return 1 if the path gains for the second transmit antenna are NaN:');
            %   disp(isequal(isnan(squeeze(pathGains(:,:,2,:))), ones(1e2, 2, 2)));
            %   disp('Return 1 if the path gains for the first receive antenna are NaN:');
            %   disp(isequal(isnan(squeeze(pathGains(:,:,:,1))), ones(1e2, 2, 2)));
            %   
            %   See also comm.AWGNChannel, comm.RayleighChannel, comm.RicianChannel,
            %   comm.LTEMIMOChannel, doppler.
        end

        function getHeaderImpl(in) %#ok<MANU>
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getPropertyGroupsImpl(in) %#ok<MANU>
        end

        function infoImpl(in) %#ok<MANU>
            %info Returns characteristic information about the MIMO fading channel
            %   S = info(OBJ) returns a structure containing characteristic
            %   information, S, about the MIMO fading channel. A description of
            %   the fields and their values is as follows:
            % 
            %   ChannelFilterDelay  - Channel filter delay, measured in samples 
            %   NumSamplesProcessed - Number of samples the channel has processed 
            %                         since the last reset
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
            % Check AveragePathGains and DopplerSpectrum sizes
        end

    end
    methods (Abstract)
    end
    properties
        %AntennaSelection Antenna selection
        %   Specify the antenna selection scheme as one of 'Off' | 'Tx' | 'Rx'
        %   | 'Tx and Rx', where Tx means transmit antennas and Rx means
        %   receive antennas. When antenna selection is on at Tx and/or Rx,
        %   additional input(s) is required to specify which antennas are
        %   selected for signal transmission. The default value of this
        %   property is 'Off'.
        AntennaSelection;

        %AveragePathGains Average path gains (dB)
        %   Specify the average gains of the discrete paths in dB as a double
        %   precision, real, scalar or row vector. AveragePathGains must have
        %   the same size as PathDelays. The default value of this property is
        %   0.
        AveragePathGains;

        %DirectPathDopplerShift LOS path Doppler shifts (Hz)
        %   Specify the Doppler shift(s) of the line-of-sight component(s) of a
        %   Rician fading channel in Hz as a double precision, real scalar or
        %   row vector. This property applies when you set the
        %   FadingDistribution property to 'Rician'. DirectPathDopplerShift
        %   must have the same size as KFactor. If DirectPathDopplerShift is a
        %   scalar, it is the line-of-sight component Doppler shift of the
        %   first discrete path that is a Rician fading process. If
        %   DirectPathDopplerShift is a row vector, the discrete path that is a
        %   Rician fading process indicated by a positive element of the
        %   KFactor vector has its line-of-sight component Doppler shift
        %   specified by the corresponding element of DirectPathDopplerShift.
        %   The default value of this property is 0.
        DirectPathDopplerShift;

        %DirectPathInitialPhase LOS path initial phases (rad)
        %   Specify the initial phase(s) of the line-of-sight component(s) of a
        %   Rician fading channel in radians as a double precision, real scalar
        %   or row vector. This property applies when you set the
        %   FadingDistribution property to 'Rician'. DirectPathInitialPhase
        %   must have the same size as KFactor. If DirectPathInitialPhase is a
        %   scalar, it is the line-of-sight component initial phase of the
        %   first discrete path that is a Rician fading process. If
        %   DirectPathInitialPhase is a row vector, the discrete path that is a
        %   Rician fading process indicated by a positive element of the
        %   KFactor vector has its line-of-sight component initial phase
        %   specified by the corresponding element of DirectPathInitialPhase.
        %   The default value of this property is 0.
        DirectPathInitialPhase;

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
        %   Alternatively, you can specify DopplerSpectrum as a single Doppler
        %   spectrum object or a row vector of such objects that must have a
        %   length equal to the length of PathDelays. The possible Doppler
        %   spectrum objects are
        %       doppler.jakes
        %       doppler.flat
        %       doppler.rounded(...)
        %       doppler.bell(...)
        %       doppler.ajakes(...)
        %       doppler.rjakes(...)
        %       doppler.gaussian(...)
        %       doppler.bigaussian(...)
        %
        %   To generate code, specify this property to a single Doppler
        %   spectrum structure. The default value of this property is
        %   doppler('Jakes').
        DopplerSpectrum;

        %FadingDistribution Fading distribution
        %   Specify the fading distribution of the channel as one of 'Rayleigh'
        %   | 'Rician'. The default value of this property is 'Rayleigh', i.e.,
        %   the channel is Rayleigh fading.
        FadingDistribution;

        %KFactor K-factors
        %   Specify the K factor of a Rician fading channel as a double
        %   precision, real, positive scalar or nonnegative, non-zero row
        %   vector of the same length as PathDelays. This property applies when
        %   you set the FadingDistribution property to 'Rician'. If KFactor is
        %   a scalar, the first discrete path is a Rician fading process with a
        %   Rician K-factor of KFactor and the remaining discrete paths are
        %   independent Rayleigh fading processes. If KFactor is a row vector,
        %   the discrete path corresponding to a positive element of the
        %   KFactor vector is a Rician fading process with a Rician K-factor
        %   specified by that element and the discrete path corresponding to a
        %   zero-valued element of the KFactor vector is a Rayleigh fading
        %   process. The default value of this property is 3.
        KFactor;

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
        MaximumDopplerShift;

        %NormalizeChannelOutputs Normalize outputs by number of receive antennas
        %   Set this property to true to normalize the channel outputs by the
        %   number of receive antennas. The default value of this property is
        %   true.
        NormalizeChannelOutputs;

        %NumReceiveAntennas Number of receive antennas
        %   Specify the number of receive antennas as a numeric, real, positive
        %   integer scalar between 1 and 8, inclusive. This property applies
        %   when you set the SpatialCorrelation property to false. The default
        %   value of this property is 2.
        NumReceiveAntennas;

        %NumTransmitAntennas Number of transmit antennas
        %   Specify the number of transmit antennas as a numeric, real,
        %   positive integer scalar between 1 and 8, inclusive. This property
        %   applies when you set the SpatialCorrelation property to false. The
        %   default value of this property is 2.
        NumTransmitAntennas;

        %PathDelays Discrete path delays (s)
        %   Specify the delays of the discrete paths in seconds as a double
        %   precision, real, scalar or row vector. When PathDelays is a scalar,
        %   the channel is frequency-flat; When PathDelays is a vector, the
        %   channel is frequency-selective. The default value of this property
        %   is 0.
        PathDelays;

        %ReceiveCorrelationMatrix Receive spatial correlation
        %   Specify the spatial correlation of the receiver as a double
        %   precision, real or complex, 2D matrix or 3D array. This property
        %   applies when you set the SpatialCorrelation property to true. The
        %   first dimension of ReceiveCorrelationMatrix determines the number
        %   of receive antennas, Nr, that must be between 1 and 8, inclusive.
        %   If the channel is frequency-flat, i.e., PathDelays is a scalar,
        %   ReceiveCorrelationMatrix is a 2D Hermitian matrix of size Nr x Nr.
        %   The main diagonal elements must be all ones, while the off-diagonal
        %   elements must be real or complex numbers with a magnitude smaller
        %   than or equal to one.
        %  
        %   If the channel is frequency-selective, i.e., PathDelays is a row
        %   vector of length Np, ReceiveCorrelationMatrix can be specified as
        %   a 2D matrix, in which case each path has the same receive spatial
        %   correlation matrix. Alternatively, it can be specified as a 3-D
        %   array of size Nr x Nr x Np, in which case each path can have its
        %   own different receive spatial correlation matrix.
        % 
        %   The default value of this property is [1 0;0 1].
        ReceiveCorrelationMatrix;

        %SampleRate Sample rate (Hz)
        %   Specify the sample rate of the input signal in Hz as a double
        %   precision, real, positive scalar. The default value of this
        %   property is 1 Hz.
        SampleRate;

        %SpatialCorrelation Spatially correlated antennas
        %   Set this property to true to specify the transmit and receive
        %   spatial correlation matrices from which the number of transmit and
        %   receive antennas can be derived. Set this property to false to
        %   specify the number of transmit and receive antennas instead. In
        %   this case, the transmit and receive spatial correlation matrices
        %   are both identity matrices. The default value of this property is
        %   true.
        SpatialCorrelation;

        %TransmitCorrelationMatrix Transmit spatial correlation
        %   Specify the spatial correlation of the transmitter as a double
        %   precision, real or complex, 2D matrix or 3D array. This property
        %   applies when you set the SpatialCorrelation property to true. The
        %   first dimension of TransmitCorrelationMatrix determines the number
        %   of transmit antennas, Nt, that must be between 1 and 8, inclusive.
        %   If the channel is frequency-flat, i.e., PathDelays is a scalar,
        %   TransmitCorrelationMatrix is a 2D Hermitian matrix of size Nt x Nt.
        %   The main diagonal elements must be all ones, while the off-diagonal
        %   elements must be real or complex numbers with a magnitude smaller
        %   than or equal to one.
        %  
        %   If the channel is frequency-selective, i.e., PathDelays is a row
        %   vector of length Np, TransmitCorrelationMatrix can be specified as
        %   a 2D matrix, in which case each path has the same transmit spatial
        %   correlation matrix. Alternatively, it can be specified as a 3-D
        %   array of size Nt x Nt x Np, in which case each path can have its
        %   own different transmit spatial correlation matrix.
        % 
        %   The default value of this property is [1 0;0 1].
        TransmitCorrelationMatrix;

    end
end
