classdef BarkerCode< handle
%BarkerCode Generate Barker code
%   H = comm.BarkerCode creates a Barker code generator System object, H,
%   that generates a Barker code of a specified length.
%
%   H = comm.BarkerCode(Name,Value) creates a Barker code generator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Barker code in column vector Y. You
%   specify the frame length with the SamplesPerFrame property. The output
%   code is in a bi-polar format with 0 and 1 mapped to 1 and -1,
%   respectively.
%
%   BarkerCode methods:
%
%   step     - Generate Barker code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Barker code generator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Barker code generator object
%
%   BarkerCode properties:
%
%   Length          - Length of generated code
%   SamplesPerFrame - Number of output samples per frame
%   OutputDataType  - Data type of output
%
%   % Example:
%   %   Generate 10 samples of a Barker code sequence of length 7
%
%   hBCode = comm.BarkerCode('SamplesPerFrame', 10);
%   seq = step(hBCode)
%
%   See also comm.HadamardCode, comm.OVSFCode.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=BarkerCode
            %BarkerCode Generate Barker code
            %   H = comm.BarkerCode creates a Barker code generator System object, H,
            %   that generates a Barker code of a specified length.
            %
            %   H = comm.BarkerCode(Name,Value) creates a Barker code generator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the Barker code in column vector Y. You
            %   specify the frame length with the SamplesPerFrame property. The output
            %   code is in a bi-polar format with 0 and 1 mapped to 1 and -1,
            %   respectively.
            %
            %   BarkerCode methods:
            %
            %   step     - Generate Barker code samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Barker code generator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Barker code generator object
            %
            %   BarkerCode properties:
            %
            %   Length          - Length of generated code
            %   SamplesPerFrame - Number of output samples per frame
            %   OutputDataType  - Data type of output
            %
            %   % Example:
            %   %   Generate 10 samples of a Barker code sequence of length 7
            %
            %   hBCode = comm.BarkerCode('SamplesPerFrame', 10);
            %   seq = step(hBCode)
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
        end

        function stepImpl(in) %#ok<MANU>
            % retrieve the data stored in the private property pData and output the
            % data in circular buffer fashion.
        end

    end
    methods (Abstract)
    end
    properties
        %Length Length of generated code
        %   Specify the length of the Barker code as a numeric, integer scalar in
        %   the set {1, 2, 3, 4, 5, 7, 11, 13}. The default is 7. The codes that
        %   the object generates for a specified length are listed below:
        %
        %       Length      BarkerCode
        %       1           [-1]
        %       2           [-1 1]
        %       3           [-1 -1 1]
        %       4           [-1 -1 1 -1]
        %       5           [-1 -1 -1 1 -1]
        %       7           [-1 -1 -1 1 1 -1 1]
        %       11          [-1 -1 -1 1 1 1 -1 1 1 -1 1]
        %       13          [-1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1]
        Length;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'int8'. The default
        %   is 'double'.
        OutputDataType;

        %SamplesPerFrame Number of output samples per frame
        %   Specify the number of Barker code samples that the step method outputs
        %   as a numeric, integer scalar. If you set this property to a value of
        %   M, then the step method outputs M samples of a Barker code sequence of
        %   length N. N represents the length of the code that you specify in the
        %   Length property. The default is 1.
        SamplesPerFrame;

    end
end
