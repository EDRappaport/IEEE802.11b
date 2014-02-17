classdef FadingChannel< handle
%FadingChannel Filter input signal through a fading channel

 
% Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=FadingChannel
            %FadingChannel Filter input signal through a fading channel
        end

        function getInputNamesImpl(in) %#ok<MANU>
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function getNumTxAndRx(in) %#ok<MANU>
        end

        function getOutputDataTypeImpl(in) %#ok<MANU>
        end

        function getOutputNamesImpl(in) %#ok<MANU>
        end

        function getOutputSizeImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
            % Use the if-else format for codegen
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexImpl(in) %#ok<MANU>
        end

        function isOutputFixedSizeImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function setupSQRTCorrelationMatrix(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateDelayProfileAndDoppler(in) %#ok<MANU>
            % Check AveragePathGains size
        end

        function validateInputsImpl(in) %#ok<MANU>
            % When the AntennaSelection property is set to 'Off' or 'Rx', the
            % signal input has a fixed number of columns.     
        end

        function validateRicianProperties(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %NormalizePathGains Normalize average path gains to 0 dB
        %   Set this property to true to normalize the fading processes such
        %   that the total power of the path gains, averaged over time, is 0dB.
        %   The default value of this property is true.
        NormalizePathGains;

        %PathGainsOutputPort Output channel path gains
        %   Set this property to true to output the channel path gains of the
        %   underlying fading process. The default value of this property is
        %   false.
        PathGainsOutputPort;

        %RandomStream Random number source
        %   Specify the source of random number stream as one of 'Global
        %   stream' | 'mt19937ar with seed'. If RandomStream is set to 'Global
        %   stream', the current global random number stream is used for
        %   normally distributed random number generation, in which case the
        %   reset method only resets the filters. If RandomStream is set to
        %   'mt19937ar with seed', the mt19937ar algorithm is used for normally
        %   distributed random number generation, in which case the reset
        %   method not only resets the filters but also re-initializes the
        %   random number stream to the value of the Seed property. The default
        %   value of this property is 'Global stream'.
        RandomStream;

        %Seed Initial seed
        %   Specify the initial seed of a mt19937ar random number generator
        %   algorithm as a double precision, real, nonnegative integer scalar.
        %   This property applies when you set the RandomStream property to
        %   'mt19937ar with seed'. The Seed is to re-initialize the mt19937ar
        %   random number stream in the reset method. The default value of this
        %   property is 73.
        Seed;

        % Channel filter delay, measured in samples
        pChannelFilterDelay;

        % Cutoff frequency factor that is 1 by default for doppler.jakes
        pFcFactor;

        % Uncorrelated spatial correlation flag
        pIsRHIdentity;

        % Number of input samples that have been processed since the last reset
        pNumSamplesProcessed;

        % Polyphase filter length that is a pre-assigned value
        pPolyphaseFilterLength;

        % [NP*NL, NP*NL] block diagonal spatial correlation matrix, for
        % spatially correlated channels only
        pSQRTCorrelationMatrix;

    end
end
