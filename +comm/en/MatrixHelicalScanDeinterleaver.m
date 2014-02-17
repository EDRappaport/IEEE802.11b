classdef MatrixHelicalScanDeinterleaver< handle
%MatrixHelicalScanDeinterleaver Deinterleave input symbols by filling a
%matrix along diagonals 
%   H = comm.MatrixHelicalScanDeinterleaver creates a matrix helical scan
%   deinterleaver object, H. The object restores the original ordering of a
%   sequence that was interleaved using the matrix helical scan interleaver
%   System object.
%
%   H = comm.MatrixHelicalScanDeinterleaver(Name,Value) creates a matrix
%   helical scan deinterleaver object, H, with the specified property Name
%   set to the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   The matrix scan deinterleaver object fills symbols along the diagonals
%   of the permutation matrix.  The object wraps the values past the edges
%   of the matrix when necessary. The number of elements in each diagonal
%   matches the value specified by the NumColumns property, after the object
%   wraps past the edges of the matrix when necessary. The object traverses
%   diagonals so that the row index and column index both increase. Each
%   diagonal after the first one begins one row below the first element of
%   the previous diagonal.
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X. The
%   object fills a permutation matrix with the input symbols in a helical
%   fashion and output the contents row by row, and returns Y. The input X
%   must be a NumRows*NumColumns long column vector and the data type can be
%   numeric, logical, or fixed-point (fi objects). Y has the same data type
%   as X.
%
%   MatrixHelicalScanDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create matrix helical scan deinterleaver object with same 
%              property values
%   isLocked - Locked status (logical)
%
%   MatrixHelicalScanDeinterleaver properties:
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
%   [data, intData, deIntData];
%
%   See also comm.MatrixHelicalScanInterleaver, comm.BlockDeinterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MatrixHelicalScanDeinterleaver
            %MatrixHelicalScanDeinterleaver Deinterleave input symbols by filling a
            %matrix along diagonals 
            %   H = comm.MatrixHelicalScanDeinterleaver creates a matrix helical scan
            %   deinterleaver object, H. The object restores the original ordering of a
            %   sequence that was interleaved using the matrix helical scan interleaver
            %   System object.
            %
            %   H = comm.MatrixHelicalScanDeinterleaver(Name,Value) creates a matrix
            %   helical scan deinterleaver object, H, with the specified property Name
            %   set to the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   The matrix scan deinterleaver object fills symbols along the diagonals
            %   of the permutation matrix.  The object wraps the values past the edges
            %   of the matrix when necessary. The number of elements in each diagonal
            %   matches the value specified by the NumColumns property, after the object
            %   wraps past the edges of the matrix when necessary. The object traverses
            %   diagonals so that the row index and column index both increase. Each
            %   diagonal after the first one begins one row below the first element of
            %   the previous diagonal.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X. The
            %   object fills a permutation matrix with the input symbols in a helical
            %   fashion and output the contents row by row, and returns Y. The input X
            %   must be a NumRows*NumColumns long column vector and the data type can be
            %   numeric, logical, or fixed-point (fi objects). Y has the same data type
            %   as X.
            %
            %   MatrixHelicalScanDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create matrix helical scan deinterleaver object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %
            %   MatrixHelicalScanDeinterleaver properties:
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
            %   [data, intData, deIntData];
            %
            %   See also comm.MatrixHelicalScanInterleaver, comm.BlockDeinterleaver. 
        end

    end
    methods (Abstract)
    end
    properties
        %pIsDeinterleaver Private property to distinguish interleaver/deinterleaver
        pIsDeinterleaver;

    end
end
