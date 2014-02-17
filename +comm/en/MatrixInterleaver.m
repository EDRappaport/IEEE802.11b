classdef MatrixInterleaver< handle
%MatrixInterleaver Permute input symbols using permutation matrix
%   H = comm.MatrixInterleaver creates a matrix interleaver System object,
%   H. This object permutes the input by filling a permutation matrix with
%   the input symbols row by row and then outputs the matrix contents column
%   by column.
%
%   H = comm.MatrixInterleaver(Name,Value) creates a matrix interleaver
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.MatrixInterleaver(N,M,Name,Value) creates a matrix interleaver
%   object, H, with the NumRows property set to N, the NumColumns property
%   set to M and other specified property Names set to the specified Values.
%   To specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The object fills a permutation matrix with the input
%   symbols row by row and outputs the matrix contents column by column. The
%   input X must be a column vector of length NumRows*NumColumns and the
%   data type can be numeric, logical, or fixed-point (fi objects). Y has
%   the same data type as X.
%
%   MatrixInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create matrix interleaver object with same property values
%   isLocked - Locked status (logical)
%
%   MatrixInterleaver properties:
%
%   NumRows    - Number of rows of permutation matrix
%   NumColumns - Number of columns of permutation matrix
%
%   % Example:
%   %   Interleave and deinterleave data
%
%   hInt = comm.MatrixInterleaver('NumRows', 2, ...
%                   'NumColumns', 5);
%   hDeInt = comm.MatrixDeinterleaver('NumRows', 2, ...
%                   'NumColumns', 5);
%   data = randi(7, 10, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   See also comm.MatrixDeinterleaver, comm.BlockInterleaver.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MatrixInterleaver
            %MatrixInterleaver Permute input symbols using permutation matrix
            %   H = comm.MatrixInterleaver creates a matrix interleaver System object,
            %   H. This object permutes the input by filling a permutation matrix with
            %   the input symbols row by row and then outputs the matrix contents column
            %   by column.
            %
            %   H = comm.MatrixInterleaver(Name,Value) creates a matrix interleaver
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.MatrixInterleaver(N,M,Name,Value) creates a matrix interleaver
            %   object, H, with the NumRows property set to N, the NumColumns property
            %   set to M and other specified property Names set to the specified Values.
            %   To specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The object fills a permutation matrix with the input
            %   symbols row by row and outputs the matrix contents column by column. The
            %   input X must be a column vector of length NumRows*NumColumns and the
            %   data type can be numeric, logical, or fixed-point (fi objects). Y has
            %   the same data type as X.
            %
            %   MatrixInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create matrix interleaver object with same property values
            %   isLocked - Locked status (logical)
            %
            %   MatrixInterleaver properties:
            %
            %   NumRows    - Number of rows of permutation matrix
            %   NumColumns - Number of columns of permutation matrix
            %
            %   % Example:
            %   %   Interleave and deinterleave data
            %
            %   hInt = comm.MatrixInterleaver('NumRows', 2, ...
            %                   'NumColumns', 5);
            %   hDeInt = comm.MatrixDeinterleaver('NumRows', 2, ...
            %                   'NumColumns', 5);
            %   data = randi(7, 10, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence, and restored
            %   % sequence
            %   [data, intData, deIntData]
            %
            %   See also comm.MatrixDeinterleaver, comm.BlockInterleaver.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %NumColumns Number of columns of permutation matrix
        %   Specify the number of permutation matrix columns as a scalar, positive
        %   integer. The default is 4.
        NumColumns;

        %NumRows  Number of rows of permutation matrix
        %   Specify the number of permutation matrix rows as a scalar, positive
        %   integer. The default is 3.
        NumRows;

    end
end
