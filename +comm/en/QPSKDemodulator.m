classdef QPSKDemodulator< handle
%QPSKDemodulator Demodulate using QPSK method
%   H = comm.QPSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the quadrature phase shift
%   keying (QPSK) method.
%
%   H = comm.QPSKDemodulator(Name,Value) creates a QPSK demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.QPSKDemodulator(PHASE,Name,Value) creates a QPSK demodulator
%   object, H, with the PhaseOffset property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the QPSK demodulator
%   System object, H, and returns Y. Input X must be a scalar or a column
%   vector with double or single precision data type. When you set BitOutput
%   to false or you set BitOutput to true and DecisionMethod to 'Hard
%   decision', the data type of the input can also be signed integer, or
%   signed fixed point (fi objects). Depending on the BitOutput property
%   value, output Y can be integer or bit valued.
%
%   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
%   VAR. This syntax applies when you set the BitOutput property to true,
%   the DecisionMethod property to 'Approximate log-likelihood ratio' or
%   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
%   The data type of input VAR must be double or single precision.
%
%   QPSKDemodulator methods:
%
%   step     - Demodulate input using QPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create QPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   QPSKDemodulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation
%   BitOutput      - Output data as bits
%   SymbolMapping  - Constellation encoding
%   DecisionMethod - Demodulation decision method
%   VarianceSource - Source of noise variance
%   Variance       - Noise variance
%   OutputDataType - Data type of output
%
%   The QPSKDemodulator object supports fixed-point operations. For more
%   information, type comm.QPSKDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate a signal using QPSK modulation
%
%   hMod = comm.QPSKModulator('PhaseOffset',pi/4);
%   hAWGN = comm.AWGNChannel('NoiseMethod',...
%                        'Signal to noise ratio (SNR)','SNR',15);
%   hDemod = comm.QPSKDemodulator('PhaseOffset',pi/4);
%   %Create an error rate calculator
%   hError = comm.ErrorRate;
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 3],50,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.QPSKModulator, comm.PSKDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=QPSKDemodulator
            %QPSKDemodulator Demodulate using QPSK method
            %   H = comm.QPSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the quadrature phase shift
            %   keying (QPSK) method.
            %
            %   H = comm.QPSKDemodulator(Name,Value) creates a QPSK demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.QPSKDemodulator(PHASE,Name,Value) creates a QPSK demodulator
            %   object, H, with the PhaseOffset property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the QPSK demodulator
            %   System object, H, and returns Y. Input X must be a scalar or a column
            %   vector with double or single precision data type. When you set BitOutput
            %   to false or you set BitOutput to true and DecisionMethod to 'Hard
            %   decision', the data type of the input can also be signed integer, or
            %   signed fixed point (fi objects). Depending on the BitOutput property
            %   value, output Y can be integer or bit valued.
            %
            %   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
            %   VAR. This syntax applies when you set the BitOutput property to true,
            %   the DecisionMethod property to 'Approximate log-likelihood ratio' or
            %   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
            %   The data type of input VAR must be double or single precision.
            %
            %   QPSKDemodulator methods:
            %
            %   step     - Demodulate input using QPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create QPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   QPSKDemodulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation
            %   BitOutput      - Output data as bits
            %   SymbolMapping  - Constellation encoding
            %   DecisionMethod - Demodulation decision method
            %   VarianceSource - Source of noise variance
            %   Variance       - Noise variance
            %   OutputDataType - Data type of output
            %
            %   The QPSKDemodulator object supports fixed-point operations. For more
            %   information, type comm.QPSKDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using QPSK modulation
            %
            %   hMod = comm.QPSKModulator('PhaseOffset',pi/4);
            %   hAWGN = comm.AWGNChannel('NoiseMethod',...
            %                        'Signal to noise ratio (SNR)','SNR',15);
            %   hDemod = comm.QPSKDemodulator('PhaseOffset',pi/4);
            %   %Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 3],50,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.QPSKModulator, comm.PSKDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.QPSKDemodulator System object fixed-point
            %               information
            %   comm.QPSKDemodulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.QPSKDemodulator
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true, the step method
        %   outputs a column vector of bit values with length equal to twice the
        %   number of demodulated symbols. When you set this property to false,
        %   the step method outputs a column vector, of length equal to the input
        %   data vector, that contains integer symbol values between 0 and 3. The
        %   default is false.
        BitOutput;

        %CustomDerotateFactorDataType Fixed-point data type of derotate factor
        %   Specify the derotate factor fixed-point type as an unscaled
        %   numerictype object with a Signedness of Auto. This property applies
        %   when you set the DerotateFactorDataType property to 'Custom'. The
        %   default is numerictype([],16). 
        %
        %   See also numerictype.
        CustomDerotateFactorDataType;

        %DecisionMethod Demodulation decision method
        %   Specify the decision method the object uses as one of 'Hard decision'
        %   | 'Log-likelihood ratio' | 'Approximate log-likelihood ratio'. The
        %   default is 'Hard decision'. When the BitOutput property is false the
        %   object always performs hard decision demodulation. This property
        %   applies when you set the BitOutput property to true.
        DecisionMethod;

        %DerotateFactorDataType Data type of derotate factor
        %   Specify derotate factor data type as one of 'Same word length as
        %   input' | 'Custom'. The default is 'Same word length as input'. This
        %   property applies when you set the BitOutput property to false, or when
        %   you set the BitOutput property to true and the DecisionMethod property
        %   to 'Hard decision'. The object uses the derotate factor in the
        %   computations only when the step method input is of a fixed-point type,
        %   and the PhaseOffset property has a value that is not an even multiple
        %   of pi/4.
        DerotateFactorDataType;

        %PhaseOffset Phase of zeroth point of constellation
        %   Specify the phase offset of the zeroth point of the constellation, in
        %   radians, as a real scalar. The default is pi/4.
        PhaseOffset;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of 2 bits to the
        %   corresponding symbol as one of 'Binary' | 'Gray'. The default is
        %   'Gray'. When you set this property to 'Gray', the object uses a
        %   Gray-encoded signal constellation. When you set this property to
        %   'Binary', the integer m (0 <= m <= 3) maps to the complex value
        %   exp(j*PhaseOffset + j*2*pi*m/4).
        SymbolMapping;

        %VarianceSource Source of noise variance
        %   Specify the source of the noise variance as one of 'Property' | 'Input
        %   port'. The default is 'Property'. This property applies when you set
        %   the BitOutput property to true and the DecisionMethod property to
        %   'Log-likelihood ratio' or 'Approximate log-likelihood ratio'.
        VarianceSource;

    end
end
