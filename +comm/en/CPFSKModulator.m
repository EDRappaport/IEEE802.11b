classdef CPFSKModulator< handle
%CPFSKModulator Modulate using CPFSK method
%   H = comm.CPFSKModulator creates a modulator System object, H. This
%   object modulates the input signal using the continuous phase frequency
%   shift keying (CPFSK) modulation method.
%
%   H = comm.CPFSKModulator(Name,Value) creates a CPFSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CPFSKModulator(M,Name,Value) creates a CPFSK modulator object,
%   H, with the ModulationOrder property set to M, and other specified
%   property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the CPFSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with data types double, signed integer, or logical. The
%   length of output vector, Y, is equal to the number of input samples
%   times the number of samples per symbol specified in the SamplesPerSymbol
%   property.
%
%   CPFSKModulator methods:
%
%   step     - Modulate using CPFSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CPFSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CPFSK modulator object
%
%   CPFSKModulator properties:
%
%   ModulationOrder      - Size of symbol alphabet
%   BitInput             - Assume bit inputs
%   SymbolMapping        - Symbol encoding
%   ModulationIndex      - Modulation index
%   InitialPhaseOffset   - Initial phase offset
%   SamplesPerSymbol     - Number of samples per output symbol
%   OutputDataType       - Data type of output
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
%   See also comm.CPFSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=CPFSKModulator
            %CPFSKModulator Modulate using CPFSK method
            %   H = comm.CPFSKModulator creates a modulator System object, H. This
            %   object modulates the input signal using the continuous phase frequency
            %   shift keying (CPFSK) modulation method.
            %
            %   H = comm.CPFSKModulator(Name,Value) creates a CPFSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CPFSKModulator(M,Name,Value) creates a CPFSK modulator object,
            %   H, with the ModulationOrder property set to M, and other specified
            %   property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the CPFSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with data types double, signed integer, or logical. The
            %   length of output vector, Y, is equal to the number of input samples
            %   times the number of samples per symbol specified in the SamplesPerSymbol
            %   property.
            %
            %   CPFSKModulator methods:
            %
            %   step     - Modulate using CPFSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CPFSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CPFSK modulator object
            %
            %   CPFSKModulator properties:
            %
            %   ModulationOrder      - Size of symbol alphabet
            %   BitInput             - Assume bit inputs
            %   SymbolMapping        - Symbol encoding
            %   ModulationIndex      - Modulation index
            %   InitialPhaseOffset   - Initial phase offset
            %   SamplesPerSymbol     - Number of samples per output symbol
            %   OutputDataType       - Data type of output
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
            %   See also comm.CPFSKDemodulator, comm.CPMModulator, comm.CPMDemodulator.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
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
        %   2K-(ModulationOrder-1) and proceeds as in the case when you set the
        %   BitInput property to false.
        %
        %   The default is false.
        BitInput;

        %ModulationIndex Modulation index
        %   Specify the modulation index. The index is the number of
        %   half-revolutions of phase shift in the modulated signal after
        %   modulating the latest symbol and when this symbol has an integer value
        %   of 1. The value of this property must be a real, non-negative scalar.
        %   The default is 0.5.
        ModulationIndex;

        %ModulationOrder Size of symbol alphabet
        %   Specify the size of the symbol alphabet. The value of this property
        %   must be a power of two, real, integer scalar. The default is 4.
        ModulationOrder;

        %SymbolMapping Symbol encoding
        %   Specify the mapping of bit inputs as one of 'Binary' | 'Gray'. The
        %   default is 'Binary'. This property determines how the object maps each
        %   input P-length bit word, where P = log2(ModulationOrder), to an
        %   integer between 0 and ModulationOrder-1. When you set this property to
        %   'Binary', the object uses a natural binary-coded ordering. When you
        %   set this property to 'Gray', the object uses a Gray-coded ordering.
        %   This property applies when you set the BitInput property to true.
        SymbolMapping;

    end
end
