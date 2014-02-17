classdef AWGNChannel< handle
%AWGNChannel AWGN Channel (GPU)
%   H = comm.gpu.AWGNChannel creates an additive white Gaussian noise
%   (AWGN) channel GPU System object, H. This object adds white Gaussian
%   noise to a real or complex input signal.
%
%   Use of this object requires a Parallel Computing Toolbox license.
%
%   H = comm.gpu.AWGNChannel(Name,Value) creates an AWGN channel GPU
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   The AWGN channel GPU object uses the default MATLAB random stream on
%   the GPU. Reset the default stream for repeatable simulations. Type
%   'help parallel.gpu.RandStream' for more information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds white Gaussian noise to input X and returns the
%   result in Y. The input X can be a double or single precision data type
%   scalar, vector, or matrix with real or complex values. The dimensions
%   of input X determine single or multichannel processing. For an M-by-N
%   matrix input, M represents the number of time samples per channel and N
%   represents the number of channels. M and N can be equal to 1. The
%   object adds frames of length M of Gaussian noise to each of the N
%   channels independently.
%
%   Y = step(H,X,VAR) uses input VAR as the variance of the white Gaussian
%   noise. This applies when you set the NoiseMethod property to 'Variance'
%   and the VarianceSource property to 'Input port'. Input VAR can be a
%   positive scalar or row vector with a length equal to the number of
%   channels. VAR must be of the same data type as input X. 
%
%   AWGNChannel methods:
%
%   step     - Add white Gaussian noise to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create AWGN channel object with same property values
%   isLocked - Locked status (logical)
%
%   AWGNChannel properties:
%
%   NoiseMethod          - Method to specify noise level
%   EbNo                 - Energy per bit to noise power spectral density
%                          ratio (Eb/No)
%   EsNo                 - Energy per symbol to noise power spectral density
%                          ratio (Es/No)
%   SNR                  - Signal to noise ratio (SNR)
%   BitsPerSymbol        - Number of bits in one symbol
%   SignalPower          - Input signal power in Watts
%   SamplesPerSymbol     - Number of samples per symbol
%   VarianceSource       - Source of noise variance
%   Variance             - Noise variance
%   RandomStream         - Source of random number stream
%   Seed                 - Seed of random number stream
% 
%   % Example:
%   %   Add AWGN to an 8-PSK signal
%
%   hMod = comm.PSKModulator; 
%   modData = step(hMod,randi([0 hMod.ModulationOrder-1],1000,1));
%   hAWGN = comm.gpu.AWGNChannel('EbNo',15, 'BitsPerSymbol', ...
%                        log2(hMod.ModulationOrder));
%   channelOutput = step(hAWGN, modData);
%   % Visualize the noiseless and noisy data in scatter plots
%   scatterplot(modData)
%   scatterplot(channelOutput)
%
%   See also comm.BinarySymmetricChannel.

 

%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=AWGNChannel
            %AWGNChannel AWGN Channel (GPU)
            %   H = comm.gpu.AWGNChannel creates an additive white Gaussian noise
            %   (AWGN) channel GPU System object, H. This object adds white Gaussian
            %   noise to a real or complex input signal.
            %
            %   Use of this object requires a Parallel Computing Toolbox license.
            %
            %   H = comm.gpu.AWGNChannel(Name,Value) creates an AWGN channel GPU
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   The AWGN channel GPU object uses the default MATLAB random stream on
            %   the GPU. Reset the default stream for repeatable simulations. Type
            %   'help parallel.gpu.RandStream' for more information.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) adds white Gaussian noise to input X and returns the
            %   result in Y. The input X can be a double or single precision data type
            %   scalar, vector, or matrix with real or complex values. The dimensions
            %   of input X determine single or multichannel processing. For an M-by-N
            %   matrix input, M represents the number of time samples per channel and N
            %   represents the number of channels. M and N can be equal to 1. The
            %   object adds frames of length M of Gaussian noise to each of the N
            %   channels independently.
            %
            %   Y = step(H,X,VAR) uses input VAR as the variance of the white Gaussian
            %   noise. This applies when you set the NoiseMethod property to 'Variance'
            %   and the VarianceSource property to 'Input port'. Input VAR can be a
            %   positive scalar or row vector with a length equal to the number of
            %   channels. VAR must be of the same data type as input X. 
            %
            %   AWGNChannel methods:
            %
            %   step     - Add white Gaussian noise to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create AWGN channel object with same property values
            %   isLocked - Locked status (logical)
            %
            %   AWGNChannel properties:
            %
            %   NoiseMethod          - Method to specify noise level
            %   EbNo                 - Energy per bit to noise power spectral density
            %                          ratio (Eb/No)
            %   EsNo                 - Energy per symbol to noise power spectral density
            %                          ratio (Es/No)
            %   SNR                  - Signal to noise ratio (SNR)
            %   BitsPerSymbol        - Number of bits in one symbol
            %   SignalPower          - Input signal power in Watts
            %   SamplesPerSymbol     - Number of samples per symbol
            %   VarianceSource       - Source of noise variance
            %   Variance             - Noise variance
            %   RandomStream         - Source of random number stream
            %   Seed                 - Seed of random number stream
            % 
            %   % Example:
            %   %   Add AWGN to an 8-PSK signal
            %
            %   hMod = comm.PSKModulator; 
            %   modData = step(hMod,randi([0 hMod.ModulationOrder-1],1000,1));
            %   hAWGN = comm.gpu.AWGNChannel('EbNo',15, 'BitsPerSymbol', ...
            %                        log2(hMod.ModulationOrder));
            %   channelOutput = step(hAWGN, modData);
            %   % Visualize the noiseless and noisy data in scatter plots
            %   scatterplot(modData)
            %   scatterplot(channelOutput)
            %
            %   See also comm.BinarySymmetricChannel.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function processTunedPropertiesImpl(in) %#ok<MANU>
        end

        function setupGPUImpl(in) %#ok<MANU>
            % Input validation
        end

        function stepGPUImpl(in) %#ok<MANU>
            % Generate unit variance real or complex Gaussian noise
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitsPerSymbol Number of bits in one symbol
        %   Specify the number of bits in each input symbol. You can set this
        %   property to a numeric, positive, integer scalar or row vector with a
        %   length equal to the number of channels. This property applies when you
        %   set the NoiseMethod property to 'Signal to noise ratio (Eb/No)'. The
        %   default is 1 bit. 
        BitsPerSymbol;

        %EbNo   Energy per bit to noise power spectral density ratio (Eb/No)
        %   Specify the Eb/No ratio in decibels. Set this property to a numeric,
        %   real scalar or row vector with a length equal to the number of
        %   channels. This property applies when you set the NoiseMethod property
        %   to 'Signal to noise ratio (Eb/No)'. The default is 10. This property
        %   is tunable.
        EbNo;

        %EsNo   Energy per symbol to noise power spectral density ratio (Es/No)
        %   Specify the Es/No ratio in decibels. Set this property to a numeric,
        %   real scalar or row vector with a length equal to the number of
        %   channels. This property applies when you set the NoiseMethod property
        %   to 'Signal to noise ratio (Es/No)'. The default is 10. This property
        %   is tunable.
        EsNo;

        %NoiseMethod Method to specify noise level
        %   Select the method to specify the noise level as one of 'Signal to
        %   noise ratio (Eb/No)' | 'Signal to noise ratio (Es/No)' | 'Signal to
        %   noise ratio (SNR)' | 'Variance'. The default is 'Signal to noise ratio
        %   (Eb/No)'.
        NoiseMethod;

        %RandomStream Source of random number stream 
        %   Specify the source of random number stream. The only valid setting
        %   for this property is 'Global stream' and the normally distributed
        %   random numbers are always generated from the current global random
        %   number stream.
        RandomStream;

        %SNR    Signal to noise ratio (SNR)
        %   Specify the SNR value in decibels. Set this property to a numeric,
        %   real scalar or row vector with a length equal to the number of
        %   channels. This property applies when you set the NoiseMethod property
        %   to 'Signal to noise ratio (SNR)'. The default is 10. This property is
        %   tunable.
        SNR;

        %SamplesPerSymbol Number of samples per symbol
        %   Specify the number of samples per symbol. Set this property to a
        %   numeric, positive, integer scalar or row vector with a length equal
        %   to the number of channels. This property applies when you set the
        %   NoiseMethod property to 'Signal to noise ratio (Eb/No)' or 'Signal to
        %   noise ratio (Es/No)'. The default is 1 sample.
        SamplesPerSymbol;

        %Seed Initial seed of mt19937ar random number stream
        %   This property is not used in the GPU version of the AWGN Channel.  
        Seed;

        %SignalPower Input signal power in Watts
        %   Specify the mean square power of the input signal in Watts. Set this
        %   property to a numeric, positive, real scalar or row vector with a
        %   length equal to the number of channels. This property applies when
        %   you set the NoiseMethod property to 'Signal to noise ratio (Eb/No)',
        %   'Signal to noise ratio (Es/No)' or 'Signal to noise ratio (SNR)'. The
        %   default is 1 Watt. The object assumes a nominal impedance of 1 Ohm.
        %   This property is tunable.
        SignalPower;

        %Variance Noise variance
        %   Specify the variance of the white Gaussian noise. You can set this
        %   property to a numeric, positive, real scalar or row vector with a
        %   length equal to the number of channels. This property applies when you
        %   set the NoiseMethod property to 'Variance' and the VarianceSource
        %   property to 'Property'. The default is 1. This property is tunable.
        Variance;

        %VarianceSource Source of noise variance
        %   Specify the source of the noise variance as one of 'Property' | 'Input
        %   port'. The default is 'Property'. Set VarianceSource to 'Input port'
        %   to specify the noise variance value via an input to the step method.
        %   Set VarianceSource to 'Property' to specify the noise variance value
        %   via the Variance property. This property applies when you set the
        %   NoiseMethod property to 'Variance'.
        VarianceSource;

    end
end
