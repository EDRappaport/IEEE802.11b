classdef TurboDecoder< handle
%TurboDecoder Turbo Decoder (GPU) 
%   H = comm.gpu.TurboDecoder creates a turbo decoder System object, H. This
%   object uses the a-posteriori probability (APP) constituent decoder to
%   iteratively decode the parallel-concatenated convolutionally encoded
%   input data.
%
%   H = comm.gpu.TurboDecoder(Name, Value) creates a turbo decoder object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as (Name1,
%   Value1, ... , NameN, ValueN).
%
%   H = comm.gpu.TurboDecoder(TRELLIS, INTERLVRINDICES, NUMITER) creates a
%   turbo decoder object, H, with the TrellisStructure property set to
%   TRELLIS, the InterleaverIndices property set to INTERLVRINDICES and the
%   NumIterations property set to NUMITER.
%
%   Step method syntax:
%
%   Y = step(H, X) decodes the input data, X, using the parallel
%   concatenated convolutional coding scheme that you specify using the
%   TrellisStructure and InterleaverIndices properties. It returns the
%   binary decoded data, Y. Both X and Y are column vectors of double or
%   single precision data type. When the constituent convolutional code
%   represents a rate 1/N code, the step method sets the length of the
%   output vector, Y, to (M-2*numTails)/(2*N-1), where M is the input vector
%   length and numTails is given by log2(TrellisStructure.numStates)*N. The
%   output length, L, is the same as the length of the interleaver indices.
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
%   NumFrames                - Number of frames present in the input vector
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
%   hTDec  = comm.gpu.TurboDecoder('TrellisStructure', poly2trellis(4, ...
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
%   See also comm.TurboEncoder, comm.TurboDecoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=TurboDecoder
            %TurboDecoder Turbo Decoder (GPU) 
            %   H = comm.gpu.TurboDecoder creates a turbo decoder System object, H. This
            %   object uses the a-posteriori probability (APP) constituent decoder to
            %   iteratively decode the parallel-concatenated convolutionally encoded
            %   input data.
            %
            %   H = comm.gpu.TurboDecoder(Name, Value) creates a turbo decoder object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as (Name1,
            %   Value1, ... , NameN, ValueN).
            %
            %   H = comm.gpu.TurboDecoder(TRELLIS, INTERLVRINDICES, NUMITER) creates a
            %   turbo decoder object, H, with the TrellisStructure property set to
            %   TRELLIS, the InterleaverIndices property set to INTERLVRINDICES and the
            %   NumIterations property set to NUMITER.
            %
            %   Step method syntax:
            %
            %   Y = step(H, X) decodes the input data, X, using the parallel
            %   concatenated convolutional coding scheme that you specify using the
            %   TrellisStructure and InterleaverIndices properties. It returns the
            %   binary decoded data, Y. Both X and Y are column vectors of double or
            %   single precision data type. When the constituent convolutional code
            %   represents a rate 1/N code, the step method sets the length of the
            %   output vector, Y, to (M-2*numTails)/(2*N-1), where M is the input vector
            %   length and numTails is given by log2(TrellisStructure.numStates)*N. The
            %   output length, L, is the same as the length of the interleaver indices.
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
            %   NumFrames                - Number of frames present in the input vector
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
            %   hTDec  = comm.gpu.TurboDecoder('TrellisStructure', poly2trellis(4, ...
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
            %   See also comm.TurboEncoder, comm.TurboDecoder.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Algorithm Decoding algorithm
        %   Specify the decoding algorithm. The only valid setting is 'True APP'.
        %   The object implements true a posteriori probability decoding. 
        Algorithm;

        %InterleaverIndices Interleaver indices
        %   Specify the mapping used to permute the input bits at the encoder as
        %   a column vector of integers. The default is (64:-1:1).'. This mapping
        %   is a vector with the number of elements equal to length, L,
        %   of the output of the step method. Each element must be an integer
        %   between 1 and L, with no repeated values.
        InterleaverIndices;

        %InterleaverIndicesSource Source of interleaver indices
        %   Specify the source of the interleaver indices as source. The only
        %   valid setting for this property is 'Property'.
        InterleaverIndicesSource;

        %NumFrames Number of independent frames present in the input and output data vectors.
        %   Specify the number of independent frames contained in a single data
        %   input/output vector.  The input vector will be segmented into
        %   NumFrames segments and decoded independently.  The output will contain
        %   NumFrames decoded segments. The default value of this property is 1.
        NumFrames;

        %NumIterations Number of decoding iterations
        %   Specify the number of decoding iterations used for each call to the
        %   step method. The default is 6. The object will iterate and provide
        %   updates to the log-likelihood ratios (LLR) of the uncoded output
        %   bits. The output of the step method is the hard-decision output of
        %   the final LLR update.
        NumIterations;

        %NumScalingBits Number of scaling bits
        %   This property is not used in the GPU version of the Turbo Decoder.
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
