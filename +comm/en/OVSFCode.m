classdef OVSFCode< handle
%OVSFCode Generate OVSF code
%   H = comm.OVSFCode creates an orthogonal variable spreading factor (OVSF)
%   code generator System object, H, that generates an OVSF code.
%
%   H = comm.OVSFCode(Name,Value) creates an OVSF code generator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the OVSF code in column vector Y. Specify
%   the frame length with the SamplesPerFrame property.
%
%   OVSFCode methods:
%
%   step     - Generate OVSF code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create OVSF code generator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of OVSF code generator object
%
%   OVSFCode properties:
%
%   SpreadingFactor - Length of generated code
%   Index           - Index of code of interest
%   SamplesPerFrame - Number of output samples per frame
%   OutputDataType  - Data type of output
%
%   % Example: 
%   %   Generate 10 samples of an OVSF code with a spreading factor of 64
%
%   hOVSF = comm.OVSFCode('SamplesPerFrame', 10,'SpreadingFactor',64);
%   seq = step(hOVSF)
%
%   See also comm.HadamardCode, comm.OVSFCode.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=OVSFCode
            %OVSFCode Generate OVSF code
            %   H = comm.OVSFCode creates an orthogonal variable spreading factor (OVSF)
            %   code generator System object, H, that generates an OVSF code.
            %
            %   H = comm.OVSFCode(Name,Value) creates an OVSF code generator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the OVSF code in column vector Y. Specify
            %   the frame length with the SamplesPerFrame property.
            %
            %   OVSFCode methods:
            %
            %   step     - Generate OVSF code samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create OVSF code generator object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of OVSF code generator object
            %
            %   OVSFCode properties:
            %
            %   SpreadingFactor - Length of generated code
            %   Index           - Index of code of interest
            %   SamplesPerFrame - Number of output samples per frame
            %   OutputDataType  - Data type of output
            %
            %   % Example: 
            %   %   Generate 10 samples of an OVSF code with a spreading factor of 64
            %
            %   hOVSF = comm.OVSFCode('SamplesPerFrame', 10,'SpreadingFactor',64);
            %   seq = step(hOVSF)
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
            % circular buffer code below for a case when SpreadingFactor = 5,
            % SamplesPerFrame = 8, and if we assume that at the current state
            % pDataIndex = 3.  
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
        %   that have the spreading factor specified in the SpreadingFactor
        %   property. Index must be an integer scalar in the range 0 to
        %   SpreadingFactor-1. The default is 60.
        %
        %   OVSF codes are defined as the rows of an n-by-n matrix, Cn, where n is
        %   the value specified in the SpreadingFactor property. Matrix Cn can be
        %   defined recursively as follows. First, define C1 = [1]. Next, assume
        %   that Cn is defined and let Cn(k) denote the kth row of Cn. Then, C2n =
        %   [Cn(0) Cn(0); Cn(0) -Cn(0); ... ; Cn(n-1) Cn(n-1); Cn(n-1) -Cn(n-1)].
        %   Cn is only defined for values of n that are a power of 2. Set the
        %   Index property to a value of k to choose the kth row of the C matrix
        %   as the code of interest.
        Index;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'int8'. The default is
        %   'double'.
        OutputDataType;

        %SamplesPerFrame Number of output samples per frame
        %   Specify the number of OVSF code samples that the step method outputs
        %   as a numeric, positive, integer scalar. If you set this property to a
        %   value of M, then the step method outputs M samples of an OVSF code of
        %   length N. N is the length of the OVSF code that you specify in the
        %   SpreadingFactor property. The default is 1.
        SamplesPerFrame;

        %SpreadingFactor Length of generated code
        %   Specify the length of the generated code as a power of 2, integer
        %   scalar.  The default is 64.
        SpreadingFactor;

    end
end
