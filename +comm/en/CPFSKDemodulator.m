classdef CPFSKDemodulator< handle
%CPFSKDemodulator Demodulate using CPFSK method and Viterbi algorithm
%   H = comm.CPFSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input continuous phase frequency shift keying
%   (CPFSK) modulated data using the Viterbi algorithm.
%
%   H = comm.CPFSKDemodulator(Name,Value) creates a CPFSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CPFSKDemodulator(M,Name,Value) creates a CPFSK demodulator
%   object, H, with the ModulationOrder property set to M, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the CPFSK demodulator
%   System object, H, and returns Y. Input X must be a double or single
%   precision, column vector with a length equal to an integer multiple of
%   the number of samples per symbol specified in the SamplesPerSymbol
%   property. Depending on the BitOutput property value, output Y can be
%   integer or bit valued.
%
%   CPFSKDemodulator methods:
%
%   step     - Demodulate input using CPFSK method and Viterbi algorithm 
%              (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CPFSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CPFSK demodulator object
%
%   CPFSKDemodulator properties:
%
%   ModulationOrder    - Size of symbol alphabet
%   BitOutput          - Output data as bits
%   SymbolMapping      - Symbol encoding
%   ModulationIndex    - Modulation index
%   InitialPhaseOffset - Initial phase offset
%   SamplesPerSymbol   - Number of samples per input symbol
%   TracebackDepth     - Traceback depth for Viterbi algorithm
%   OutputDataType     - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using CPFSK modulation with Gray 
%   %   mapping and bit inputs
%
%   hMod = comm.CPFSKModulator(8, 'BitInput', true, ...
%                        'SymbolMapping', 'Gray');
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',0);
%   hDemod = comm.CPFSKDemodulator(8, 'BitOutput', true, ...
%                        'SymbolMapping', 'Gray');
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
%   See also comm.CPFSKModulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=CPFSKDemodulator
            %CPFSKDemodulator Demodulate using CPFSK method and Viterbi algorithm
            %   H = comm.CPFSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input continuous phase frequency shift keying
            %   (CPFSK) modulated data using the Viterbi algorithm.
            %
            %   H = comm.CPFSKDemodulator(Name,Value) creates a CPFSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CPFSKDemodulator(M,Name,Value) creates a CPFSK demodulator
            %   object, H, with the ModulationOrder property set to M, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the CPFSK demodulator
            %   System object, H, and returns Y. Input X must be a double or single
            %   precision, column vector with a length equal to an integer multiple of
            %   the number of samples per symbol specified in the SamplesPerSymbol
            %   property. Depending on the BitOutput property value, output Y can be
            %   integer or bit valued.
            %
            %   CPFSKDemodulator methods:
            %
            %   step     - Demodulate input using CPFSK method and Viterbi algorithm 
            %              (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CPFSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CPFSK demodulator object
            %
            %   CPFSKDemodulator properties:
            %
            %   ModulationOrder    - Size of symbol alphabet
            %   BitOutput          - Output data as bits
            %   SymbolMapping      - Symbol encoding
            %   ModulationIndex    - Modulation index
            %   InitialPhaseOffset - Initial phase offset
            %   SamplesPerSymbol   - Number of samples per input symbol
            %   TracebackDepth     - Traceback depth for Viterbi algorithm
            %   OutputDataType     - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using CPFSK modulation with Gray 
            %   %   mapping and bit inputs
            %
            %   hMod = comm.CPFSKModulator(8, 'BitInput', true, ...
            %                        'SymbolMapping', 'Gray');
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',0);
            %   hDemod = comm.CPFSKDemodulator(8, 'BitOutput', true, ...
            %                        'SymbolMapping', 'Gray');
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
            %   See also comm.CPFSKModulator, comm.CPMModulator, comm.CPMDemodulator.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
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

        %ModulationIndex Modulation index
        %   Specify the modulation index. The index is the number of
        %   half-revolutions of phase shift in the modulated signal after
        %   modulating the latest symbol, and when this symbol has an integer
        %   value of 1. The value of this property must be a real, non-negative
        %   scalar. The default is 0.5.
        ModulationIndex;

        %ModulationOrder Size of symbol alphabet
        %   Specify the size of the symbol alphabet. The value of this property
        %   must be a power of two, real, integer scalar. The default is 4.
        ModulationOrder;

        %SymbolMapping Symbol encoding
        %   Specify the mapping of the modulated symbols as one of 'Binary' |
        %   'Gray'. The default is 'Binary'. This property determines how the
        %   object maps each demodulated integer symbol value (in the range 0 and
        %   ModulationOrder-1) to a P-length bit word, where P =
        %   log2(ModulationOrder). When you set this property to 'Binary', the
        %   object uses a natural binary-coded ordering. When you set this
        %   property to 'Gray', the object uses a Gray-coded ordering. This
        %   property applies when you set the BitOutput property to true.
        SymbolMapping;

    end
end
