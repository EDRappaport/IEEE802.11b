classdef MSKModulator< handle
%MSKModulator Modulate using MSK method
%   H = comm.MSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the minimum shift keying (MSK)
%   modulation method.
%
%   H = comm.MSKModulator(Name,Value) creates an MSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the MSK modulator object, H.
%   It returns the baseband modulated output, Y. Depending on the value of
%   the BitInput property, input X can be a double precision, signed
%   integer, or logical column vector. The length of output vector, Y, is
%   equal to the number of input samples times the number of samples per
%   symbol you specify in the SamplesPerSymbol property.
%
%   MSKModulator methods:
%
%   step     - Modulate using MSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create MSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the MSK modulator object
%
%   MSKModulator properties:
%
%   BitInput           - Assume bit inputs
%   InitialPhaseOffset - Initial phase offset
%   SamplesPerSymbol   - Number of samples per output symbol
%   OutputDataType     - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using MSK modulation with bit 
%   %   inputs and an initial phase offset of pi/4
%
%   hMod = comm.MSKModulator('BitInput', true, ...
%                   'InitialPhaseOffset', pi/4);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)','SNR',0);
%   hDemod = comm.MSKDemodulator('BitOutput', true, ...
%                   'InitialPhaseOffset', pi/4);
%   % Create an error rate calculator, account for the delay caused by
%   % the Viterbi algorithm
%   hError = comm.ErrorRate('ReceiveDelay', hDemod.TracebackDepth);
%   for counter = 1:100
%     % Transmit 100 3-bit words
%     data = randi([0 1],300,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.MSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MSKModulator
            %MSKModulator Modulate using MSK method
            %   H = comm.MSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the minimum shift keying (MSK)
            %   modulation method.
            %
            %   H = comm.MSKModulator(Name,Value) creates an MSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the MSK modulator object, H.
            %   It returns the baseband modulated output, Y. Depending on the value of
            %   the BitInput property, input X can be a double precision, signed
            %   integer, or logical column vector. The length of output vector, Y, is
            %   equal to the number of input samples times the number of samples per
            %   symbol you specify in the SamplesPerSymbol property.
            %
            %   MSKModulator methods:
            %
            %   step     - Modulate using MSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create MSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the MSK modulator object
            %
            %   MSKModulator properties:
            %
            %   BitInput           - Assume bit inputs
            %   InitialPhaseOffset - Initial phase offset
            %   SamplesPerSymbol   - Number of samples per output symbol
            %   OutputDataType     - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using MSK modulation with bit 
            %   %   inputs and an initial phase offset of pi/4
            %
            %   hMod = comm.MSKModulator('BitInput', true, ...
            %                   'InitialPhaseOffset', pi/4);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)','SNR',0);
            %   hDemod = comm.MSKDemodulator('BitOutput', true, ...
            %                   'InitialPhaseOffset', pi/4);
            %   % Create an error rate calculator, account for the delay caused by
            %   % the Viterbi algorithm
            %   hError = comm.ErrorRate('ReceiveDelay', hDemod.TracebackDepth);
            %   for counter = 1:100
            %     % Transmit 100 3-bit words
            %     data = randi([0 1],300,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.MSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. When you set the
        %   BitInput property to false, the step method input must be a double
        %   precision or signed integer data type column vector of values equal to
        %   -1 or 1. When you set the BitInput property to true, the step method
        %   input must be double precision or logical data type column vector of
        %   0's and 1's. The default is false.
        BitInput;

    end
end
