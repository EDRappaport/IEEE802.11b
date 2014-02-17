classdef PSKTCMModulator< handle
%PSKTCMModulator Convolutionally encode binary data and map using M-ary PSK
%constellation
%   H = comm.PSKTCMModulator creates a trellis-coded M-ary phase shift
%   keying (PSK TCM) modulator System object, H. The object convolutionally
%   encodes a binary input signal and maps the result to an M-PSK
%   constellation.
%
%   H = comm.PSKTCMModulator(Name,Value) creates a PSK TCM encoder object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PSKTCMModulator(TRELLIS,Name,Value) creates a PSK TCM encoder
%   object, H, with the TrellisStructure property set to TRELLIS and other
%   specified property Names set to the specified Values.
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
%   Y = step(H,X,R) resets the encoder of the PSK TCM modulator object to
%   the all-zeros state when you input a reset signal, R, that is non-zero.
%   R must be a double precision or logical scalar integer. This syntax
%   applies when you set the ResetInputPort property to true.
%
%   PSKTCMModulator methods:
%
%   step     - Modulate using PSK TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PSK TCM modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the PSK TCM modulator object
%
%   PSKTCMModulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   ResetInputPort    - Enable modulator reset input
%   ModulationOrder   - Number of points in signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate data using 8-PSK TCM modulation
%
%   % Create binary data
%   data = randi([0 1], 1000,1); 
%   % Define a trellis structure with 4-ary input symbols and 8-ary  
%   % output symbols and create an 8-PSK TCM modulator
%   t =  poly2trellis([5 4],[23 35 0; 0 5 13]);
%   hMod = comm.PSKTCMModulator(t,'ModulationOrder', 8);
%   % Modulate and plot the data
%   modData = step(hMod, data);
%   scatterplot(modData);
%
%   See also comm.PSKTCMDemodulator, comm.GeneralQAMTCMModulator, 
%            comm.RectangularQAMTCMModulator, comm.ConvolutionalEncoder.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=PSKTCMModulator
            %PSKTCMModulator Convolutionally encode binary data and map using M-ary PSK
            %constellation
            %   H = comm.PSKTCMModulator creates a trellis-coded M-ary phase shift
            %   keying (PSK TCM) modulator System object, H. The object convolutionally
            %   encodes a binary input signal and maps the result to an M-PSK
            %   constellation.
            %
            %   H = comm.PSKTCMModulator(Name,Value) creates a PSK TCM encoder object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PSKTCMModulator(TRELLIS,Name,Value) creates a PSK TCM encoder
            %   object, H, with the TrellisStructure property set to TRELLIS and other
            %   specified property Names set to the specified Values.
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
            %   Y = step(H,X,R) resets the encoder of the PSK TCM modulator object to
            %   the all-zeros state when you input a reset signal, R, that is non-zero.
            %   R must be a double precision or logical scalar integer. This syntax
            %   applies when you set the ResetInputPort property to true.
            %
            %   PSKTCMModulator methods:
            %
            %   step     - Modulate using PSK TCM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PSK TCM modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the PSK TCM modulator object
            %
            %   PSKTCMModulator properties:
            %
            %   TrellisStructure  - Trellis structure of convolutional code
            %   TerminationMethod - Termination method of encoded frame
            %   ResetInputPort    - Enable modulator reset input
            %   ModulationOrder   - Number of points in signal constellation
            %   OutputDataType    - Data type of output
            %
            %   % Example:
            %   %   Modulate data using 8-PSK TCM modulation
            %
            %   % Create binary data
            %   data = randi([0 1], 1000,1); 
            %   % Define a trellis structure with 4-ary input symbols and 8-ary  
            %   % output symbols and create an 8-PSK TCM modulator
            %   t =  poly2trellis([5 4],[23 35 0; 0 5 13]);
            %   hMod = comm.PSKTCMModulator(t,'ModulationOrder', 8);
            %   % Modulate and plot the data
            %   modData = step(hMod, data);
            %   scatterplot(modData);
            %
            %   See also comm.PSKTCMDemodulator, comm.GeneralQAMTCMModulator, 
            %            comm.RectangularQAMTCMModulator, comm.ConvolutionalEncoder.
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
        %   the convolutionally encoded data as a positive integer scalar equal to
        %   4, 8, or 16. The value of the ModulationOrder property must be equal
        %   to the number of possible output symbols from the convolutional
        %   encoder of the PSK TCM modulator. This means that the value for the
        %   ModulationOrder property must be equal to 2^N for a rate K/N
        %   convolutional code. The default is 8.
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
        %   input vector independently. However, for each input vector, extra bits
        %   are used to set the encoder to the all-zeros state at the end of the
        %   vector. For a rate K/N code, the step method outputs the vector with a
        %   length given by y = N*(L+S)/K, where S = constraintLength-1 (or, in
        %   the case of multiple constraint lengths, S =
        %   sum(constraintLength(i)-1)). L is the length of the input to the step
        %   method.
        TerminationMethod;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis([1 3], [1 0 0; 0 5 2]).
        %
        %   See also istrellis and poly2trellis.
        TrellisStructure;

    end
end
