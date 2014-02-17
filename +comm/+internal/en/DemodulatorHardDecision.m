classdef DemodulatorHardDecision< handle
%DemodulatorHardDecision Demodulator with hard decision base class
%   Base class for M-ary demodulator System objects that only perform hard
%   decision demodulation.

   
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DemodulatorHardDecision
            %DemodulatorHardDecision Demodulator with hard decision base class
            %   Base class for M-ary demodulator System objects that only perform hard
            %   decision demodulation.
        end

        function getOutputDataTypeIndex(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        BitOutput;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Full precision' | 'Smallest
        %   unsigned integer' | 'double' | 'single' | 'int8' | 'uint8' | 'int16'
        %   | 'uint16' | 'int32' | 'uint32'. The default is 'Full precision'.
        %   When you set this property to 'Full precision' the output data is the
        %   same as that of the input if the input data type is single or double
        %   precision. When you set the BitOutput property to true, 'logical'
        %   data type becomes a valid option.
        OutputDataType;

    end
end
