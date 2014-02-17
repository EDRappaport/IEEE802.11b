classdef BlockInterleaver< handle
%BlockInterleaver Permute input symbols using a permutation vector
%   H = comm.BlockInterleaver creates a block interleaver System object, H.
%   This object permutes the symbols in the input signal based on a
%   permutation vector.
%
%   H = comm.BlockInterleaver(Name,Value) creates a block interleaver
%   object, H, with the specified property Name set to the specified Value.
%
%   H = comm.BlockInterleaver(PERMVEC) creates a block interleaver object,
%   H, with the PermutationVector property set to PERMVEC.
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The step method forms the output Y, based on the mapping
%   defined by the PermutationVector property as
%   Output(k)=Input(PermutationVector(k)), for k = 1:N, where N is the
%   length of the PermutationVector property. The input X must be a column
%   vector of length N. The data type of X can be numeric, logical, or
%   fixed-point (fi objects). Y has the same data type as X.
%
%   BlockInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create block interleaver object with same property values
%   isLocked - Locked status (logical)
%
%   BlockInterleaver properties:
%
%   PermutationVector - Permutation vector
%
%   % Example 1:
%   %   Interleave and deinterleave data
%
%   hInt = comm.BlockInterleaver([3 4 1 2]');
%   hDeInt = comm.BlockDeinterleaver([3 4 1 2]');
%   data = randi(7, 4, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   % Example 2:
%   %   Interleave and deinterleave data with random interleaver
%
%   permVec = randperm(7)';  % Random permutation vector
%   hInt = comm.BlockInterleaver(permVec);
%   hDeInt = comm.BlockDeinterleaver(permVec);
%   data = randi(9, 7, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   See also comm.BlockDeinterleaver, comm.MatrixInterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=BlockInterleaver
            %BlockInterleaver Permute input symbols using a permutation vector
            %   H = comm.BlockInterleaver creates a block interleaver System object, H.
            %   This object permutes the symbols in the input signal based on a
            %   permutation vector.
            %
            %   H = comm.BlockInterleaver(Name,Value) creates a block interleaver
            %   object, H, with the specified property Name set to the specified Value.
            %
            %   H = comm.BlockInterleaver(PERMVEC) creates a block interleaver object,
            %   H, with the PermutationVector property set to PERMVEC.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The step method forms the output Y, based on the mapping
            %   defined by the PermutationVector property as
            %   Output(k)=Input(PermutationVector(k)), for k = 1:N, where N is the
            %   length of the PermutationVector property. The input X must be a column
            %   vector of length N. The data type of X can be numeric, logical, or
            %   fixed-point (fi objects). Y has the same data type as X.
            %
            %   BlockInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create block interleaver object with same property values
            %   isLocked - Locked status (logical)
            %
            %   BlockInterleaver properties:
            %
            %   PermutationVector - Permutation vector
            %
            %   % Example 1:
            %   %   Interleave and deinterleave data
            %
            %   hInt = comm.BlockInterleaver([3 4 1 2]');
            %   hDeInt = comm.BlockDeinterleaver([3 4 1 2]');
            %   data = randi(7, 4, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence, and restored
            %   % sequence
            %   [data, intData, deIntData]
            %
            %   % Example 2:
            %   %   Interleave and deinterleave data with random interleaver
            %
            %   permVec = randperm(7)';  % Random permutation vector
            %   hInt = comm.BlockInterleaver(permVec);
            %   hDeInt = comm.BlockDeinterleaver(permVec);
            %   data = randi(9, 7, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence, and restored
            %   % sequence
            %   [data, intData, deIntData]
            %
            %   See also comm.BlockDeinterleaver, comm.MatrixInterleaver. 
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %PermutationVector Permutation vector
        %   Specify the mapping used to permute the input symbols as a column
        %   vector of integers. The default is [5;4;3;2;1]. The mapping is a
        %   vector where the number of elements is equal to the length, N, of the
        %   input to the step method. Each element must be an integer between 1
        %   and N, with no repeated values.
        PermutationVector;

    end
end
