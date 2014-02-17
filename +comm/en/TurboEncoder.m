classdef TurboEncoder< handle
%TurboEncoder Encode binary data using a turbo encoder.
%   H = comm.TurboEncoder creates a System object, H, that encodes binary
%   data using a turbo encoder.
%
%   H = comm.TurboEncoder(Name, Value) creates a turbo encoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1, Value1, ... , NameN, ValueN).
%
%   H = comm.TurboEncoder(TRELLIS, INTERLVRINDICES) creates a
%   turbo encoder object, H, with the TrellisStructure property set to
%   TRELLIS, and the InterleaverIndices property set to INTERLVRINDICES.
%
%   Step method syntax:
%
%   Y = step(H, X) encodes the binary data, X, using the parallel
%   concatenated convolutional encoding scheme that you specify by the
%   TrellisStructure and InterleaverIndices properties. It returns the
%   encoded data, Y. Both X and Y are column vectors of data type numeric,
%   logical, or unsigned fixed point with word length 1 (fi object).
%   When the constituent convolutional encoder represents a rate 1/N code,
%   the step method sets the length of the output vector, Y, to L*(2*N-1)+
%   2*numTails, where L is the input vector length and numTails is given by
%   log2(TrellisStructure.numStates)*N. The tail bits, due to the
%   termination, are appended at the end after the input bits are encoded.
%
%   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
%   an input. INTERLVRINDICES is a column vector containing integer values
%   from 1 to L with no repeated values. The length of the data input X and
%   INTERLVRINDICES input must be the same and equal to L.
%
%   TurboEncoder methods:
%
%   step     - Perform turbo encoding (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create turbo encoder object with same property values
%   isLocked - Locked status (logical)
%
%   TurboEncoder properties:
%
%   TrellisStructure         - Trellis structure of constituent 
%                              convolutional code
%   InterleaverIndicesSource - Source of interleaving indices
%   InterleaverIndices       - Interleaving indices
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
%   See also comm.TurboDecoder, comm.ConvolutionalEncoder.

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=TurboEncoder
            %TurboEncoder Encode binary data using a turbo encoder.
            %   H = comm.TurboEncoder creates a System object, H, that encodes binary
            %   data using a turbo encoder.
            %
            %   H = comm.TurboEncoder(Name, Value) creates a turbo encoder object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1, Value1, ... , NameN, ValueN).
            %
            %   H = comm.TurboEncoder(TRELLIS, INTERLVRINDICES) creates a
            %   turbo encoder object, H, with the TrellisStructure property set to
            %   TRELLIS, and the InterleaverIndices property set to INTERLVRINDICES.
            %
            %   Step method syntax:
            %
            %   Y = step(H, X) encodes the binary data, X, using the parallel
            %   concatenated convolutional encoding scheme that you specify by the
            %   TrellisStructure and InterleaverIndices properties. It returns the
            %   encoded data, Y. Both X and Y are column vectors of data type numeric,
            %   logical, or unsigned fixed point with word length 1 (fi object).
            %   When the constituent convolutional encoder represents a rate 1/N code,
            %   the step method sets the length of the output vector, Y, to L*(2*N-1)+
            %   2*numTails, where L is the input vector length and numTails is given by
            %   log2(TrellisStructure.numStates)*N. The tail bits, due to the
            %   termination, are appended at the end after the input bits are encoded.
            %
            %   Y = step(H, X, INTERLVRINDICES) uses the INTERLVRINDICES specified as
            %   an input. INTERLVRINDICES is a column vector containing integer values
            %   from 1 to L with no repeated values. The length of the data input X and
            %   INTERLVRINDICES input must be the same and equal to L.
            %
            %   TurboEncoder methods:
            %
            %   step     - Perform turbo encoding (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create turbo encoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   TurboEncoder properties:
            %
            %   TrellisStructure         - Trellis structure of constituent 
            %                              convolutional code
            %   InterleaverIndicesSource - Source of interleaving indices
            %   InterleaverIndices       - Interleaving indices
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
            %   See also comm.TurboDecoder, comm.ConvolutionalEncoder.
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

    end
    methods (Abstract)
    end
    properties
        %InterleaverIndices Interleaver indices
        %   Specify the mapping used to permute the input bits as a column vector
        %   of integers. The default is (64:-1:1).'. This mapping is a vector
        %   with the number of elements equal to length, L, of the input to the
        %   step method. Each element must be an integer between 1 and L, with no
        %   repeated values.
        InterleaverIndices;

        %InterleaverIndicesSource Source of interleaver indices
        %   Specify the source of the interleaver indices as one of 'Property' |
        %   'Input port'. The default is 'Property'. When you set this property
        %   to 'Input port' the object uses the interleaver indices specified as
        %   an input to the step method. When you set this property to
        %   'Property', the object uses the interleaver indices that you specify
        %   in the InterleaverIndices property.
        InterleaverIndicesSource;

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
