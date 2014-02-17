classdef BCHDecoder< handle
%BCHDecoder Decode data using a BCH decoder
%   H = comm.BCHDecoder creates a BCH decoder System object, H, that
%   performs BCH decoding.
%
%   H = comm.BCHDecoder(Name,Value) creates a BCH decoder object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.BCHDecoder(N,K,Name,Value) creates a BCH decoder object, H, with
%   the CodewordLength property set to N, the MessageLength property set to
%   K, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) decodes input binary codewords in X using a
%   (CodewordLength,MessageLength) BCH decoder with the corresponding
%   narrow-sense generator polynomial. The step method returns the estimated
%   message in Y. This syntax applies when you set the
%   NumCorrectedErrorsOutputPort property to false. The input X must be a
%   numeric or logical column vector. X must have an integer multiple of
%   (CodewordLength - number of punctures) elements. Specify the number of
%   punctures with the PuncturePatternSource and PuncturePattern properties.
%   Each group of (CodewordLength - number of punctures) input elements
%   represents one codeword to be decoded. The length of the output decoded
%   data vector, Y, is an integer multiple of the message length specified
%   in the MessageLength property.
% 
%   [Y,ERR] = step(H,X) returns the number of corrected errors in output ERR
%   when you set the NumCorrectedErrorsOutputPort property to true. A non-
%   negative value in the ith element of the ERR output vector denotes the
%   number of corrected errors in the ith input codeword. A value of -1 in
%   the ith element of the ERR output indicates that a decoding error
%   occurred for the ith input codeword. A decoding error occurs when an
%   input codeword has more errors than the error correction capability of
%   the BCH code.
%
%   Y = step(H,X,ERASURES) uses ERASURES as the erasures pattern input when
%   you set the ErasuresInputPort property to true. The object decodes the
%   binary encoded data input, X, and treats as erasures the bits of the
%   input codewords specified by the binary column vector, ERASURES. The
%   length of ERASURES must equal the length of X, and its elements must be
%   of data type double or logical. Values of 1 in the erasures vector
%   correspond to erased bits in the same position of the (possibly
%   punctured) input codewords.
%
%   BCHDecoder methods:
%
%   step     - Decode input data (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create BCH decoder object with same property values
%   isLocked - Locked status (logical)
%   info     - Returns characteristic information about the code
%
%   BCHDecoder properties:
%
%   CodewordLength               - Codeword length
%   MessageLength                - Message length
%   PrimitivePolynomialSource    - Source of primitive polynomial
%   PrimitivePolynomial          - Primitive polynomial
%   GeneratorPolynomialSource    - Source of generator polynomial
%   GeneratorPolynomial          - Generator polynomial
%   CheckGeneratorPolynomial     - Enable generator polynomial checking
%   PuncturePatternSource        - Source of puncture pattern
%   PuncturePattern              - Puncture pattern vector
%   ErasuresInputPort            - Enable erasures input
%   NumCorrectedErrorsOutputPort - Output number of corrected errors
%
%   % Example:
%   %   Transmit a BCH-encoded, 8-DPSK-modulated bit stream through an AWGN 
%   %   channel, then demodulate, decode, and count errors
%
%   hEnc = comm.BCHEncoder;
%   hMod = comm.DPSKModulator('BitInput',true);
%   hChan = comm.AWGNChannel(...
%           'NoiseMethod','Signal to noise ratio (SNR)','SNR',10);
%   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
%   hDec = comm.BCHDecoder;
%   hError = comm.ErrorRate('ComputationDelay',3);
%   for counter = 1:20
%     data = randi([0 1], 30, 1);
%     encodedData = step(hEnc, data);
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     receivedBits = step(hDec, demodSignal);
%     errorStats = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.BCHEncoder, comm.RSDecoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=BCHDecoder
            %BCHDecoder Decode data using a BCH decoder
            %   H = comm.BCHDecoder creates a BCH decoder System object, H, that
            %   performs BCH decoding.
            %
            %   H = comm.BCHDecoder(Name,Value) creates a BCH decoder object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.BCHDecoder(N,K,Name,Value) creates a BCH decoder object, H, with
            %   the CodewordLength property set to N, the MessageLength property set to
            %   K, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) decodes input binary codewords in X using a
            %   (CodewordLength,MessageLength) BCH decoder with the corresponding
            %   narrow-sense generator polynomial. The step method returns the estimated
            %   message in Y. This syntax applies when you set the
            %   NumCorrectedErrorsOutputPort property to false. The input X must be a
            %   numeric or logical column vector. X must have an integer multiple of
            %   (CodewordLength - number of punctures) elements. Specify the number of
            %   punctures with the PuncturePatternSource and PuncturePattern properties.
            %   Each group of (CodewordLength - number of punctures) input elements
            %   represents one codeword to be decoded. The length of the output decoded
            %   data vector, Y, is an integer multiple of the message length specified
            %   in the MessageLength property.
            % 
            %   [Y,ERR] = step(H,X) returns the number of corrected errors in output ERR
            %   when you set the NumCorrectedErrorsOutputPort property to true. A non-
            %   negative value in the ith element of the ERR output vector denotes the
            %   number of corrected errors in the ith input codeword. A value of -1 in
            %   the ith element of the ERR output indicates that a decoding error
            %   occurred for the ith input codeword. A decoding error occurs when an
            %   input codeword has more errors than the error correction capability of
            %   the BCH code.
            %
            %   Y = step(H,X,ERASURES) uses ERASURES as the erasures pattern input when
            %   you set the ErasuresInputPort property to true. The object decodes the
            %   binary encoded data input, X, and treats as erasures the bits of the
            %   input codewords specified by the binary column vector, ERASURES. The
            %   length of ERASURES must equal the length of X, and its elements must be
            %   of data type double or logical. Values of 1 in the erasures vector
            %   correspond to erased bits in the same position of the (possibly
            %   punctured) input codewords.
            %
            %   BCHDecoder methods:
            %
            %   step     - Decode input data (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create BCH decoder object with same property values
            %   isLocked - Locked status (logical)
            %   info     - Returns characteristic information about the code
            %
            %   BCHDecoder properties:
            %
            %   CodewordLength               - Codeword length
            %   MessageLength                - Message length
            %   PrimitivePolynomialSource    - Source of primitive polynomial
            %   PrimitivePolynomial          - Primitive polynomial
            %   GeneratorPolynomialSource    - Source of generator polynomial
            %   GeneratorPolynomial          - Generator polynomial
            %   CheckGeneratorPolynomial     - Enable generator polynomial checking
            %   PuncturePatternSource        - Source of puncture pattern
            %   PuncturePattern              - Puncture pattern vector
            %   ErasuresInputPort            - Enable erasures input
            %   NumCorrectedErrorsOutputPort - Output number of corrected errors
            %
            %   % Example:
            %   %   Transmit a BCH-encoded, 8-DPSK-modulated bit stream through an AWGN 
            %   %   channel, then demodulate, decode, and count errors
            %
            %   hEnc = comm.BCHEncoder;
            %   hMod = comm.DPSKModulator('BitInput',true);
            %   hChan = comm.AWGNChannel(...
            %           'NoiseMethod','Signal to noise ratio (SNR)','SNR',10);
            %   hDemod = comm.DPSKDemodulator('BitOutput',true);                                  
            %   hDec = comm.BCHDecoder;
            %   hError = comm.ErrorRate('ComputationDelay',3);
            %   for counter = 1:20
            %     data = randi([0 1], 30, 1);
            %     encodedData = step(hEnc, data);
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     receivedBits = step(hDec, demodSignal);
            %     errorStats = step(hError, data, receivedBits);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.BCHEncoder, comm.RSDecoder.
        end

        function infoImpl(in) %#ok<MANU>
            %info Returns characteristic information about the code
            %   S = info(OBJ) returns a structure containing characteristic
            %   information, S, about the Decoder. A description of
            %   the fields and their values is as follows.
            %   ErrorCorrectionCapability       - Number of errors the code 
            %                                     is capable of correcting.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %CheckGeneratorPolynomial Enable generator polynomial checking
        %   Set this property to true to perform a generator polynomial check the
        %   first time you call the step method. This check verifies that
        %   X^CodewordLength + 1 is divisible by the generator polynomial
        %   specified in the GeneratorPolynomial property. For larger codes,
        %   disabling the check reduces processing time. It is recommended that
        %   you perform the check at least once before setting this property to
        %   false. This property applies when you set the
        %   GeneratorPolynomialSource property to 'Property'. The default is true.
        CheckGeneratorPolynomial;

        %CodewordLength Codeword length
        %   Specify the codeword length of the BCH code as a double precision,
        %   positive, integer scalar. The default is 15. The values in
        %   CodewordLength and MessageLength, must produce a valid narrow-sense
        %   BCH code. For a full-length BCH code the value of the CodewordLength
        %   property must be of the form 2^M-1, where M is an integer, with 3 <= M
        %   <= 16, that corresponds to the degree of the primitive polynomial that
        %   you specify with the PrimitivePolynomialSource and PrimitivePolynomial
        %   properties. If the CodewordLength property is less than 2^M-1, the
        %   object assumes a shortened code.
        CodewordLength;

        %ErasuresInputPort Enable erasures input
        %   Set this property to true to specify a vector of erasures as a step
        %   method input. The erasures vector is a double precision or logical,
        %   binary column vector that indicates which bits of the input codewords
        %   to erase or ignore. The length of the vector must be equal to the
        %   encoded data input, X, (i.e., it must be an integer multiple of
        %   (CodewordLength - number of punctures)). Values of 1 in the erasures
        %   vector correspond to erased bits in the same position of the (possibly
        %   punctured) input codewords. Set the ErasuresInputPort property to
        %   false to disable erasures. The default is false.
        ErasuresInputPort;

        %GeneratorPolynomial Generator polynomial
        %   Specify the generator polynomial as a binary, double precision, row
        %   vector or as a binary Galois row vector that represents the
        %   coefficients of the generator polynomial in order of descending
        %   powers. The length of the generator polynomial must be
        %   CodewordLength-MessageLength+1. This property applies when you set the
        %   GeneratorPolynomialSource property to 'Property'. The default is the
        %   result of bchgenpoly(15,5,[],'double'), which corresponds to a (15,5) code.
        %   
        %   When you use this object to generate code, you must set the generator
        %   polynomial to a binary, double precision row vector.
        GeneratorPolynomial;

        %GeneratorPolynomialSource Source of generator polynomial
        %   Specify the source of the generator polynomial as one of 'Auto' |
        %   'Property'. The default is 'Auto'.
        %   
        %   When you set this property to 'Auto', the object chooses the generator
        %   polynomial automatically. The object computes the generator polynomial
        %   based on the value of the PrimitivePolynomialSource property. When you
        %   set the PrimitivePolynomialSource property to 'Auto' the object
        %   computes the generator polynomial as
        %   bchgenpoly(CodewordLength+SL,MessageLength+SL). When you set the
        %   PrimitivePolynomialSource property to 'Property', the object computes
        %   generator polynomial as bchgenpoly(CodewordLength+SL,MessageLength+SL,
        %   PrimitivePolynomial). In both cases, SL = (2^M-1)-CodewordLength is
        %   the shortening length and M is the degree of the primitive polynomial
        %   that you specify with the PrimitivePolynomialSource and
        %   PrimitivePolynomial properties.
        %
        %   Set this property to 'Property' to specify a generator polynomial
        %   using the GeneratorPolynomial property.
        GeneratorPolynomialSource;

        %MessageLength Message length
        %   Specify the message length as a double precision, positive, integer
        %   scalar. The values of the CodewordLength and MessageLength properties
        %   must produce a valid narrow-sense BCH code. The default is 5.
        MessageLength;

        %NumCorrectedErrorsOutputPort Output number of corrected errors
        %   Set this property to true so that the step method outputs the number
        %   of corrected errors. The default is true.
        NumCorrectedErrorsOutputPort;

        %PrimitivePolynomial Primitive polynomial
        %   Specify the primitive polynomial of order M, that defines the finite
        %   Galois field GF(2) as a double precision, binary row vector with the
        %   coefficients of the polynomial in order of descending powers. This
        %   property applies when you set the PrimitivePolynomialSource property
        %   to 'Property'. The default is fliplr(de2bi(primpoly(4))) = [1 0 0 1
        %   1], which corresponds to the polynomial x^4+x+1.
        PrimitivePolynomial;

        %PrimitivePolynomialSource Source of primitive polynomial
        %   Specify the source of the primitive polynomial as one of 'Auto' |
        %   'Property'. The default is 'Auto'. When you set this property to
        %   'Auto', the object uses a primitive polynomial of degree
        %   M=ceil(log2(CodewordLength+1)). The result of
        %   fliplr(de2bi(primpoly(M))), sets the value for this polynomial. Set
        %   this property to 'Property to specify a polynomial using the
        %   PrimitivePolynomial property.
        PrimitivePolynomialSource;

        %PuncturePattern Puncture pattern vector
        %   Specify the pattern that the object uses to puncture the encoded data
        %   as a double precision, binary column vector of length
        %   CodewordLength-MessageLength. Zeros in the puncture pattern vector
        %   indicate the position of the parity bits that the object punctures or
        %   excludes from each codeword. This property applies when you set the
        %   PuncturePatternSource property to 'Property'. The default is
        %   [ones(8,1); zeros(2,1)].
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. Set this property to 'None', to
        %   disable puncturing. Set this property to 'Property' to decode
        %   punctured codewords based on a puncture pattern vector you specify in
        %   the PuncturePattern property.
        PuncturePatternSource;

    end
end
