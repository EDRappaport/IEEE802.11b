classdef AWGNChannel< handle
%AWGNChannel Add white Gaussian noise to the input signal
%   H = comm.AWGNChannel creates an additive white Gaussian noise (AWGN)
%   channel System object, H. This object adds white Gaussian noise to a
%   real or complex input signal.
%
%   H = comm.AWGNChannel(Name,Value) creates an AWGN channel object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   The AWGN channel object uses the default MATLAB random stream. Reset
%   the default stream for repeatable simulations. Type 'help RandStream'
%   for more information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds white Gaussian noise to input X and returns the
%   result in Y. The input X can be a double or single precision data type
%   scalar, vector, or 2D matrix with real or complex values. The
%   dimensions of input X determine single or multichannel processing. For
%   a M-by-N matrix input, M is the number of time samples per channel and
%   N is the number of channels. M and N can be equal to 1. The object adds
%   frames of length M of Gaussian noise to each of the N channels
%   independently.
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
%   reset    - Reset random number stream if the RandomStream property is 
%              set to 'mt19937ar with seed'
%
%   AWGNChannel properties:
%
%   NoiseMethod          - Noise method
%   EbNo                 - Eb/No (dB)
%   EsNo                 - Es/No (dB)
%   SNR                  - SNR (dB)
%   BitsPerSymbol        - Bits per symbol
%   SignalPower          - Input signal power, referenced to 1 ohm (watts)
%   SamplesPerSymbol     - Samples per symbol
%   VarianceSource       - Noise variance source
%   Variance             - Noise variance
%   RandomStream         - Random number source
%   Seed                 - Initial seed
%
%   % Example:
%   %   Add AWGN to an 8-PSK signal
%
%   hMod = comm.PSKModulator; 
%   modData = step(hMod, randi([0 hMod.ModulationOrder-1], 1000, 1));
%   hAWGN = comm.AWGNChannel('EbNo',          15, ...
%                            'BitsPerSymbol', log2(hMod.ModulationOrder));
%   channelOutput = step(hAWGN, modData);
%   % Visualize the noiseless and noisy data in scatter plots
%   scatterplot(modData)
%   scatterplot(channelOutput)
%   % Change to a multi-channel input with bigger noise
%   hAWGN.EbNo = 10;
%   modData = step(hMod, randi([0 hMod.ModulationOrder-1], 1000, 1));
%   modData = reshape(modData, 500, 2);
%   channelOutput = step(hAWGN, modData);
%   % Visualize to see the effects from bigger noise
%   scatterplot(channelOutput(:))
% 
%   See also comm.BinarySymmetricChannel.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=AWGNChannel
            %AWGNChannel Add white Gaussian noise to the input signal
            %   H = comm.AWGNChannel creates an additive white Gaussian noise (AWGN)
            %   channel System object, H. This object adds white Gaussian noise to a
            %   real or complex input signal.
            %
            %   H = comm.AWGNChannel(Name,Value) creates an AWGN channel object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   The AWGN channel object uses the default MATLAB random stream. Reset
            %   the default stream for repeatable simulations. Type 'help RandStream'
            %   for more information.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) adds white Gaussian noise to input X and returns the
            %   result in Y. The input X can be a double or single precision data type
            %   scalar, vector, or 2D matrix with real or complex values. The
            %   dimensions of input X determine single or multichannel processing. For
            %   a M-by-N matrix input, M is the number of time samples per channel and
            %   N is the number of channels. M and N can be equal to 1. The object adds
            %   frames of length M of Gaussian noise to each of the N channels
            %   independently.
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
            %   reset    - Reset random number stream if the RandomStream property is 
            %              set to 'mt19937ar with seed'
            %
            %   AWGNChannel properties:
            %
            %   NoiseMethod          - Noise method
            %   EbNo                 - Eb/No (dB)
            %   EsNo                 - Es/No (dB)
            %   SNR                  - SNR (dB)
            %   BitsPerSymbol        - Bits per symbol
            %   SignalPower          - Input signal power, referenced to 1 ohm (watts)
            %   SamplesPerSymbol     - Samples per symbol
            %   VarianceSource       - Noise variance source
            %   Variance             - Noise variance
            %   RandomStream         - Random number source
            %   Seed                 - Initial seed
            %
            %   % Example:
            %   %   Add AWGN to an 8-PSK signal
            %
            %   hMod = comm.PSKModulator; 
            %   modData = step(hMod, randi([0 hMod.ModulationOrder-1], 1000, 1));
            %   hAWGN = comm.AWGNChannel('EbNo',          15, ...
            %                            'BitsPerSymbol', log2(hMod.ModulationOrder));
            %   channelOutput = step(hAWGN, modData);
            %   % Visualize the noiseless and noisy data in scatter plots
            %   scatterplot(modData)
            %   scatterplot(channelOutput)
            %   % Change to a multi-channel input with bigger noise
            %   hAWGN.EbNo = 10;
            %   modData = step(hMod, randi([0 hMod.ModulationOrder-1], 1000, 1));
            %   modData = reshape(modData, 500, 2);
            %   channelOutput = step(hAWGN, modData);
            %   % Visualize to see the effects from bigger noise
            %   scatterplot(channelOutput(:))
            % 
            %   See also comm.BinarySymmetricChannel.
        end

        function getHeaderImpl(in) %#ok<MANU>
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getOutputDataTypeImpl(in) %#ok<MANU>
        end

        function getOutputSizeImpl(in) %#ok<MANU>
        end

        function getPropertyGroupsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isOutputFixedSizeImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function processTunedPropertiesImpl(in) %#ok<MANU>
            % Calculate standard deviation
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % If input is complex, the random source generates complex data.
        end

        function stepImpl(in) %#ok<MANU>
            % If input is complex, output is also complex
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
            % Assign default values if property is not already set
        end

    end
    methods (Abstract)
    end
    properties
        %BitsPerSymbol Bits per symbol
        %   Specify the number of bits in each input symbol. You can set this
        %   property to a numeric, positive, integer scalar or row vector with a
        %   length equal to the number of channels. This property applies when
        %   you set the NoiseMethod property to 'Signal to noise ratio (Eb/No)'.
        %   The default is 1 bit.
        BitsPerSymbol;

        %EbNo     Eb/No (dB)
        %   Specify the Eb/No ratio in decibels. You can set this property to a
        %   numeric, real scalar or row vector with a length equal to the number
        %   of channels. This property applies when you set the NoiseMethod
        %   property to 'Signal to noise ratio (Eb/No)'. The default is 10. This
        %   property is tunable.
        EbNo;

        %EsNo     Es/No (dB)
        %   Specify the Es/No ratio in decibels. You can set this property to a
        %   numeric, real scalar or row vector with a length equal to the number
        %   of channels. This property applies when you set the NoiseMethod
        %   property to 'Signal to noise ratio (Es/No)'. The default is 10. This
        %   property is tunable.
        EsNo;

        %NoiseMethod Noise method
        %   Select the method to specify the noise level as one of 'Signal to
        %   noise ratio (Eb/No)' | 'Signal to noise ratio (Es/No)' | 'Signal to
        %   noise ratio (SNR)' | 'Variance'. The default is 'Signal to noise
        %   ratio (Eb/No)'.
        NoiseMethod;

        %RandomStream Random number source
        %   Specify the source of random number stream as one of 'Global stream'
        %   | 'mt19937ar with seed'. If RandomStream is set to 'Global stream',
        %   the current global random number stream is used for normally
        %   distributed random number generation. If RandomStream is set to
        %   'mt19937ar with seed', the mt19937ar algorithm is used for normally
        %   distributed random number generation, in which case the reset method
        %   re-initializes the random number stream to the value of the Seed
        %   property. The default value of this property is 'Global stream'.
        RandomStream;

        %SNR      SNR (dB)    
        %   Specify the SNR value in decibels. You can set this property to a
        %   numeric, real scalar or row vector with a length equal to the number
        %   of channels. This property applies when you set the NoiseMethod
        %   property to 'Signal to noise ratio (SNR)'. The default is 10. This
        %   property is tunable.
        SNR;

        %SamplesPerSymbol Samples per symbol
        %   Specify the number of samples per symbol. You can set this property
        %   to a numeric, positive, integer scalar or row vector with a length
        %   equal to the number of channels. This property applies when you set
        %   the NoiseMethod property to 'Signal to noise ratio (Eb/No)' or
        %   'Signal to noise ratio (Es/No)'. The default is 1 sample.
        SamplesPerSymbol;

        %Seed Initial seed
        %   Specify the initial seed of a mt19937ar random number generator
        %   algorithm as a double precision, real, nonnegative integer scalar.
        %   This property applies when you set the RandomStream property to
        %   'mt19937ar with seed'. The Seed is to re-initialize the mt19937ar
        %   random number stream in the reset method. The default value of this
        %   property is 67.
        Seed;

        %SignalPower Input signal power (watts)
        %   Specify the mean square power of the input signal in Watts. You can
        %   set this property to a numeric, positive, real scalar or row vector
        %   with a length equal to the number of channels. This property applies
        %   when you set the NoiseMethod property to 'Signal to noise ratio
        %   (Eb/No)', 'Signal to noise ratio (Es/No)' or 'Signal to noise ratio
        %   (SNR)'. The default is 1 Watt. The object assumes a nominal impedance
        %   of 1 Ohm. This property is tunable.
        SignalPower;

        %Variance Noise variance
        %   Specify the variance of the white Gaussian noise. You can set this
        %   property to a numeric, positive, real scalar or row vector with a
        %   length equal to the number of channels. This property applies when you
        %   set the NoiseMethod property to 'Variance' and the VarianceSource
        %   property to 'Property'. The default is 1. This property is tunable.
        Variance;

        %VarianceSource Noise variance source
        %   Specify the source of the noise variance as one of 'Property' | 'Input
        %   port'. The default is 'Property'. Set VarianceSource to 'Input port'
        %   to specify the noise variance value via an input to the step method.
        %   Set VarianceSource to 'Property' to specify the noise variance value
        %   via the Variance property. This property applies when you set the
        %   NoiseMethod property to 'Variance'.
        VarianceSource;

    end
end
