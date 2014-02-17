classdef HelicalDeinterleaver< handle
%HelicalDeinterleaver Restore ordering of symbols using a helical array
%   H = comm.HelicalDeinterleaver creates a helical deinterleaver System
%   object, H. The object restores the original ordering of a sequence that
%   was interleaved using the helical interleaver System object.
%
%   H = comm.HelicalDeinterleaver(Name,Value) creates a Helical
%   deinterleaver object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X,
%   that was interleaved using a helical interleaver and returns Y. The
%   input X must be a column vector. The data type must be numeric,
%   logical, or fixed-point (fi objects). Y has the same data type as X. 
%
%   The helical deinterleaver object uses an array for its computations. If
%   you set the NumColumns property of the object to C, then the array has C
%   columns and unlimited rows. If you set the GroupSize property to N, then
%   the object accepts an input of length C*N and inserts it into the next N
%   rows of the array. The object also places the value of the
%   InitialConditions property into certain positions in the top few rows of
%   the array (not only to accommodate the helical pattern but also to
%   preserve the vector indices of symbols that pass through the
%   HelicalInterleaver and HelicalDeinterleaver objects in turn). The output
%   consists of consecutive groups of N symbols. The object selects the kth
%   output group in the array from column k mod C. This selection is of type
%   helical because of the reduction modulo C and because the first symbol
%   in the kth group is in row 1+(k-1)*s, where s is the value for the
%   StepSize property.
%
%   HelicalDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create helical deinterleaver object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the helical deinterleaver object
%
%   HelicalDeinterleaver properties:
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
%   See also comm.HelicalInterleaver, comm.MultiplexedDeinterleaver.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=HelicalDeinterleaver
            %HelicalDeinterleaver Restore ordering of symbols using a helical array
            %   H = comm.HelicalDeinterleaver creates a helical deinterleaver System
            %   object, H. The object restores the original ordering of a sequence that
            %   was interleaved using the helical interleaver System object.
            %
            %   H = comm.HelicalDeinterleaver(Name,Value) creates a Helical
            %   deinterleaver object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X,
            %   that was interleaved using a helical interleaver and returns Y. The
            %   input X must be a column vector. The data type must be numeric,
            %   logical, or fixed-point (fi objects). Y has the same data type as X. 
            %
            %   The helical deinterleaver object uses an array for its computations. If
            %   you set the NumColumns property of the object to C, then the array has C
            %   columns and unlimited rows. If you set the GroupSize property to N, then
            %   the object accepts an input of length C*N and inserts it into the next N
            %   rows of the array. The object also places the value of the
            %   InitialConditions property into certain positions in the top few rows of
            %   the array (not only to accommodate the helical pattern but also to
            %   preserve the vector indices of symbols that pass through the
            %   HelicalInterleaver and HelicalDeinterleaver objects in turn). The output
            %   consists of consecutive groups of N symbols. The object selects the kth
            %   output group in the array from column k mod C. This selection is of type
            %   helical because of the reduction modulo C and because the first symbol
            %   in the kth group is in row 1+(k-1)*s, where s is the value for the
            %   StepSize property.
            %
            %   HelicalDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create helical deinterleaver object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the helical deinterleaver object
            %
            %   HelicalDeinterleaver properties:
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
            %   See also comm.HelicalInterleaver, comm.MultiplexedDeinterleaver.
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
            % setup the Matrix deinterleaver and General Multiplexed
            % deinterleaver sub-system.
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
