classdef MatrixDeinterleaver< handle
%MatrixDeinterleaver Deinterleave input symbols using permutation matrix
%   H = comm.MatrixDeinterleaver creates a matrix deinterleaver System
%   object, H. This object restores the original ordering of a sequence that
%   was interleaved using the matrix interleaver object.
%
%   H = comm.MatrixDeinterleaver(Name,Value) creates a matrix deinterleaver
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.MatrixDeinterleaver(N,M,Name,Value) creates a matrix
%   deinterleaver object, H, with the NumRows property set to N, the
%   NumColumns property set to M, and other specified property Names set to
%   the specified Values. To specify a value-only argument, you must also
%   specify all preceding value-only arguments. You can specify name-value
%   pair arguments in any order.
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X, that
%   was interleaved using a block interleaver. The object fills a
%   permutation matrix with the input symbols column by column and outputs
%   the matrix contents row by row in the output, Y. The input X must be a
%   column vector of length equal to NumRows*NumColumns. The data type for X
%   can be numeric, logical, or fixed-point (fi objects). Y has the same
%   data type as X.
%
%   MatrixDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create matrix deinterleaver object with same property values
%   isLocked - Locked status (logical)
%
%   MatrixDeinterleaver properties:
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
%   [data, intData, deIntData]
%
%   See also comm.MatrixInterleaver, comm.BlockDeinterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MatrixDeinterleaver
            %MatrixDeinterleaver Deinterleave input symbols using permutation matrix
            %   H = comm.MatrixDeinterleaver creates a matrix deinterleaver System
            %   object, H. This object restores the original ordering of a sequence that
            %   was interleaved using the matrix interleaver object.
            %
            %   H = comm.MatrixDeinterleaver(Name,Value) creates a matrix deinterleaver
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.MatrixDeinterleaver(N,M,Name,Value) creates a matrix
            %   deinterleaver object, H, with the NumRows property set to N, the
            %   NumColumns property set to M, and other specified property Names set to
            %   the specified Values. To specify a value-only argument, you must also
            %   specify all preceding value-only arguments. You can specify name-value
            %   pair arguments in any order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X, that
            %   was interleaved using a block interleaver. The object fills a
            %   permutation matrix with the input symbols column by column and outputs
            %   the matrix contents row by row in the output, Y. The input X must be a
            %   column vector of length equal to NumRows*NumColumns. The data type for X
            %   can be numeric, logical, or fixed-point (fi objects). Y has the same
            %   data type as X.
            %
            %   MatrixDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create matrix deinterleaver object with same property values
            %   isLocked - Locked status (logical)
            %
            %   MatrixDeinterleaver properties:
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
            %   [data, intData, deIntData]
            %
            %   See also comm.MatrixInterleaver, comm.BlockDeinterleaver. 
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
