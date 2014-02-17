classdef MultiBandFilter< handle
%MultiBandFilter MultiBandFilter class for use by comm.ACPR

     
%   Copyright 2011-2012 The MathWorks, Inc.

    methods
        function out=MultiBandFilter
            %MultiBandFilter MultiBandFilter class for use by comm.ACPR
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
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        % DC centered FIR filter transfer function coefficients
        DcCenteredFilterCoefficients;

        % Frequency offsets for shifted filter transfer functions
        FrequencyOffsets;

    end
end
