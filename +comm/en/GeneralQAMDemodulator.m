classdef GeneralQAMDemodulator< handle
%GeneralQAMDemodulator Demodulate using arbitrary QAM constellation
%   H = comm.GeneralQAMDemodulator creates a demodulator System object, H.
%   This object demodulates the input signal using a general quadrature
%   amplitude modulation (QAM) method.
%
%   H = comm.GeneralQAMDemodulator(Name,Value) creates a general QAM
%   demodulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.GeneralQAMDemodulator(CONST,Name,Value) creates a general QAM
%   demodulator object, H, with the Constellation property set to CONST, and
%   other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates the input data, X, with the general QAM
%   demodulator System object, H, and returns Y. Input X must be a scalar or
%   a column vector with double or single precision data type. When you set
%   BitOutput to false or you set BitOutput to true and DecisionMethod to
%   either 'Hard decision' or 'Approximate log-likelihood ratio', the data
%   type of the input can also be signed integer, or signed fixed point (fi
%   objects). Depending on the BitOutput property value, output Y can be
%   integer or bit valued.
%
%   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
%   VAR. This syntax applies when you set the BitOutput property to true,
%   the DecisionMethod property to 'Approximate log-likelihood ratio' or
%   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
%   The data type of input VAR must be double or single precision.
%
%   GeneralQAMDemodulator methods:
%
%   step     - Demodulate input using arbitrary QAM constellation (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create general QAM demodulator object with same property
%              values
%   isLocked - Locked status (logical)
%
%   GeneralQAMDemodulator properties:
%
%   Constellation  - Signal constellation
%   BitOutput      - Output data as bits
%   DecisionMethod - Demodulation decision method
%   VarianceSource - Source of noise variance
%   Variance       - Noise variance
%   OutputDataType - Data type of output
%
%   The GeneralQAMDemodulator object supports fixed-point operations. For
%   more information, type comm.GeneralQAMDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate data using an arbitrary three point
%   %   constellation
%
%   % Setup a three point constellation
%   c = [1 1i -1];
%   hQAMMod = comm.GeneralQAMModulator(c);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%              'Signal to noise ratio (SNR)','SNR',15, 'SignalPower', 0.89);
%   hQAMDemod = comm.GeneralQAMDemodulator(c);
%   %Create an error rate calculator
%   hError = comm.ErrorRate;
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 2],50,1);
%       modSignal = step(hQAMMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hQAMDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.GeneralQAMModulator, comm.RectangularQAMDemodulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=GeneralQAMDemodulator
            %GeneralQAMDemodulator Demodulate using arbitrary QAM constellation
            %   H = comm.GeneralQAMDemodulator creates a demodulator System object, H.
            %   This object demodulates the input signal using a general quadrature
            %   amplitude modulation (QAM) method.
            %
            %   H = comm.GeneralQAMDemodulator(Name,Value) creates a general QAM
            %   demodulator object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.GeneralQAMDemodulator(CONST,Name,Value) creates a general QAM
            %   demodulator object, H, with the Constellation property set to CONST, and
            %   other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates the input data, X, with the general QAM
            %   demodulator System object, H, and returns Y. Input X must be a scalar or
            %   a column vector with double or single precision data type. When you set
            %   BitOutput to false or you set BitOutput to true and DecisionMethod to
            %   either 'Hard decision' or 'Approximate log-likelihood ratio', the data
            %   type of the input can also be signed integer, or signed fixed point (fi
            %   objects). Depending on the BitOutput property value, output Y can be
            %   integer or bit valued.
            %
            %   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
            %   VAR. This syntax applies when you set the BitOutput property to true,
            %   the DecisionMethod property to 'Approximate log-likelihood ratio' or
            %   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
            %   The data type of input VAR must be double or single precision.
            %
            %   GeneralQAMDemodulator methods:
            %
            %   step     - Demodulate input using arbitrary QAM constellation (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create general QAM demodulator object with same property
            %              values
            %   isLocked - Locked status (logical)
            %
            %   GeneralQAMDemodulator properties:
            %
            %   Constellation  - Signal constellation
            %   BitOutput      - Output data as bits
            %   DecisionMethod - Demodulation decision method
            %   VarianceSource - Source of noise variance
            %   Variance       - Noise variance
            %   OutputDataType - Data type of output
            %
            %   The GeneralQAMDemodulator object supports fixed-point operations. For
            %   more information, type comm.GeneralQAMDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate data using an arbitrary three point
            %   %   constellation
            %
            %   % Setup a three point constellation
            %   c = [1 1i -1];
            %   hQAMMod = comm.GeneralQAMModulator(c);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %              'Signal to noise ratio (SNR)','SNR',15, 'SignalPower', 0.89);
            %   hQAMDemod = comm.GeneralQAMDemodulator(c);
            %   %Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 2],50,1);
            %       modSignal = step(hQAMMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hQAMDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.GeneralQAMModulator, comm.RectangularQAMDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.GeneralQAMDemodulator System object 
            %               fixed-point information
            %   comm.GeneralQAMDemodulator.helpFixedPoint displays information
            %   about fixed-point properties and operations of the
            %   comm.GeneralQAMDemodulator System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is always the same as that of the input if the
            % BitOutput property is set to 'true' and the DecisionMethod property is
            % set to 'Log-likelihood ratio'. It is also connected to the input if
            % the OutputDataType property is set to 'Full precision' and the input is
            % of data type floating-point.
        end

    end
    methods (Abstract)
    end
    properties
        %Accumulator1DataType Data type of accumulator 1
        %   Specify the accumulator 1 fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property does not apply when you set
        %   the BitOutput property to true and the DecisionMethod property to
        %   'Log-likelihood ratio'. Otherwise, this property applies when you set
        %   the FullPrecisionOverride property to false.
        Accumulator1DataType;

        %Accumulator2DataType Data type of accumulator 2
        %   Specify the accumulator 2 fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property applies when the
        %   FullPrecisionOverride property is false, the BitOutput property is
        %   true, and the DecisionMethod property is 'Log-likelihood ratio'.
        Accumulator2DataType;

        %Accumulator3DataType Data type of accumulator 3
        %   Specify the accumulator 3 fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property applies when the
        %   FullPrecisionOverride property is false, the BitOutput property is
        %   true, and the DecisionMethod property is 'Log-likelihood ratio'.
        Accumulator3DataType;

        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true the step method
        %   outputs a column vector of bit values with length equal to log2(M)
        %   times the number of demodulated symbols, where M is the length of the
        %   signal constellation specified in the Constellation property (i.e. M
        %   is the modulation order). When you set this property to false, the
        %   step method outputs a column vector, of length equal to the input data
        %   vector. The vector contains integer symbol values between 0 and M-1.
        %   The default is false.
        BitOutput;

        %Constellation Signal constellation
        %   Specify the constellation points as a real or complex, double
        %   precision data type vector. The length of the vector, M, determines
        %   the modulation order. When you set the BitOutput property to false,
        %   the step method outputs a vector with values that are integers between
        %   0 and M-1 and with a length equal to the length of the input signal.
        %   When you set the BitOutput property to true, the output signal
        %   contains bits. For bit outputs, the size of the signal constellation
        %   must be an integer power of two and the output length is an integer
        %   multiple of the number of bits per symbol. The default is
        %   exp(2*pi*1i*(0:7)/8).
        Constellation;

        %ConstellationDataType Data type of signal constellation
        %   Specify the constellation fixed-point data type as one of [{'Same
        %   word length as input'} | 'Custom']. This property does not apply when
        %   you set the BitOutput property to true and the DecisionMethod
        %   property to 'Log-likelihood ratio'.
        ConstellationDataType;

        %CustomAccumulator1DataType Fixed-point data type of accumulator 1
        %   Specify the accumulator 1 fixed-point type as an auto-signed, scaled
        %   numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the Accumulator1DataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomAccumulator1DataType;

        %CustomAccumulator2DataType Fixed-point data type accumulator 2
        %   Specify the accumulator 2 fixed-point data type as an auto-signed,
        %   scaled numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the Accumulator2DataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomAccumulator2DataType;

        %CustomAccumulator3DataType Fixed-point data type of accumulator 3
        %   Specify the accumulator 3 fixed-point type as an auto-signed, scaled
        %   numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and theAccumulator3DataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomAccumulator3DataType;

        %CustomConstellationDataType Fixed-point data type of signal constellation
        %   Specify the constellation fixed-point type as an auto-signed,
        %   unscaled numerictype object. This property applies when you set
        %   the ConstellationDataType property to 'Custom'. The default value of
        %   this property is numerictype([],16).
        %
        %   See also numerictype.  
        CustomConstellationDataType;

        %CustomInverseVarianceDataType Fixed-point data type of inverse noise variance
        %   Specify the inverse noise variance fixed-point type as an
        %   auto-signed (scaled or unscaled) numerictype object. This property
        %   applies when the InverseVarianceDataType property is 'Custom'. The
        %   default value of this property is numerictype([],16,8).
        %
        %   See also numerictype.  
        CustomInverseVarianceDataType;

        %CustomNoiseScalingInputDataType Fixed-point data type of noise scaling
        %                                input
        %   Specify the noise scaling input fixed-point type as an auto-signed,
        %   scaled numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the
        %   NoiseScalingInputDataType property is 'Custom'. The default value of
        %   this property is numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomNoiseScalingInputDataType;

        %CustomOutputDataType Data type of output
        %   Specify the output fixed-point type as an auto-signed, scaled
        %   numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the OutputDataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomOutputDataType;

        %CustomProductInputDataType Fixed-point data type of product
        %   Specify the product input fixed-point type as an auto-signed, scaled
        %   numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the ProductInputDataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomProductInputDataType;

        %CustomProductOutputDataType Fixed-point data type of product output
        %   Specify the product output fixed-point type as an auto-signed, scaled
        %   numerictype object. This property applies when the
        %   FullPrecisionOverride property is false and the ProductOutputDataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomProductOutputDataType;

        %DecisionMethod Demodulation decision method
        %   Specify the decision method the object uses as one of [{'Hard
        %   decision'} | 'Log-likelihood ratio' | 'Approximate log-likelihood
        %   ratio']. When you set the BitOutput property to false the object
        %   always performs hard decision demodulation. This
        %   property applies when you set the BitOutput property to true.
        DecisionMethod;

        %FullPrecisionOverride Full precision override for fixed-point arithmetic
        %   Specify whether to use full precision rules. This property does not
        %   apply when you set the DecisionMethod property to 'Approximate
        %   log-likelihood ratio'. Otherwise, if you set FullPrecisionOverride to
        %   true the object computes all internal arithmetic and output data
        %   types using full precision rules. These rules guarantee that no
        %   quantization occurs within the object. Bits are added as needed to
        %   ensure that no round-off or overflow occurs. If you set
        %   FullPrecisionOverride to false, fixed-point data types
        %   are controlled through individual property settings.
        FullPrecisionOverride;

        %InverseVarianceDataType Data type of inverse noise variance
        %   Specify the inverse noise variance fixed-point data type as one of
        %   [{'Same word length as input'} | 'Custom']. This property applies
        %   when the BitOutput property is true, the DecisionMethod property is
        %   'Log-likelihood ratio', and the VarianceSource property is
        %   'Property'.
        InverseVarianceDataType;

        %NoiseScalingInputDataType Data type of noise scaling input
        %   Specify the noise scaling input fixed-point data type as one of
        %   [{'Same as accumulator 3'} | 'Custom']. This property applies when
        %   the FullPrecisionOverride property is false, the BitOutput property
        %   is true, and the DecisionMethod property is 'Log-likelihood ratio'.
        NoiseScalingInputDataType;

        %OutputDataType Data type of output
        %   Specify the output data type as one of [{'Full precision'} |
        %   'Smallest unsigned integer' | 'double' | 'single' | 'int8' | 'uint8'
        %   | 'int16' |  'uint16' | 'int32' | 'uint32']. This
        %   property applies only when you set the BitOutput property to false or
        %   when you set the BitOutput property to true and the DecisionMethod
        %   property to 'Hard decision' or 'Approximate log-likelihood ratio'. In
        %   this case, when you set the OutputDataType property to 'Full
        %   precision', the output data type is the same as that of the input
        %   when the input data type is single or double precision. When the
        %   input data is of a fixed-point type, the output data type works as if
        %   you had set the OutputDataType property to 'Smallest unsigned
        %   integer'. Note that for integer data type inputs, a Fixed-Point
        %   Designer license is required when this property is set to 'Smallest
        %   unsigned integer' or 'Full precision'.
        %
        %   When you set the BitOutput property to true, and the DecisionMethod
        %   property to 'Hard Decision' the data type 'logical' becomes a valid
        %   option.
        %
        %   When you set the BitOutput property to true and the DecisionMethod
        %   property to 'Approximate log-likelihood ratio' you may only set this
        %   property to 'Full precision' | 'Custom'.
        %
        %   If you set the BitOutput property to true and the DecisionMethod
        %   property to 'Log-likelihood ratio', the output data type is the same
        %   as that of the input which, in this case, can only be single or double
        %   precision.
        OutputDataType;

        %OverflowAction Action when fixed-point numeric values overflow
        %   Specify the overflow action as one of [{'Wrap'} | 'Saturate']. This
        %   property does not apply when you set the BitOutput property to true
        %   and the DecisionMethod property to 'Log-likelihood ratio'. Otherwise,
        %   this property is applicable when the object is not in a full
        %   precision configuration.
        OverflowAction;

        %ProductInputDataType Data type of product
        %   Specify the product input fixed-point data type as one of [{'Same as
        %   accumulator 1'} | 'Custom']. This property applies when the
        %   FullPrecisionOverride property is false, the BitOutput property is
        %   true, and the DecisionMethod property is 'Log-likelihood ratio'.
        ProductInputDataType;

        %ProductOutputDataType Data type of product output
        %   Specify the product output fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property applies when the
        %   FullPrecisionOverride property is false, the BitOutput property is
        %   true, and the DecisionMethod property is 'Log-likelihood ratio'.
        ProductOutputDataType;

        %RoundingMethod Rounding of fixed-point numeric values
        %   Specify the rounding method as one of ['Ceiling' |
        %   'Convergent' | {'Floor'} | 'Nearest' | 'Round' | 'Simplest' |
        %   'Zero']. This property does not apply when you set BitOutput to true
        %   and DecisionMethod to 'Log-likelihood ratio'. Otherwise, this
        %   property is applicable when the object is not in a full precision
        %   configuration.
        RoundingMethod;

        %Variance Noise variance
        %   Specify the variance of the noise as a non-zero, real scalar. If this
        %   value is very small (i.e., SNR is very high), log-likelihood ratio
        %   (LLR) computations may yield Inf or -Inf. This occurs because the LLR
        %   algorithm would compute the exponential of very large or very small
        %   numbers using finite precision arithmetic. In such cases, using
        %   approximate LLR is recommended because its algorithm does not compute
        %   exponentials. This property applies when you set the VarianceSource
        %   property to 'Property'. The default is 1. This property is tunable.
        Variance;

        %VarianceSource Source of noise variance
        %   Specify the source of the noise variance as one of [{'Property'} |
        %   'Input port']. This property applies when you set the DecisionMethod
        %   property to 'Log-likelihood ratio' or 'Approximate log-likelihood ratio'.
        VarianceSource;

    end
end
