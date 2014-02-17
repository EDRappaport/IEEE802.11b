classdef HDLRSEncoder< handle
%HDLRSEncoder Encode data using a Reed-Solomon encoder
%   H = comm.HDLRSEncoder returns a block encoder System object, H, that
%   performs Reed-Solomon (RS) encoding in a streaming fashion for HDL.
%
%   H = comm.HDLRSEncoder(Name,Value) creates an RS encoder object, H, with the
%   specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.HDLRSEncoder(N,K,Name,Value) creates an RS encoder object, H, with
%   the CodewordLength property set to N, the MessageLength property set to
%   K, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,startOut,endOut,validOut] = step(H,X,startIn,EndIn,validIn) encodes the
%   input data, X, and returns the encoded data, Y. The PuncturePatternSource and
%   PuncturePattern properties affect the amount of valid Y data.
%
%   HDLRSEncoder methods:
%
%   step     - Perform RS encoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create RS encoder object with same property values
%   isLocked - Locked status (logical)
%
%   HDLRSEncoder properties:
%
%   CodewordLength            - Codeword length
%   MessageLength             - Message length
%   PrimitivePolynomialSource - Source of primitive polynomial
%   PrimitivePolynomial       - Primitive polynomial
%   PuncturePatternSource     - Source of puncture pattern
%   PuncturePattern           - Puncture pattern column vector
%   BSource                   - Source of B value
%   B                         - B value for polynomial generation
%
%   % Example:
%   %   RS-encoded a DVD-II standard packet of random data
%
%   hHDLEnc = comm.HDLRSEncoder(204,188,'BSource','Property','B',0);
%   hRSEnc  = comm.RSEncoder(204,188,...
%                            'GeneratorPolynomialSource','Property',...
%                            'GeneratorPolynomial',rsgenpoly(255,239,[],0));
%   dataIn = [randi([0,255],188,1,'uint8') ; zeros(255-188,1)];
%   for ii = 1:255
%     [dataOut(ii), startOut(ii), endOut(ii), validOut(ii)] = step(hHDLEnc, dataIn(ii), ii==1, ii==188, ii<=188);
%   end
%   % Check the result:
%   Y = step(hRSEnc,dataIn(1:188));
%   assert(all(Y == dataOut(validOut)'))
%
%   See also comm.RSEncoder, comm.HDLRSDecoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=HDLRSEncoder
            %HDLRSEncoder Encode data using a Reed-Solomon encoder
            %   H = comm.HDLRSEncoder returns a block encoder System object, H, that
            %   performs Reed-Solomon (RS) encoding in a streaming fashion for HDL.
            %
            %   H = comm.HDLRSEncoder(Name,Value) creates an RS encoder object, H, with the
            %   specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.HDLRSEncoder(N,K,Name,Value) creates an RS encoder object, H, with
            %   the CodewordLength property set to N, the MessageLength property set to
            %   K, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,startOut,endOut,validOut] = step(H,X,startIn,EndIn,validIn) encodes the
            %   input data, X, and returns the encoded data, Y. The PuncturePatternSource and
            %   PuncturePattern properties affect the amount of valid Y data.
            %
            %   HDLRSEncoder methods:
            %
            %   step     - Perform RS encoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create RS encoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   HDLRSEncoder properties:
            %
            %   CodewordLength            - Codeword length
            %   MessageLength             - Message length
            %   PrimitivePolynomialSource - Source of primitive polynomial
            %   PrimitivePolynomial       - Primitive polynomial
            %   PuncturePatternSource     - Source of puncture pattern
            %   PuncturePattern           - Puncture pattern column vector
            %   BSource                   - Source of B value
            %   B                         - B value for polynomial generation
            %
            %   % Example:
            %   %   RS-encoded a DVD-II standard packet of random data
            %
            %   hHDLEnc = comm.HDLRSEncoder(204,188,'BSource','Property','B',0);
            %   hRSEnc  = comm.RSEncoder(204,188,...
            %                            'GeneratorPolynomialSource','Property',...
            %                            'GeneratorPolynomial',rsgenpoly(255,239,[],0));
            %   dataIn = [randi([0,255],188,1,'uint8') ; zeros(255-188,1)];
            %   for ii = 1:255
            %     [dataOut(ii), startOut(ii), endOut(ii), validOut(ii)] = step(hHDLEnc, dataIn(ii), ii==1, ii==188, ii<=188);
            %   end
            %   % Check the result:
            %   Y = step(hRSEnc,dataIn(1:188));
            %   assert(all(Y == dataOut(validOut)'))
            %
            %   See also comm.RSEncoder, comm.HDLRSDecoder.
        end

        function getHeaderImpl(in) %#ok<MANU>
            %getHeaderImpl   Return header for object display
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getInputNamesImpl(in) %#ok<MANU>
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function getOutputNamesImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function resetStates(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Setup GF tables 
            % codeSize = 2.^ceil(log2(obj.CodewordLength));
            % corrSize = obj.CodewordLength - obj.MessageLength;
            % tMultTable  = zeros(corrSize, codeSize,'uint32'); % hardcoded for now
            % tPowerTable = zeros(corrSize, codeSize,'uint32'); % hardcoded for now
            % tCorr       = uint32(0);            % hardcoded for now
            % tWordSize   = uint32(0);            % hardcoded for now    
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %B B value
        %   Specify the starting power for roots of the primitive polynomial. 
        %   The default is 1. The primitive polynomial used is 
        %   (X-alpha^B)*(X-alpha^(B+1))*...*(X-alpha^(B+N-K-1)), where B is an 
        %   integer and alpha is a root of the primitive polynomial.
        B;

        %BSource Source of B, the starting power for roots of the primitive polynomial
        %   Specify the source of the B value as one of 'Auto' | 'Property'. The
        %   default is 'Auto'. 
        BSource;

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

        %MessageLength Message length
        %   Specify the message length as a double precision, positive integer
        %   scalar. The difference (CodewordLength - MessageLength) must be an
        %   even integer. The default is 3.
        MessageLength;

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
