classdef CPMDemodulator< handle
%CPMDemodulator Demodulate using CPM method and Viterbi algorithm
%   H = comm.CPMDemodulator creates a demodulator System object, H. This
%   object demodulates the input continuous phase modulated (CPM) data using
%   the Viterbi algorithm.
%
%   H = comm.CPMDemodulator(Name,Value) creates a CPM demodulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CPMDemodulator(M,Name,Value) creates a CPM demodulator object,
%   H, with the ModulationOrder property set to M, and other specified
%   property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the CPM demodulator System
%   object, H, and returns Y. X must be a double or single precision, column
%   vector with a length equal to an integer multiple of the number of
%   samples per symbol specified in the SamplesPerSymbol property. Depending
%   on the BitOutput property value, output Y can be integer or bit valued.
%
%   CPMDemodulator methods:
%
%   step     - Demodulate input using CPM method and Viterbi algorithm (see
%              above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CPM demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CPM demodulator object
%
%   CPMDemodulator properties:
%
%   ModulationOrder      - Size of symbol alphabet
%   BitOutput            - Output data as bits
%   SymbolMapping        - Symbol encoding
%   ModulationIndex      - Modulation index
%   FrequencyPulse       - Frequency pulse shape
%   MainLobeDuration     - Main lobe duration of spectral raised cosine
%                          pulse 
%   RolloffFactor        - Rolloff factor of spectral raised cosine pulse 
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
%   %   Modulate and demodulate a signal using CPM modulation with Gray
%   %   mapping and bit inputs
%
%   hMod = comm.CPMModulator(8, 'BitInput', true, ...
%                        'SymbolMapping', 'Gray');
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',0);
%   hDemod = comm.CPMDemodulator(8, 'BitOutput', true, ...
%                        'SymbolMapping', 'Gray');
%   % Create an error rate calculator, account for the delay caused by
%   % the Viterbi algorithm.
%   delay = log2(hDemod.ModulationOrder)*hDemod.TracebackDepth;
%   hError = comm.ErrorRate('ReceiveDelay', delay);
%   for counter = 1:100
%       % Transmit 100 3-bit words
%       data = randi([0 1],300,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.CPMModulator, comm.CPFSKDemodulator, comm.MSKDemodulator,
%            comm.GMSKDemodulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=CPMDemodulator
            %CPMDemodulator Demodulate using CPM method and Viterbi algorithm
            %   H = comm.CPMDemodulator creates a demodulator System object, H. This
            %   object demodulates the input continuous phase modulated (CPM) data using
            %   the Viterbi algorithm.
            %
            %   H = comm.CPMDemodulator(Name,Value) creates a CPM demodulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CPMDemodulator(M,Name,Value) creates a CPM demodulator object,
            %   H, with the ModulationOrder property set to M, and other specified
            %   property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the CPM demodulator System
            %   object, H, and returns Y. X must be a double or single precision, column
            %   vector with a length equal to an integer multiple of the number of
            %   samples per symbol specified in the SamplesPerSymbol property. Depending
            %   on the BitOutput property value, output Y can be integer or bit valued.
            %
            %   CPMDemodulator methods:
            %
            %   step     - Demodulate input using CPM method and Viterbi algorithm (see
            %              above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CPM demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CPM demodulator object
            %
            %   CPMDemodulator properties:
            %
            %   ModulationOrder      - Size of symbol alphabet
            %   BitOutput            - Output data as bits
            %   SymbolMapping        - Symbol encoding
            %   ModulationIndex      - Modulation index
            %   FrequencyPulse       - Frequency pulse shape
            %   MainLobeDuration     - Main lobe duration of spectral raised cosine
            %                          pulse 
            %   RolloffFactor        - Rolloff factor of spectral raised cosine pulse 
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
            %   %   Modulate and demodulate a signal using CPM modulation with Gray
            %   %   mapping and bit inputs
            %
            %   hMod = comm.CPMModulator(8, 'BitInput', true, ...
            %                        'SymbolMapping', 'Gray');
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',0);
            %   hDemod = comm.CPMDemodulator(8, 'BitOutput', true, ...
            %                        'SymbolMapping', 'Gray');
            %   % Create an error rate calculator, account for the delay caused by
            %   % the Viterbi algorithm.
            %   delay = log2(hDemod.ModulationOrder)*hDemod.TracebackDepth;
            %   hError = comm.ErrorRate('ReceiveDelay', delay);
            %   for counter = 1:100
            %       % Transmit 100 3-bit words
            %       data = randi([0 1],300,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.CPMModulator, comm.CPFSKDemodulator, comm.MSKDemodulator,
            %            comm.GMSKDemodulator.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BandwidthTimeProduct Product of bandwidth and symbol time of Gaussian
        %                     pulse
        %   Specify the product of bandwidth and symbol time for the Gaussian
        %   pulse shape that the modulator has used to pulse-shape the input
        %   modulated signal. This property must be a real, positive scalar. This
        %   property applies when you set the FrequencyPulse property to
        %   'Gaussian'. The default is 0.3.
        BandwidthTimeProduct;

        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   values.
        %
        %   When you set this property to false, the step method outputs a column
        %   vector of length equal to N/SamplesPerSymbol and with elements that
        %   are integers between -(ModulationOrder-1) and ModulationOrder-1. Here,
        %   N, is the length of the input signal, i.e., the number of input
        %   baseband modulated symbols.
        %
        %   When you set this property to true, the step method outputs a binary
        %   column vector of length equal to P*(N/SamplesPerSymbol), where P =
        %   log2(ModulationOrder). The output contains length-P bit words. In this
        %   scenario, the object first maps each demodulated symbol to an odd
        %   integer value, K, between -(ModulationOrder-1) and ModulationOrder-1.
        %   The object then maps K to the nonnegative integer
        %   (K+ModulationOrder-1)/2. Finally, the object maps each nonnegative
        %   integer to a length-P binary word, using the mapping specified in the
        %   SymbolMapping property.
        %
        %   The default is false.
        BitOutput;

        %FrequencyPulse Frequency pulse shape
        %   Specify the type of pulse shaping that the modulator has used to
        %   smooth the phase transitions of the input modulated signal as one of
        %   'Rectangular' | 'Raised Cosine' | 'Spectral Raised Cosine' |
        %   'Gaussian' | 'Tamed FM'. The default is 'Rectangular'.
        FrequencyPulse;

        %MainLobeDuration Main lobe duration of spectral raised cosine pulse
        %   Specify, in number of symbol intervals, the duration of the largest
        %   lobe of the spectral raised cosine pulse that the modulator has used
        %   to pulse-shape the input modulated signal. This property must be a
        %   real, positive, integer scalar. This property applies when you set the
        %   FrequencyPulse property to 'Spectral Raised Cosine'. The default is 1.
        MainLobeDuration;

        %ModulationIndex Modulation index
        %   Specify the modulation index. The index is the number of
        %   half-revolutions of phase shift in the modulated signal after
        %   modulating the latest symbol and when this symbol has an integer value
        %   of 1. The value of this property must be a real, non-negative scalar or
        %   column vector. The default is 0.5.
        ModulationIndex;

        %ModulationOrder Size of symbol alphabet
        %   Specify the size of the symbol alphabet. The value of this property
        %   must be a power of two, real, integer scalar. The default is 4.
        ModulationOrder;

        %PulseLength Pulse length
        %   Specify the length of the frequency pulse shape in symbol intervals.
        %   The value of this property must be a real positive integer. The
        %   default is 1.
        PulseLength;

        %RolloffFactor Rolloff factor of spectral raised cosine pulse
        %   Specify the rolloff factor of the spectral raised cosine pulse that
        %   the modulator has used to pulse-shape the input modulated signal. This
        %   property must be a real scalar between 0 and 1. This property applies
        %   when you set the FrequencyPulse property to 'Spectral Raised Cosine'.
        %   The default is 0.2.
        RolloffFactor;

        %SymbolMapping Symbol encoding
        %   Specify the mapping of the demodulated symbols as one of 'Binary' |
        %   'Gray'. The default is 'Binary'. This property determines how the
        %   object maps each demodulated integer symbol value (in the range 0 and
        %   ModulationOrder-1) to a P-length bit word, where P =
        %   log2(ModulationOrder). When you set this property to 'Binary', the
        %   object uses a natural binary-coded ordering. When you set this
        %   property to 'Gray', the object uses a Gray-coded ordering. This
        %   property applies when you set the BitOutput property to true.
        SymbolMapping;

        %SymbolPrehistory Symbol prehistory
        %   Specify the data symbols used by the modulator prior to the first call
        %   to the step method. This property must be a scalar or vector with odd
        %   integer elements between -(ModulationOrder-1) and (ModulationOrder-1).
        %   If it is a vector, then its length must be one less than the value in
        %   the PulseLength property. The default is 1.
        SymbolPrehistory;

    end
end
