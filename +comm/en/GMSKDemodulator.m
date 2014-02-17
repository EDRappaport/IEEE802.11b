classdef GMSKDemodulator< handle
%GMSKDemodulator Demodulate using GMSK method and the Viterbi algorithm 
%   H = comm.GMSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input Gaussian minimum shift keying (GMSK)
%   modulated data using the Viterbi algorithm.
%
%   H = comm.GMSKDemodulator(Name,Value) creates a GMSK demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the GMSK demodulator
%   object, H, and returns Y. X must be a double or single precision column
%   vector with a length equal to an integer multiple of the number of
%   samples per symbol you specify in the SamplesPerSymbol property.
%
%   GMSKDemodulator methods:
%
%   step     - Modulate using GMSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create GMSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the GMSK demodulator object
%
%   GMSKDemodulator properties:
%
%   BitOutput            - Output data as bits
%   BandwidthTimeProduct - Product of bandwidth and symbol time of Gaussian
%                          pulse
%   PulseLength          - Pulse length
%   SymbolPrehistory     - Symbol prehistory
%   InitialPhaseOffset   - Initial phase offset
%   SamplesPerSymbol     - Number of samples per input symbol
%   TracebackDepth       - Traceback depth for Viterbi algorithm
%   OutputDataType       - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using GMSK modulation with bit 
%   %   inputs and an initial phase offset of pi/4
%
%   hMod = comm.GMSKModulator('BitInput', true, ...
%                   'InitialPhaseOffset', pi/4);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)','SNR',0);
%   hDemod = comm.GMSKDemodulator('BitOutput', true, ...
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
%   See also comm.GMSKModulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=GMSKDemodulator
            %GMSKDemodulator Demodulate using GMSK method and the Viterbi algorithm 
            %   H = comm.GMSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input Gaussian minimum shift keying (GMSK)
            %   modulated data using the Viterbi algorithm.
            %
            %   H = comm.GMSKDemodulator(Name,Value) creates a GMSK demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the GMSK demodulator
            %   object, H, and returns Y. X must be a double or single precision column
            %   vector with a length equal to an integer multiple of the number of
            %   samples per symbol you specify in the SamplesPerSymbol property.
            %
            %   GMSKDemodulator methods:
            %
            %   step     - Modulate using GMSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create GMSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the GMSK demodulator object
            %
            %   GMSKDemodulator properties:
            %
            %   BitOutput            - Output data as bits
            %   BandwidthTimeProduct - Product of bandwidth and symbol time of Gaussian
            %                          pulse
            %   PulseLength          - Pulse length
            %   SymbolPrehistory     - Symbol prehistory
            %   InitialPhaseOffset   - Initial phase offset
            %   SamplesPerSymbol     - Number of samples per input symbol
            %   TracebackDepth       - Traceback depth for Viterbi algorithm
            %   OutputDataType       - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using GMSK modulation with bit 
            %   %   inputs and an initial phase offset of pi/4
            %
            %   hMod = comm.GMSKModulator('BitInput', true, ...
            %                   'InitialPhaseOffset', pi/4);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)','SNR',0);
            %   hDemod = comm.GMSKDemodulator('BitOutput', true, ...
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
            %   See also comm.GMSKModulator, comm.CPMModulator, comm.CPMDemodulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BandwidthTimeProduct Product of bandwidth and symbol time of Gaussian
        %                     pulse
        %   Specify the product of bandwidth and symbol time for the Gaussian
        %   pulse shape as a real, positive scalar. The default is 0.3.
        BandwidthTimeProduct;

        %BitOutput Output data as bits
        %   Specify whether the output is groups of bits or integer values. When
        %   you set the BitOutput property to false, the step method outputs a
        %   column vector of length equal to N/SamplesPerSymbol. N is the length
        %   of the input signal, which is the number of input baseband modulated
        %   symbols. The elements of the output vector are -1 or 1. When you set
        %   the BitOutput property to true, the step method outputs a binary
        %   column vector of length equal to N/SamplesPerSymbol with bit values of
        %   0 or 1. The default is false.
        BitOutput;

        %PulseLength Pulse length
        %   Specify the length of the Gaussian pulse shape in symbol intervals as
        %   a real positive integer. The default is 4.
        PulseLength;

        %SymbolPrehistory Symbol prehistory
        %   Specify the data symbols used by the modulator prior to the first call
        %   to the step method. This property must be a scalar or vector with
        %   elements equal to -1 or 1. If it is a vector, its length must be one
        %   less than the value you set in the PulseLength property. The default
        %   is 1.
        SymbolPrehistory;

    end
end
