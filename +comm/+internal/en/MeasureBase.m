classdef MeasureBase< handle
%MeasureBase MeasureBase class for measure package

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=MeasureBase
            %MeasureBase MeasureBase class for measure package
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %pNumChannels Number of channels
        pNumChannels;

    end
end
