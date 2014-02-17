classdef CPMModulatorBase< handle
%CPMModulatorBase CPM modulator base class

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=CPMModulatorBase
            %CPMModulatorBase CPM modulator base class
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        % The command-line help for BitInput varies in the subclasses so each
        % subclass needs to declare this property.
        BitInput;

        %InitialPhaseOffset Initial phase offset
        %   Specify the initial phase of the modulated waveform in radians as a
        %   real, numeric scalar. The default is 0.
        InitialPhaseOffset;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'single'. The default is
        %   'double'.
        OutputDataType;

        %SamplesPerSymbol Number of samples per output symbol
        %   Specify the upsampling factor at the output as a real, positive,
        %   integer scalar. The upsampling factor is the number of output samples
        %   that the step method produces for each input sample. The default is 8.
        SamplesPerSymbol;

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
