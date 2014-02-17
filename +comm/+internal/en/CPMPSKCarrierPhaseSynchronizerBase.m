classdef CPMPSKCarrierPhaseSynchronizerBase< handle
% Base class for CPMCarrierPhaseSynchronizer and PSKCarrierPhaseSynchronizer

   
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=CPMPSKCarrierPhaseSynchronizerBase
            % Base class for CPMCarrierPhaseSynchronizer and PSKCarrierPhaseSynchronizer
        end

        function getNumOutputsImpl(in) %#ok<MANU>
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

        function setupImpl(in) %#ok<MANU>
            % Input cannot be fi-double or fi-single. This check can be moved to
            % validateInputsImpl when we have a mechanism to know, without looking at
            % actual input data, that this data is a fi object.
        end

        function stepImpl(in) %#ok<MANU>
            % raise to pPower-power 
        end

        function validateInputsImpl(in) %#ok<MANU>
            % input must be complex
        end

    end
    methods (Abstract)
    end
    properties
        %ObservationInterval Number of symbols where carrier phase assumed
        %constant
        %   Specify the observation interval as a real positive scalar integer
        %   value of data type single or double. The default is 100.
        ObservationInterval;

        % Subclasses must set and check valid values for this property. This
        % property stands for M in the M-Power method and 2P in the 2P-Power
        % method. This property is tunable.
        pPower;

    end
end
