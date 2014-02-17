classdef GoldSequenceXor< handle
%GoldSequenceXor Gold sequence generation engine for the public GoldSequence
%System object
%   H = comm.internal.GoldSequenceXor creates a Gold sequence generator that
%   performs an XOR operation on outputs of two PN sequence System objects.

   
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=GoldSequenceXor
            %GoldSequenceXor Gold sequence generation engine for the public GoldSequence
            %System object
            %   H = comm.internal.GoldSequenceXor creates a Gold sequence generator that
            %   performs an XOR operation on outputs of two PN sequence System objects.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
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
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Create the fully configured objects. For codegen, no subsequent
            % sets allowed
        end

        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
