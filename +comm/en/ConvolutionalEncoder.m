classdef ConvolutionalEncoder< handle
%ConvolutionalEncoder Convolutionally encode binary data
%   H = comm.ConvolutionalEncoder creates a System object, H, that
%   convolutionally encodes binary data.
%
%   H = comm.ConvolutionalEncoder(Name,Value) creates a convolutional
%   encoder object, H, with the specified property Name set to the specified
%   Value. You can specify additional name-value pair arguments in any order
%   as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.ConvolutionalEncoder(TRELLIS,Name,Value) creates a
%   convolutional encoder object, H, with the TrellisStructure property set
%   to TRELLIS, and other specified property Names set to the specified
%   Values.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the binary data, X, using the convolutional
%   encoding that you specify in the TrellisStructure property. It returns
%   the encoded data, Y. Both X and Y are column vectors of data type
%   numeric, logical, or unsigned fixed point of word length 1 (fi object).
%   When the convolutional encoder represents a rate K/N code, the length of
%   the input vector equals K*L, for some positive integer, L. The step
%   method sets the length of the output vector, Y, to L*N.
%
%   Y = step(H,X,INITSTATE) uses the initial state specified in the
%   INITSTATE input when you set the TerminationMethod property to
%   'Truncated' and the InitialStateInputPort property to true. INITSTATE
%   must be an integer scalar.
%
%   Y = step(H,X,R) resets the internal states of the encoder when you input
%   a non-zero reset signal, R. R must be a double precision or logical
%   scalar. This syntax applies when you set the TerminationMethod property
%   to 'Continuous' and the ResetInputPort property to true.
%
%   [Y,FSTATE] = step(HCONENC,X) returns the final state of the encoder in
%   the integer scalar output FSTATE when you set the FinalStateOutputPort
%   property to true. This syntax applies when you set the TerminationMethod
%   property to 'Continuous' or 'Truncated'.
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
%
%   % Example:
%   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
%   %   through an AWGN channel, then demodulate, decode using a Viterbi 
%   %   decoder, and count errors
%
%   hConEnc = comm.ConvolutionalEncoder;
%   hMod = comm.DPSKModulator('BitInput',true);
%   hChan = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)',...
%                   'SNR',10);
%   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
%   hDec = comm.ViterbiDecoder('InputFormat','Hard');
%   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay', 34);
%   for counter = 1:20
%     data = randi([0 1],30,1);
%     encodedData = step(hConEnc, data);
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     receivedBits = step(hDec, demodSignal);
%     errors = step(hError, data, receivedBits);
%   end
%   disp(errors)
%
%   See also comm.ViterbiDecoder, comm.APPDecoder.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=ConvolutionalEncoder
            %ConvolutionalEncoder Convolutionally encode binary data
            %   H = comm.ConvolutionalEncoder creates a System object, H, that
            %   convolutionally encodes binary data.
            %
            %   H = comm.ConvolutionalEncoder(Name,Value) creates a convolutional
            %   encoder object, H, with the specified property Name set to the specified
            %   Value. You can specify additional name-value pair arguments in any order
            %   as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.ConvolutionalEncoder(TRELLIS,Name,Value) creates a
            %   convolutional encoder object, H, with the TrellisStructure property set
            %   to TRELLIS, and other specified property Names set to the specified
            %   Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes the binary data, X, using the convolutional
            %   encoding that you specify in the TrellisStructure property. It returns
            %   the encoded data, Y. Both X and Y are column vectors of data type
            %   numeric, logical, or unsigned fixed point of word length 1 (fi object).
            %   When the convolutional encoder represents a rate K/N code, the length of
            %   the input vector equals K*L, for some positive integer, L. The step
            %   method sets the length of the output vector, Y, to L*N.
            %
            %   Y = step(H,X,INITSTATE) uses the initial state specified in the
            %   INITSTATE input when you set the TerminationMethod property to
            %   'Truncated' and the InitialStateInputPort property to true. INITSTATE
            %   must be an integer scalar.
            %
            %   Y = step(H,X,R) resets the internal states of the encoder when you input
            %   a non-zero reset signal, R. R must be a double precision or logical
            %   scalar. This syntax applies when you set the TerminationMethod property
            %   to 'Continuous' and the ResetInputPort property to true.
            %
            %   [Y,FSTATE] = step(HCONENC,X) returns the final state of the encoder in
            %   the integer scalar output FSTATE when you set the FinalStateOutputPort
            %   property to true. This syntax applies when you set the TerminationMethod
            %   property to 'Continuous' or 'Truncated'.
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
            %
            %   % Example:
            %   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
            %   %   through an AWGN channel, then demodulate, decode using a Viterbi 
            %   %   decoder, and count errors
            %
            %   hConEnc = comm.ConvolutionalEncoder;
            %   hMod = comm.DPSKModulator('BitInput',true);
            %   hChan = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)',...
            %                   'SNR',10);
            %   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
            %   hDec = comm.ViterbiDecoder('InputFormat','Hard');
            %   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay', 34);
            %   for counter = 1:20
            %     data = randi([0 1],30,1);
            %     encodedData = step(hConEnc, data);
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     receivedBits = step(hDec, demodSignal);
            %     errors = step(hError, data, receivedBits);
            %   end
            %   disp(errors)
            %
            %   See also comm.ViterbiDecoder, comm.APPDecoder.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DelayedResetAction Delay output reset
        %   Set this property to true to delay resetting the object output. The
        %   default is false. When you set this property to true, the reset of the
        %   internal states of the encoder occurs after the object computes the
        %   encoded data. When you set this property to false, the reset of the
        %   internal states of the encoder occurs before the object computes the
        %   encoded data. This property applies when you set the ResetInputPort
        %   property to true.
        DelayedResetAction;

        %FinalStateOutputPort Enable final state output
        %   Set this property to true to obtain the final state of the encoder via
        %   a step method output. This property applies when you set the
        %   TerminationMethod property to 'Continuous' or 'Truncated'. The default
        %   is false.
        FinalStateOutputPort;

        %InitialStateInputPort Enable initial state input
        %   Set this property to true to enable a step method input that allows
        %   the specification of the initial state of the encoder for each input
        %   vector. This property applies when you set the TerminationMethod
        %   property to 'Truncated'. The default is false.
        InitialStateInputPort;

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
        %   Set this property to true to enable an additional input to the step
        %   method. When the reset step method input is a non-zero value, the
        %   internal states of the encoder are reset to initial conditions. The
        %   default is false. This property applies when you set the
        %   TerminationMethod property to 'Continuous'.
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
