classdef ConvolutionalEncoder< handle
%ConvolutionalEncoder Convolutionally encode binary data
%   H = comm.gpu.ConvolutionalEncoder creates a System object, H, that
%   convolutionally encodes binary data.
%
%   H = comm.gpu.ConvolutionalEncoder(Name,Value) creates a convolutional
%   encoder object, H, with the specified property Name set to the specified
%   Value. You can specify additional name-value pair arguments in any order
%   as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.ConvolutionalEncoder(TRELLIS,Name,Value) creates a
%   convolutional encoder object, H, with the TrellisStructure property set
%   to TRELLIS, and other specified property Names set to the specified
%   Values.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the binary data, X, using the convolutional
%   encoding that you specify in the TrellisStructure property. It returns
%   the encoded data, Y. Both X and Y are column vectors of data type
%   single, double or logical. When the convolutional encoder represents a
%   rate K/N code, the length of the input vector equals K*L, for some
%   positive integer, L. The step method sets the length of the output
%   vector, Y, to L*N.
%
%   ConvolutionalEncoder methods:
%
%   step     - Perform convolutional encoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create convolutional encoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the convolutional encoder object
%
%   ConvolutionalEncoder properties:
%
%   TrellisStructure      - Trellis structure of convolutional code
%   TerminationMethod     - Termination method of encoded frame
%   ResetInputPort        - Enable encoder reset input
%   DelayedResetAction    - Delay output reset
%   InitialStateInputPort - Enable initial state input
%   FinalStateOutputPort  - Enable final state output
%   PuncturePatternSource - Source of puncture pattern
%   PuncturePattern       - Puncture pattern vector
%   NumFrames             - Number of frames present in the input vector
%
%   % Example:
%   %   Transmit a convolutionally encoded 8-PSK-modulated bit stream 
%   %   through an AWGN channel, then demodulate, decode using a Viterbi 
%   %   decoder, and count errors
%
%   hConEnc = comm.gpu.ConvolutionalEncoder;
%   hMod = comm.gpu.PSKModulator('BitInput',true);
%   hChan = comm.gpu.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)',...
%                   'SNR',7);
%   hDemod = comm.gpu.PSKDemodulator('BitOutput',true);                                  
%   hDec = comm.gpu.ViterbiDecoder('InputFormat','Hard');
%   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay', 34);
%   for counter = 1:20
%     data = randi([0 1],30,1);
%     encodedData = step(hConEnc, gpuArray(data));
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     receivedBits = step(hDec, demodSignal);
%     errors = step(hError, data, gather(receivedBits));
%   end
%   disp(errors)
%
%   See also comm.ConvolutionalEncoder, comm.gpu.ViterbiDecoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=ConvolutionalEncoder
            %ConvolutionalEncoder Convolutionally encode binary data
            %   H = comm.gpu.ConvolutionalEncoder creates a System object, H, that
            %   convolutionally encodes binary data.
            %
            %   H = comm.gpu.ConvolutionalEncoder(Name,Value) creates a convolutional
            %   encoder object, H, with the specified property Name set to the specified
            %   Value. You can specify additional name-value pair arguments in any order
            %   as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.ConvolutionalEncoder(TRELLIS,Name,Value) creates a
            %   convolutional encoder object, H, with the TrellisStructure property set
            %   to TRELLIS, and other specified property Names set to the specified
            %   Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes the binary data, X, using the convolutional
            %   encoding that you specify in the TrellisStructure property. It returns
            %   the encoded data, Y. Both X and Y are column vectors of data type
            %   single, double or logical. When the convolutional encoder represents a
            %   rate K/N code, the length of the input vector equals K*L, for some
            %   positive integer, L. The step method sets the length of the output
            %   vector, Y, to L*N.
            %
            %   ConvolutionalEncoder methods:
            %
            %   step     - Perform convolutional encoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create convolutional encoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the convolutional encoder object
            %
            %   ConvolutionalEncoder properties:
            %
            %   TrellisStructure      - Trellis structure of convolutional code
            %   TerminationMethod     - Termination method of encoded frame
            %   ResetInputPort        - Enable encoder reset input
            %   DelayedResetAction    - Delay output reset
            %   InitialStateInputPort - Enable initial state input
            %   FinalStateOutputPort  - Enable final state output
            %   PuncturePatternSource - Source of puncture pattern
            %   PuncturePattern       - Puncture pattern vector
            %   NumFrames             - Number of frames present in the input vector
            %
            %   % Example:
            %   %   Transmit a convolutionally encoded 8-PSK-modulated bit stream 
            %   %   through an AWGN channel, then demodulate, decode using a Viterbi 
            %   %   decoder, and count errors
            %
            %   hConEnc = comm.gpu.ConvolutionalEncoder;
            %   hMod = comm.gpu.PSKModulator('BitInput',true);
            %   hChan = comm.gpu.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)',...
            %                   'SNR',7);
            %   hDemod = comm.gpu.PSKDemodulator('BitOutput',true);                                  
            %   hDec = comm.gpu.ViterbiDecoder('InputFormat','Hard');
            %   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay', 34);
            %   for counter = 1:20
            %     data = randi([0 1],30,1);
            %     encodedData = step(hConEnc, gpuArray(data));
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     receivedBits = step(hDec, demodSignal);
            %     errors = step(hError, data, gather(receivedBits));
            %   end
            %   disp(errors)
            %
            %   See also comm.ConvolutionalEncoder, comm.gpu.ViterbiDecoder.
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

        function resetImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DelayedResetAction Delay output reset
        %   Resetting the encoder via an input port is not supported. The only valid
        %   setting is false.
        DelayedResetAction;

        %FinalStateOutputPort Enable final state output
        %   Outputting the final state of the encoder is not supported. The only valid
        %   setting is false.
        FinalStateOutputPort;

        %InitialStateInputPort Enable initial state input
        %   Setting the initial state of the encoder is not supported. The only valid
        %   setting is false.
        InitialStateInputPort;

        %NumFrames Number of independent frames present in the input and output data vectors.
        %   Specify the number of independent frames contained in a single data
        %   input/output vector.  The input vector will be segmented into
        %   NumFrames segments and encoded independently.  The output will contain
        %   NumFrames encoded segments. The default value of this property is 1.
        %   This property is applicable when the TerminationMethod is set to
        %   'Terminated' or 'Truncated'.
        NumFrames;

        %PuncturePattern Puncture pattern vector
        %   Specify the puncture pattern used to puncture the encoded data as a
        %   column vector. The vector contains 1's and 0's, where the 0's indicate
        %   the punctured, or excluded, bits. This property applies when you set
        %   the TerminationMethod property to 'Continuous' or 'Truncated', and the
        %   PuncturePatternSource property to 'Property'. The default is [1; 1; 0;
        %   1; 0; 1].
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. When you set this property to
        %   'None' the object does not apply puncturing. When you set this
        %   property to 'Property', the object punctures the code based on the
        %   puncture pattern vector that you specify in the PuncturePattern
        %   property. This property applies when you set the TerminationMethod
        %   property to 'Continuous' or 'Truncated'.
        PuncturePatternSource;

        %ResetInputPort Enable encoder reset input
        %   Resetting the encoder via an input port is not supported. The only valid
        %   setting is false.
        ResetInputPort;

        %TerminationMethod Termination method of encoded frame
        %   Specify how the encoded frame is terminated as one of 'Continuous' |
        %   'Truncated' | 'Terminated'. The default is 'Continuous'.
        %
        %   When you set this property to 'Continuous', the object retains the
        %   encoder states at the end of each input vector for use with the next
        %   input vector.
        %
        %   When you set this property to 'Truncated', the object treats each
        %   input vector independently. The encoder states are reset at the start
        %   of each input vector. If you set the InitialStateInputPort property to
        %   false, the object resets its states to the all-zeros state. If you set
        %   the InitialStateInputPort property to true, the object resets the
        %   states to the values you specify in the initial states step method
        %   input.
        %
        %   When you set this property to 'Terminated', the object treats each
        %   input vector independently. For each input vector, the object uses
        %   extra bits to set the encoder states to all-zeros states at the end of
        %   the vector. For a rate K/N code, the step method outputs a vector with
        %   length N*(L+S)/K, where S = constraintLength-1 (or, in the case of
        %   multiple constraint lengths, S = sum(constraintLength(i)-1)). L is the
        %   length of the input to the step method.
        TerminationMethod;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify the trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis(7, [171 133]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
