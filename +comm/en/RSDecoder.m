classdef RSDecoder< handle
%RSDecoder Decode data using a Reed-Solomon decoder
%   H = comm.RSDecoder returns a block decoder System object, H, that
%   performs Reed-Solomon (RS) decoding.
%
%   H = comm.RSDecoder(Name,Value) creates an RS decoder object, H, with the
%   specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RSDecoder(N,K,Name,Value) creates an RS decoder object, H, with
%   the CodewordLength property set to N, the MessageLength property set to
%   K, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,ERR] = step(H,X) decodes the encoded input data, X, into the output
%   vector Y and returns the number of corrected errors in output vector
%   ERR. The value of the BitInput property determines whether X is a vector
%   of integers or bits with a numeric, logical, or fixed-point data type.
%   The PuncturePatternSource and PuncturePattern properties affect the
%   expected length of X. The MessageLength property affects the length of
%   Y. When you set the BitInput property to true, the data type of output
%   ERR is double precision. When you set the BitInput property to false,
%   the data type of ERR is the same as the data type of input X. This
%   syntax applies when you set the NumCorrectedErrorsOutputPort property to
%   true.
%
%   Y = step(H,X) decodes the encoded data, X, into the output vector Y.
%   This syntax applies when you set the NumCorrectedErrorsOutputPort
%   property to false.
%
%   Y = step(H,X,ERASURES) uses the binary column input vector, ERASURES, to
%   erase the symbols of the input codewords. The elements in ERASURES must
%   be of data type double or logical. Values of 1 in the ERASURES vector
%   correspond to erased symbols, and values of 0 correspond to non-erased
%   symbols. This syntax applies when you set the ErasuresInputPort property
%   to true.
%
%   RSDecoder methods:
%
%   step     - Perform RS decoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create RS decoder object with same property values
%   isLocked - Locked status (logical)
%   info     - Returns characteristic information about the code
%
%   RSDecoder properties:
%
%   BitInput                     - Assume input is bits
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
%   NumCorrectedErrorsOutputPort - Enable number of corrected errors output
%   OutputDataType               - Data type of output
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
%   See also comm.RSEncoder, comm.BCHDecoder.

  
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=RSDecoder
            %RSDecoder Decode data using a Reed-Solomon decoder
            %   H = comm.RSDecoder returns a block decoder System object, H, that
            %   performs Reed-Solomon (RS) decoding.
            %
            %   H = comm.RSDecoder(Name,Value) creates an RS decoder object, H, with the
            %   specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RSDecoder(N,K,Name,Value) creates an RS decoder object, H, with
            %   the CodewordLength property set to N, the MessageLength property set to
            %   K, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,ERR] = step(H,X) decodes the encoded input data, X, into the output
            %   vector Y and returns the number of corrected errors in output vector
            %   ERR. The value of the BitInput property determines whether X is a vector
            %   of integers or bits with a numeric, logical, or fixed-point data type.
            %   The PuncturePatternSource and PuncturePattern properties affect the
            %   expected length of X. The MessageLength property affects the length of
            %   Y. When you set the BitInput property to true, the data type of output
            %   ERR is double precision. When you set the BitInput property to false,
            %   the data type of ERR is the same as the data type of input X. This
            %   syntax applies when you set the NumCorrectedErrorsOutputPort property to
            %   true.
            %
            %   Y = step(H,X) decodes the encoded data, X, into the output vector Y.
            %   This syntax applies when you set the NumCorrectedErrorsOutputPort
            %   property to false.
            %
            %   Y = step(H,X,ERASURES) uses the binary column input vector, ERASURES, to
            %   erase the symbols of the input codewords. The elements in ERASURES must
            %   be of data type double or logical. Values of 1 in the ERASURES vector
            %   correspond to erased symbols, and values of 0 correspond to non-erased
            %   symbols. This syntax applies when you set the ErasuresInputPort property
            %   to true.
            %
            %   RSDecoder methods:
            %
            %   step     - Perform RS decoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create RS decoder object with same property values
            %   isLocked - Locked status (logical)
            %   info     - Returns characteristic information about the code
            %
            %   RSDecoder properties:
            %
            %   BitInput                     - Assume input is bits
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
            %   NumCorrectedErrorsOutputPort - Enable number of corrected errors output
            %   OutputDataType               - Data type of output
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
            %   See also comm.RSEncoder, comm.BCHDecoder.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
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
        %   equal to an integer multiple of (CodewordLength - number of
        %   punctures). You specify the number of punctures with the
        %   PuncturePatternSource and PuncturePattern properties. The
        %   CodewordLength property stores the codeword length value. The decoded
        %   data output vector, Y, is a column vector of integers with length
        %   equal to an integer multiple of the message length you specify in the
        %   MessageLength property. Each symbol that forms the input codewords and
        %   output message is an integer between 0 and 2^M-1. These integers
        %   correspond to an element of the finite Galois field GF(2^M). M is the
        %   degree of the primitive polynomial that you specify with the
        %   PrimitivePolynomialSource and PrimitivePolynomial properties.
        %
        %   When you set this property to true, the input encoded data vector, X,
        %   must be a column vector of bits with length equal to an integer
        %   multiple of (CodewordLength - number of punctures)*M. You specify the
        %   number of punctures with PuncturePatternSource and PuncturePattern
        %   properties. The data type of input X can be numeric, logical, or
        %   unsigned fixed point of word length 1 (fi object). The decoded data
        %   output vector, Y, is a column vector of bits with length equal to an
        %   integer multiple of MessageLength*M. A group of M bits represents an
        %   integer between 0 and 2^M-1 that belongs to the finite Galois field
        %   GF(2^M). M is the degree of the primitive polynomial that you specify
        %   with the PrimitivePolynomialSource and PrimitivePolynomial properties.
        %
        %   When you set BitInput to false and ErasuresInputPort to true, the
        %   erasures input, ERASURES, must be of length equal to the encoded data
        %   input vector X. Values of 1 in the ERASURES vector correspond to
        %   erased symbols in the same position as the input codewords, and values
        %   of 0 correspond to non-erased symbols.
        %
        %   When you set BitInput to true and ErasuresInputPort to true, ERASURES,
        %   must be of length 1/M times the length of the input encoded data
        %   vector X. M corresponds to the degree of the primitive polynomial.
        %   Values of 1 in the ERASURES vector correspond to erased symbols and
        %   values of 0 correspond to non-erased symbols. In this case a symbol
        %   corresponds to M bits.
        %
        %   The default is false.
        BitInput;

        %CheckGeneratorPolynomial Enable generator polynomial checking
        %   Set this property to true to perform a generator polynomial check.
        %   This check verifies that X^CodewordLength + 1 is divisible by the
        %   generator polynomial you specify in the GeneratorPolynomial property.
        %   For larger codes, disabling the check speeds up processing time. You
        %   should perform the check at least once before setting this property to
        %   false. This property applies when you set the
        %   GeneratorPolynomialSource property to 'Property'. The default is true.
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

        %ErasuresInputPort Enable erasures input
        %   Set this property to true to specify a vector of erasures, ERASURES,
        %   as an input to the step method. The erasures input must be a double
        %   precision or logical binary column vector that indicates which symbols
        %   of the input codewords to erase.
        %
        %   When you set BitInput to true, ERASURES must be of length equal to 1/M
        %   times the length of the input encoded data vector X, where M
        %   corresponds to the degree of the primitive polynomial. Values of 1 in
        %   the ERASURES vector correspond to erased symbols in the same position
        %   of the bit-packed input codewords. Values of 0 correspond to
        %   non-erased symbols.
        %
        %   When you set BitInput to false, ERASURES must be of length equal to
        %   the input encoded data vector X. Values of 1 in the ERASURES vector
        %   correspond to erased symbols in the same position of the input
        %   codewords Values of 0 correspond to non-erased symbols.
        %
        %   When the ErasuresInputPort property is set to false the object assumes
        %   no erasures. The default is false.
        ErasuresInputPort;

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
        %   Specify the message length as a double precision, positive, integer
        %   scalar. The difference (CodewordLength - MessageLength) must be an
        %   even integer. The default is 3.
        MessageLength;

        %NumCorrectedErrorsOutputPort Enable number of corrected errors output
        %   Set this property to true to obtain the number of corrected errors as
        %   an output to the step method. A non negative value in the ith element
        %   of the error output vector, ERR, denotes the number of corrected
        %   errors in the ith input codeword. A value of -1 in the ith element of
        %   the ERR output indicates that a decoding error occurred for that
        %   codeword. A decoding error occurs when an input codeword has more
        %   errors than the error correction capability of the RS code. The
        %   default is true.
        NumCorrectedErrorsOutputPort;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Same as input' | 'double' |
        %   'logical'.  The default is 'Same as input'. This property applies when
        %   you set the BitInput property to true.
        OutputDataType;

        %PrimitivePolynomial Primitive polynomial
        %   Specify the primitive polynomial that defines the finite field GF(2^M)
        %   corresponding to the integers that form messages and codewords. You
        %   must set this property to a double precision, binary, row vector that
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
        %   fliplr(de2bi(primpoly(M))). When you set this property to 'Property'
        %   you specify a polynomial using the PrimitivePolynomial property.
        PrimitivePolynomialSource;

        %PuncturePattern Puncture pattern vector
        %   Specify the pattern to use to puncture the encoded data as a double
        %   precision, binary column vector of length
        %   CodewordLength-MessageLength. Zeros in the puncture pattern vector
        %   indicate the position of the parity symbols that are punctured or
        %   excluded from each codeword. This property applies when you set the
        %   PuncturePatternSource property to 'Property'. The default is
        %   [ones(2,1); zeros(2,1)].
        PuncturePattern;

        %PuncturePatternSource Source of puncture pattern
        %   Specify the source of the puncture pattern as one of 'None' |
        %   'Property'. The default is 'None'. If you set this property to 'None'
        %   then the object does not apply puncturing to the code. If you set this
        %   property to 'Property' then the object punctures the code based on the
        %   puncture pattern vector you specify in the PuncturePattern property.
        PuncturePatternSource;

    end
end
