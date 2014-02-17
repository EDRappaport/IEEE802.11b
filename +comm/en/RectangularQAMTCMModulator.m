classdef RectangularQAMTCMModulator< handle
%RectangularQAMTCMModulator Convolutionally encode binary data and map using
%rectangular QAM constellation
%   H = comm.RectangularQAMTCMModulator creates a trellis-coded, rectangular
%   quadrature amplitude (QAM TCM) modulator System object, H. This object
%   convolutionally encodes a binary input signal and maps the result to a
%   rectangular QAM constellation.
%
%   H = comm.RectangularQAMTCMModulator(Name,Value) creates a rectangular
%   QAM TCM modulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RectangularQAMTCMModulator(TRELLIS,Name,Value) creates a
%   rectangular QAM TCM modulator object, H, with the TrellisStructure
%   property set to TRELLIS and other specified property Names set to the
%   specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) convolutionally encodes and modulates the input binary
%   data column vector, X, and returns the encoded and modulated data, Y. X
%   must be of data type numeric, logical, or unsigned fixed point of word
%   length 1 (fi object). When the convolutional encoder represents a rate
%   K/N code, the length of the input vector, X, must be K*L, for some
%   positive integer L. The step method outputs a complex column vector, Y,
%   of length L.
%
%   Y = step(H,X,R) resets the encoder of the rectangular QAM TCM modulator
%   object to the all-zeros state when you input a non-zero reset signal, R.
%   R must be a double precision or logical, scalar integer. This syntax
%   applies when you set the ResetInputPort property to true.
%
%   RectangularQAMTCMModulator methods:
%
%   step     - Modulate using rectangular QAM TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create rectangular QAM TCM modulator object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the rectangular QAM TCM modulator object
%
%   RectangularQAMTCMModulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   ResetInputPort    - Enable modulator reset input
%   ModulationOrder   - Number of points in signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate data using rectangular 16-QAM TCM modulation
%
%   % Create binary data.
%   data = randi([0 1], 3000,1); 
%   hMod = comm.RectangularQAMTCMModulator;
%   % Modulate and plot the data.
%   modData = step(hMod, data);
%   scatterplot(modData);
%
%   See also comm.RectangularQAMTCMDemodulator, comm.GeneralQAMTCMModulator,
%            comm.ConvolutionalEncoder.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=RectangularQAMTCMModulator
            %RectangularQAMTCMModulator Convolutionally encode binary data and map using
            %rectangular QAM constellation
            %   H = comm.RectangularQAMTCMModulator creates a trellis-coded, rectangular
            %   quadrature amplitude (QAM TCM) modulator System object, H. This object
            %   convolutionally encodes a binary input signal and maps the result to a
            %   rectangular QAM constellation.
            %
            %   H = comm.RectangularQAMTCMModulator(Name,Value) creates a rectangular
            %   QAM TCM modulator object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RectangularQAMTCMModulator(TRELLIS,Name,Value) creates a
            %   rectangular QAM TCM modulator object, H, with the TrellisStructure
            %   property set to TRELLIS and other specified property Names set to the
            %   specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) convolutionally encodes and modulates the input binary
            %   data column vector, X, and returns the encoded and modulated data, Y. X
            %   must be of data type numeric, logical, or unsigned fixed point of word
            %   length 1 (fi object). When the convolutional encoder represents a rate
            %   K/N code, the length of the input vector, X, must be K*L, for some
            %   positive integer L. The step method outputs a complex column vector, Y,
            %   of length L.
            %
            %   Y = step(H,X,R) resets the encoder of the rectangular QAM TCM modulator
            %   object to the all-zeros state when you input a non-zero reset signal, R.
            %   R must be a double precision or logical, scalar integer. This syntax
            %   applies when you set the ResetInputPort property to true.
            %
            %   RectangularQAMTCMModulator methods:
            %
            %   step     - Modulate using rectangular QAM TCM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create rectangular QAM TCM modulator object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the rectangular QAM TCM modulator object
            %
            %   RectangularQAMTCMModulator properties:
            %
            %   TrellisStructure  - Trellis structure of convolutional code
            %   TerminationMethod - Termination method of encoded frame
            %   ResetInputPort    - Enable modulator reset input
            %   ModulationOrder   - Number of points in signal constellation
            %   OutputDataType    - Data type of output
            %
            %   % Example:
            %   %   Modulate data using rectangular 16-QAM TCM modulation
            %
            %   % Create binary data.
            %   data = randi([0 1], 3000,1); 
            %   hMod = comm.RectangularQAMTCMModulator;
            %   % Modulate and plot the data.
            %   modData = step(hMod, data);
            %   scatterplot(modData);
            %
            %   See also comm.RectangularQAMTCMDemodulator, comm.GeneralQAMTCMModulator,
            %            comm.ConvolutionalEncoder.
        end

        function getInitializationParameters(in) %#ok<MANU>
            % input validation and initialization
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function releaseImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Initialization
        end

        function stepImpl(in) %#ok<MANU>
            % A non-empty varargin contains the input reset signal
        end

    end
    methods (Abstract)
    end
    properties
        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation used to map
        %   the convolutionally encoded data as a positive, integer scalar equal
        %   to 4, 8, 16, 32, or 64. The value of the ModulationOrder property must
        %   equal the number of possible output symbols from the convolutional
        %   encoder of the rectangular QAM TCM modulator. The value of the
        %   ModulationOrder property must be 2^N for a rate K/N convolutional
        %   code. The default is 16.
        ModulationOrder;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'single'. The
        %   default is 'double'.
        OutputDataType;

        %ResetInputPort Enable modulator reset input
        %   Set this property to true to enable an additional input to the step
        %   method. When you set the reset input to the step method to a non-zero
        %   value, the object resets the encoder to the all-zeros state. This
        %   property applies when you set the TerminationMethod property to
        %   'Continuous'. The default is false.
        ResetInputPort;

        %TerminationMethod Termination method of encoded frame
        %   Specify the termination method as one of 'Continuous' | 'Truncated' |
        %   'Terminated'. The default is 'Continuous'.
        %
        %   When you set this property to 'Continuous', the object retains the
        %   encoder states at the end of each input vector for use with the next
        %   input vector.
        %
        %   When you set this property to 'Truncated', the object treats each
        %   input vector independently. The encoder is reset to the all-zeros
        %   state at the start of each input vector.
        %
        %   When you set this property to 'Terminated', the object treats each
        %   input vector independently. For each input vector, extra bits are used
        %   to set the encoder to the all-zeros state at the end of the vector. For
        %   a rate K/N code, the step method outputs the vector with a length
        %   given by y = N*(L+S)/K, where S = constraintLength-1 (or, in the case
        %   of multiple constraint lengths, S = sum(constraintLength(i)-1)). L is
        %   the length of the input to the step method.
        TerminationMethod;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis([3 1 1], [ 5 2 0 0; 0 0 1 0; 0 0 0 1]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
