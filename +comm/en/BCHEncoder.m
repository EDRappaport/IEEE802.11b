classdef BCHEncoder< handle
%BCHEncoder Encode data using a BCH encoder
%   H = comm.BCHEncoder creates a BCH encoder System object, H, that
%   performs BCH encoding.
%
%   H = comm.BCHEncoder(Name,Value) creates a BCH encoder object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.BCHEncoder(N,K,Name,Value) creates a BCH encoder object, H, with
%   the CodewordLength property set to N, the MessageLength property set to
%   K, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes input binary data, X, using a
%   (CodewordLength,MessageLength) BCH encoder with the corresponding
%   narrow-sense generator polynomial and returns the result in vector Y.
%   Input X must be a numeric or logical column vector with length equal to
%   an integer multiple of the message length stored in the MessageLength
%   property. A group of MessageLength input elements represents one message
%   word to be encoded. The length of the encoded data output vector, Y, is
%   an integer multiple of (CodewordLength - number of punctures). You
%   specify the number of punctures with the PuncturePatternSource and
%   PuncturePattern properties.
%
%   BCHEncoder methods:
%
%   step     - Encode input data (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create BCH encoder object with same property values
%   isLocked - Locked status (logical)
%   info     - Returns characteristic information about the code
%
%   BCHEncoder properties:
%
%   CodewordLength            - Codeword length
%   MessageLength             - Message length
%   PrimitivePolynomialSource - Source of primitive polynomial
%   PrimitivePolynomial       - Primitive polynomial
%   GeneratorPolynomialSource - Source of generator polynomial
%   GeneratorPolynomial       - Generator polynomial
%   CheckGeneratorPolynomial  - Enable generator polynomial checking
%   PuncturePatternSource     - Source of puncture pattern
%   PuncturePattern           - Puncture pattern vector
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
%   See also comm.BCHDecoder, comm.RSEncoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=BCHEncoder
            %BCHEncoder Encode data using a BCH encoder
            %   H = comm.BCHEncoder creates a BCH encoder System object, H, that
            %   performs BCH encoding.
            %
            %   H = comm.BCHEncoder(Name,Value) creates a BCH encoder object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.BCHEncoder(N,K,Name,Value) creates a BCH encoder object, H, with
            %   the CodewordLength property set to N, the MessageLength property set to
            %   K, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes input binary data, X, using a
            %   (CodewordLength,MessageLength) BCH encoder with the corresponding
            %   narrow-sense generator polynomial and returns the result in vector Y.
            %   Input X must be a numeric or logical column vector with length equal to
            %   an integer multiple of the message length stored in the MessageLength
            %   property. A group of MessageLength input elements represents one message
            %   word to be encoded. The length of the encoded data output vector, Y, is
            %   an integer multiple of (CodewordLength - number of punctures). You
            %   specify the number of punctures with the PuncturePatternSource and
            %   PuncturePattern properties.
            %
            %   BCHEncoder methods:
            %
            %   step     - Encode input data (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create BCH encoder object with same property values
            %   isLocked - Locked status (logical)
            %   info     - Returns characteristic information about the code
            %
            %   BCHEncoder properties:
            %
            %   CodewordLength            - Codeword length
            %   MessageLength             - Message length
            %   PrimitivePolynomialSource - Source of primitive polynomial
            %   PrimitivePolynomial       - Primitive polynomial
            %   GeneratorPolynomialSource - Source of generator polynomial
            %   GeneratorPolynomial       - Generator polynomial
            %   CheckGeneratorPolynomial  - Enable generator polynomial checking
            %   PuncturePatternSource     - Source of puncture pattern
            %   PuncturePattern           - Puncture pattern vector
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
            %   See also comm.BCHDecoder, comm.RSEncoder.
        end

        function infoImpl(in) %#ok<MANU>
            %info Returns characteristic information about the code
            %   S = info(OBJ) returns a structure containing characteristic
            %   information, S, about the Encoder. A description of
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
        %   Set this property to true to perform a generator polynomial check.
        %   This check verifies that X^CodewordLength + 1 is divisible by the
        %   generator polynomial specified in the GeneratorPolynomial property.
        %   For larger codes, disabling the check reduces processing time. It is
        %   recommended that you perform the check at least once before setting
        %   this property to false. This property applies when you set the
        %   GeneratorPolynomialSource property to 'Property'. The default is true.
        CheckGeneratorPolynomial;

        %CodewordLength Codeword length
        %   Specify the codeword length of the BCH code as a double precision,
        %   positive, integer scalar. The default is 15. The values in
        %   CodewordLength and MessageLength must produce a valid narrow-sense BCH
        %   code. For a full-length BCH code, the value of the CodewordLength
        %   property must be of the form 2^M-1, where M is an integer, with 3 <= M
        %   <= 16, that corresponds to the degree of the primitive polynomial that
        %   you specify with the PrimitivePolynomialSource and PrimitivePolynomial
        %   properties. If CodewordLength is less than 2^M-1, the object assumes a
        %   shortened code.
        CodewordLength;

        %GeneratorPolynomial Generator polynomial
        %   Specify the generator polynomial for encoding as a binary, double
        %   precision row vector or as a binary Galois row vector that represents
        %   the coefficients of the generator polynomial in order of descending
        %   powers. The length of the generator polynomial must be
        %   CodewordLength-MessageLength+1. This property applies when you set
        %   the GeneratorPolynomialSource property to 'Property'. The default is
        %   the result of bchgenpoly(15,5,[],'double'), which corresponds to a
        %   (15,5) code. 
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

        %PrimitivePolynomial Primitive polynomial
        %   Specify the primitive polynomial of order M that defines the finite
        %   Galois field GF(2) as a double precision, binary row vector with
        %   the coefficients of the polynomial in order of descending
        %   powers. This property applies when you set the
        %   PrimitivePolynomialSource property to 'Property'. The default is
        %   fliplr(de2bi(primpoly(4))) = [1 0 0 1 1], which corresponds to the
        %   polynomial x^4+x+1.
        PrimitivePolynomial;

        %PrimitivePolynomialSource Source of primitive polynomial
        %   Specify the source of the primitive polynomial as one of 'Auto' |
        %   'Property'. The default is 'Auto'. When you set this property to
        %   'Auto', the object uses a primitive polynomial of degree
        %   M=ceil(log2(CodewordLength+1)). The result of
        %   fliplr(de2bi(primpoly(M))) sets the value for this polynomial. Set
        %   this property to 'Property' to specify a polynomial using the
        %   PrimitivePolynomial property.
        PrimitivePolynomialSource;

        %PuncturePattern Puncture pattern vector
        %   Specify the pattern used to puncture the encoded data as a double
        %   precision, binary, column vector of length
        %   CodewordLength-MessageLength. Zeros in the puncture pattern vector
        %   indicate the position of the parity bits that the object punctures or
        %   excludes from each codeword. This property applies when you set the
        %   PuncturePatternSource property to 'Property'. The default is
        %   [ones(8,1); zeros(2,1)].
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. Set this property to 'None' to
        %   disable puncturing. Set this property to 'Property' to enable
        %   puncturing the code based on a puncture pattern vector you specify in
        %   the PuncturePattern property.
        PuncturePatternSource;

    end
end
