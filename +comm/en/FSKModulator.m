classdef FSKModulator< handle
%FSKModulator Modulate using M-ary FSK method
%   H = comm.FSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the M-ary frequency shift keying
%   (M-FSK) method.
%
%   H = comm.FSKModulator(Name,Value) creates an M-FSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.FSKModulator(M,FREQSEP,RS,Name,Value) creates an M-FSK
%   modulator object, H, with the ModulationOrder property set to M, the
%   FrequencySeparation property set to FREQSEP, the SymbolRate property
%   set to RS, and other specified property Names set to the specified
%   Values. M, FREQSEP, and RS are value-only arguments. To specify a
%   value-only argument, you must also specify all preceding value-only
%   arguments. You can specify name-value pair arguments in any order.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the FSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit- valued
%   column vector with numeric or logical data types. The length of output
%   vector, Y, is equal to the number of input samples times the number of
%   samples per symbol you specify in the SamplesPerSymbol property.
%
%   FSKModulator methods:
%
%   step     - Modulate input using M-FSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create M-FSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of M-FSK modulator object
%
%   FSKModulator properties:
%
%   ModulationOrder     - Number of frequencies in modulated signal
%   BitInput            - Assume bit inputs
%   SymbolMapping       - Symbol encoding
%   FrequencySeparation - Frequency separation between successive tones
%   ContinuousPhase     - Phase continuity
%   SamplesPerSymbol    - Number of samples per output symbol
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
%   See also comm.FSKDemodulator, comm.CPFSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=FSKModulator
            %FSKModulator Modulate using M-ary FSK method
            %   H = comm.FSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the M-ary frequency shift keying
            %   (M-FSK) method.
            %
            %   H = comm.FSKModulator(Name,Value) creates an M-FSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.FSKModulator(M,FREQSEP,RS,Name,Value) creates an M-FSK
            %   modulator object, H, with the ModulationOrder property set to M, the
            %   FrequencySeparation property set to FREQSEP, the SymbolRate property
            %   set to RS, and other specified property Names set to the specified
            %   Values. M, FREQSEP, and RS are value-only arguments. To specify a
            %   value-only argument, you must also specify all preceding value-only
            %   arguments. You can specify name-value pair arguments in any order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the FSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit- valued
            %   column vector with numeric or logical data types. The length of output
            %   vector, Y, is equal to the number of input samples times the number of
            %   samples per symbol you specify in the SamplesPerSymbol property.
            %
            %   FSKModulator methods:
            %
            %   step     - Modulate input using M-FSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create M-FSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of M-FSK modulator object
            %
            %   FSKModulator properties:
            %
            %   ModulationOrder     - Number of frequencies in modulated signal
            %   BitInput            - Assume bit inputs
            %   SymbolMapping       - Symbol encoding
            %   FrequencySeparation - Frequency separation between successive tones
            %   ContinuousPhase     - Phase continuity
            %   SamplesPerSymbol    - Number of samples per output symbol
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
            %   See also comm.FSKDemodulator, comm.CPFSKModulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. When you set this
        %   property to false, the step method input must be a numeric (except
        %   single precision data type) column vector of integer values between 0
        %   and ModulationOrder-1. In this case, the input vector can also be of
        %   data type logical if ModulationOrder is 2. When you set this property
        %   to true, the step method input must be a double precision or logical
        %   data type column vector of bit values whose length is an integer
        %   multiple of log2(ModulationOrder). This vector contains bit
        %   representations of integers between 0 and ModulationOrder-1. The
        %   default is false.
        BitInput;

        %ContinuousPhase Phase continuity
        %   Specify if the phase of the output modulated signal is continuous or
        %   discontinuous. When you set this property to true, the modulated
        %   signal maintains continuous phase even when its frequency changes.
        %   When you set this property to false, the modulated signal comprises
        %   portions of ModulationOrder sinusoids of different frequencies. In
        %   this case, a change in the input value might cause a change in the
        %   phase of the modulated signal. The default is true.
        ContinuousPhase;

        %FrequencySeparation Frequency separation between successive tones
        %   Specify the frequency separation between successive tones in the
        %   modulated signal in Hz as a positive, real scalar. To avoid output
        %   signal aliasing, the output sampling rate, Fs =
        %   SamplesPerSymbol*SymbolRate, must be greater than ModulationOrder
        %   multiplied by FrequencySeparation. The default is 6 Hz.
        FrequencySeparation;

        %ModulationOrder Number of frequencies in modulated signal
        %   Specify the number of frequencies in the modulated signal as a numeric
        %   positive integer scalar that is a power of 2. The default is 8.
        ModulationOrder;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'single'. The
        %   default is 'double'.
        OutputDataType;

        %SamplesPerSymbol Number of samples per output symbol
        %   Specify the number of output samples that the object produces for each
        %   integer or binary word in the input as a positive, integer scalar. The
        %   default is 17.
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
        %   Specify the symbol rate in symbols per second as a positive, double
        %   precision, real scalar. To avoid output signal aliasing, the output
        %   sampling rate, Fs = SamplesPerSymbol*SymbolRate, must be greater than
        %   ModulationOrder multiplied by FrequencySeparation. The symbol duration
        %   is always the same regardless of the input being bits or integers. The
        %   default is 100 symbols per second.
        SymbolRate;

    end
end
