classdef DifferentialEncoder< handle
%DifferentialEncoder Encode binary signal using differential coding
%   H = comm.DifferentialEncoder creates a differential encoder System
%   object, H. This object encodes a binary input signal by calculating its
%   logical difference with the previously encoded data.
%
%   H = comm.DifferentialEncoder(Name,Value) creates a differential encoder
%   object, H, with the specified property Name set to the specified Value.
%
%   H = comm.DifferentialEncoder(INITCOND) creates a differential encoder
%   object, H, with the InitialCondition property set to INITCOND.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the binary input data, X, and returns the
%   differentially encoded data, Y. The input X must be a scalar, vector, or
%   matrix of data type logical, numeric, or fixed-point (embedded.fi
%   objects). When the input is a matrix, the object treats each column as a
%   separate channel. Y has the same data type as X. The object treats
%   non-binary inputs as binary signals. The object computes the initial
%   output value by performing an Xor operation of the value in the
%   InitialCondition property and the first element of the vector you input
%   the first time you call the step method.
%
%   DifferentialEncoder methods:
%
%   step     - Encode input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create differential encoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of differential encoder object
%
%   DifferentialEncoder properties:
%
%   InitialCondition - Initial value used to generate initial output
%
%   % Example: 
%   %   Encode binary signal using differential coding
%
%   % Create Differential Encoder System object
%   hdiffenc = comm.DifferentialEncoder;
%   % Generate random binary data
%   data = randi([0 1], 11, 1);
%   % Encode data
%   encdata = step(hdiffenc,data);
%
%   See also comm.DifferentialDecoder.

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DifferentialEncoder
            %DifferentialEncoder Encode binary signal using differential coding
            %   H = comm.DifferentialEncoder creates a differential encoder System
            %   object, H. This object encodes a binary input signal by calculating its
            %   logical difference with the previously encoded data.
            %
            %   H = comm.DifferentialEncoder(Name,Value) creates a differential encoder
            %   object, H, with the specified property Name set to the specified Value.
            %
            %   H = comm.DifferentialEncoder(INITCOND) creates a differential encoder
            %   object, H, with the InitialCondition property set to INITCOND.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes the binary input data, X, and returns the
            %   differentially encoded data, Y. The input X must be a scalar, vector, or
            %   matrix of data type logical, numeric, or fixed-point (embedded.fi
            %   objects). When the input is a matrix, the object treats each column as a
            %   separate channel. Y has the same data type as X. The object treats
            %   non-binary inputs as binary signals. The object computes the initial
            %   output value by performing an Xor operation of the value in the
            %   InitialCondition property and the first element of the vector you input
            %   the first time you call the step method.
            %
            %   DifferentialEncoder methods:
            %
            %   step     - Encode input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create differential encoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of differential encoder object
            %
            %   DifferentialEncoder properties:
            %
            %   InitialCondition - Initial value used to generate initial output
            %
            %   % Example: 
            %   %   Encode binary signal using differential coding
            %
            %   % Create Differential Encoder System object
            %   hdiffenc = comm.DifferentialEncoder;
            %   % Generate random binary data
            %   data = randi([0 1], 11, 1);
            %   % Encode data
            %   encdata = step(hdiffenc,data);
            %
            %   See also comm.DifferentialDecoder.
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
            %   Note: State buffer WILL have same dtype and complexity as input.
            %   Initial condition may not, so a cast is necessary
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %InitialCondition Initial value used to generate initial output
        %   Specify the initial condition as a real scalar. The data type can be
        %   logical, numeric, or fixed-point (embedded.fi object). The object
        %   treats non-binary values as binary signals. The default is 0.
        InitialCondition;

    end
end
