classdef DifferentialDecoder< handle
%DifferentialDecoder Decode binary signal using differential decoding
%   H = comm.DifferentialDecoder returns a differential decoder System
%   object, H. This object decodes a binary input signal that was previously
%   encoded using a differential encoder.
%
%   H = comm.DifferentialDecoder(Name,Value) creates a differential decoder
%   object, H, with the specified property Name set to the specified Value.
%
%   H = comm.DifferentialDecoder(INITCOND) creates a differential decoder
%   object, H,  with the InitialCondition property set to INITCOND.
% 
%   Step method syntax:
%
%   Y = step(H,X) decodes the differentially encoded input data, X, and
%   returns the decoded data, Y. The input X must be a scalar, vector, or
%   matrix of data type logical, numeric, or fixed-point (embedded.fi
%   objects). When the input is a matrix or a row vector, the object treats
%   each column as a separate channel. Y has the same data type as X. The
%   object treats non-binary inputs as binary signals. The object computes
%   the initial output value by performing an Xor operation of the value in
%   the InitialCondition property and the first element of the vector you
%   input the first time you call the step method.
%
%   DifferentialDecoder methods:
%
%   step     - Decode input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create differential decoder object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of differential decoder object
%
%   DifferentialDecoder properties:
%
%   InitialCondition  - Initial value used to generate initial output
%
%   % Example: 
%   %   Decode a differentially encoded signal
%
%   % Create Differential Encoder System object
%   hdiffenc = comm.DifferentialEncoder;
%   % Create Differential Decoder System object
%   hdiffdec = comm.DifferentialDecoder;
%   % Generate random binary data
%   data = randi([0 1], 100, 1);
%   % Encode data
%   encdata = step(hdiffenc,data);
%   % Decode data
%   recdata = step(hdiffdec, encdata);
%   errors = biterr(data, recdata);
%   fprintf(1, ['\nThere were %d errors in the decoded signal ' ...
%               'out of %d bits\n'],errors, length(data));
%     
%   See also comm.DifferentialEncoder.

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DifferentialDecoder
            %DifferentialDecoder Decode binary signal using differential decoding
            %   H = comm.DifferentialDecoder returns a differential decoder System
            %   object, H. This object decodes a binary input signal that was previously
            %   encoded using a differential encoder.
            %
            %   H = comm.DifferentialDecoder(Name,Value) creates a differential decoder
            %   object, H, with the specified property Name set to the specified Value.
            %
            %   H = comm.DifferentialDecoder(INITCOND) creates a differential decoder
            %   object, H,  with the InitialCondition property set to INITCOND.
            % 
            %   Step method syntax:
            %
            %   Y = step(H,X) decodes the differentially encoded input data, X, and
            %   returns the decoded data, Y. The input X must be a scalar, vector, or
            %   matrix of data type logical, numeric, or fixed-point (embedded.fi
            %   objects). When the input is a matrix or a row vector, the object treats
            %   each column as a separate channel. Y has the same data type as X. The
            %   object treats non-binary inputs as binary signals. The object computes
            %   the initial output value by performing an Xor operation of the value in
            %   the InitialCondition property and the first element of the vector you
            %   input the first time you call the step method.
            %
            %   DifferentialDecoder methods:
            %
            %   step     - Decode input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create differential decoder object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of differential decoder object
            %
            %   DifferentialDecoder properties:
            %
            %   InitialCondition  - Initial value used to generate initial output
            %
            %   % Example: 
            %   %   Decode a differentially encoded signal
            %
            %   % Create Differential Encoder System object
            %   hdiffenc = comm.DifferentialEncoder;
            %   % Create Differential Decoder System object
            %   hdiffdec = comm.DifferentialDecoder;
            %   % Generate random binary data
            %   data = randi([0 1], 100, 1);
            %   % Encode data
            %   encdata = step(hdiffenc,data);
            %   % Decode data
            %   recdata = step(hdiffdec, encdata);
            %   errors = biterr(data, recdata);
            %   fprintf(1, ['\nThere were %d errors in the decoded signal ' ...
            %               'out of %d bits\n'],errors, length(data));
            %     
            %   See also comm.DifferentialEncoder.
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
            % Set size and type from input. Buffers are initialized to 0.
        end

        function stepImpl(in) %#ok<MANU>
            % Cast (xor output is logical) into output temp.
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
        %   treats non-binary values as binary signals, interpreting non-zero
        %   values as 1. The default is 0.
        InitialCondition;

    end
end
