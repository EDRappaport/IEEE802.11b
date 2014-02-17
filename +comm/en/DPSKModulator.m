classdef DPSKModulator< handle
%DPSKModulator Modulate using M-ary DPSK method
%   H = comm.DPSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the M-ary differential phase shift
%   keying (M-DPSK) method.
%
%   H = comm.DPSKModulator(Name,Value) creates an M-DPSK modulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.DPSKModulator(M,PHASE,Name,Value) creates an M-DPSK modulator
%   object, H, with the ModulationOrder property set to M, the PhaseRotation
%   property set to PHASE, and other specified property Names set to the
%   specified Values. M and PHASE are value-only arguments. To specify a
%   value-only argument, you must also specify all preceding value-only
%   arguments. You can specify name-value pair arguments in any order.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the DPSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with numeric or logical data types.
%
%   DPSKModulator methods:
%
%   step     - Modulate input using M-DPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create M-DPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of M-DPSK modulator object
%
%   DPSKModulator properties:
%
%   ModulationOrder - Number of points in signal constellation
%   PhaseRotation   - Additional phase shift
%   BitInput        - Assume bit inputs
%   SymbolMapping   - Constellation encoding
%   OutputDataType  - Data type of output
%
%   % Example:
%   %   Modulate data using 8-DPSK modulation and visualize the data in a
%   %   scatter plot
%
%   % Create binary data for 1000, 3 bit symbols
%   data = randi([0 1],3000,1);
%   % Create an 8-DPSK modulator System object with bits as inputs,
%   % phase rotation of pi/4 and Gray-coded signal constellation
%   hModulator = comm.DPSKModulator(8,pi/4,'BitInput',true);
%   % Modulate and plot the data
%   modData = step(hModulator, data);
%   scatterplot(modData)
%
%   See also comm.DPSKDemodulator, comm.DBPSKModulator, comm.DQPSKModulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=DPSKModulator
            %DPSKModulator Modulate using M-ary DPSK method
            %   H = comm.DPSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the M-ary differential phase shift
            %   keying (M-DPSK) method.
            %
            %   H = comm.DPSKModulator(Name,Value) creates an M-DPSK modulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.DPSKModulator(M,PHASE,Name,Value) creates an M-DPSK modulator
            %   object, H, with the ModulationOrder property set to M, the PhaseRotation
            %   property set to PHASE, and other specified property Names set to the
            %   specified Values. M and PHASE are value-only arguments. To specify a
            %   value-only argument, you must also specify all preceding value-only
            %   arguments. You can specify name-value pair arguments in any order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the DPSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with numeric or logical data types.
            %
            %   DPSKModulator methods:
            %
            %   step     - Modulate input using M-DPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create M-DPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of M-DPSK modulator object
            %
            %   DPSKModulator properties:
            %
            %   ModulationOrder - Number of points in signal constellation
            %   PhaseRotation   - Additional phase shift
            %   BitInput        - Assume bit inputs
            %   SymbolMapping   - Constellation encoding
            %   OutputDataType  - Data type of output
            %
            %   % Example:
            %   %   Modulate data using 8-DPSK modulation and visualize the data in a
            %   %   scatter plot
            %
            %   % Create binary data for 1000, 3 bit symbols
            %   data = randi([0 1],3000,1);
            %   % Create an 8-DPSK modulator System object with bits as inputs,
            %   % phase rotation of pi/4 and Gray-coded signal constellation
            %   hModulator = comm.DPSKModulator(8,pi/4,'BitInput',true);
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
        %   values whose length is an integer multiple of log2(ModulationOrder).
        %   This vector contains bit representations of integers between 0 and
        %   ModulationOrder-1. When you set this property to false, the step
        %   method input must be a column vector of integer symbol values between
        %   0 and ModulationOrder-1. The default is false.
        BitInput;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. The default is 8.
        ModulationOrder;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'single'. The default is
        %   'double'.
        OutputDataType;

        %PhaseRotation Additional phase shift
        %   Specify the additional phase difference between previous and current
        %   modulated symbols in radians as a real scalar. This value corresponds
        %   to the phase difference between previous and current modulated symbols
        %   when the input is zero. The default is pi/8.
        PhaseRotation;

        %SymbolMapping Constellation encoding  
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) input bits to the corresponding symbol as one of
        %   'Binary' | 'Gray'. The default is 'Gray'. When you set this property
        %   to 'Gray', the object uses a Gray-encoded signal constellation. When
        %   you set this property to 'Binary', the input integer m (0 <= m <=
        %   ModulationOrder-1) shifts the output phase by (PhaseRotation +
        %   2*pi*m/ModulationOrder) radians from the previous output phase, i.e.
        %   the output symbol is exp(j*PhaseRotation +
        %   j*2*pi*m/ModulationOrder)*(previously modulated symbol).
        SymbolMapping;

    end
end
