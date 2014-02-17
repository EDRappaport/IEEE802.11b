classdef MSKDemodulator< handle
%MSKDemodulator Demodulate using MSK method and the Viterbi algorithm
%   H = comm.MSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input minimum shift keying (MSK) modulated data
%   using the Viterbi algorithm.
%
%   H = comm.MSKDemodulator(Name,Value) creates an MSK demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the MSK demodulator System
%   object, H, and returns Y. X must be a double or single precision column
%   vector with a length equal to an integer multiple of the number of
%   samples per symbol you specify in the SamplesPerSymbol property.
%
%   MSKDemodulator methods:
%
%   step     - Modulate using MSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create MSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the MSK demodulator object
%
%   MSKDemodulator properties:
%
%   BitOutput          - Output data as bits
%   InitialPhaseOffset - Initial phase offset
%   SamplesPerSymbol   - Number of samples per input symbol
%   TracebackDepth     - Traceback depth for Viterbi algorithm
%   OutputDataType     - Data type of output
%
%   % Example:
%   %    Modulate and demodulate a signal using MSK modulation with bit 
%   %    inputs and an initial phase offset of pi/4
%
%   hMod = comm.MSKModulator('BitInput', true, 'InitialPhaseOffset', pi/4);
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
%   See also comm.MSKModulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MSKDemodulator
            %MSKDemodulator Demodulate using MSK method and the Viterbi algorithm
            %   H = comm.MSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input minimum shift keying (MSK) modulated data
            %   using the Viterbi algorithm.
            %
            %   H = comm.MSKDemodulator(Name,Value) creates an MSK demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the MSK demodulator System
            %   object, H, and returns Y. X must be a double or single precision column
            %   vector with a length equal to an integer multiple of the number of
            %   samples per symbol you specify in the SamplesPerSymbol property.
            %
            %   MSKDemodulator methods:
            %
            %   step     - Modulate using MSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create MSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the MSK demodulator object
            %
            %   MSKDemodulator properties:
            %
            %   BitOutput          - Output data as bits
            %   InitialPhaseOffset - Initial phase offset
            %   SamplesPerSymbol   - Number of samples per input symbol
            %   TracebackDepth     - Traceback depth for Viterbi algorithm
            %   OutputDataType     - Data type of output
            %
            %   % Example:
            %   %    Modulate and demodulate a signal using MSK modulation with bit 
            %   %    inputs and an initial phase offset of pi/4
            %
            %   hMod = comm.MSKModulator('BitInput', true, 'InitialPhaseOffset', pi/4);
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
            %   See also comm.MSKModulator, comm.CPMModulator, comm.CPMDemodulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   values. When you set this property to false, the step method outputs a
        %   column vector of length equal to N/SamplesPerSymbol. N is the length
        %   of the input signal, which is the number of input baseband modulated
        %   symbols. The elements of the output vector are -1 or 1. When you set
        %   the BitOutput property to true, the step method outputs a binary
        %   column vector of length equal to N/SamplesPerSymbol. Its elements are
        %   bit values of 0 or 1. The default is false.
        BitOutput;

    end
end
