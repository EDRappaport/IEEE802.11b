classdef WalshCode< handle
%WalshCode Generate Walsh code from orthogonal set of codes
%   H = comm.WalshCode creates a Walsh code generator System object, H, that
%   generates a Walsh code from a set of orthogonal codes.
%
%   H = comm.WalshCode(Name,Value) creates a Walsh code generator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Walsh code in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The Walsh
%   code corresponds to a row of an NxN Hadamard matrix, where N is a
%   nonnegative power of 2 that you specify in the Length property. Use the
%   Index property to choose the row of the Hadamard matrix. The output code
%   is in a bi-polar format with 0 and 1 mapped to 1 and -1 respectively.
%
%   WalshCode methods:
%
%   step     - Generate Walsh code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Walsh code generator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Walsh code generator object
%
%   WalshCode properties:
%
%   Length          - Length of generated code
%   Index           - Index of code of interest
%   SamplesPerFrame - Number of output samples per frame
%   OutputDataType  - Data type of output
%
%   % Example:
%   %   Generate 10 samples of a length-64 Walsh code sequence
%
%   hwc = comm.WalshCode('SamplesPerFrame', 10);
%   seq = step(hwc)
%
%   See also comm.HadamardCode, comm.OVSFCode.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=WalshCode
            %WalshCode Generate Walsh code from orthogonal set of codes
            %   H = comm.WalshCode creates a Walsh code generator System object, H, that
            %   generates a Walsh code from a set of orthogonal codes.
            %
            %   H = comm.WalshCode(Name,Value) creates a Walsh code generator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the Walsh code in column vector Y.
            %   Specify the frame length with the SamplesPerFrame property. The Walsh
            %   code corresponds to a row of an NxN Hadamard matrix, where N is a
            %   nonnegative power of 2 that you specify in the Length property. Use the
            %   Index property to choose the row of the Hadamard matrix. The output code
            %   is in a bi-polar format with 0 and 1 mapped to 1 and -1 respectively.
            %
            %   WalshCode methods:
            %
            %   step     - Generate Walsh code samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Walsh code generator object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Walsh code generator object
            %
            %   WalshCode properties:
            %
            %   Length          - Length of generated code
            %   Index           - Index of code of interest
            %   SamplesPerFrame - Number of output samples per frame
            %   OutputDataType  - Data type of output
            %
            %   % Example:
            %   %   Generate 10 samples of a length-64 Walsh code sequence
            %
            %   hwc = comm.WalshCode('SamplesPerFrame', 10);
            %   seq = step(hwc)
            %
            %   See also comm.HadamardCode, comm.OVSFCode.
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
            % Create the Hadamard code matrix. The combination of extrinsic and
            % coder.internal.const tells MATLAB Coder to execute hadamard() in
            % MATLAB, not in CGIR. The reason for going to MATLAB is that hadamard()
            % is quite numerically expensive, and CGIR constant folder may fail with
            % timeout if obj.Length is big enough.
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
        %Index Index of code of interest
        %   Specify the index of the desired code from the available set of codes
        %   as a numeric, integer scalar in the range [0, 1, ... , N-1]. N is the
        %   value of the Length property. The number of zero crossings in the
        %   generated code equals the value of the specified index. The default is
        %   60.
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
        %   Specify the number of Walsh code samples that the step method outputs
        %   as a numeric, positive, integer scalar. The default is 1. If you set
        %   this property to a value of M, then the step method outputs M samples
        %   of a Walsh code of length N. N is the length of the code that you
        %   specify in the Length property.
        SamplesPerFrame;

    end
end
