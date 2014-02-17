classdef HadamardCode< handle
%HadamardCode Generate Hadamard code
%   H = comm.HadamardCode creates a Hadamard code generator System object,
%   H, that generates Hadamard codes from a set of orthogonal codes.
%
%   H = comm.HadamardCode(Name,Value) creates a Hadamard code generator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Hadamard code in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The Hadamard
%   code corresponds to one of the rows of an NxN Hadamard matrix, where N
%   is a nonnegative power of 2, which you specify in the Length property.
%   Use the Index property to choose the row of the Hadamard matrix. The
%   step method outputs the code in a bi-polar format with 0 and 1 mapped to
%   1 and -1, respectively.
%
%   HadamardCode methods:
%
%   step     - Generate Hadamard code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Hadamard code generator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Hadamard code generator object
%
%   HadamardCode properties:
%
%   Length          - Length of generated code
%   Index           - Row index of Hadamard matrix
%   SamplesPerFrame - Number of output samples per frame
%   OutputDataType  - Data type of output
%
%   % Example: 
%   %   Generate 10 samples of a Hadamard code sequence of length 64
%
%   hHCode = comm.HadamardCode('SamplesPerFrame', 10);
%   seq = step(hHCode)
%
%   See also comm.WalshCode, comm.OVSFCode.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=HadamardCode
            %HadamardCode Generate Hadamard code
            %   H = comm.HadamardCode creates a Hadamard code generator System object,
            %   H, that generates Hadamard codes from a set of orthogonal codes.
            %
            %   H = comm.HadamardCode(Name,Value) creates a Hadamard code generator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the Hadamard code in column vector Y.
            %   Specify the frame length with the SamplesPerFrame property. The Hadamard
            %   code corresponds to one of the rows of an NxN Hadamard matrix, where N
            %   is a nonnegative power of 2, which you specify in the Length property.
            %   Use the Index property to choose the row of the Hadamard matrix. The
            %   step method outputs the code in a bi-polar format with 0 and 1 mapped to
            %   1 and -1, respectively.
            %
            %   HadamardCode methods:
            %
            %   step     - Generate Hadamard code samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Hadamard code generator object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Hadamard code generator object
            %
            %   HadamardCode properties:
            %
            %   Length          - Length of generated code
            %   Index           - Row index of Hadamard matrix
            %   SamplesPerFrame - Number of output samples per frame
            %   OutputDataType  - Data type of output
            %
            %   % Example: 
            %   %   Generate 10 samples of a Hadamard code sequence of length 64
            %
            %   hHCode = comm.HadamardCode('SamplesPerFrame', 10);
            %   seq = step(hHCode)
            %
            %   See also comm.WalshCode, comm.OVSFCode.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Obtain code from specified row index of a Hadamard matrix. The
            % combination of extrinsic and coder.internal.const tells MATLAB Coder
            % to execute hadamard() in MATLAB, not in CGIR. The reason for going to
            % MATLAB is that hadamard() is quite numerically expensive, and CGIR
            % constant folder may fail with timeout if obj.Length is big enough.
        end

        function stepImpl(in) %#ok<MANU>
            % retrieve the data stored in the private property pData and output the
            % data in circular buffer fashion.
            % Eg: This is the way rangeIndex is modified at each line of the
            % circular buffer code below for a case when Length = 5, SamplesPerFrame
            % = 8, and if we assume that at the current state pDataIndex = 3.  
            %   rangeIndex = [1 1 1 1 1 1 1 1];
            %   rangeIndex = [1 1 -4 1 1 1 1 -4];
            %   rangeIndex = [4 1 -4 1 1 1 1 -4];
            %   rangeIndex = [4 5 1 2 3 4 5 1];
            %   pDataIndex = 1;    
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Index Row index of Hadamard matrix
        %   Specify the row index of the Hadamard matrix as a numeric, integer
        %   scalar in the range [0, 1, ... , N-1]. N is the value of the Length
        %   property. The default is 60.
        %
        %   An NxN Hadamard matrix, denoted as P(N), is defined recursively as
        %   follows:
        %
        %     P(1) = [1]
        %     P(2N) = [P(N) P(N); P(N) -P(N)]
        % 
        %     The NxN Hadamard matrix has the property that
        %     P(N)*P(N)' = N*eye(N)
        %
        %   The step method outputs code samples from the row of the Hadamard
        %   matrix that you specify in the Index property. If you set the Index
        %   property to an integer k, then the output code has exactly k zero
        %   crossings, for k = 0, 1, ... , N-1.
        Index;

        %Length Length of generated code
        %   Specify the length of the generated code as a numeric, integer scalar
        %   that is a power of two. The default is 64.
        Length;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'int8'. The default
        %   is 'double'.
        OutputDataType;

        %SamplesPerFrame Number of output samples per frame
        %   Specify the number of Hadamard code samples that the step method
        %   outputs as a numeric, positive, integer scalar. The default is 1. If
        %   you set this property to a value of M, then the step method outputs M
        %   samples of a Hadamard code of length N. N is the length of the code
        %   that you specify in the Length property.
        SamplesPerFrame;

    end
end
