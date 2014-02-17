classdef PSKDemodulator< handle
%PSKDemodulator M-ary PSK Demodulator (GPU)
%   H = comm.gpu.PSKDemodulator returns a GPU-based demodulator System
%   object, H. This object demodulates the input signal using the M-ary
%   phase shift keying (M-PSK) method.
% 
%   Use of this object requires a Parallel Computing Toolbox license.
%
%   H = comm.gpu.PSKDemodulator(Name,Value) creates an M-PSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.PSKDemodulator(M,PHASE,Name,Value) creates an M-PSK
%   demodulator object, H, with the ModulationOrder property set to M, the
%   PhaseOffset property set to PHASE and other specified property Names
%   set to the specified Values. M and PHASE are value-only arguments. To
%   specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates data, X, with the PSK demodulator System
%   object, H, and returns Y. Input X must be a scalar or a column vector
%   with double or single precision data type. Depending on the BitOutput
%   property value, output Y can be integer or bit valued.
%
%   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
%   VAR. This syntax applies when you set the BitOutput property to true,
%   the DecisionMethod property to 'Approximate log-likelihood ratio' or
%   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
%   The data type of input VAR must be double or single precision.
%
%   comm.gpu.PSKDemodulator methods:
%
%   step     - Demodulate input using M-PSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation
%
%   comm.gpu.PSKDemodulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   PhaseOffset         - Phase of the zeroth point of constellation
%   BitOutput           - Output data as bits
%   SymbolMapping       - Constellation encoding
%   CustomSymbolMapping - Custom constellation encoding
%   DecisionMethod      - Demodulation decision method
%   VarianceSource      - Source of noise variance
%   Variance            - Noise variance
%   OutputDataType      - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using 16-PSK modulation
%  
%   hMod = comm.gpu.PSKModulator(16, 'PhaseOffset',pi/16);
%   hAWGN = comm.gpu.AWGNChannel('NoiseMethod', ...
%                          'Signal to noise ratio (SNR)','SNR',15);
%   hDemod = comm.gpu.PSKDemodulator(16, 'PhaseOffset',pi/16);
%   %Create an error rate calculator
%   hError = comm.ErrorRate;
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = gpuArray.randi([0 hMod.ModulationOrder-1], 50, 1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, gather(data), gather(receivedData));
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.gpu.PSKModulator, comm.PSKDemodulator.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=PSKDemodulator
            %PSKDemodulator M-ary PSK Demodulator (GPU)
            %   H = comm.gpu.PSKDemodulator returns a GPU-based demodulator System
            %   object, H. This object demodulates the input signal using the M-ary
            %   phase shift keying (M-PSK) method.
            % 
            %   Use of this object requires a Parallel Computing Toolbox license.
            %
            %   H = comm.gpu.PSKDemodulator(Name,Value) creates an M-PSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.PSKDemodulator(M,PHASE,Name,Value) creates an M-PSK
            %   demodulator object, H, with the ModulationOrder property set to M, the
            %   PhaseOffset property set to PHASE and other specified property Names
            %   set to the specified Values. M and PHASE are value-only arguments. To
            %   specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates data, X, with the PSK demodulator System
            %   object, H, and returns Y. Input X must be a scalar or a column vector
            %   with double or single precision data type. Depending on the BitOutput
            %   property value, output Y can be integer or bit valued.
            %
            %   Y = step(H,X,VAR) uses soft decision demodulation and noise variance
            %   VAR. This syntax applies when you set the BitOutput property to true,
            %   the DecisionMethod property to 'Approximate log-likelihood ratio' or
            %   'Log-likelihood ratio', and the VarianceSource property to 'Input port'.
            %   The data type of input VAR must be double or single precision.
            %
            %   comm.gpu.PSKDemodulator methods:
            %
            %   step     - Demodulate input using M-PSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation
            %
            %   comm.gpu.PSKDemodulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   PhaseOffset         - Phase of the zeroth point of constellation
            %   BitOutput           - Output data as bits
            %   SymbolMapping       - Constellation encoding
            %   CustomSymbolMapping - Custom constellation encoding
            %   DecisionMethod      - Demodulation decision method
            %   VarianceSource      - Source of noise variance
            %   Variance            - Noise variance
            %   OutputDataType      - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using 16-PSK modulation
            %  
            %   hMod = comm.gpu.PSKModulator(16, 'PhaseOffset',pi/16);
            %   hAWGN = comm.gpu.AWGNChannel('NoiseMethod', ...
            %                          'Signal to noise ratio (SNR)','SNR',15);
            %   hDemod = comm.gpu.PSKDemodulator(16, 'PhaseOffset',pi/16);
            %   %Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = gpuArray.randi([0 hMod.ModulationOrder-1], 50, 1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, gather(data), gather(receivedData));
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.gpu.PSKModulator, comm.PSKDemodulator.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function hardDecisionBit(in) %#ok<MANU>
        end

        function hardDecisionInt(in) %#ok<MANU>
            % use no mapping
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setupGPUImpl(in) %#ok<MANU>
        end

        function softDecisionApprox(in) %#ok<MANU>
        end

        function softDecisionExact(in) %#ok<MANU>
        end

        function stepGPUImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true, the step method
        %   outputs a column vector of bit values with length equal to
        %   log2(ModulationOrder) times the number of demodulated symbols. When
        %   you set this property to false, the step method outputs a column
        %   vector, of length equal to the input data vector, that contains
        %   integer symbol values between 0 and ModulationOrder-1. The default is
        %   false.
        BitOutput;

        %CustomSymbolMapping Custom constellation encoding
        %   Specify a custom constellation symbol mapping vector. This property
        %   must be a row or column vector of size ModulationOrder with unique
        %   integer values in the range [0, ModulationOrder-1]. The values must
        %   be of data type double. The first element of this vector corresponds
        %   to the constellation point at an angle of 0 + PhaseOffset, with
        %   subsequent elements running counterclockwise. The last element
        %   corresponds to the constellation point at an angle of
        %   -pi/ModulationOrder + PhaseOffset. This property applies when you set
        %   the SymbolMapping property to 'Custom'. The default is 0:7.
        CustomSymbolMapping;

        %DecisionMethod Demodulation decision method
        %   Specify the decision method the object uses as one of 'Hard decision'
        %   | 'Log-likelihood ratio' | 'Approximate log-likelihood ratio'. The
        %   default is 'Hard decision'. When the BitOutput property is false the
        %   object always performs hard decision demodulation. This property
        %   applies when you set the BitOutput property to true.
        DecisionMethod;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. The default is 8.
        ModulationOrder;

        %OutputDataType Data type of output
        %   The only valid setting is 'Full precision', which makes the output
        %   data type match the input data type.
        OutputDataType;

        %PhaseOffset Phase of zeroth point of constellation
        %   Specify the phase offset of the zeroth point of the constellation, in
        %   radians, as a real scalar. The default is pi/8.
        PhaseOffset;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) bits to the corresponding symbol as one of
        %   'Binary' | 'Gray' | 'Custom'. The default is 'Gray'. When you set
        %   this property to 'Gray', the object uses a Gray-encoded signal
        %   constellation. When you set this property to 'Binary', the integer m
        %   (0 <= m <= ModulationOrder-1) maps to the complex value
        %   exp(j*PhaseOffset + j*2*pi*m/ModulationOrder). When you set this
        %   property to 'Custom', the object uses the signal constellation
        %   defined in the CustomSymbolMapping property.
        SymbolMapping;

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

        %VarianceSource Source of noise variance
        %   Specify the source of the noise variance as one of 'Property' |
        %   'Input port'. The default is 'Property'. This property applies when
        %   you set the BitOutput property to true and the DecisionMethod
        %   property to 'Log-likelihood ratio' or 'Approximate log-likelihood
        %   ratio'.
        VarianceSource;

    end
end
