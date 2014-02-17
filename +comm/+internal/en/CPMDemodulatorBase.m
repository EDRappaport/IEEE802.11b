classdef CPMDemodulatorBase< handle
%CPMDemodulatorBase CPM demodulator base class

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=CPMDemodulatorBase
            %CPMDemodulatorBase CPM demodulator base class
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        % The command-line help for BitOutput varies in the subclasses so each
        % subclass needs to declare this property.
        BitOutput;

        %InitialPhaseOffset Initial phase offset
        %   Specify the initial phase offset of the input modulated waveform in
        %   radians as a real, numeric scalar. The default is 0.
        InitialPhaseOffset;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'int8' | 'int16' | 'int32' |
        %   'double', when you set the BitOutput property to false. When you set
        %   the BitOutput property to true, specify the output data type as one of
        %   'logical' | 'double'. The default is 'double'.
        OutputDataType;

        %SamplesPerSymbol Number of samples per input symbol
        %   Specify the expected number of samples per input symbol as a positive,
        %   integer scalar. The default is 8.
        SamplesPerSymbol;

        %TracebackDepth Traceback depth for Viterbi algorithm
        %   Specify the number of trellis branches that the Viterbi algorithm uses
        %   to construct each traceback path as a positive, integer scalar. The
        %   value of this property is also the output delay, which is the number
        %   of zero symbols that precede the first meaningful demodulated symbol
        %   in the output. The default is 16.
        TracebackDepth;

        pBandwidthTimeProduct;

        pMainLobeDuration;

        pModulationIndex;

        pModulationOrder;

        pPulseLength;

        pRolloffFactor;

        pSymbolMapping;

        pSymbolPrehistory;

    end
end
