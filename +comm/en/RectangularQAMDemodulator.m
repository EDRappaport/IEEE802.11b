classdef RectangularQAMDemodulator< handle
%RectangularQAMDemodulator Demodulate using rectangular QAM method
%   H = comm.RectangularQAMDemodulator creates a demodulator System object,
%   H. This object demodulates the input signal using the rectangular
%   quadrature amplitude modulation (QAM) method.
%
%   H = comm.RectangularQAMDemodulator(Name,Value) creates a rectangular QAM
%   demodulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RectangularQAMDemodulator(M,Name,Value) creates a rectangular
%   QAM demodulator object, H, with the ModulationOrder property set to M,
%   and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates the input data, X, with the rectangular QAM
%   demodulator System object, H, and returns, Y. Input X must be a scalar
%   or a column vector with double or single precision data type. When
%   ModulationOrder is an even power of two and you set BitOutput to false
%   or you set BitOutput to true and DecisionMethod to 'Hard decision', the
%   data type of the input can also be signed integer, or signed fixed point
%   (fi objects). Depending on the BitOutput property value, output Y can be
%   integer or bit valued.
%
%   Y = step(H,X,VAR)uses soft decision demodulation and noise variance VAR.
%   This syntax applies when you set the BitOutput property to true, the
%   DecisionMethod property to 'Approximate log-likelihood ratio' or
%   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
%   The data type of input VAR must be double or single precision.
%
%   RectangularQAMDemodulator methods:
%
%   step     - Demodulate input using rectangular QAM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create rectangular QAM demodulator object with same property
%              values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   RectangularQAMDemodulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   PhaseOffset         - Phase offset of constellation
%   BitOutput           - Output data as bits
%   SymbolMapping       - Constellation encoding
%   CustomSymbolMapping - Custom constellation encoding
%   NormalizationMethod - Constellation normalization method
%   MinimumDistance     - Minimum distance between symbols
%   AveragePower        - Average power of constellation
%   PeakPower           - Peak power of constellation
%   DecisionMethod      - Demodulation decision method
%   VarianceSource      - Source of noise variance
%   Variance            - Noise variance
%   OutputDataType      - Data type of output
%
%   The RectangularQAMDemodulator object supports fixed-point operations.
%   For more information, type comm.RectangularQAMDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate data using rectangular 8-QAM
%
%   hMod = comm.RectangularQAMModulator(8);
%   hAWGN = comm.AWGNChannel('NoiseMethod',...
%               'Signal to noise ratio (SNR)', 'SNR', 15, 'SignalPower', 6);
%   hDemod = comm.RectangularQAMDemodulator(8);
%   % Create an error rate calculator
%   hError = comm.ErrorRate;   
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 hMod.ModulationOrder-1],50,1);
%       modData = step(hMod, data);
%       receivedSignal = step(hAWGN, modData);
%       receivedData = step(hDemod, receivedSignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.RectangularQAMModulator, comm.GeneralQAMDemodulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=RectangularQAMDemodulator
            %RectangularQAMDemodulator Demodulate using rectangular QAM method
            %   H = comm.RectangularQAMDemodulator creates a demodulator System object,
            %   H. This object demodulates the input signal using the rectangular
            %   quadrature amplitude modulation (QAM) method.
            %
            %   H = comm.RectangularQAMDemodulator(Name,Value) creates a rectangular QAM
            %   demodulator object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RectangularQAMDemodulator(M,Name,Value) creates a rectangular
            %   QAM demodulator object, H, with the ModulationOrder property set to M,
            %   and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates the input data, X, with the rectangular QAM
            %   demodulator System object, H, and returns, Y. Input X must be a scalar
            %   or a column vector with double or single precision data type. When
            %   ModulationOrder is an even power of two and you set BitOutput to false
            %   or you set BitOutput to true and DecisionMethod to 'Hard decision', the
            %   data type of the input can also be signed integer, or signed fixed point
            %   (fi objects). Depending on the BitOutput property value, output Y can be
            %   integer or bit valued.
            %
            %   Y = step(H,X,VAR)uses soft decision demodulation and noise variance VAR.
            %   This syntax applies when you set the BitOutput property to true, the
            %   DecisionMethod property to 'Approximate log-likelihood ratio' or
            %   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
            %   The data type of input VAR must be double or single precision.
            %
            %   RectangularQAMDemodulator methods:
            %
            %   step     - Demodulate input using rectangular QAM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create rectangular QAM demodulator object with same property
            %              values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   RectangularQAMDemodulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   PhaseOffset         - Phase offset of constellation
            %   BitOutput           - Output data as bits
            %   SymbolMapping       - Constellation encoding
            %   CustomSymbolMapping - Custom constellation encoding
            %   NormalizationMethod - Constellation normalization method
            %   MinimumDistance     - Minimum distance between symbols
            %   AveragePower        - Average power of constellation
            %   PeakPower           - Peak power of constellation
            %   DecisionMethod      - Demodulation decision method
            %   VarianceSource      - Source of noise variance
            %   Variance            - Noise variance
            %   OutputDataType      - Data type of output
            %
            %   The RectangularQAMDemodulator object supports fixed-point operations.
            %   For more information, type comm.RectangularQAMDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate data using rectangular 8-QAM
            %
            %   hMod = comm.RectangularQAMModulator(8);
            %   hAWGN = comm.AWGNChannel('NoiseMethod',...
            %               'Signal to noise ratio (SNR)', 'SNR', 15, 'SignalPower', 6);
            %   hDemod = comm.RectangularQAMDemodulator(8);
            %   % Create an error rate calculator
            %   hError = comm.ErrorRate;   
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 hMod.ModulationOrder-1],50,1);
            %       modData = step(hMod, data);
            %       receivedSignal = step(hAWGN, modData);
            %       receivedData = step(hDemod, receivedSignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.RectangularQAMModulator, comm.GeneralQAMDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.RectangularQAMDemodulator System  object
            %               fixed-point information
            %   comm.RectangularQAMDemodulator.helpFixedPoint displays information
            %   about fixed-point properties and operations of the
            %   comm.RectangularQAMDemodulator System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %AveragePower Average power of constellation
        %   Specify the average power of the symbols in the constellation as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Average power'. The default is 1.
        AveragePower;

        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true the step method
        %   outputs a column vector of bit values with length equal to
        %   log2(ModulationOrder) times the number of demodulated symbols. When
        %   you set this property to false, the step method outputs a column
        %   vector, of length equal to the input data vector, that contains
        %   integer symbol values between 0 and ModulationOrder-1. The default is
        %   false.
        BitOutput;

        %CustomDenormalizationFactorDataType Fixed-point data type of denormalization factor
        %   Specify the denormalization factor fixed-point type as an
        %   auto-signed, unscaled numerictype object. This property applies
        %   when you set the DenormalizationFactorDataType property to 'Custom'.
        %   The default value of this property is numerictype([],16).
        %
        %   See also numerictype.
        CustomDenormalizationFactorDataType;

        %CustomDerotateFactorDataType Fixed-point data type of derotate factor
        %   Specify the derotate factor fixed-point type as an auto-signed,
        %   unscaled numerictype object. This property applies when you set the
        %   DerotateFactorDataType property to 'Custom'. The default value of
        %   this property is numerictype([],16).
        %
        %   See also numerictype.
        CustomDerotateFactorDataType;

        %CustomProductDataType Fixed-point data type of product
        %   Specify the product fixed-point type as an auto-signed, unscaled
        %   numerictype object. This property is applicable when the
        %   FullPrecisionOverride property is false and when the
        %   ProductDataType property is 'Custom'. The default value of this
        %   property is numerictype([],32).
        %
        %   See also numerictype.
        CustomProductDataType;

        %CustomSumDataType Fixed-point data type of sum
        %   Specify the sum fixed-point type as an auto-signed, unscaled
        %   numerictype object. This property is applicable when the
        %   FullPrecisionOverride property is false and when the SumDataType
        %   property is 'Custom'. The default value of this property is
        %   numerictype([],32).
        %
        %   See also numerictype.
        CustomSumDataType;

        %CustomSymbolMapping Custom constellation encoding
        %   Specify a custom constellation symbol mapping vector. This property is
        %   a row or column vector of size ModulationOrder with unique integer
        %   values in the range [0, ModulationOrder-1]. The values must be of data
        %   type double. The first element of this vector corresponds to the
        %   top-leftmost point of the constellation, with subsequent elements
        %   running down column-wise, from left to right. The last element
        %   corresponds to the bottom-rightmost point. This property applies when
        %   you set the SymbolMapping property to 'Custom'. The default is 0:15.
        CustomSymbolMapping;

        %DecisionMethod Demodulation decision method
        %   Specify the decision method the object uses as one of 'Hard decision'
        %   | 'Log-likelihood ratio' | 'Approximate log-likelihood ratio'. The
        %   default is 'Hard decision'. When the BitOutput property is false the
        %   object always performs hard decision demodulation. This property
        %   applies when you set the BitOutput property to true.
        DecisionMethod;

        %DenormalizationFactorDataType Data type of denormalization factor
        %   Specify the denormalization factor fixed-point data type as one of
        %   [{'Same word length as input'} | 'Custom']. This property applies
        %   when you set the BitOutput property to false, or when you set the
        %   BitOutput property to true and the DecisionMethod property to 'Hard
        %   decision'.
        DenormalizationFactorDataType;

        %DerotateFactorDataType Data type of derotate factor
        %   Specify the derotate factor fixed-point data type as one of
        %   [{'Same word length as input'} | 'Custom']. This
        %   property applies when you set the BitOutput property to false, or when
        %   you set the BitOutput property to true and the DecisionMethod property
        %   to 'Hard decision'. The object uses the derotate factor in the
        %   computations only when the step method input is of a fixed-point type,
        %   and the PhaseOffset property has a value that is not a multiple of
        %   pi/2.
        DerotateFactorDataType;

        %FullPrecisionOverride Full precision override for fixed-point arithmetic
        %   Specify whether to use full precision rules. If you set
        %   FullPrecisionOverride to true the object computes all
        %   internal arithmetic and output data types using full
        %   precision rules. These rules guarantee that no quantization
        %   occurs within the object. Bits are added as needed to ensure
        %   that no round-off or overflow occurs. If you set
        %   FullPrecisionOverride to false, fixed-point data types
        %   are controlled through individual property settings.
        FullPrecisionOverride;

        %MinimumDistance Minimum distance between symbols
        %   Specify the distance between two nearest constellation points as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Minimum distance between symbols'.
        %   The default is 2.
        MinimumDistance;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as scalar
        %   that is a positive, integer power of two. The default is 16.
        ModulationOrder;

        %NormalizationMethod Constellation normalization method
        %   Specify the method used to normalize the signal constellation as one
        %   of 'Minimum distance between symbols' | 'Average power' | 'Peak
        %   power'. The default is 'Minimum distance between symbols'.
        NormalizationMethod;

        %PeakPower Peak power of constellation
        %   Specify the maximum power of the symbols in the constellation as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Peak power'. The default is 1.
        PeakPower;

        %PhaseOffset Phase offset of constellation
        %   Specify the phase offset of the signal constellation, in radians, as a
        %   real scalar. The default is 0.
        PhaseOffset;

        %ProductDataType Data type of product
        %   Specify the product fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property is
        %   applicable when the FullPrecisionOverride property is false, and also
        %   either when the BitOutput property is false, or when the BitOutput
        %   property is true and the DecisionMethod property is 'Hard decision'.
        ProductDataType;

        %ProductOverflowAction Action when fixed-point numeric value of product overflows
        %   Specify the product overflow action as one of [{'Wrap'} |
        %   'Saturate']. This property is applicable when the object is not in a
        %   full precision configuration and also when either the BitOutput property
        %   is false, or when the BitOutput property is true and the
        %   DecisionMethod property setting is 'Hard decision'.
        ProductOverflowAction;

        %ProductRoundingMethod Rounding of fixed-point numeric value of product
        %   Specify the product rounding method as one of ['Ceiling' |
        %   'Convergent' | {'Floor'} | 'Nearest' | 'Round' | 'Simplest' |
        %   'Zero']. This property is applicable when the object is not in a full
        %   precision configuration and also when either the BitOutput property
        %   is false, or when the BitOutput property is true and the
        %   DecisionMethod property setting is 'Hard decision'.
        ProductRoundingMethod;

        %SumDataType Data type of sum
        %   Specify the sum fixed-point data type as one of [{'Full precision'} |
        %   'Same as product' | 'Custom']. This property is applicable when the
        %   FullPrecisionOverride property is false and also when either the
        %   BitOutput property is false, or when the BitOutput property is true
        %   and the DecisionMethod property setting is 'Hard decision'.
        SumDataType;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) bits to the corresponding symbol as one of
        %   'Binary' | 'Gray' | 'Custom'. The default is 'Gray'. When you set this
        %   property to 'Gray', the object uses a Gray-coded signal constellation.
        %   When you set this property to 'Binary', the object uses a natural
        %   binary-coded constellation. When you set this property to 'Custom',
        %   the object uses the signal constellation defined in the
        %   CustomSymbolMapping property.
        SymbolMapping;

        %VarianceSource Source of noise variance
        %   Specify the source of the noise variance as one of 'Property' | 'Input
        %   port'. The default is 'Property'. This property applies when you set
        %   the BitOutput property to true and the DecisionMethod property to
        %   'Log-likelihood ratio' or 'Approximate log-likelihood ratio'.
        VarianceSource;

    end
end
