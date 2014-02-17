classdef DBPSKModulator< handle
%DBPSKModulator Modulate using DBPSK method
%   H = comm.DBPSKModulator creates a modulator System object, H. This
%   object modulates the input signal using the differential binary phase
%   shift keying (DBPSK) method.
%
%   H = comm.DBPSKModulator(Name,Value) creates a DBPSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DBPSKModulator(PHASE,Name,Value) creates a DBPSK modulator
%   object, H, with the PhaseRotation property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the DBPSK modulator System
%   object, H. It returns the baseband modulated output, Y. The input must
%   be a numeric or logical data type column vector of bits.
%
%   DBPSKModulator methods:
%
%   step     - Modulate input using DBPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create DBPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of DBPSK modulator object
%
%   DBPSKModulator properties:
%
%   PhaseRotation  - Additional phase shift
%   OutputDataType - Data type of output
%
%   % Example:
%   %   Modulate data using DBPSK modulation and visualize the data in a
%   %   scatter plot
%
%   % Create binary data symbols
%   data = randi([0 1], 96, 1);
%   % Create a DBPSK modulator System object and set the phase rotation to
%   % pi/4
%   hModulator = comm.DBPSKModulator(pi/4);
%   % Modulate and plot the data
%   modData = step(hModulator, data);
%   scatterplot(modData)
%
%   See also comm.DBPSKDemodulator, comm.DQPSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=DBPSKModulator
            %DBPSKModulator Modulate using DBPSK method
            %   H = comm.DBPSKModulator creates a modulator System object, H. This
            %   object modulates the input signal using the differential binary phase
            %   shift keying (DBPSK) method.
            %
            %   H = comm.DBPSKModulator(Name,Value) creates a DBPSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DBPSKModulator(PHASE,Name,Value) creates a DBPSK modulator
            %   object, H, with the PhaseRotation property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the DBPSK modulator System
            %   object, H. It returns the baseband modulated output, Y. The input must
            %   be a numeric or logical data type column vector of bits.
            %
            %   DBPSKModulator methods:
            %
            %   step     - Modulate input using DBPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create DBPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of DBPSK modulator object
            %
            %   DBPSKModulator properties:
            %
            %   PhaseRotation  - Additional phase shift
            %   OutputDataType - Data type of output
            %
            %   % Example:
            %   %   Modulate data using DBPSK modulation and visualize the data in a
            %   %   scatter plot
            %
            %   % Create binary data symbols
            %   data = randi([0 1], 96, 1);
            %   % Create a DBPSK modulator System object and set the phase rotation to
            %   % pi/4
            %   hModulator = comm.DBPSKModulator(pi/4);
            %   % Modulate and plot the data
            %   modData = step(hModulator, data);
            %   scatterplot(modData)
            %
            %   See also comm.DBPSKDemodulator, comm.DQPSKModulator.
        end

    end
    methods (Abstract)
    end
    properties
        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'single'. The default is
        %   'double'.
        OutputDataType;

        %PhaseRotation Additional phase shift
        %   Specify the additional phase difference between previous and current
        %   modulated bits in radians as a real scalar. This value corresponds to
        %   the phase difference between previous and current modulated bits when
        %   the input is zero. The default is 0.
        PhaseRotation;

    end
end
