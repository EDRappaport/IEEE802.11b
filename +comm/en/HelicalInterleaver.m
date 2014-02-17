classdef HelicalInterleaver< handle
%HelicalInterleaver Permute input symbols using a helical array
%   H = comm.HelicalInterleaver creates a helical interleaver System object,
%   H. The object permutes the input symbols in the input signal by placing
%   them in an array in a helical fashion.
%
%   H = comm.HelicalInterleaver(Name,Value) creates a helical interleaver
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The input X must be a column vector. The data type must be
%   numeric, logical, or fixed-point (fi objects). Y has the same data type
%   as X.
%
%   The helical interleaver object places the elements of X in an array in a
%   helical fashion. If you set the NumColumns property of the object to C,
%   then the array has C columns and unlimited rows. If you set the
%   GroupSize property to N, then the object accepts an input of length C*N
%   and partitions the input into consecutive groups of N symbols. The
%   object places the kth group in the array along column k mod C. This
%   placement is of type helical because of the reduction modulo C and
%   because the first symbol in the kth group is in the row 1+(k-1)*s, where
%   s is the value for the StepSize property. Positions in the array that do
%   not contain input symbols have default contents specified by the
%   InitialConditions property. The object outputs C*N symbols from the
%   array by reading the next N rows sequentially.
%
%   HelicalInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create helical interleaver object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the helical interleaver object
%
%   HelicalInterleaver properties:
%
%   NumColumns        - Number of columns in helical array
%   GroupSize         - Size of each group of input symbols
%   StepSize          - Helical array step size
%   InitialConditions - Initial conditions of helical array
%
%   % Example:
%   %   Interleave and deinterleave random data
%
%   hInt = comm.HelicalInterleaver('GroupSize', 2, ...
%                   'NumColumns', 3, ...
%                   'InitialConditions', -1);
%   hDeInt = comm.HelicalDeinterleaver('GroupSize', 2, ...
%                   'NumColumns', 3, ...
%                   'InitialConditions', -1);
%   data = randi(7, 6, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   See also comm.HelicalDeinterleaver, comm.MultiplexedInterleaver.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=HelicalInterleaver
            %HelicalInterleaver Permute input symbols using a helical array
            %   H = comm.HelicalInterleaver creates a helical interleaver System object,
            %   H. The object permutes the input symbols in the input signal by placing
            %   them in an array in a helical fashion.
            %
            %   H = comm.HelicalInterleaver(Name,Value) creates a helical interleaver
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The input X must be a column vector. The data type must be
            %   numeric, logical, or fixed-point (fi objects). Y has the same data type
            %   as X.
            %
            %   The helical interleaver object places the elements of X in an array in a
            %   helical fashion. If you set the NumColumns property of the object to C,
            %   then the array has C columns and unlimited rows. If you set the
            %   GroupSize property to N, then the object accepts an input of length C*N
            %   and partitions the input into consecutive groups of N symbols. The
            %   object places the kth group in the array along column k mod C. This
            %   placement is of type helical because of the reduction modulo C and
            %   because the first symbol in the kth group is in the row 1+(k-1)*s, where
            %   s is the value for the StepSize property. Positions in the array that do
            %   not contain input symbols have default contents specified by the
            %   InitialConditions property. The object outputs C*N symbols from the
            %   array by reading the next N rows sequentially.
            %
            %   HelicalInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create helical interleaver object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the helical interleaver object
            %
            %   HelicalInterleaver properties:
            %
            %   NumColumns        - Number of columns in helical array
            %   GroupSize         - Size of each group of input symbols
            %   StepSize          - Helical array step size
            %   InitialConditions - Initial conditions of helical array
            %
            %   % Example:
            %   %   Interleave and deinterleave random data
            %
            %   hInt = comm.HelicalInterleaver('GroupSize', 2, ...
            %                   'NumColumns', 3, ...
            %                   'InitialConditions', -1);
            %   hDeInt = comm.HelicalDeinterleaver('GroupSize', 2, ...
            %                   'NumColumns', 3, ...
            %                   'InitialConditions', -1);
            %   data = randi(7, 6, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence, and restored
            %   % sequence
            %   [data, intData, deIntData]
            %
            %   See also comm.HelicalDeinterleaver, comm.MultiplexedInterleaver.
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
            % setup the Matrix interleaver and General Multiplexed
            % interleaver sub system.
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %GroupSize Size of each group of input symbols
        %   Specify the size of each group of input symbols as a positive integer
        %   scalar. The default is 4.
        GroupSize;

        %InitialConditions Initial conditions of helical array
        %   Specify the value that is initially stored in the helical array as a
        %   numeric scalar. The default is 0.
        InitialConditions;

        %NumColumns Number of columns in helical array
        %   Specify the number of columns in the helical array as a positive
        %   integer scalar. The default is 6.
        NumColumns;

        %StepSize Helical array step size
        %   Specify number of rows of separation between consecutive input groups
        %   in their respective columns of the helical array as a positive integer
        %   scalar. The default is 1.
        StepSize;

    end
end
