classdef ViterbiDecoder< handle
%ViterbiDecoder Decode convolutionally encoded data using Viterbi algorithm
%   H = comm.ViterbiDecoder creates a Viterbi decoder System object, H. This
%   object uses the Viterbi algorithm to decode convolutionally encoded
%   input data.
%
%   H = comm.ViterbiDecoder(Name,Value) creates a Viterbi decoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.ViterbiDecoder(TRELLIS,Name,Value) creates a Viterbi decoder
%   object, H, with the TrellisStructure property set to TRELLIS, and other
%   specified property Names set to the specified Values.
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
%   Y = step(H,X,ERASURES) uses the binary column input vector, ERASURES, to
%   erase the symbols of the input codewords. The elements in ERASURES must
%   be of data type double or logical. Values of 1 in the ERASURES vector
%   correspond to erased symbols, and values of 0 correspond to non-erased
%   symbols. The lengths of the X and ERASURES inputs must be the same. This
%   syntax applies when you set the ErasuresInputPort property to true.
%
%   Y = step(H,X,R) resets the internal states of the decoder when you input
%   a non-zero reset signal, R. R must be a double precision or logical
%   scalar. This syntax applies when you set the TerminationMethod property
%   to 'Continuous' and the ResetInputPort property to true.
%
%   ViterbiDecoder methods:
%
%   step     - Decode using Viterbi algorithm (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Viterbi decoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the Viterbi decoder object
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
%
%   The ViterbiDecoder object supports fixed-point operations. For more
%   information, type comm.ViterbiDecoder.helpFixedPoint.
%
%   % Example:
%   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
%   %   through an AWGN channel, then demodulate, decode using a Viterbi 
%   %   decoder, and count errors
%
%   hConEnc = comm.ConvolutionalEncoder;
%   hMod = comm.DPSKModulator('BitInput',true);
%   hChan = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)', 'SNR',10);
%   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
%   hDec = comm.ViterbiDecoder('InputFormat','Hard');
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
%   See also comm.ConvolutionalEncoder, comm.APPDecoder.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=ViterbiDecoder
            %ViterbiDecoder Decode convolutionally encoded data using Viterbi algorithm
            %   H = comm.ViterbiDecoder creates a Viterbi decoder System object, H. This
            %   object uses the Viterbi algorithm to decode convolutionally encoded
            %   input data.
            %
            %   H = comm.ViterbiDecoder(Name,Value) creates a Viterbi decoder object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.ViterbiDecoder(TRELLIS,Name,Value) creates a Viterbi decoder
            %   object, H, with the TrellisStructure property set to TRELLIS, and other
            %   specified property Names set to the specified Values.
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
            %   Y = step(H,X,ERASURES) uses the binary column input vector, ERASURES, to
            %   erase the symbols of the input codewords. The elements in ERASURES must
            %   be of data type double or logical. Values of 1 in the ERASURES vector
            %   correspond to erased symbols, and values of 0 correspond to non-erased
            %   symbols. The lengths of the X and ERASURES inputs must be the same. This
            %   syntax applies when you set the ErasuresInputPort property to true.
            %
            %   Y = step(H,X,R) resets the internal states of the decoder when you input
            %   a non-zero reset signal, R. R must be a double precision or logical
            %   scalar. This syntax applies when you set the TerminationMethod property
            %   to 'Continuous' and the ResetInputPort property to true.
            %
            %   ViterbiDecoder methods:
            %
            %   step     - Decode using Viterbi algorithm (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Viterbi decoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the Viterbi decoder object
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
            %
            %   The ViterbiDecoder object supports fixed-point operations. For more
            %   information, type comm.ViterbiDecoder.helpFixedPoint.
            %
            %   % Example:
            %   %   Transmit a convolutionally encoded 8-DPSK-modulated bit stream 
            %   %   through an AWGN channel, then demodulate, decode using a Viterbi 
            %   %   decoder, and count errors
            %
            %   hConEnc = comm.ConvolutionalEncoder;
            %   hMod = comm.DPSKModulator('BitInput',true);
            %   hChan = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)', 'SNR',10);
            %   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
            %   hDec = comm.ViterbiDecoder('InputFormat','Hard');
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
            %   See also comm.ConvolutionalEncoder, comm.APPDecoder.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.ViterbiDecoder System object fixed-point 
            %information
            %   comm.ViterbiDecoder.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.ViterbiDecoder
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is connected to the input if the OutputDataType
            % property is set to 'Full precision' and the input is floating-point
        end

    end
    methods (Abstract)
    end
    properties
        %CustomStateMetricDataType Fixed-point data type of state metric
        %  Specify the state metric fixed-point type as an unscaled, numerictype
        %  object with a Signedness of Auto. This property applies when you set
        %  the StateMetricDataType property to 'Custom'. The default is
        %  numerictype([],16).
        %
        %   See also numerictype.  
        CustomStateMetricDataType;

        %DelayedResetAction Delay output reset
        %   Set this property to true to delay resetting the object output. The
        %   default is false. When you set this property to true, the reset of the
        %   internal states of the decoder occurs after the object computes the
        %   decoded data. When you set this property to false, the reset of the
        %   internal states of the decoder occurs before the object computes the
        %   decoded data. This property applies when you set the ResetInputPort
        %   property to true.
        DelayedResetAction;

        %ErasuresInputPort Enable erasures input
        %   Set this property to true to specify a vector of erasures as a step
        %   method input. The erasures input must be a double precision or
        %   logical, binary, column vector that indicates which symbols of the
        %   input codewords to erase. Values of 1 indicate erased bits. The
        %   decoder does not update the branch metric for the erasures in the
        %   incoming data stream. The lengths of the step method erasure input and
        %   the step method data input must be the same. When you set the
        %   ErasuresInputPort property to false the object assumes no erasures.
        %   The default is false.
        ErasuresInputPort;

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
        %   inputs can be double precision, single precision, logical, 8-, 16-,
        %   and 32-bit signed integers, and 8-, 16-, and 32-bit unsigned integers.
        %
        %   When you set this property to 'Soft', the input must be a vector of
        %   quantized soft values represented as integers between 0 and
        %   2^SoftInputWordLength-1. The data type of the inputs can be double
        %   precision, single precision, logical, 8-, 16-, and 32-bit signed
        %   integers, and 8-, 16-, and 32-bit unsigned integers. The data type can
        %   also be set to an unsigned and unscaled fixed point object (fi) with a
        %   word length equal to the word length that you specify in the
        %   SoftInputWordLength property.
        InputFormat;

        %InvalidQuantizedInputAction Action when input values are out of  range
        %   Specify the action the object takes when input values are out of range
        %   as one of 'Ignore' | 'Error'. The default is 'Ignore'. Set this
        %   property to 'Error' so that the object generates an error when the
        %   quantized input values are out of range. This property applies when
        %   you set the InputFormat property to 'Hard' or 'Soft'.
        InvalidQuantizedInputAction;

        %OutputDataType Data type of output
        %   Specify the data type of the output as one of 'Full precision' |
        %   'Smallest unsigned integer' | 'double' | 'single' | 'int8' | 'uint8' |
        %   'int16' | 'uint16' | 'int32' | 'uint32' | 'logical'. The default is
        %   'Full precision'. Note that for integer data type inputs, a
        %   Fixed-Point Designer license is required when this property is set to
        %   'Smallest unsigned integer' or 'Full precision'.
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

        %StateMetricDataType Data type of state metric
        %   Specify the state metric data type as one of 'Custom' | 'Full
        %   precision'. The default is 'Custom'. This property applies when
        %   you set the InputFormat property to 'Hard' or 'Soft'.
        %
        %   When you set the InputFormat property to 'Hard' the step method data
        %   input must be a column vector of unsigned, fixed point numbers, (fi
        %   objects) of word length 1 to enable fixed-point Viterbi decoding.
        %   Based on this input (either a 0 or a 1), the object calculates the
        %   internal branch metrics using an unsigned integer of word length L,
        %   where L is the number of output bits as specified by the trellis
        %   structure.
        %
        %   When you set the InputFormat property to 'Soft', the step method data
        %   input must be a column vector of unsigned, fixed point numbers, (fi
        %   objects) of word length N, where N is the number of soft-decision bits
        %   specified in the SoftInputWordLength property. The step method data
        %   inputs must be integers in the range 0 to 2^N-1. The object calculates
        %   the internal branch metrics using an unsigned integer of word length L
        %   = (N + Nout - 1), where Nout is the number of output bits as specified
        %   by the trellis structure.
        StateMetricDataType;

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
        %   traceback path as a numeric, integer scalar. The traceback depth
        %   influences the decoding accuracy and delay. The number of zero symbols
        %   that precede the first decoded symbol in the output represent a
        %   decoding delay.  When you set the TerminationMethod property to
        %   'Continuous', the decoding delay consists of TracebackDepth zero
        %   symbols, or TracebackDepth*K zero bits for a rate K/N convolutional
        %   code. When you set the TerminationMethod property to 'Truncated' or
        %   'Terminated', there is no output delay and TracebackDepth must be less
        %   than or equal to the number of symbols in each input. If the code rate
        %   is 1/2, a typical traceback depth value is about five times the
        %   constraint length of the code. The default is 34.
        TracebackDepth;

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
