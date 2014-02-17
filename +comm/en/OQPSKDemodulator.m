classdef OQPSKDemodulator< handle
%OQPSKDemodulator Demodulate using OQPSK method
%   H = comm.OQPSKDemodulator creates a demodulator System object, H, that
%   demodulates the input signal using the offset quadrature phase shift
%   keying (OQPSK) method.
%
%   H = comm.OQPSKDemodulator(Name,Value) creates an OQPSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.OQPSKDemodulator(PHASE,Name,Value) creates an OQPSK demodulator
%   object, H, with the PhaseOffset property set to PHASE and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates data, X, with the OQPSK demodulator object, H,
%   and returns Y. Input X must be a double, single, or signed fixed-point
%   data type scalar or column vector. The object produces one output symbol
%   for each pair of input samples. When used with the OQPSK modulator
%   object, the step method output has a one symbol delay as compared to the
%   input of the modulator. Depending on the BitOutput property value,
%   output Y can be integer or bit valued.
%
%   OQPSKDemodulator methods:
%
%   step     - Demodulate input using OQPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create OQPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset demodulator state 
%   constellation - Ideal signal constellation 
%
%   OQPSKDemodulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation from pi/4
%   BitOutput      - Output data as bits
%   OutputDataType - Data type of output
%
%   The OQPSKDemodulator object supports fixed-point operations. For more
%   information, type comm.OQPSKDemodulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate and demodulate a signal using OQPSK modulation with a 
%   %   constellation with pi/8 radians of phase offset
%
%   hMod = comm.OQPSKModulator(pi/8);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)','SNR',6);
%   hDemod = comm.OQPSKDemodulator(pi/8);
%   % Create an error rate calculator, account for the one symbol delay
%   hError = comm.ErrorRate('ReceiveDelay',1);
%   for counter = 1:100
%     % Transmit a 50-symbol frame
%     data = randi([0 3],50,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.OQPSKModulator, comm.QPSKDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=OQPSKDemodulator
            %OQPSKDemodulator Demodulate using OQPSK method
            %   H = comm.OQPSKDemodulator creates a demodulator System object, H, that
            %   demodulates the input signal using the offset quadrature phase shift
            %   keying (OQPSK) method.
            %
            %   H = comm.OQPSKDemodulator(Name,Value) creates an OQPSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.OQPSKDemodulator(PHASE,Name,Value) creates an OQPSK demodulator
            %   object, H, with the PhaseOffset property set to PHASE and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates data, X, with the OQPSK demodulator object, H,
            %   and returns Y. Input X must be a double, single, or signed fixed-point
            %   data type scalar or column vector. The object produces one output symbol
            %   for each pair of input samples. When used with the OQPSK modulator
            %   object, the step method output has a one symbol delay as compared to the
            %   input of the modulator. Depending on the BitOutput property value,
            %   output Y can be integer or bit valued.
            %
            %   OQPSKDemodulator methods:
            %
            %   step     - Demodulate input using OQPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create OQPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset demodulator state 
            %   constellation - Ideal signal constellation 
            %
            %   OQPSKDemodulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation from pi/4
            %   BitOutput      - Output data as bits
            %   OutputDataType - Data type of output
            %
            %   The OQPSKDemodulator object supports fixed-point operations. For more
            %   information, type comm.OQPSKDemodulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using OQPSK modulation with a 
            %   %   constellation with pi/8 radians of phase offset
            %
            %   hMod = comm.OQPSKModulator(pi/8);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)','SNR',6);
            %   hDemod = comm.OQPSKDemodulator(pi/8);
            %   % Create an error rate calculator, account for the one symbol delay
            %   hError = comm.ErrorRate('ReceiveDelay',1);
            %   for counter = 1:100
            %     % Transmit a 50-symbol frame
            %     data = randi([0 3],50,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.OQPSKModulator, comm.QPSKDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.OQPSKDemodulator System object 
            %               fixed-point information
            %   comm.OQPSKDemodulator.helpFixedPoint displays information
            %   about fixed-point properties and operations of the
            %   comm.OQPSKDemodulator System object.
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
        %AccumulatorDataType Data type of accumulator
        %   Specify AccumulatorMode as one of 'Full precision' | 'Same as input'
        %   | 'Custom'. The default is 'Full precision'.
        AccumulatorDataType;

        %AccumulatorOverflowAction Action when fixed-point numeric value of
        %                          accumulator overflows
        %   Specify the accumulator overflow action as one of 'Wrap' | 'Saturate'.
        %   The default is 'Wrap'.
        AccumulatorOverflowAction;

        %AccumulatorRoundingMethod Rounding of fixed-point numeric value of
        %                          accumulator
        %   Specify the accumulator rounding method as one of 'Ceiling' |
        %   'Convergent' | 'Floor' | 'Nearest' | 'Round' | 'Simplest' | 'Zero'.
        %   The default is 'Floor'.
        AccumulatorRoundingMethod;

        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   values. When you set this property to true the step method outputs a
        %   column vector of bit values with length equal to twice the number of
        %   demodulated symbols. When you set this property to false, the step
        %   method outputs a column vector. The length of this vector equals to
        %   the number of demodulated symbols that contain integer values between
        %   0 and 3. The object produces one output demodulated symbol for each
        %   pair of input samples. The default is false.
        BitOutput;

        %CustomAccumulatorDataType Fixed-point data type of accumulator
        %   Specify the accumulator output fixed-point type as a scaled
        %   numerictype object with a Signedness of Auto. This property applies
        %   when you set the AccumulatorDataType property to 'Custom'. The default
        %   is numerictype([],32,15).
        %
        %   See also numerictype.  
        CustomAccumulatorDataType;

        %CustomDerotateFactorDataType fixed-point data type of derotate factor 
        %   Specify the derotate factor fixed-point type as an unscaled
        %   numerictype object with a Signedness of Auto. This property applies
        %   when you set the DerotateFactorDataType property to 'Custom'. The
        %   default is numerictype([],16).
        %
        %   See also numerictype.
        CustomDerotateFactorDataType;

        %CustomMappingDataType Fixed-point data type of mapping
        %   Specify the mapping fixed-point type as a scaled numerictype object
        %   with a Signedness of Auto. This property applies when you set the
        %   MappingDataType property to 'Custom'. The default is
        %   numerictype([],32,15).
        %
        %   See also numerictype.  
        CustomMappingDataType;

        %DerotateFactorDataType Data type of derotate factor
        %   Specify derotate factor data type as one of 'Same word length as
        %   input' | 'Custom'. The default is 'Same word length as input'. The
        %   object uses the derotate factor in the computations only when the step
        %   method input is of a fixed-point type, and the PhaseOffset property
        %   has a value that is not a multiple of pi/2.
        DerotateFactorDataType;

        %MappingDataType Data type of mapping
        %   Specify the mapping data type as one of 'Same as accumulator' |
        %   'Custom'. The default is 'Same as accumulator'.
        MappingDataType;

        %PhaseOffset Phase of zeroth point of constellation from pi/4
        %   Specify the phase offset of the zeroth point of the constellation
        %   shifted from pi/4, in radians, as a finite, real valued scalar. The
        %   default is 0.
        PhaseOffset;

    end
end
