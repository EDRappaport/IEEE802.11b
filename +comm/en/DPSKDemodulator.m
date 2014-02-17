classdef DPSKDemodulator< handle
%DPSKDemodulator Demodulate using M-ary DPSK method
%   H = comm.DPSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the M-ary differential phase
%   shift keying (M-DPSK) method.
%
%   H = comm.DPSKDemodulator(Name,Value) creates an M-DPSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DPSKDemodulator(M,PHASE,Name,Value) creates an M-DPSK
%   demodulator object, H, with the ModulationOrder property set to M, the
%   PhaseRotation property set to PHASE, and other specified property Names
%   set to the specified Values. M and PHASE are value-only arguments. To
%   specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the DPSK demodulator
%   System object, H, and returns Y. Input X must be a double or single
%   precision data type scalar or column vector. Depending on the BitOutput
%   property value, output Y can be integer or bit valued.
%
%   DPSKDemodulator methods:
%
%   step     - Demodulate input using M-DPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create M-DPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of M-DPSK demodulator object
%
%   DPSKDemodulator properties:
%
%   ModulationOrder - Number of points in signal constellation
%   PhaseRotation   - Additional phase shift
%   BitOutput       - Output data as bits
%   SymbolMapping   - Constellation encoding
%   OutputDataType  - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using 8-DPSK modulation
%
%   hMod = comm.DPSKModulator(8,pi/4);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',20);
%   hDemod = comm.DPSKDemodulator(8,pi/4);
%   % Create an error rate calculator, account for the one symbol
%   % transient caused by the differential modulation
%   hError = comm.ErrorRate('ComputationDelay',1);
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 hMod.ModulationOrder-1],50,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.DPSKModulator, comm.DBPSKDemodulator, 
%            comm.DQPSKDemodulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=DPSKDemodulator
            %DPSKDemodulator Demodulate using M-ary DPSK method
            %   H = comm.DPSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the M-ary differential phase
            %   shift keying (M-DPSK) method.
            %
            %   H = comm.DPSKDemodulator(Name,Value) creates an M-DPSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DPSKDemodulator(M,PHASE,Name,Value) creates an M-DPSK
            %   demodulator object, H, with the ModulationOrder property set to M, the
            %   PhaseRotation property set to PHASE, and other specified property Names
            %   set to the specified Values. M and PHASE are value-only arguments. To
            %   specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the DPSK demodulator
            %   System object, H, and returns Y. Input X must be a double or single
            %   precision data type scalar or column vector. Depending on the BitOutput
            %   property value, output Y can be integer or bit valued.
            %
            %   DPSKDemodulator methods:
            %
            %   step     - Demodulate input using M-DPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create M-DPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of M-DPSK demodulator object
            %
            %   DPSKDemodulator properties:
            %
            %   ModulationOrder - Number of points in signal constellation
            %   PhaseRotation   - Additional phase shift
            %   BitOutput       - Output data as bits
            %   SymbolMapping   - Constellation encoding
            %   OutputDataType  - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using 8-DPSK modulation
            %
            %   hMod = comm.DPSKModulator(8,pi/4);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',20);
            %   hDemod = comm.DPSKDemodulator(8,pi/4);
            %   % Create an error rate calculator, account for the one symbol
            %   % transient caused by the differential modulation
            %   hError = comm.ErrorRate('ComputationDelay',1);
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 hMod.ModulationOrder-1],50,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.DPSKModulator, comm.DBPSKDemodulator, 
            %            comm.DQPSKDemodulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BitOutput Output data as bits
        %   Specify whether the output consists of groups of bits or integer
        %   symbol values. When you set this property to true the step method
        %   outputs a column vector of bit values with length equal to
        %   log2(ModulationOrder) times the number of demodulated symbols. When
        %   you set this property to false, the step method outputs a column
        %   vector, of length equal to the input data vector, that contains
        %   integer symbol values between 0 and ModulationOrder-1. The default is
        %   false.
        BitOutput;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. The default is 8.
        ModulationOrder;

        %PhaseRotation Additional phase shift
        %   Specify the additional phase difference between previous and current
        %   modulated symbols in radians as real scalar. This value corresponds to
        %   the phase difference between previous and current modulated symbols
        %   when the input is zero. The default is pi/8.
        PhaseRotation;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) bits to the corresponding symbol as one of
        %   'Binary' | 'Gray'. The default is 'Gray'. When you set this property
        %   to 'Gray', the object uses a Gray-encoded signal constellation. When
        %   you set this property to 'Binary', the integer m (0 <= m <=
        %   ModulationOrder-1) maps to the current symbol as exp(j*PhaseRotation +
        %   j*2*pi*m/ModulationOrder)*(previously modulated symbol).
        SymbolMapping;

    end
end
