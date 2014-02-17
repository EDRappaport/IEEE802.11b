classdef DQPSKDemodulator< handle
%DQPSKDemodulator Demodulate using DQPSK method
%   H = comm.DQPSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the differential quadrature
%   phase shift keying (DQPSK) method.
%
%   H = comm.DQPSKDemodulator(Name,Value) creates a DQPSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DQPSKDemodulator(PHASE,Name,Value) creates a DQPSK demodulator
%   object, H, with the PhaseRotation property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the DQPSK demodulator
%   System object, H, and returns Y. Input X must be a single or double
%   precision data type scalar or column vector. Depending on the BitOutput
%   property value, output Y can be integer or bit valued.
%
%   DQPSKDemodulator methods:
%
%   step     - Demodulate input using DQPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create DQPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of DQPSK demodulator object
%
%   DQPSKDemodulator properties:
%
%   PhaseRotation  - Additional phase shift
%   BitOutput      - Output data as bits
%   SymbolMapping  - Constellation encoding
%   OutputDataType - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using DQPSK modulation
%
%   hMod = comm.DQPSKModulator(pi/8);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',15);
%   hDemod = comm.DQPSKDemodulator(pi/8);
%   % Create an error rate calculator, account for the one symbol
%   % transient caused by the differential modulation
%   hError = comm.ErrorRate('ComputationDelay',1);
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 3],50,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.DPSKModulator, comm.DBPSKModulator, comm.DQPSKModulator. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=DQPSKDemodulator
            %DQPSKDemodulator Demodulate using DQPSK method
            %   H = comm.DQPSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the differential quadrature
            %   phase shift keying (DQPSK) method.
            %
            %   H = comm.DQPSKDemodulator(Name,Value) creates a DQPSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DQPSKDemodulator(PHASE,Name,Value) creates a DQPSK demodulator
            %   object, H, with the PhaseRotation property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the DQPSK demodulator
            %   System object, H, and returns Y. Input X must be a single or double
            %   precision data type scalar or column vector. Depending on the BitOutput
            %   property value, output Y can be integer or bit valued.
            %
            %   DQPSKDemodulator methods:
            %
            %   step     - Demodulate input using DQPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create DQPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of DQPSK demodulator object
            %
            %   DQPSKDemodulator properties:
            %
            %   PhaseRotation  - Additional phase shift
            %   BitOutput      - Output data as bits
            %   SymbolMapping  - Constellation encoding
            %   OutputDataType - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using DQPSK modulation
            %
            %   hMod = comm.DQPSKModulator(pi/8);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',15);
            %   hDemod = comm.DQPSKDemodulator(pi/8);
            %   % Create an error rate calculator, account for the one symbol
            %   % transient caused by the differential modulation
            %   hError = comm.ErrorRate('ComputationDelay',1);
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 3],50,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.DPSKModulator, comm.DBPSKModulator, comm.DQPSKModulator. 
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true the step method
        %   outputs a column vector of bit values with length equal to twice the
        %   number of demodulated symbols. When you set this property to false,
        %   the step method outputs a column vector, of length equal to the input
        %   data vector, that contains integer symbol values between 0 and 3. The
        %   default is false.
        BitOutput;

        %PhaseRotation Additional phase shift
        %   Specify the additional phase difference between previous and current
        %   modulated symbols in radians as a real scalar. This value corresponds
        %   to the phase difference between previous and current modulated symbols
        %   when the input is zero. The default is pi/4.
        PhaseRotation;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of 2 bits to the
        %   corresponding symbol as one of 'Binary' | 'Gray'. The default is
        %   'Gray'. When you set this property to 'Gray', the object uses a
        %   Gray-encoded signal constellation. When you set this property to
        %   'Binary', the integer m (0 <= m <= 3) maps to the current symbol as
        %   exp(j*PhaseRotation + j*2*pi*m/4)*(previously modulated symbol).
        SymbolMapping;

    end
end
