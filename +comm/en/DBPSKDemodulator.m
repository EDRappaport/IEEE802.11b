classdef DBPSKDemodulator< handle
%DBPSKDemodulator Demodulate using DBPSK method
%   H = comm.DBPSKDemodulator creates a demodulator System object, H. This
%   object demodulates the input signal using the differential binary phase
%   shift keying (DBPSK) method.
%
%   H = comm.DBPSKDemodulator(Name,Value) creates a DBPSK demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DBPSKDemodulator(PHASE,Name,Value) creates a DBPSK demodulator
%   object, H, with the PhaseRotation property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates input data, X, with the DBPSK demodulator
%   System object, H, and returns Y. Input X must be a double or single
%   precision data type scalar or column vector.
%
%   DBPSKDemodulator methods:
%
%   step     - Demodulate input using DBPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create DBPSK demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of DBPSK demodulator object
%
%   DBPSKDemodulator properties:
%
%   PhaseRotation  - Additional phase shift
%   OutputDataType - Data type of output
%
%   % Example:
%   %   Modulate and demodulate a signal using DBPSK modulation
%
%   hMod = comm.DBPSKModulator(pi/4);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                        'Signal to noise ratio (SNR)','SNR',15);
%   hDemod = comm.DBPSKDemodulator(pi/4);
%   % Create an error rate calculator, account for the one bit transient
%   % caused by the differential modulation
%   hError = comm.ErrorRate('ComputationDelay',1);
%   for counter = 1:100
%       % Transmit a 50-symbol frame
%       data = randi([0 1],50,1);
%       modSignal = step(hMod, data);
%       noisySignal = step(hAWGN, modSignal);
%       receivedData = step(hDemod, noisySignal);
%       errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.DBPSKModulator, comm.DQPSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=DBPSKDemodulator
            %DBPSKDemodulator Demodulate using DBPSK method
            %   H = comm.DBPSKDemodulator creates a demodulator System object, H. This
            %   object demodulates the input signal using the differential binary phase
            %   shift keying (DBPSK) method.
            %
            %   H = comm.DBPSKDemodulator(Name,Value) creates a DBPSK demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DBPSKDemodulator(PHASE,Name,Value) creates a DBPSK demodulator
            %   object, H, with the PhaseRotation property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates input data, X, with the DBPSK demodulator
            %   System object, H, and returns Y. Input X must be a double or single
            %   precision data type scalar or column vector.
            %
            %   DBPSKDemodulator methods:
            %
            %   step     - Demodulate input using DBPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create DBPSK demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of DBPSK demodulator object
            %
            %   DBPSKDemodulator properties:
            %
            %   PhaseRotation  - Additional phase shift
            %   OutputDataType - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate a signal using DBPSK modulation
            %
            %   hMod = comm.DBPSKModulator(pi/4);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                        'Signal to noise ratio (SNR)','SNR',15);
            %   hDemod = comm.DBPSKDemodulator(pi/4);
            %   % Create an error rate calculator, account for the one bit transient
            %   % caused by the differential modulation
            %   hError = comm.ErrorRate('ComputationDelay',1);
            %   for counter = 1:100
            %       % Transmit a 50-symbol frame
            %       data = randi([0 1],50,1);
            %       modSignal = step(hMod, data);
            %       noisySignal = step(hAWGN, modSignal);
            %       receivedData = step(hDemod, noisySignal);
            %       errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.DBPSKModulator, comm.DQPSKModulator.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %OutputDataType Data type of output
        %   Specify output data type as one of 'Full precision' | 'Smallest
        %   unsigned integer' | 'double' | 'single' | 'int8' | 'uint8' | 'int16' |
        %   'uint16' | 'int32' | 'uint32' | 'logical'. The default is 'Full
        %   precision'. When you set this property to 'Full precision', the
        %   output data type is the same as that of the input which, in this
        %   case, must be double or single precision.
        OutputDataType;

        %PhaseRotation Additional phase shift 
        %   Specify the additional phase difference between previous and current
        %   modulated bits in radians as a real scalar. This value corresponds to
        %   the phase difference between previous and current modulated bits when
        %   the input is zero. The default is 0.
        PhaseRotation;

    end
end
