classdef CPMModulator< handle
%CPMModulator Modulate using CPM method
%   H = comm.CPMModulator creates a modulator System object, H. This object
%   modulates the input signal using the continuous phase modulation (CPM)
%   method.
%
%   H = comm.CPMModulator(Name,Value) creates a CPM modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CPMModulator(M,Name,Value) creates a CPM modulator object, H,
%   with the ModulationOrder property set to M, and other specified property
%   Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the CPM modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on
%   the value of the BitInput property, input X can be an integer or bit
%   valued column vector with data types double, signed integer, or logical.
%   The length of output vector, Y, is equal to the number of input samples
%   times the number of samples per symbol specified in the SamplesPerSymbol
%   property.
%
%   CPMModulator methods:
%
%   step     - Modulate input using CPM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CPM modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CPM modulator object
%
%   CPMModulator properties:
%
%   ModulationOrder      - Size of symbol alphabet
%   BitInput             - Assume bit inputs
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
%   SamplesPerSymbol     - Number of samples per output symbol
%   OutputDataType       - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using CPM modulation with Gray
%   %   mapping and bit inputs
%
%   hMod = comm.CPMModulator(8, 'BitInput', true, ...
%                           'SymbolMapping', 'Gray');
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                           'Signal to noise ratio (SNR)','SNR',0);
%   hDemod = comm.CPMDemodulator(8, 'BitOutput', true, ...
%                           'SymbolMapping', 'Gray');
%   % Create an error rate calculator, account for the delay caused by the
%   % Viterbi algorithm.
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
%   See also comm.CPMDemodulator, comm.CPFSKModulator, comm.MSKModulator, 
%            comm.GMSKModulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=CPMModulator
            %CPMModulator Modulate using CPM method
            %   H = comm.CPMModulator creates a modulator System object, H. This object
            %   modulates the input signal using the continuous phase modulation (CPM)
            %   method.
            %
            %   H = comm.CPMModulator(Name,Value) creates a CPM modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CPMModulator(M,Name,Value) creates a CPM modulator object, H,
            %   with the ModulationOrder property set to M, and other specified property
            %   Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the CPM modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on
            %   the value of the BitInput property, input X can be an integer or bit
            %   valued column vector with data types double, signed integer, or logical.
            %   The length of output vector, Y, is equal to the number of input samples
            %   times the number of samples per symbol specified in the SamplesPerSymbol
            %   property.
            %
            %   CPMModulator methods:
            %
            %   step     - Modulate input using CPM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CPM modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CPM modulator object
            %
            %   CPMModulator properties:
            %
            %   ModulationOrder      - Size of symbol alphabet
            %   BitInput             - Assume bit inputs
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
            %   SamplesPerSymbol     - Number of samples per output symbol
            %   OutputDataType       - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using CPM modulation with Gray
            %   %   mapping and bit inputs
            %
            %   hMod = comm.CPMModulator(8, 'BitInput', true, ...
            %                           'SymbolMapping', 'Gray');
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                           'Signal to noise ratio (SNR)','SNR',0);
            %   hDemod = comm.CPMDemodulator(8, 'BitOutput', true, ...
            %                           'SymbolMapping', 'Gray');
            %   % Create an error rate calculator, account for the delay caused by the
            %   % Viterbi algorithm.
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
            %   See also comm.CPMDemodulator, comm.CPFSKModulator, comm.MSKModulator, 
            %            comm.GMSKModulator.
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
        %   pulse shape. This property must be a real, positive scalar. This
        %   property applies when you set the FrequencyPulse property to
        %   'Gaussian'.  The default is 0.3.
        BandwidthTimeProduct;

        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers.
        %
        %   When you set this property to false, the step method input must be a
        %   double precision or signed integer data type column vector of odd
        %   integer values between -(ModulationOrder-1) and ModulationOrder-1.
        %
        %   When you set this property to true, the step method input must be a
        %   column vector of P-length bit words, where P = log2(ModulationOrder).
        %   The input data type must be double precision or logical. The object
        %   maps each bit word to an integer K between 0 and ModulationOrder-1,
        %   using the mapping specified in the SymbolMapping property. The object
        %   then maps the integer K to the intermediate value
        %   2K-(ModulationOrder-1) and proceeds as in the case when BitInput is
        %   false.
        %
        %   The default is false.
        BitInput;

        %FrequencyPulse Frequency pulse shape
        %   Specify the type of pulse shaping that the modulator uses to smooth
        %   the phase transitions of the modulated signal as one of 'Rectangular'
        %   | 'Raised Cosine' | 'Spectral Raised Cosine' | 'Gaussian' | 'Tamed
        %   FM'. The default is 'Rectangular'.
        FrequencyPulse;

        %MainLobeDuration Main lobe duration of spectral raised cosine pulse 
        %   Specify, in number of symbol intervals, the duration of the largest
        %   lobe of the spectral raised cosine pulse. This property must be a
        %   real, positive, integer scalar. This property applies when you set the
        %   FrequencyPulse property to 'Spectral Raised Cosine'. The default is 1.
        MainLobeDuration;

        %ModulationIndex Modulation index
        %   Specify the modulation index. The index is the number of
        %   half-revolutions of phase shift in the modulated signal after
        %   modulating the latest symbol, and when this symbol has an integer
        %   value of 1. The value of this property must be a real, non-negative
        %   scalar or column vector. The default is 0.5.
        ModulationIndex;

        %ModulationOrder Size of symbol alphabet
        %   Specify the size of the symbol alphabet. The value of this property
        %   must be a power of two, real, integer scalar. The default is 4.
        ModulationOrder;

        %PulseLength Pulse length
        %   Specify the length of the frequency pulse shape in symbol intervals.
        %   The value of this property must be a real, positive integer. The
        %   default is 1.
        PulseLength;

        %RolloffFactor Rolloff factor of spectral raised cosine pulse 
        %   Specify the rolloff factor of the spectral raised cosine pulse. This
        %   property must be a real scalar between 0 and 1. This property applies
        %   when you set the FrequencyPulse property to 'Spectral Raised Cosine'.
        %   The default is 0.2.
        RolloffFactor;

        %SymbolMapping Symbol encoding
        %   Specify the mapping of bit inputs as one of 'Binary' | 'Gray'. The
        %   default is 'Binary'. This property determines how the object maps each
        %   input P-length bit word, where P = log2(ModulationOrder), to an
        %   integer between 0 and ModulationOrder-1. When you set this property to
        %   'Binary', the object uses a natural binary-coded ordering. When you
        %   set this property to 'Gray', the object uses a Gray-coded ordering.
        %   This property applies when you set the BitInput property to true.
        SymbolMapping;

        %SymbolPrehistory Symbol prehistory
        %   Specify the data symbols used by the modulator prior to the first call
        %   to the step method in reverse chronological order. This property must
        %   be a scalar or vector with odd integer elements between
        %   -(ModulationOrder-1) and (ModulationOrder-1). If it is a vector, then
        %   its length must be one less than the value in the PulseLength
        %   property. The default is 1.
        SymbolPrehistory;

    end
end
