classdef DemodulatorSoftDecision< handle
%DemodulatorSoftDecision Demodulator with soft decision base class
%   Base class for M-ary demodulator System objects that perform hard and
%   soft decision demodulation.

   
%   Copyright 2008-2012 The MathWorks, Inc.

    methods
        function out=DemodulatorSoftDecision
            %DemodulatorSoftDecision Demodulator with soft decision base class
            %   Base class for M-ary demodulator System objects that perform hard and
            %   soft decision demodulation.
        end

        function getOutputDataTypeIndex(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is always the same as that of the input if the
            % BitOutput property is set to 'true' and the DecisionMethod property is
            % not 'Hard decision'. It is also connected to the input if
            % the OutputDataType property is set to 'Full precision' and the input is
            % of data type floating-point.
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
        %   This property applies only when you set the BitOutput property to
        %   false or when you set the BitOutput property to true and the
        %   DecisionMethod property to 'Hard decision'. In this case, when the
        %   OutputDataType property is set to 'Full precision', the output data
        %   type is the same as that of the input when the input data type is
        %   single or double precision. When the input data is of a fixed-point
        %   type, the output data type works as if you had set the OutputDataType
        %   property to 'Smallest unsigned integer'.
        %
        %   When you set BitOutput to true and the DecisionMethod property to
        %   'Hard Decision', then 'logical' data type becomes a valid option.
        %
        %   If you set the BitOutput property to true and the DecisionMethod
        %   property to 'Log-likelihood ratio' or 'Approximate log-likelihood
        %   ratio', the output data type is the same as that of the input which,
        %   in this case, can only be single or double precision.
        OutputDataType;

        %Variance Noise variance
        %   Specify the variance of the noise as a positive, real scalar. If this
        %   value is very small (i.e., SNR is very high), log-likelihood ratio
        %   (LLR) computations may yield Inf or -Inf. This occurs because the LLR
        %   algorithm would compute the exponential of very large or very small
        %   numbers using finite precision arithmetic. In such cases, using
        %   approximate LLR is recommended because its algorithm does not compute
        %   exponentials. This property applies when you set the BitOutput
        %   property to true, the DecisionMethod property to 'Log-likelihood
        %   ratio' or 'Approximate log-likelihood ratio', and the VarianceSource
        %   property to 'Property'. The default is 1. This property is tunable.
        Variance;

    end
end
