classdef BPSKDemodulator< handle
%BPSKDemodulator Demodulate using BPSK method
%   H = comm.BPSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the binary phase shift keying
%   (BPSK) method.
%
%   H = comm.BPSKDemodulator(Name,Value) creates a BPSK demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.BPSKDemodulator(PHASE,Name,Value) creates a BPSK demodulator
%   object, H, with the PhaseOffset property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the BPSK demodulator
%   System object, H, and returns Y. Input X must be a scalar or a column
%   vector with double or single precision data type. When you set the
%   DecisionMethod property to 'Hard decision', the data type of the input
%   can also be signed integer, or signed fixed point (fi objects).
%
%   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
%   VAR. This syntax applies when you set the DecisionMethod property to
%   'Log-likelihood ratio' or 'Approximate log-likelihood ratio' and the
%   VarianceSource property to 'Input port'. The data type of input VAR
%   must be double or single precision.
%
%   BPSKDemodulator methods:
%
%   step     - Demodulate input using BPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create BPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   BPSKDemodulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation
%   DecisionMethod - Demodulation decision method
%   VarianceSource - Source of noise variance
%   Variance       - Noise variance
%   OutputDataType - Data type of output
%
%   The BPSKDemodulator object supports fixed-point operations. For more
%   information, type comm.BPSKDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate a signal using BPSK modulation
%
%   hMod = comm.BPSKModulator('PhaseOffset',pi/2);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',15);
%   hDemod = comm.BPSKDemodulator('PhaseOffset',pi/2);
%   % Create an error rate calculator
%   hError = comm.ErrorRate;
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 1],50,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.BPSKModulator, comm.PSKDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=BPSKDemodulator
            %BPSKDemodulator Demodulate using BPSK method
            %   H = comm.BPSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the binary phase shift keying
            %   (BPSK) method.
            %
            %   H = comm.BPSKDemodulator(Name,Value) creates a BPSK demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.BPSKDemodulator(PHASE,Name,Value) creates a BPSK demodulator
            %   object, H, with the PhaseOffset property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the BPSK demodulator
            %   System object, H, and returns Y. Input X must be a scalar or a column
            %   vector with double or single precision data type. When you set the
            %   DecisionMethod property to 'Hard decision', the data type of the input
            %   can also be signed integer, or signed fixed point (fi objects).
            %
            %   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
            %   VAR. This syntax applies when you set the DecisionMethod property to
            %   'Log-likelihood ratio' or 'Approximate log-likelihood ratio' and the
            %   VarianceSource property to 'Input port'. The data type of input VAR
            %   must be double or single precision.
            %
            %   BPSKDemodulator methods:
            %
            %   step     - Demodulate input using BPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create BPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   BPSKDemodulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation
            %   DecisionMethod - Demodulation decision method
            %   VarianceSource - Source of noise variance
            %   Variance       - Noise variance
            %   OutputDataType - Data type of output
            %
            %   The BPSKDemodulator object supports fixed-point operations. For more
            %   information, type comm.BPSKDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using BPSK modulation
            %
            %   hMod = comm.BPSKModulator('PhaseOffset',pi/2);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',15);
            %   hDemod = comm.BPSKDemodulator('PhaseOffset',pi/2);
            %   % Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 1],50,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.BPSKModulator, comm.PSKDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.BPSKDemodulator System object fixed-point
            %               information
            %   comm.BPSKDemodulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.BPSKDemodulator
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is always the same as that of the input is the
            % DecisionMethod property is not set to 'Hard decision'. It is also
            % connected to the input if the OutputDataType property is set to
            % 'Full precision' and the input is floating-point
        end

    end
    methods (Abstract)
    end
    properties
        %CustomDerotateFactorDataType Fixed-point data type of derotate factor
        %   Specify the derotate factor fixed-point type as an unscaled,
        %   numerictype object with a Signedness of Auto. This property applies
        %   when you set the DecisionMethod property to 'Hard decision' and the
        %   DerotateFactorDataType property to 'Custom'. The default is
        %   numerictype([],16).
        %
        %   See also numerictype.
        CustomDerotateFactorDataType;

        %DecisionMethod Demodulation decision method
        %   Specify the decision method the object uses as one of 'Hard decision'
        %   | 'Log-likelihood ratio' | 'Approximate log-likelihood ratio'. The
        %   default is 'Hard decision'.
        DecisionMethod;

        %DerotateFactorDataType Data type of derotate factor
        %   Specify the derotate factor data type as one of 'Same word length as
        %   input' | 'Custom'. The default is 'Same word length as input'. This
        %   property applies when you set the DecisionMethod property to 'Hard
        %   decision'. The object uses the derotate factor in the computations
        %   only when the step method input is of a fixed-point type, and the
        %   PhaseOffset property has a value that is not a multiple of pi/2.
        DerotateFactorDataType;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Full precision' | 'Smallest
        %   unsigned integer' | 'double' | 'single' | 'int8' | 'uint8' | 'int16'
        %   | 'uint16' | 'int32' | 'uint32' | 'logical'. The default is 'Full
        %   precision'. This property applies only when you set the
        %   DecisionMethod property to 'Hard decision'. In this case, when you
        %   set the OutputDataType property to 'Full precision', the output data
        %   type is the same as that of the input when the input data type is
        %   single or double precision. If the input data is of a fixed-point
        %   type, then the output data type works as if you had set the
        %   OutputDataType property to 'Smallest unsigned integer'. Note that for
        %   integer data type inputs, a Fixed-Point Designer license is required
        %   when this property is set to 'Smallest unsigned integer' or 'Full
        %   precision'.
        %
        %   If you set the DecisionMethod property to 'Log-likelihood ratio' or
        %   'Approximate log-likelihood ratio', the output data type is the same
        %   as that of the input which, in this case, can only be single or
        %   double precision.
        OutputDataType;

        %PhaseOffset Phase of zeroth point of constellation
        %   Specify the phase offset of the zeroth point of the constellation, in
        %   radians, as a finite, real scalar. The default is 0.
        PhaseOffset;

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
        %   Specify the source of the noise variance as one of 'Property' |
        %   'Input port'. The default is 'Property'. This property applies when
        %   you set the DecisionMethod property to 'Log-likelihood ratio' or
        %   'Approximate log-likelihood ratio'.
        VarianceSource;

    end
end
