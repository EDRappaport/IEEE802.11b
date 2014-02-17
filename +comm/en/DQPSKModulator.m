classdef DQPSKModulator< handle
%DQPSKModulator Modulate using DQPSK method
%   H = comm.DQPSKModulator creates a modulator System object, H. This
%   object modulates the input signal using the differential quadrature
%   phase shift keying (DQPSK) method.
%
%   H = comm.DQPSKModulator(Name,Value) creates a DQPSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DQPSKModulator(PHASE,Name,Value) creates a DQPSK modulator
%   object, H, with the PhaseRotation property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the DQPSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with numeric or logical data types.
%
%   DQPSKModulator methods:
%
%   step     - Modulate input using DQPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create DQPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of DQPSK modulator object
%
%   DQPSKModulator properties:
%
%   PhaseRotation  - Additional phase shift
%   BitInput       - Assume bit inputs
%   SymbolMapping  - Constellation encoding
%   OutputDataType - Data type of output
%
%   % Example:
%   %   Modulate data using DQPSK modulation and visualize the data in a
%   %   scatter plot
%
%   % Create binary data for 100, 4 bit symbols
%   data = randi([0 1],400,1);
%   % Create a DQPSK modulator System object with bits as inputs,
%   % phase rotation of pi/8 and Gray-coded constellation
%   hModulator = comm.DQPSKModulator(pi/8,'BitInput',true);
%   % Modulate and plot the data
%   modData = step(hModulator, data);
%   scatterplot(modData)
%
%   See also comm.DPSKDemodulator, comm.DBPSKModulator, comm.DQPSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=DQPSKModulator
            %DQPSKModulator Modulate using DQPSK method
            %   H = comm.DQPSKModulator creates a modulator System object, H. This
            %   object modulates the input signal using the differential quadrature
            %   phase shift keying (DQPSK) method.
            %
            %   H = comm.DQPSKModulator(Name,Value) creates a DQPSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DQPSKModulator(PHASE,Name,Value) creates a DQPSK modulator
            %   object, H, with the PhaseRotation property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the DQPSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with numeric or logical data types.
            %
            %   DQPSKModulator methods:
            %
            %   step     - Modulate input using DQPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create DQPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of DQPSK modulator object
            %
            %   DQPSKModulator properties:
            %
            %   PhaseRotation  - Additional phase shift
            %   BitInput       - Assume bit inputs
            %   SymbolMapping  - Constellation encoding
            %   OutputDataType - Data type of output
            %
            %   % Example:
            %   %   Modulate data using DQPSK modulation and visualize the data in a
            %   %   scatter plot
            %
            %   % Create binary data for 100, 4 bit symbols
            %   data = randi([0 1],400,1);
            %   % Create a DQPSK modulator System object with bits as inputs,
            %   % phase rotation of pi/8 and Gray-coded constellation
            %   hModulator = comm.DQPSKModulator(pi/8,'BitInput',true);
            %   % Modulate and plot the data
            %   modData = step(hModulator, data);
            %   scatterplot(modData)
            %
            %   See also comm.DPSKDemodulator, comm.DBPSKModulator, comm.DQPSKModulator.
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. When you set this
        %   property to true, the step method input must be a column vector of bit
        %   values whose length is an integer multiple of 2. This vector contains
        %   bit representations of integers between 0 and 3. When you set this
        %   property to false, the step method input must be a column vector of
        %   integer symbol values between 0 and 3. The default is false.
        BitInput;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'single'. The default is
        %   'double'.
        OutputDataType;

        %PhaseRotation Additional phase shift
        %   Specify the additional phase difference between previous and current
        %   modulated symbols in radians as a real scalar. This value corresponds
        %   to the phase difference between previous and current modulated symbols
        %   when the input is zero. The default is pi/4.
        PhaseRotation;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of 2 input bits to the
        %   corresponding symbol as one of 'Binary' | 'Gray'. The default is
        %   'Gray'. When you set this property to 'Gray', the object uses a
        %   Gray-encoded signal constellation. When you set this property to
        %   'Binary', the input integer m (0 <= m <= 3) shifts the output phase by
        %   (PhaseRotation + 2*pi*m/4) radians from the previous output phase,
        %   i.e. the output symbol is exp(j*PhaseRotation +
        %   j*2*pi*m/4)*(previously modulated symbol).
        SymbolMapping;

    end
end
