classdef TCMDemodulatorBase< handle
%TCMDemodulatorBase Base class for TCM modulators

 
  %   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=TCMDemodulatorBase
            %TCMDemodulatorBase Base class for TCM modulators
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
        getInitializationParameters; %#ok<NOIN>

    end
    properties
        %OutputDataType Data type of output
        %   Specify output data type as one of 'logical' | 'double'. The default
        %   is 'double'.
        OutputDataType;

        %ResetInputPort Enable demodulator reset input
        %   Set this property to true to enable an additional input to the step
        %   method. When you set the reset input of the step method to a non-zero
        %   value, the object resets all the demodulator's state metrics to zero
        %   and sets the traceback memory to zero. This property applies when you
        %   set the TerminationMethod property to 'Continuous'. The default is
        %   false.
        ResetInputPort;

        %TerminationMethod Termination method of encoded frame
        %   Specify the termination method as one of 'Continuous' | 'Truncated' |
        %   'Terminated'. The default is 'Continuous'.
        %
        %   If you set the property to 'Continuous', the object saves its internal
        %   state metric at the end of each frame. The next frame uses the same
        %   state metric. The object treats each traceback path independently. If
        %   the input signal contains only one symbol, you should use 'Continuous'
        %   mode.
        %
        %   If you set the property to 'Truncated', the object treats each input
        %   vector independently. The traceback path starts at the state with the
        %   best metric and always ends in the all-zeros state.
        %
        %   If you set the to 'Terminated', the object treats each input vector
        %   independently, and the traceback path always starts and ends in the
        %   all-zeros state.
        TerminationMethod;

        %TracebackDepth Traceback depth for Viterbi decoder
        %   Specify the scalar, integer number of trellis branches to construct
        %   each traceback path. The Traceback depth parameter influences the
        %   decoding accuracy and delay. The decoding delay is the number of zero
        %   symbols that precede the first decoded symbol in the output. When you
        %   set the TerminationMethod property to 'Continuous', the decoding delay
        %   consists of TracebackDepth zero symbols or TracebackDepth*K zero bits
        %   for a rate K/N convolutional code. When you set the TerminationMethod
        %   property to 'Truncated' or 'Terminated', no output delay occurs and
        %   the traceback depth must be less than or equal to the number of
        %   symbols in each input vector. The default is 21.
        TracebackDepth;

    end
end
