classdef PAMDemodulator< handle
%PAMDemodulator Demodulate using M-ary PAM method
%   H = comm.PAMDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the M-ary pulse amplitude
%   modulation (M-PAM) method.
%
%   H = comm.PAMDemodulator(Name,Value) creates an M-PAM demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PAMDemodulator(M,Name,Value) creates an M-PAM demodulator
%   object, H, with the ModulationOrder property set to M and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates data, X, with the M-PAM demodulator System
%   object, H, and returns Y. Input X must be a scalar or column vector. The
%   data type of the input can be double or single precision, signed
%   integer, or signed fixed point (fi objects). Depending on the BitOutput
%   property value, output Y can be integer or bit valued.
%
%   PAMDemodulator methods:
%
%   step     - Demodulate input using M-PAM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create M-PAM demodulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   PAMDemodulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   BitOutput           - Output data as bits
%   SymbolMapping       - Constellation encoding
%   NormalizationMethod - Constellation normalization method
%   MinimumDistance     - Minimum distance between symbols
%   AveragePower        - Average power of constellation
%   PeakPower           - Peak power of constellation
%   OutputDataType      - Data type of output
%
%   Fixed-point property information:
%
%   The PAMDemodulator object supports fixed-point operations. For more
%   information, type comm.PAMDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate a signal using 16-PAM modulation
%
%   hMod = comm.PAMModulator(16);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)', ...
%                   'SNR',20, 'SignalPower', 85);
%   hDemod = comm.PAMDemodulator(16);
%   %Create an error rate calculator
%   hError = comm.ErrorRate;
%   for counter = 1:100
%     % Transmit a 50-symbol frame
%     data = randi([0 hMod.ModulationOrder-1],50,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.PAMModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PAMDemodulator
            %PAMDemodulator Demodulate using M-ary PAM method
            %   H = comm.PAMDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the M-ary pulse amplitude
            %   modulation (M-PAM) method.
            %
            %   H = comm.PAMDemodulator(Name,Value) creates an M-PAM demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PAMDemodulator(M,Name,Value) creates an M-PAM demodulator
            %   object, H, with the ModulationOrder property set to M and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates data, X, with the M-PAM demodulator System
            %   object, H, and returns Y. Input X must be a scalar or column vector. The
            %   data type of the input can be double or single precision, signed
            %   integer, or signed fixed point (fi objects). Depending on the BitOutput
            %   property value, output Y can be integer or bit valued.
            %
            %   PAMDemodulator methods:
            %
            %   step     - Demodulate input using M-PAM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create M-PAM demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   PAMDemodulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   BitOutput           - Output data as bits
            %   SymbolMapping       - Constellation encoding
            %   NormalizationMethod - Constellation normalization method
            %   MinimumDistance     - Minimum distance between symbols
            %   AveragePower        - Average power of constellation
            %   PeakPower           - Peak power of constellation
            %   OutputDataType      - Data type of output
            %
            %   Fixed-point property information:
            %
            %   The PAMDemodulator object supports fixed-point operations. For more
            %   information, type comm.PAMDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using 16-PAM modulation
            %
            %   hMod = comm.PAMModulator(16);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)', ...
            %                   'SNR',20, 'SignalPower', 85);
            %   hDemod = comm.PAMDemodulator(16);
            %   %Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for counter = 1:100
            %     % Transmit a 50-symbol frame
            %     data = randi([0 hMod.ModulationOrder-1],50,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.PAMModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.PAMDemodulator System object 
            %               fixed-point information
            %   comm.PAMDemodulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.PAMDemodulator
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is connected to the input if the OutputDataType
            % property is set to 'Full precision' and the input is floating-point
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

        %DenormalizationFactorDataType Data type of denormalization factor
        %   Specify the denormalization factor fixed-point data type as one of
        %   [{'Same word length as input'} | 'Custom'].
        DenormalizationFactorDataType;

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
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. When you set the BitOutput property to
        %   false, ModulationOrder must be even. When you set the BitOutput
        %   property to true, ModulationOrder must be an integer power of two. The
        %   default is 4.
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

        %ProductDataType Data type of product
        %   Specify the product fixed-point data type as one of [{'Full
        %   precision'} | 'Custom']. This property is
        %   applicable when the FullPrecisionOverride property is false.
        ProductDataType;

        %ProductOverflowAction Action when fixed-point numeric value of product overflows
        %   Specify the product overflow action as one of [{'Wrap'} |
        %   'Saturate']. This property is applicable when the object is not in a
        %   full precision configuration.
        ProductOverflowAction;

        %ProductRoundingMethod Rounding of fixed-point numeric value of product
        %   Specify the product rounding method as one of ['Ceiling' |
        %   'Convergent' | {'Floor'} | 'Nearest' | 'Round' | 'Simplest' |
        %   'Zero']. This property is applicable when the object is not in a full
        %   precision configuration.
        ProductRoundingMethod;

        %SumDataType Data type of sum
        %   Specify the sum fixed-point data type as one of [{'Full precision'} |
        %   'Same as product' | 'Custom']. This property is applicable when the
        %   FullPrecisionOverride property is false.
        SumDataType;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) bits to the corresponding symbol as one of
        %   'Binary' | 'Gray'. The default is 'Gray'. When you set this property
        %   to 'Gray', the object uses a Gray-encoded signal constellation. When
        %   you set this property to 'Binary', the integer m (0 <= m <=
        %   ModulationOrder-1) maps to the complex value 2m-ModulationOrder+1.
        SymbolMapping;

    end
end
