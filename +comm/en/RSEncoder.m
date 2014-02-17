classdef RSEncoder< handle
%RSEncoder Encode data using a Reed-Solomon encoder
%   H = comm.RSEncoder returns a block encoder System object, H, that
%   performs Reed-Solomon (RS) encoding.
%
%   H = comm.RSEncoder(Name,Value) creates an RS encoder object, H, with the
%   specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RSEncoder(N,K,Name,Value) creates an RS encoder object, H, with
%   the CodewordLength property set to N, the MessageLength property set to
%   K, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the column input data vector, X, and returns the
%   encoded data, Y. The value of the BitInput property determines whether X
%   is a vector of integers or bits with a numeric, logical, or fixed-point
%   data type. The MessageLength property affects the expected length of X.
%   The PuncturePatternSource and PuncturePattern properties affect the
%   length of Y.
%
%   RSEncoder methods:
%
%   step     - Perform RS encoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create RS encoder object with same property values
%   isLocked - Locked status (logical)
%   info     - Returns characteristic information about the code
%
%   RSEncoder properties:
%
%   BitInput                  - Assume input is bits
%   CodewordLength            - Codeword length
%   MessageLength             - Message length
%   PrimitivePolynomialSource - Source of primitive polynomial
%   PrimitivePolynomial       - Primitive polynomial
%   GeneratorPolynomialSource - Source of generator polynomial
%   GeneratorPolynomial       - Generator polynomial
%   CheckGeneratorPolynomial  - Enable generator polynomial checking
%   PuncturePatternSource     - Source of puncture pattern
%   PuncturePattern           - Puncture pattern vector
%   OutputDataType            - Data type of output
%
%   % Example:
%   %   Transmit an RS-encoded, 8-DPSK-modulated symbol stream through an 
%   %   AWGN channel, then demodulate, decode, and count errors.
%
%   hEnc = comm.RSEncoder;
%   hMod = comm.DPSKModulator('BitInput',false);
%   hChan = comm.AWGNChannel(...
%               'NoiseMethod','Signal to noise ratio (SNR)','SNR',10);
%   hDemod = comm.DPSKDemodulator('BitOutput',false);
%   hDec = comm.RSDecoder;
%   hError = comm.ErrorRate('ComputationDelay',3);
%   for counter = 1:20
%     data = randi([0 7], 30, 1);
%     encodedData = step(hEnc, data);
%     modSignal = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal = step(hDemod, receivedSignal);
%     receivedSymbols = step(hDec, demodSignal);
%     errorStats = step(hError, data, receivedSymbols);            
%   end            
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.RSDecoder, comm.BCHEncoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=RSEncoder
            %RSEncoder Encode data using a Reed-Solomon encoder
            %   H = comm.RSEncoder returns a block encoder System object, H, that
            %   performs Reed-Solomon (RS) encoding.
            %
            %   H = comm.RSEncoder(Name,Value) creates an RS encoder object, H, with the
            %   specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RSEncoder(N,K,Name,Value) creates an RS encoder object, H, with
            %   the CodewordLength property set to N, the MessageLength property set to
            %   K, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes the column input data vector, X, and returns the
            %   encoded data, Y. The value of the BitInput property determines whether X
            %   is a vector of integers or bits with a numeric, logical, or fixed-point
            %   data type. The MessageLength property affects the expected length of X.
            %   The PuncturePatternSource and PuncturePattern properties affect the
            %   length of Y.
            %
            %   RSEncoder methods:
            %
            %   step     - Perform RS encoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create RS encoder object with same property values
            %   isLocked - Locked status (logical)
            %   info     - Returns characteristic information about the code
            %
            %   RSEncoder properties:
            %
            %   BitInput                  - Assume input is bits
            %   CodewordLength            - Codeword length
            %   MessageLength             - Message length
            %   PrimitivePolynomialSource - Source of primitive polynomial
            %   PrimitivePolynomial       - Primitive polynomial
            %   GeneratorPolynomialSource - Source of generator polynomial
            %   GeneratorPolynomial       - Generator polynomial
            %   CheckGeneratorPolynomial  - Enable generator polynomial checking
            %   PuncturePatternSource     - Source of puncture pattern
            %   PuncturePattern           - Puncture pattern vector
            %   OutputDataType            - Data type of output
            %
            %   % Example:
            %   %   Transmit an RS-encoded, 8-DPSK-modulated symbol stream through an 
            %   %   AWGN channel, then demodulate, decode, and count errors.
            %
            %   hEnc = comm.RSEncoder;
            %   hMod = comm.DPSKModulator('BitInput',false);
            %   hChan = comm.AWGNChannel(...
            %               'NoiseMethod','Signal to noise ratio (SNR)','SNR',10);
            %   hDemod = comm.DPSKDemodulator('BitOutput',false);
            %   hDec = comm.RSDecoder;
            %   hError = comm.ErrorRate('ComputationDelay',3);
            %   for counter = 1:20
            %     data = randi([0 7], 30, 1);
            %     encodedData = step(hEnc, data);
            %     modSignal = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal = step(hDemod, receivedSignal);
            %     receivedSymbols = step(hDec, demodSignal);
            %     errorStats = step(hError, data, receivedSymbols);            
            %   end            
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.RSDecoder, comm.BCHEncoder.
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
        end

        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume input is bits
        %   Specify whether the input is bits or integers. 
        %
        %   When you set this property to false, the step method input data
        %   vector, X, must be a numeric, column vector of integers with a length
        %   equal to an integer multiple of the message length value stored in the
        %   MessageLength property. Each group of MessageLength input elements
        %   represents one message word the object will encode. The encoded data
        %   output vector, Y, is a column vector of integers whose length is an
        %   integer multiple of (CodewordLength - number of punctures). You
        %   specify the number of punctures with the PuncturePatternSource and
        %   PuncturePattern properties. Each symbols that forms the input message
        %   and output codewords is an integer between 0 and 2^M-1. These integers
        %   correspond to an element of the finite Galois field GF(2^M). M is the
        %   degree of the primitive polynomial that you specify with the
        %   PrimitivePolynomialSource and PrimitivePolynomial properties.
        %    
        %   When you set this property to true, X must be a column vector of bits
        %   with an integer multiple of MessageLength*M bits. The data type of
        %   input X can be numeric, logical, or unsigned fixed point of word
        %   length 1 (fi object). Each group of MessageLength*M input bits
        %   represents one message word the object will encode. The encoded data
        %   output vector, Y, is a column vector of bits with length equal to an
        %   integer multiple of (CodewordLength - number of punctures)* M. You
        %   specify the number of punctures with the PuncturePatternSource and
        %   PuncturePattern properties. A group of M bits represents an integer
        %   between 0 and 2^M-1 that belongs to the finite Galois field GF(2^M). M
        %   is the degree of the primitive polynomial that you specify with the
        %   PrimitivePolynomialSource and PrimitivePolynomial properties.
        %
        %   The default is false.  
        BitInput;

        %CheckGeneratorPolynomial Enable generator polynomial checking
        %   Set this property to true to perform a generator polynomial check.
        %   This check verifies that X^CodewordLength + 1 is divisible by the
        %   generator polynomial specified in the GeneratorPolynomial property.
        %   For larger codes, disabling the check speeds up processing. You should
        %   perform the check at least once before setting this property to false.
        %   This property applies when you set the GeneratorPolynomialSource
        %   property to 'Property'. The default is true.
        CheckGeneratorPolynomial;

        %CodewordLength Codeword length
        %   Specify the codeword length of the RS code as a double precision,
        %   positive, integer scalar. If you set the PrimitivePolynomialSource
        %   property to 'Auto', CodewordLength must be in the range 3 <
        %   CodewordLength <= 2^16-1. If you set the PrimitivePolynomialSource
        %   property to 'Property', CodewordLength must be in the range 3 <=
        %   CodewordLength <= 2^M-1. M is the degree of the primitive polynomial
        %   that you specify with the PrimitivePolynomialSource and
        %   PrimitivePolynomial properties. M must be in the range 3<= M <= 16.
        %   The difference (CodewordLength - MessageLength) must be an even
        %   integer.
        %
        %   For a full-length RS code the value of the CodewordLength property
        %   must be of the form 2^M-1. If CodewordLength is less than 2^M-1, the
        %   object assumes a shortened RS code.
        %
        %   The default is 7.
        CodewordLength;

        %GeneratorPolynomial Generator polynomial
        %   Specify the generator polynomial as a double precision, integer row 
        %   vector or as a Galois row vector whose entries are in the range from 
        %   0 to 2^M-1 and represent a generator polynomial in descending order 
        %   of powers. The length of the generator polynomial must be 
        %   CodewordLength-MessageLength+1. This property applies 
        %   when you set the GeneratorPolynomialSource property to 'Property'. 
        %   The default is the result of rsgenpoly(7,3,[],[],'double'), which 
        %   corresponds to [1 3 1 2 3]. 
        %   
        %   When you use this object to generate code, you must set the generator
        %   polynomial to a double precision, integer row vector.
        GeneratorPolynomial;

        %GeneratorPolynomialSource Source of generator polynomial
        %   Specify the source of the generator polynomial as one of 'Auto' |
        %   'Property'. The default is 'Auto'. 
        %
        %   When you set this property to 'Auto', the object automatically chooses
        %   the generator polynomial. The object computes the generator polynomial
        %   based on the value of the PrimitivePolynomialSource property. When you
        %   set the PrimitivePolynomialSource property to 'Auto' the object
        %   computes the generator polynomial as
        %   rsgenpoly(CodewordLength+SL,MessageLength+SL). When you set the
        %   PrimitivePolynomialSource property to 'Property', the object computes
        %   generator polynomial as rsgenpoly(CodewordLength+SL,MessageLength+SL,
        %   PrimitivePolynomial). In both cases, SL = (2^M-1)-CodewordLength is
        %   the shortening length and M is the degree of the primitive polynomial
        %   that you specify with the PrimitivePolynomialSource and
        %   PrimitivePolynomial properties.
        %
        %   When you set this property to 'Property', you can specify a generator
        %   polynomial using the GeneratorPolynomial property.
        GeneratorPolynomialSource;

        %MessageLength Message length
        %   Specify the message length as a double precision, positive integer
        %   scalar. The difference (CodewordLength - MessageLength) must be an
        %   even integer. The default is 3.
        MessageLength;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Same as input' | 'double' |
        %   'logical'. The default is 'Same as input'. This property applies when
        %   you set the BitInput property to true.
        OutputDataType;

        %PrimitivePolynomial Primitive polynomial
        %   Specify the primitive polynomial that defines the finite field GF(2^M)
        %   corresponding to the integers that form messages and codewords. You
        %   must set this property to a double precision, binary row vector that
        %   represents a primitive polynomial over GF(2) of degree M in descending
        %   order of powers. If CodewordLength is less than 2^M-1, the object uses
        %   a shortened RS code. The default is the result of
        %   fliplr(de2bi(primpoly(3))), which is [1 0 1 1] or the polynomial
        %   x^3+x+1. This property applies when you set the
        %   PrimitivePolynomialSource property to 'Property'.
        PrimitivePolynomial;

        %PrimitivePolynomialSource Source of primitive polynomial
        %   Specify the source of the primitive polynomial as one of 'Auto' |
        %   'Property'. The default is 'Auto'. When you set this property to
        %   'Auto', the object uses a primitive polynomial of degree M =
        %   ceil(log2(CodewordLength+1)), which is the result of
        %   fliplr(de2bi(primpoly(M))). When you set this property to 'Property',
        %   you can specify a polynomial using the PrimitivePolynomial property.
        PrimitivePolynomialSource;

        %PuncturePattern Puncture pattern vector
        %   Specify the pattern used to puncture the encoded data as a double
        %   precision, binary column vector of length
        %   (CodewordLength-MessageLength). Zeros in the puncture pattern vector
        %   indicate the position of the parity symbols that are punctured or
        %   excluded from each codeword. This property applies when you set the
        %   PuncturePatternSource property to 'Property'. The default is
        %   [ones(2,1); zeros(2,1)].
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. If you set this property to 'None'
        %   then the object does not apply puncturing to the code. If you set this
        %   property to 'Property' then the object punctures the code based on a
        %   puncture pattern vector specified in the PuncturePattern property.
        PuncturePatternSource;

    end
end
