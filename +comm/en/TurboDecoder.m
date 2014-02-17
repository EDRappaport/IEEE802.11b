classdef TurboDecoder< handle
%TurboDecoder Decode input using a turbo decoder.
%   H = comm.TurboDecoder creates a turbo decoder System object, H. This
%   object uses the a-posteriori probability (APP) constituent decoder to
%   iteratively decode the parallel-concatenated convolutionally encoded
%   input data.
%
%   H = comm.TurboDecoder(Name, Value) creates a turbo decoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1, Value1, ... , NameN, ValueN).
%
%   H = comm.TurboDecoder(TRELLIS, INTERLVRINDICES, NUMITER) creates a
%   turbo decoder object, H, with the TrellisStructure property set to
%   TRELLIS, the InterleaverIndices property set to INTERLVRINDICES and 
%   the NumIterations property set to NUMITER.
%
%   Step method syntax:
%
%   Y = step(H, X) decodes the input data, X, using the parallel
%   concatenated convolutional coding scheme that you specify using the
%   TrellisStructure and InterleaverIndices properties. It returns the
%   binary decoded data, Y. Both X and Y are column vectors of double or
%   single precision data type. When the constituent convolutional code
%   represents a rate 1/N code, the step method sets the length of the
%   output vector, Y, to (M-2*numTails)/(2*N-1), where M is the input
%   vector length and numTails is given by
%   log2(TrellisStructure.numStates)*N. The output length, L, is the same
%   as the length of the interleaver indices.
%
%   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
%   an input. INTERLVRINDICES is a column vector containing integer values
%   from 1 to L with no repeated values. The lengths of the INTERLVRINDICES
%   input and the Y output are the same.
%
%   TurboDecoder methods:
%
%   step     - Perform turbo decoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create turbo decoder object with same property values
%   isLocked - Locked status (logical)
%
%   TurboDecoder properties:
%
%   TrellisStructure         - Trellis structure of constituent 
%                              convolutional code
%   InterleaverIndicesSource - Source of interleaving indices
%   InterleaverIndices       - Interleaving indices
%   Algorithm                - Decoding algorithm
%   NumScalingBits           - Number of scaling bits
%   NumIterations            - Number of decoding iterations
%
%   % Example:
%   %   Transmit turbo-encoded blocks of data over a BPSK-modulated AWGN
%   %   channel, decode using an iterative turbo decoder and display errors
% 
%   noiseVar = 4; frmLen = 256;
%   s = RandStream('mt19937ar', 'Seed', 11);
%   intrlvrIndices = randperm(s, frmLen);
% 
%   hTEnc  = comm.TurboEncoder('TrellisStructure', poly2trellis(4, ...
%            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices);
%   hMod   = comm.BPSKModulator;
%   hChan  = comm.AWGNChannel('NoiseMethod', 'Variance', 'Variance', noiseVar);
%   hTDec  = comm.TurboDecoder('TrellisStructure', poly2trellis(4, ...
%            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices, ...
%            'NumIterations', 4);
%   hError = comm.ErrorRate;
% 
%   for frmIdx = 1:8
%       data = randi(s, [0 1], frmLen, 1);
%       encodedData = step(hTEnc, data);
%       modSignal = step(hMod, encodedData);
%       receivedSignal = step(hChan, modSignal);
% 
%       % Convert received signal to log-likelihood ratios for decoding
%       receivedBits  = step(hTDec, (-2/(noiseVar/2))*real(receivedSignal));
%     
%       errorStats = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\nTotal bits = %d\n', ...
%   errorStats(1), errorStats(2), errorStats(3))     
%
%   See also comm.TurboEncoder, comm.APPDecoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=TurboDecoder
            %TurboDecoder Decode input using a turbo decoder.
            %   H = comm.TurboDecoder creates a turbo decoder System object, H. This
            %   object uses the a-posteriori probability (APP) constituent decoder to
            %   iteratively decode the parallel-concatenated convolutionally encoded
            %   input data.
            %
            %   H = comm.TurboDecoder(Name, Value) creates a turbo decoder object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1, Value1, ... , NameN, ValueN).
            %
            %   H = comm.TurboDecoder(TRELLIS, INTERLVRINDICES, NUMITER) creates a
            %   turbo decoder object, H, with the TrellisStructure property set to
            %   TRELLIS, the InterleaverIndices property set to INTERLVRINDICES and 
            %   the NumIterations property set to NUMITER.
            %
            %   Step method syntax:
            %
            %   Y = step(H, X) decodes the input data, X, using the parallel
            %   concatenated convolutional coding scheme that you specify using the
            %   TrellisStructure and InterleaverIndices properties. It returns the
            %   binary decoded data, Y. Both X and Y are column vectors of double or
            %   single precision data type. When the constituent convolutional code
            %   represents a rate 1/N code, the step method sets the length of the
            %   output vector, Y, to (M-2*numTails)/(2*N-1), where M is the input
            %   vector length and numTails is given by
            %   log2(TrellisStructure.numStates)*N. The output length, L, is the same
            %   as the length of the interleaver indices.
            %
            %   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
            %   an input. INTERLVRINDICES is a column vector containing integer values
            %   from 1 to L with no repeated values. The lengths of the INTERLVRINDICES
            %   input and the Y output are the same.
            %
            %   TurboDecoder methods:
            %
            %   step     - Perform turbo decoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create turbo decoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   TurboDecoder properties:
            %
            %   TrellisStructure         - Trellis structure of constituent 
            %                              convolutional code
            %   InterleaverIndicesSource - Source of interleaving indices
            %   InterleaverIndices       - Interleaving indices
            %   Algorithm                - Decoding algorithm
            %   NumScalingBits           - Number of scaling bits
            %   NumIterations            - Number of decoding iterations
            %
            %   % Example:
            %   %   Transmit turbo-encoded blocks of data over a BPSK-modulated AWGN
            %   %   channel, decode using an iterative turbo decoder and display errors
            % 
            %   noiseVar = 4; frmLen = 256;
            %   s = RandStream('mt19937ar', 'Seed', 11);
            %   intrlvrIndices = randperm(s, frmLen);
            % 
            %   hTEnc  = comm.TurboEncoder('TrellisStructure', poly2trellis(4, ...
            %            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices);
            %   hMod   = comm.BPSKModulator;
            %   hChan  = comm.AWGNChannel('NoiseMethod', 'Variance', 'Variance', noiseVar);
            %   hTDec  = comm.TurboDecoder('TrellisStructure', poly2trellis(4, ...
            %            [13 15 17], 13), 'InterleaverIndices', intrlvrIndices, ...
            %            'NumIterations', 4);
            %   hError = comm.ErrorRate;
            % 
            %   for frmIdx = 1:8
            %       data = randi(s, [0 1], frmLen, 1);
            %       encodedData = step(hTEnc, data);
            %       modSignal = step(hMod, encodedData);
            %       receivedSignal = step(hChan, modSignal);
            % 
            %       % Convert received signal to log-likelihood ratios for decoding
            %       receivedBits  = step(hTDec, (-2/(noiseVar/2))*real(receivedSignal));
            %     
            %       errorStats = step(hError, data, receivedBits);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\nTotal bits = %d\n', ...
            %   errorStats(1), errorStats(2), errorStats(3))     
            %
            %   See also comm.TurboEncoder, comm.APPDecoder.
        end

        function getHeaderImpl(in) %#ok<MANU>
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getInputNamesImpl(in) %#ok<MANU>
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getOutputDataTypeImpl(in) %#ok<MANU>
        end

        function getOutputSizeImpl(in) %#ok<MANU>
        end

        function getPropertyGroupsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isOutputFixedSizeImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function releaseImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Algorithm Decoding algorithm
        %   Specify the decoding algorithm that the object uses for decoding as
        %   one of 'True APP' | 'Max*' | 'Max'. The default is 'TrueAPP'. When
        %   you set this property to 'True APP', the object implements true a
        %   posteriori probability decoding. When you set this property to any
        %   other value, the object uses approximations to increase the speed of
        %   the computations.
        Algorithm;

        %InterleaverIndices Interleaver indices
        %   Specify the mapping used to permute the input bits at the encoder as
        %   a column vector of integers. The default is (64:-1:1).'. This mapping
        %   is a vector with the number of elements equal to length, L,
        %   of the output of the step method. Each element must be an integer
        %   between 1 and L, with no repeated values.
        InterleaverIndices;

        %InterleaverIndicesSource Source of interleaver indices
        %   Specify the source of the interleaver indices as one of 'Property' |
        %   'Input port'. The default is 'Property'. When you set this property
        %   to 'Input port' the object uses the interleaver indices specified as
        %   an input to the step method. When you set this property to
        %   'Property', the object uses the interleaver indices that you specify
        %   in the InterleaverIndices property.
        InterleaverIndicesSource;

        %NumIterations Number of decoding iterations
        %   Specify the number of decoding iterations used for each call to the
        %   step method. The default is 6. The object will iterate and provide
        %   updates to the log-likelihood ratios (LLR) of the uncoded output
        %   bits. The output of the step method is the hard-decision output of
        %   the final LLR update.
        NumIterations;

        %NumScalingBits Number of scaling bits
        %   Specify the number of bits the constituent decoders use to scale the
        %   input data to avoid losing precision during computations. The
        %   constituent decoders multiply the input by 2^NumScalingBits and
        %   divide the pre-output by the same factor. NumScalingBits must be a
        %   scalar integer between 0 and 8. This property applies when you set
        %   the Algorithm property to 'Max*'. The default is 3.
        NumScalingBits;

        %TrellisStructure Trellis structure of constituent convolutional code
        %   Specify the trellis as a MATLAB structure that contains the trellis
        %   description of the constituent convolutional code. Use the istrellis
        %   function to check if a structure is a valid trellis structure. The
        %   default is the result of poly2trellis(4, [13 15], 13).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
