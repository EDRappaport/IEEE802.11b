classdef APPDecoder< handle
%APPDecoder Decode convolutional code using the a posteriori probability 
%method 
%   H = comm.APPDecoder creates an a posteriori probability (APP) decoder
%   System object, H, that decodes a convolutional code using the APP
%   method.
%
%   H = comm.APPDecoder(Name,Value) creates an APP decoder object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.APPDecoder(TRELLIS,Name,Value) creates an APP decoder object,
%   H, with the TrellisStructure property set to TRELLIS, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   [LUD,LCD] = step(H,LU,LC) performs APP decoding. The input LU is the
%   sequence of log-likelihoods of encoder input data bits. The input LC is
%   the sequence of log-likelihoods of encoded bits. Negative soft inputs
%   are considered to be zeros and positive soft inputs are considered to be
%   ones. The outputs, LUD and LCD, are updated versions of the input LU and
%   LC sequences and are obtained based on information about the encoder.
%   The inputs must be of the same data type, which can be double or single
%   precision. The output data type is the same as the input data type. If
%   the convolutional code uses an alphabet of 2^N symbols, the LC and LCD
%   vector lengths are multiples of N. If the decoded data uses an alphabet
%   of 2^K output symbols, the LU and LUD vector lengths are multiples of K.
%
%   LUD = step(H,LU,LC) performs APP decoding with the second output
%   disabled when the CodedBitLLROutputPort property is false.
%
%   APPDecoder methods:
%
%   step     - Decode convolutionally encoded input data using APP method
%              (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create APP decoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of APP decoder object
%
%   APPDecoder properties:
%
%   TrellisStructure      - Trellis structure of convolutional code
%   TerminationMethod     - Termination method of encoded frame
%   Algorithm             - Decoding algorithm
%   NumScalingBits        - Number of scaling bits
%   CodedBitLLROutputPort - Enable coded-bit LLR output
%
%   % Example: 
%   %   Transmit a convolutionally encoded 8-PSK-modulated bit stream 
%   %   through an AWGN channel, then demodulate, decode using an APP
%   %   decoder, and count errors
%
%   noiseVar = 2e-1;
%   frameLength = 300;
%   hConEnc = comm.ConvolutionalEncoder('TerminationMethod','Truncated');
%   hMod = comm.PSKModulator('BitInput',true, 'PhaseOffset',0);
%   hChan = comm.AWGNChannel('NoiseMethod', 'Variance', ...
%               'Variance',noiseVar);
%   % Demodulate using soft decisions
%   hDemod = comm.PSKDemodulator('BitOutput',true, 'PhaseOffset',0, ...
%              'DecisionMethod', 'Approximate log-likelihood ratio', ...
%              'Variance', noiseVar);
%   hAPPDec = comm.APPDecoder(...
%              'TrellisStructure', poly2trellis(7, [171 133]), ...
%              'Algorithm', 'True APP', 'CodedBitLLROutputPort', false);
%   hError = comm.ErrorRate;
%   for counter = 1:5
%     data = randi([0 1],frameLength,1);
%     encodedData = step(hConEnc, data);
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     % Decode the convolutionally encoded data. The APP decoder assumes a
%     % polarization of the soft inputs that is inverse to that of the 
%     % demodulator soft outputs so change the sign of demodSignal
%     receivedSoftBits = step(hAPPDec, zeros(frameLength,1), -demodSignal);
%     % Convert soft decisions to hard decisions
%     receivedBits = double(receivedSoftBits > 0);
%     errorStats = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.ConvolutionalEncoder, comm.TurboDecoder, poly2trellis. 

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=APPDecoder
            %APPDecoder Decode convolutional code using the a posteriori probability 
            %method 
            %   H = comm.APPDecoder creates an a posteriori probability (APP) decoder
            %   System object, H, that decodes a convolutional code using the APP
            %   method.
            %
            %   H = comm.APPDecoder(Name,Value) creates an APP decoder object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.APPDecoder(TRELLIS,Name,Value) creates an APP decoder object,
            %   H, with the TrellisStructure property set to TRELLIS, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [LUD,LCD] = step(H,LU,LC) performs APP decoding. The input LU is the
            %   sequence of log-likelihoods of encoder input data bits. The input LC is
            %   the sequence of log-likelihoods of encoded bits. Negative soft inputs
            %   are considered to be zeros and positive soft inputs are considered to be
            %   ones. The outputs, LUD and LCD, are updated versions of the input LU and
            %   LC sequences and are obtained based on information about the encoder.
            %   The inputs must be of the same data type, which can be double or single
            %   precision. The output data type is the same as the input data type. If
            %   the convolutional code uses an alphabet of 2^N symbols, the LC and LCD
            %   vector lengths are multiples of N. If the decoded data uses an alphabet
            %   of 2^K output symbols, the LU and LUD vector lengths are multiples of K.
            %
            %   LUD = step(H,LU,LC) performs APP decoding with the second output
            %   disabled when the CodedBitLLROutputPort property is false.
            %
            %   APPDecoder methods:
            %
            %   step     - Decode convolutionally encoded input data using APP method
            %              (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create APP decoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of APP decoder object
            %
            %   APPDecoder properties:
            %
            %   TrellisStructure      - Trellis structure of convolutional code
            %   TerminationMethod     - Termination method of encoded frame
            %   Algorithm             - Decoding algorithm
            %   NumScalingBits        - Number of scaling bits
            %   CodedBitLLROutputPort - Enable coded-bit LLR output
            %
            %   % Example: 
            %   %   Transmit a convolutionally encoded 8-PSK-modulated bit stream 
            %   %   through an AWGN channel, then demodulate, decode using an APP
            %   %   decoder, and count errors
            %
            %   noiseVar = 2e-1;
            %   frameLength = 300;
            %   hConEnc = comm.ConvolutionalEncoder('TerminationMethod','Truncated');
            %   hMod = comm.PSKModulator('BitInput',true, 'PhaseOffset',0);
            %   hChan = comm.AWGNChannel('NoiseMethod', 'Variance', ...
            %               'Variance',noiseVar);
            %   % Demodulate using soft decisions
            %   hDemod = comm.PSKDemodulator('BitOutput',true, 'PhaseOffset',0, ...
            %              'DecisionMethod', 'Approximate log-likelihood ratio', ...
            %              'Variance', noiseVar);
            %   hAPPDec = comm.APPDecoder(...
            %              'TrellisStructure', poly2trellis(7, [171 133]), ...
            %              'Algorithm', 'True APP', 'CodedBitLLROutputPort', false);
            %   hError = comm.ErrorRate;
            %   for counter = 1:5
            %     data = randi([0 1],frameLength,1);
            %     encodedData = step(hConEnc, data);
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     % Decode the convolutionally encoded data. The APP decoder assumes a
            %     % polarization of the soft inputs that is inverse to that of the 
            %     % demodulator soft outputs so change the sign of demodSignal
            %     receivedSoftBits = step(hAPPDec, zeros(frameLength,1), -demodSignal);
            %     % Convert soft decisions to hard decisions
            %     receivedBits = double(receivedSoftBits > 0);
            %     errorStats = step(hError, data, receivedBits);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.ConvolutionalEncoder, comm.TurboDecoder, poly2trellis. 
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Algorithm Decoding algorithm
        %   Specify the decoding algorithm that the object uses for
        %   decoding as one of 'True APP' | 'Max*' | 'Max'. The default is 'Max*'.
        %   When you set this property to 'True APP', the object implements true a
        %   posteriori probability decoding. When you set the property to any
        %   other value, the object uses approximations to increase the speed of
        %   the computations.
        Algorithm;

        %CodedBitLLROutputPort Enable coded-bit LLR output
        %   Set this property to false to disable the second output of the 
        %   decoding step method.  The default is true.
        CodedBitLLROutputPort;

        %NumScalingBits Number of scaling bits
        %   Specify the number of bits the decoder uses to scale the input data to
        %   avoid losing precision during the computations. The decoder multiplies
        %   the input by 2^NumScalingBits and divides the pre-output by the same
        %   factor. NumScalingBits must be a scalar integer between 0 and 8. This
        %   property applies when you set the Algorithm property to 'Max*'. The
        %   default is 3.
        NumScalingBits;

        %TerminationMethod Termination method of encoded frame    
        %   Specify how the encoded frame is terminated as one of 'Truncated' |
        %   'Terminated'. The default is 'Truncated'. When you set this property
        %   to 'Truncated', the object assumes that the encoder stops after
        %   encoding the last symbol in the input frame. When you set this
        %   property to 'Terminated' the object assumes that the encoder forces
        %   the trellis to end each frame in the all-zeros state by encoding
        %   additional symbols. If you use the comm.ConvolutionalEncoder System
        %   object to generate the encoded frame, the TerminationMethod values of
        %   both encoder and decoder objects must match.
        TerminationMethod;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis(7, [171 133], 171).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
