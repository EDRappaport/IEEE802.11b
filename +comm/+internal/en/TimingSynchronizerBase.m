classdef TimingSynchronizerBase< handle
%TimingSynchronizerBase Base class for MSK, GMSK, Mueller-Muller, and
%early-late gate, and Gardner timing synchronizers

 
%   Copyright 2010-2011 The MathWorks, Inc.

    methods
        function out=TimingSynchronizerBase
            %TimingSynchronizerBase Base class for MSK, GMSK, Mueller-Muller, and
            %early-late gate, and Gardner timing synchronizers
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %ErrorUpdateGain Error update step size
        %   Specify the step size for updating successive timing phase estimates
        %   as a positive real scalar. Typically, this number is less than
        %   1/SamplesPerSymbol, which corresponds to a slowly varying timing
        %   phase. The default is 0.05. This property is tunable.
        ErrorUpdateGain;

        %ResetCondition Condition for timing phase recovery reset
        %   Specify the conditions to reset the timing phase recovery process as
        %   one of 'Never' | 'Every frame'. The default is 'Never'. When you set
        %   this property to 'Never', the phase recovery process never restarts.
        %   The object operates continuously, retaining information from one
        %   symbol to the next. When you set this property to 'Every frame', the
        %   timing phase recovery restarts at the start of each frame of data,
        %   that is, at each step method call. This property applies when you set
        %   the ResetInputPort property to false.
        ResetCondition;

        %ResetInputPort Enable synchronization reset input
        %   Set this property to true to enable resetting the timing phase
        %   recovery process based on an input argument value.  When you set this
        %   property to true, you must specify a reset input value to the step
        %   method. When the reset input is a non-zero value, the object restarts
        %   the timing phase recovery process. When you set this property to
        %   false, the object does not restart. The default is false.
        ResetInputPort;

        %SamplesPerSymbol Number of samples representing each symbol
        %   Specify the number of samples that represent each symbol in the input
        %   signal as an integer-valued scalar greater than 1. The default is 4.
        SamplesPerSymbol;

        pSynchronizerIndex;

    end
end
