classdef GMSKModulator< handle
%GMSKModulator Modulate using GMSK method   
%   H = comm.GMSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the Gaussian minimum shift keying
%   (GMSK) modulation method.
%
%   H = comm.GMSKModulator(Name,Value) creates a GMSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the GMSK modulator object,
%   H. It returns the baseband modulated output in Y. Depending on the
%   BitInput property value, input X can be a double precision, signed
%   integer, or logical column vector. The length of vector Y is equal to
%   the number of input samples times the number of samples per symbol that
%   you specify in the SamplesPerSymbol property.
%
%   GMSKModulator methods:
%
%   step     - Modulate using GMSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create GMSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the GMSK modulator object
%
%   GMSKModulator properties:
%
%   BitInput             - Assume input is bits
%   BandwidthTimeProduct - Product of bandwidth and symbol time of Gaussian
%                          pulse
%   PulseLength          - Pulse length
%   SymbolPrehistory     - Symbol prehistory
%   InitialPhaseOffset   - Initial phase offset
%   SamplesPerSymbol     - Number of samples per output symbol
%   OutputDataType       - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using GMSK modulation with bit 
%   %   inputs and an initial phase offset of pi/4
%
%   hMod = comm.GMSKModulator('BitInput', true, 'InitialPhaseOffset', pi/4);
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
%   See also comm.GMSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=GMSKModulator
            %GMSKModulator Modulate using GMSK method   
            %   H = comm.GMSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the Gaussian minimum shift keying
            %   (GMSK) modulation method.
            %
            %   H = comm.GMSKModulator(Name,Value) creates a GMSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the GMSK modulator object,
            %   H. It returns the baseband modulated output in Y. Depending on the
            %   BitInput property value, input X can be a double precision, signed
            %   integer, or logical column vector. The length of vector Y is equal to
            %   the number of input samples times the number of samples per symbol that
            %   you specify in the SamplesPerSymbol property.
            %
            %   GMSKModulator methods:
            %
            %   step     - Modulate using GMSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create GMSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the GMSK modulator object
            %
            %   GMSKModulator properties:
            %
            %   BitInput             - Assume input is bits
            %   BandwidthTimeProduct - Product of bandwidth and symbol time of Gaussian
            %                          pulse
            %   PulseLength          - Pulse length
            %   SymbolPrehistory     - Symbol prehistory
            %   InitialPhaseOffset   - Initial phase offset
            %   SamplesPerSymbol     - Number of samples per output symbol
            %   OutputDataType       - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using GMSK modulation with bit 
            %   %   inputs and an initial phase offset of pi/4
            %
            %   hMod = comm.GMSKModulator('BitInput', true, 'InitialPhaseOffset', pi/4);
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
            %   See also comm.GMSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BandwidthTimeProduct Product of bandwidth and symbol time of Gaussian
        %                     pulse
        %   Specify the product of the bandwidth and symbol time for the Gaussian
        %   pulse shape as a real, positive scalar. The default is 0.3
        BandwidthTimeProduct;

        %BitInput Assume input is bits
        %   Specify whether the input is bits or integers. When you set the
        %   BitInput property to false, the step method input must be a double
        %   precision or signed integer data type column vector with values of -1
        %   or 1. When you set the BitInput property to true, step method input
        %   must be double precision or logical data type column vector of 0's and
        %   1's. The default is false.
        BitInput;

        %PulseLength Pulse length
        %   Specify the length of the Gaussian pulse shape in symbol intervals as
        %   a real, positive integer. The default is 4.
        PulseLength;

        %SymbolPrehistory Symbol prehistory
        %   Specify the data symbols the modulator uses prior to the first call to
        %   the step method in reverse chronological order. This property must be
        %   a scalar or vector with elements equal to -1 or 1. If it is a vector,
        %   then its length must be one less than the value in the PulseLength
        %   property. The default is 1.
        SymbolPrehistory;

    end
end
