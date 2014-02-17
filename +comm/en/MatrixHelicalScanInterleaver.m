classdef MatrixHelicalScanInterleaver< handle
%MatrixHelicalScanInterleaver Permute input symbols by selecting matrix
%elements along diagonals 
%   H = comm.MatrixHelicalScanInterleaver creates a matrix helical scan
%   interleaver object, H. The object permutes the input by filling a
%   permutation matrix with the input symbols row by row and then outputs
%   the matrix contents in a helical fashion.
%
%   H = comm.MatrixHelicalScanInterleaver(Name,Value) creates a matrix
%   helical scan interleaver object, H, with the specified property Name set
%   to the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Helical fashion means that the object outputs symbols by selecting
%   elements along diagonals of the permutation matrix. The number of
%   elements in each diagonal matches the value of the NumColumns property,
%   after the object wraps past the edges of the matrix when necessary. The
%   object traverses diagonals so that the row index and column index both
%   increase. Each diagonal after the first one begins one row below the
%   first element of the previous diagonal.
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The input X must be a NumRows*NumColumns long column vector
%   and the data type can be numeric, logical, or fixed-point (fi objects).
%   Y has the same data type as X.
%
%   MatrixHelicalScanInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create matrix helical scan interleaver object with same 
%              property values
%   isLocked - Locked status (logical)
%
%   MatrixHelicalScanInterleaver properties:
%
%   NumRows    - Number of rows of permutation matrix
%   NumColumns - Number of columns of permutation matrix
%   StepSize   - Slope of diagonals
%
%   % Example:
%   %   Interleave and deinterleave random data
%
%   hInt = comm.MatrixHelicalScanInterleaver('NumRows', 4, ...
%                   'NumColumns', 4);
%   hDeInt = comm.MatrixHelicalScanDeinterleaver('NumRows', 4, ...
%                   'NumColumns', 4);
%   data = randi(7, 16, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence and restored
%   % sequence.
%   [data, intData, deIntData]
%
%   See also comm.MatrixHelicalScanDeinterleaver, comm.BlockInterleaver.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MatrixHelicalScanInterleaver
            %MatrixHelicalScanInterleaver Permute input symbols by selecting matrix
            %elements along diagonals 
            %   H = comm.MatrixHelicalScanInterleaver creates a matrix helical scan
            %   interleaver object, H. The object permutes the input by filling a
            %   permutation matrix with the input symbols row by row and then outputs
            %   the matrix contents in a helical fashion.
            %
            %   H = comm.MatrixHelicalScanInterleaver(Name,Value) creates a matrix
            %   helical scan interleaver object, H, with the specified property Name set
            %   to the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Helical fashion means that the object outputs symbols by selecting
            %   elements along diagonals of the permutation matrix. The number of
            %   elements in each diagonal matches the value of the NumColumns property,
            %   after the object wraps past the edges of the matrix when necessary. The
            %   object traverses diagonals so that the row index and column index both
            %   increase. Each diagonal after the first one begins one row below the
            %   first element of the previous diagonal.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The input X must be a NumRows*NumColumns long column vector
            %   and the data type can be numeric, logical, or fixed-point (fi objects).
            %   Y has the same data type as X.
            %
            %   MatrixHelicalScanInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create matrix helical scan interleaver object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %
            %   MatrixHelicalScanInterleaver properties:
            %
            %   NumRows    - Number of rows of permutation matrix
            %   NumColumns - Number of columns of permutation matrix
            %   StepSize   - Slope of diagonals
            %
            %   % Example:
            %   %   Interleave and deinterleave random data
            %
            %   hInt = comm.MatrixHelicalScanInterleaver('NumRows', 4, ...
            %                   'NumColumns', 4);
            %   hDeInt = comm.MatrixHelicalScanDeinterleaver('NumRows', 4, ...
            %                   'NumColumns', 4);
            %   data = randi(7, 16, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence and restored
            %   % sequence.
            %   [data, intData, deIntData]
            %
            %   See also comm.MatrixHelicalScanDeinterleaver, comm.BlockInterleaver.
        end

    end
    methods (Abstract)
    end
    properties
        %pIsDeinterleaver Private property to distinguish interleaver/deinterleaver
        pIsDeinterleaver;

    end
end
