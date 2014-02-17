classdef ViterbiDecoder< handle
%ViterbiDecoder Viterbi Decoder (GPU) 
%   H = comm.gpu.ViterbiDecoder creates a Viterbi decoder System object, H.
%   This object uses the Viterbi algorithm to decode convolutionally encoded
%   input data.
%
%   Use of this object requires a Parallel Computing Toolbox license.
%
%   H = comm.gpu.ViterbiDecoder(Name,Value) creates a Viterbi decoder
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.ViterbiDecoder(TRELLIS,Name,Value) creates a Viterbi
%   decoder object, H, with the TrellisStructure property set to TRELLIS,
%   and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) decodes encoded data, X, using the Viterbi algorithm and
%   returns Y. X, must be a column vector with data type and values that
%   depend on how you set the InputFormat property. If the convolutional
%   code uses an alphabet of 2^N possible symbols, the length of the input
%   vector, X, must be L*N for some positive integer L. Similarly, if the
%   decoded data uses an alphabet of 2^K possible output symbols, the length
%   of the output vector, Y, is L*K.
%
%   Y = step(H,X,R) resets the internal states of the decoder when you input
%   a non-zero reset signal, R. R must be a double precision, single
%   precision or logical scalar. This syntax applies when you set the
%   TerminationMethod property to 'Continuous' and the ResetInputPort
%   property to true.
%
%   ViterbiDecoder methods:
%
%   step     - Decode using Viterbi algorithm (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Viterbi decoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the Viterbi decoder object
%   info     - Returns information about the GPU implementation 
%
%   ViterbiDecoder properties:
%
%   TrellisStructure            - Trellis structure of convolutional code
%   InputFormat                 - Input format
%   SoftInputWordLength         - Soft input word length
%   InvalidQuantizedInputAction - Action when input values are out of range
%   TracebackDepth              - Traceback depth
%   TerminationMethod           - Termination method of encoded frame
%   ResetInputPort              - Enable decoder reset input
%   DelayedResetAction          - Delay output reset
%   PuncturePatternSource       - Source of puncture pattern
%   PuncturePattern             - Puncture pattern vector
%   ErasuresInputPort           - Enable erasures input
%   OutputDataType              - Data type of output 
%   NumFrames                   - Number of Frames present in the input
%
%   % Example:
%   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
%   %   through an AWGN channel, then demodulate, decode using a Viterbi 
%   %   decoder, and count errors
%
%   hConEnc = comm.ConvolutionalEncoder;
%   hMod = comm.DPSKModulator('BitInput',true);
%   hChan = comm.gpu.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)', 'SNR',10);
%   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
%   hDec = comm.gpu.ViterbiDecoder('InputFormat','Hard');
%   % Delay in bits is TracebackDepth times the number of bits per symbol
%   delay = hDec.TracebackDepth*...
%                   log2(hDec.TrellisStructure.numInputSymbols);
%   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay',delay);
%   for counter = 1:20
%     data = randi([0 1],30,1);
%     encodedData = step(hConEnc, data);
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     receivedBits = step(hDec, demodSignal);
%     errorStats = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.ViterbiDecoder, comm.ConvolutionalEncoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=ViterbiDecoder
            %ViterbiDecoder Viterbi Decoder (GPU) 
            %   H = comm.gpu.ViterbiDecoder creates a Viterbi decoder System object, H.
            %   This object uses the Viterbi algorithm to decode convolutionally encoded
            %   input data.
            %
            %   Use of this object requires a Parallel Computing Toolbox license.
            %
            %   H = comm.gpu.ViterbiDecoder(Name,Value) creates a Viterbi decoder
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.ViterbiDecoder(TRELLIS,Name,Value) creates a Viterbi
            %   decoder object, H, with the TrellisStructure property set to TRELLIS,
            %   and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) decodes encoded data, X, using the Viterbi algorithm and
            %   returns Y. X, must be a column vector with data type and values that
            %   depend on how you set the InputFormat property. If the convolutional
            %   code uses an alphabet of 2^N possible symbols, the length of the input
            %   vector, X, must be L*N for some positive integer L. Similarly, if the
            %   decoded data uses an alphabet of 2^K possible output symbols, the length
            %   of the output vector, Y, is L*K.
            %
            %   Y = step(H,X,R) resets the internal states of the decoder when you input
            %   a non-zero reset signal, R. R must be a double precision, single
            %   precision or logical scalar. This syntax applies when you set the
            %   TerminationMethod property to 'Continuous' and the ResetInputPort
            %   property to true.
            %
            %   ViterbiDecoder methods:
            %
            %   step     - Decode using Viterbi algorithm (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Viterbi decoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the Viterbi decoder object
            %   info     - Returns information about the GPU implementation 
            %
            %   ViterbiDecoder properties:
            %
            %   TrellisStructure            - Trellis structure of convolutional code
            %   InputFormat                 - Input format
            %   SoftInputWordLength         - Soft input word length
            %   InvalidQuantizedInputAction - Action when input values are out of range
            %   TracebackDepth              - Traceback depth
            %   TerminationMethod           - Termination method of encoded frame
            %   ResetInputPort              - Enable decoder reset input
            %   DelayedResetAction          - Delay output reset
            %   PuncturePatternSource       - Source of puncture pattern
            %   PuncturePattern             - Puncture pattern vector
            %   ErasuresInputPort           - Enable erasures input
            %   OutputDataType              - Data type of output 
            %   NumFrames                   - Number of Frames present in the input
            %
            %   % Example:
            %   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
            %   %   through an AWGN channel, then demodulate, decode using a Viterbi 
            %   %   decoder, and count errors
            %
            %   hConEnc = comm.ConvolutionalEncoder;
            %   hMod = comm.DPSKModulator('BitInput',true);
            %   hChan = comm.gpu.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)', 'SNR',10);
            %   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
            %   hDec = comm.gpu.ViterbiDecoder('InputFormat','Hard');
            %   % Delay in bits is TracebackDepth times the number of bits per symbol
            %   delay = hDec.TracebackDepth*...
            %                   log2(hDec.TrellisStructure.numInputSymbols);
            %   hError = comm.ErrorRate('ComputationDelay',3,'ReceiveDelay',delay);
            %   for counter = 1:20
            %     data = randi([0 1],30,1);
            %     encodedData = step(hConEnc, data);
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     receivedBits = step(hDec, demodSignal);
            %     errorStats = step(hError, data, receivedBits);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.ViterbiDecoder, comm.ConvolutionalEncoder.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function infoImpl(in) %#ok<MANU>
            %info Returns the acquisition depth used in the GPU implementation
            %   S = info(OBJ) returns a structure describing the Acquisition
            %   Depth. The received sequence is decoded in parallel on the GPU.
            %   The decoding is performed by segmenting the received data into
            %   subsequences. The subsequences overlap by an amount called the
            %   Acquisition Depth which allows for correct decoding of each
            %   subsequence. The Acquisition Depth is given in units of
            %   (depunctured) codewords.
            %
            %   For unpunctured codes, the Acquisition Depth is the greater of 10
            %   times the constraint length or 2 times the TracebackDepth. For
            %   punctured codes this number is scaled by a multiple of the number
            %   of codewords in the puncture pattern vector.
            %
            %   AcquisitionDepth    - The number of (depunctured) codewords used to
            %                         overlap subsequences of the received data in
            %                         the GPU implementation of the Viterbi 
            %                         Decoder.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DelayedResetAction Delay output reset
        %   Delaying the output reset is not supported. The only valid setting is
        %   'false'.
        DelayedResetAction;

        %ErasuresInputPort Enable erasures input
        %   Erasures are not supported. The only valid setting is 'false'. 
        ErasuresInputPort;

        GPUCompiledArch;

        %InputFormat Input format
        %   Specify the format of the input to the decoder as one of 'Unquantized'
        %   | 'Hard' | 'Soft'. The default is 'Unquantized'. 
        %
        %   When you set this property to 'Unquantized', the input must be a real
        %   vector of double or single precision unquantized soft values. The
        %   object considers negative numbers to be 1's and positive numbers to be
        %   0's.
        %
        %   When you set this property to 'Hard', the input must be a vector of
        %   hard decision values, which are 0's or 1's. The data type of the
        %   inputs can be double precision or single precision.
        %
        %   When you set this property to 'Soft', the input must be a vector of
        %   quantized soft values represented as integers between 0 and
        %   2^SoftInputWordLength-1. The data type of the inputs can be double
        %   precision or single precision.
        InputFormat;

        %InvalidQuantizedInputAction Action when input values are out of  range
        %   The only valid setting is 'Ignore' which ignores out of range inputs. 
        InvalidQuantizedInputAction;

        %MaxRegistersPerThread - set in launch_bound in the .cu code 
        MaxRegistersPerThread;

        %These properties are constraints in the kernel code. The kernel code
        %assumes these maximums 
        MaxStates;

        MaxTraceback;

        %NumFrames Number of independent frames present in the input and output data vectors.
        %   Specify the number of independent frames contained in a single data
        %   input/output vector.  The input vector will be segmented into
        %   NumFrames segments and decoded independently.  The output will contain
        %   NumFrames decoded segments. The default value of this property is 1.
        %   This property is applicable when the TerminationMethod is set to
        %   'Terminated' or 'Truncated'.
        NumFrames;

        %OutputDataType Data type of output
        %   The only valid setting is 'Full precision' which makes the output data
        %   type match the input data type.
        OutputDataType;

        %PuncturePattern Puncture pattern vector
        %   Specify puncture pattern used to puncture the encoded data. The
        %   default is [1; 1; 0; 1; 0; 1]. The puncture pattern is a column vector
        %   of 1's and 0's, where the 0's indicate where to insert dummy bits. The
        %   puncture pattern must match the puncture pattern used by the encoder.
        %   This property applies when you set the PuncturePatternSource property
        %   to Property.
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. When you set this property to
        %   'None' the object assumes no puncturing. Set this property to
        %   'Property' to decode punctured codewords based on a puncture pattern
        %   vector specified via the PuncturePattern property.
        PuncturePatternSource;

        %ResetInputPort Enable decoder reset input
        %   Set this property to true to enable an additional step method input.
        %   When the reset input is a non-zero value, the object resets the
        %   internal states of the decoder to initial conditions. This property
        %   applies when you set the TerminationMethod property to 'Continuous'.
        %   The default is false.
        ResetInputPort;

        %SoftInputWordLength Soft input word length
        %   Specify the number of bits used to represent each quantized soft input
        %   value as a positive, integer scalar. This property applies when you
        %   set the InputFormat property to 'Soft'. The default is 4 bits.
        SoftInputWordLength;

        %TerminationMethod Termination method of encoded frame 
        %   Specify TerminationMethod as one of 'Continuous' | 'Truncated' |
        %   'Terminated'. The default is 'Continuous'.
        %
        %   In 'Continuous' mode, the object saves its internal state metric at
        %   the end of each frame for use with the next frame. The object treats
        %   each traceback path independently. Select 'Continuous' mode when the
        %   input signal contains only one symbol.
        %
        %   In 'Truncated' mode, the object treats each frame independently. The
        %   traceback path starts at the state with the best metric and always
        %   ends in the all-zeros state.
        %
        %   In 'Terminated' mode, the object treats each frame independently, and
        %   the traceback path always starts and ends in the all-zeros state.
        TerminationMethod;

        %TracebackDepth Traceback depth
        %   Specify the number of trellis branches used to construct each
        %   traceback path as a positive, integer scalar less than or equal to
        %   256. The traceback depth influences the decoding accuracy and delay.
        %   The number of zero symbols that precede the first decoded symbol in
        %   the output represent a decoding delay.  When you set the
        %   TerminationMethod property to 'Continuous', the decoding delay
        %   consists of TracebackDepth zero symbols, or TracebackDepth zero bits
        %   for a rate 1/N convolutional code. When you set the TerminationMethod
        %   property to 'Truncated' or 'Terminated', there is no output delay and
        %   TracebackDepth must be less than or equal to the number of symbols in
        %   each input. If the code rate is 1/2, a typical traceback depth value
        %   is about five times the constraint length of the code. The default is
        %   34.
        TracebackDepth;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify the trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. Only rate 1/2, 1/3
        %   and 1/4 trellises from simple feedforward encoders are supported. The
        %   default value is the result of poly2trellis(7, [171 133]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
