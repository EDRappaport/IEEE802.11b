classdef FSKDemodulator< handle
%FSKDemodulator Demodulate using M-ary FSK method
%   H = comm.FSKDemodulator creates a demodulator System object, H. This
%   object demodulates an M-ary frequency shift keying (M-FSK) signal using
%   a non-coherent energy detector. The M-FSK demodulator object implements
%   a non-coherent energy detector. To obtain the same bit error rate
%   performance as that of coherent FSK demodulation, use the CPFSK
%   Demodulator System object.
%
%   H = comm.FSKDemodulator(Name,Value) creates an M-FSK demodulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.FSKDemodulator(M,FREQSEP,RS,Name,Value) creates an M-FSK
%   demodulator object, H, with the ModulationOrder property set to M, the
%   FrequencySeparation property set to FREQSEP, the SymbolRate property
%   set to RS, and other specified property Names set to the specified
%   Values. M, FREQSEP, and RS are value-only arguments. To specify a
%   value-only argument, you must also specify all preceding value-only
%   arguments. You can specify name-value pair arguments in any order.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the FSK demodulator System
%   object, H, and returns Y. X must be a double or single precision data
%   type column vector of length equal to an integer multiple of the number
%   of samples per symbol that you specify in the SamplesPerSymbol property.
%   Depending on the BitOutput property value, output Y can be integer or
%   bit valued.
%
%   FSKDemodulator methods:
%
%   step     - Demodulate input using M-FSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create M-FSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of M-FSK demodulator object
%
%   FSKDemodulator properties:
%
%   ModulationOrder     - Number of frequencies in modulated signal
%   BitOutput           - Output data as bits
%   SymbolMapping       - Symbol encoding
%   FrequencySeparation - Frequency separation between successive tones
%   SamplesPerSymbol    - Number of samples per input symbol
%   SymbolRate          - Symbol rate
%   OutputDataType      - Data type of output
%
%   % Example: 
%   %   Modulate and demodulate a signal using 8-FSK modulation with a
%   %   frequency separation of 100 Hz
%
%    hMod = comm.FSKModulator(8, 100);
%    hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',0);
%    hDemod = comm.FSKDemodulator(8, 100);
%    %Create an error rate calculator
%    hError = comm.ErrorRate;
%    for counter = 1:100
%        % Transmit a 50-symbol frame
%        data = randi([0 hMod.ModulationOrder-1],50,1);
%        modSignal = step(hMod, data);
%        noisySignal = step(hAWGN, modSignal);
%        receivedData = step(hDemod, noisySignal);
%        errorStats = step(hError, data, receivedData);
%    end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.FSKModulator, comm.CPFSKModulator, comm.CPFSKDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=FSKDemodulator
            %FSKDemodulator Demodulate using M-ary FSK method
            %   H = comm.FSKDemodulator creates a demodulator System object, H. This
            %   object demodulates an M-ary frequency shift keying (M-FSK) signal using
            %   a non-coherent energy detector. The M-FSK demodulator object implements
            %   a non-coherent energy detector. To obtain the same bit error rate
            %   performance as that of coherent FSK demodulation, use the CPFSK
            %   Demodulator System object.
            %
            %   H = comm.FSKDemodulator(Name,Value) creates an M-FSK demodulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.FSKDemodulator(M,FREQSEP,RS,Name,Value) creates an M-FSK
            %   demodulator object, H, with the ModulationOrder property set to M, the
            %   FrequencySeparation property set to FREQSEP, the SymbolRate property
            %   set to RS, and other specified property Names set to the specified
            %   Values. M, FREQSEP, and RS are value-only arguments. To specify a
            %   value-only argument, you must also specify all preceding value-only
            %   arguments. You can specify name-value pair arguments in any order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the FSK demodulator System
            %   object, H, and returns Y. X must be a double or single precision data
            %   type column vector of length equal to an integer multiple of the number
            %   of samples per symbol that you specify in the SamplesPerSymbol property.
            %   Depending on the BitOutput property value, output Y can be integer or
            %   bit valued.
            %
            %   FSKDemodulator methods:
            %
            %   step     - Demodulate input using M-FSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create M-FSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of M-FSK demodulator object
            %
            %   FSKDemodulator properties:
            %
            %   ModulationOrder     - Number of frequencies in modulated signal
            %   BitOutput           - Output data as bits
            %   SymbolMapping       - Symbol encoding
            %   FrequencySeparation - Frequency separation between successive tones
            %   SamplesPerSymbol    - Number of samples per input symbol
            %   SymbolRate          - Symbol rate
            %   OutputDataType      - Data type of output
            %
            %   % Example: 
            %   %   Modulate and demodulate a signal using 8-FSK modulation with a
            %   %   frequency separation of 100 Hz
            %
            %    hMod = comm.FSKModulator(8, 100);
            %    hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',0);
            %    hDemod = comm.FSKDemodulator(8, 100);
            %    %Create an error rate calculator
            %    hError = comm.ErrorRate;
            %    for counter = 1:100
            %        % Transmit a 50-symbol frame
            %        data = randi([0 hMod.ModulationOrder-1],50,1);
            %        modSignal = step(hMod, data);
            %        noisySignal = step(hAWGN, modSignal);
            %        receivedData = step(hDemod, noisySignal);
            %        errorStats = step(hError, data, receivedData);
            %    end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.FSKModulator, comm.CPFSKModulator, comm.CPFSKDemodulator.
        end

        function getOutputDataTypeIndex(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output is groups of bits or integer values. When
        %   you set this property to false, the step method outputs a column
        %   vector of length equal to N/SamplesPerSymbol. N is the length of the
        %   input data vector to the step method. The elements of the output
        %   vector are integers between 0 and ModulationOrder-1. When you set this
        %   property to true, the step method outputs a column vector of length
        %   equal to log2(ModulationOrder)*(N/SamplesPerSymbol). Its elements are
        %   bit representations of integers between 0 and ModulationOrder-1. The
        %   default is false.
        BitOutput;

        %FrequencySeparation Frequency separation between successive tones
        %   Specify the frequency separation between successive symbols in the
        %   modulated signal in Hertz as a positive, real scalar. The default is 6
        %   Hz.
        FrequencySeparation;

        %ModulationOrder Number of frequencies in modulated signal
        %   Specify the number of frequencies in the modulated signal as a
        %   numeric, positive, integer scalar that is a power of 2. The default is
        %   8.
        ModulationOrder;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'logical' | 'int8' | 'uint8' |
        %   'int16' | 'uint16' | 'int32' | 'uint32' | 'double'. The 'logical' type
        %   is valid only when you set the BitOutput property to false and the
        %   ModulationOrder property to two.  When you set the BitOutput property
        %   to true, the output data type must be one of 'logical' | 'double'. The
        %   default is 'double'.
        OutputDataType;

        %SamplesPerSymbol Number of samples per input symbol
        %   Specify the number of samples per input symbol as a positive, integer
        %   scalar. The default is 17.
        SamplesPerSymbol;

        %SymbolMapping Symbol encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) bits to the corresponding symbol as one of
        %   'Binary' | 'Gray'. The default is 'Gray'. When you set this property
        %   to 'Gray', the object uses Gray-coded ordering. When you set this
        %   property to 'Binary', the object uses natural binary-coded ordering.
        %   For either type of mapping, the object maps the highest frequency to
        %   the integer 0 and maps the lowest frequency to the integer M-1. In
        %   baseband simulation, the lowest frequency is the negative frequency
        %   with the largest absolute value.
        SymbolMapping;

        %SymbolRate Symbol rate
        %   Specify the symbol rate in symbols per seconds as a positive, double
        %   precision, real scalar. The default is 100 symbols per second.
        SymbolRate;

        pBitOutputDataTypeSet;

        pIntOutputDataTypeSet;

    end
end
