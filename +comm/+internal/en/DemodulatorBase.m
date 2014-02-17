classdef DemodulatorBase< handle
%DemodulatorBase Demodulator base class

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DemodulatorBase
            %DemodulatorBase Demodulator base class
        end

        function getOutputDataTypeIndex(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        BitOutput;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Full precision' | 'Smallest
        %   unsigned integer' | 'double' | 'single' | 'int8' | 'uint8' | 'int16' |
        %   'uint16' | 'int32' | 'uint32'. The default is 'Full precision'. When
        %   you set this property to 'Full precision', the output data type is the
        %   same as that of the input when the input data type is single or double
        %   precision. When the input data is of a fixed-point type, the output
        %   data type works as if you had set the OutputDataType property to
        %   'Smallest unsigned integer'. Note that for integer data type inputs,
        %   a Fixed-Point Designer license is required when this property is set
        %   to 'Smallest unsigned integer' or 'Full precision'. When you set the
        %   BitOutput property to true, then 'logical' data type becomes a valid
        %   option.
        OutputDataType;

        pBitOutputDataTypeSet;

        pIntOutputDataTypeSet;

    end
end
