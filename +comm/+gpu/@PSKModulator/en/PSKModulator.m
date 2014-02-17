classdef PSKModulator< handle
%PSKModulator M-ary PSK Modulator (GPU)
%   H = comm.gpu.PSKModulator creates a modulator System object, H. This
%   object modulates the input signal using the M-ary phase shift keying
%   (M-PSK) method.
%
%   Use of this object requires a Parallel Computing Toolbox license.
%
%   H = comm.gpu.PSKModulator(Name,Value) creates an M-PSK modulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.PSKModulator(M,PHASE,Name,Value) creates an M-PSK
%   modulator object, H, with the ModulationOrder property set to M, the
%   PhaseOffset property set to PHASE, and other specified property Names
%   set to the specified Values. M and PHASE are value-only arguments. To
%   specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the PSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with numeric or logical data types.
%
%   PSKModulator methods:
%
%   step     - Modulate input using M-PSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PSK modulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation PhaseOffset = pi/8
%
%   PSKModulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   PhaseOffset         - Phase of zeroth point of constellation
%   BitInput            - Assume bit inputs
%   SymbolMapping       - Constellation encoding
%   CustomSymbolMapping - Custom constellation encoding
%   OutputDataType      - Data type of output
%
%   % Example:
%   %   Modulate data using 16-PSK modulation and visualize the data in a 
%   %   scatter plot
%
%   % Create binary data for 24, 4-bit symbols 
%   data = randi([0 1],96,1);
%   % Create a 16-PSK modulator System object with bits as inputs and
%   % Gray-coded signal constellation
%   hModulator = comm.gpu.PSKModulator(16,'BitInput',true);
%   % Change the phase offset to pi/16 
%   hModulator.PhaseOffset = pi/16; 
%   % Modulate and plot the data
%   modData = step(hModulator, data); 
%   scatterplot(modData)
%
%   See also comm.PSKModulator, comm.PSKDemodulator, comm.QPSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PSKModulator
            %PSKModulator M-ary PSK Modulator (GPU)
            %   H = comm.gpu.PSKModulator creates a modulator System object, H. This
            %   object modulates the input signal using the M-ary phase shift keying
            %   (M-PSK) method.
            %
            %   Use of this object requires a Parallel Computing Toolbox license.
            %
            %   H = comm.gpu.PSKModulator(Name,Value) creates an M-PSK modulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.PSKModulator(M,PHASE,Name,Value) creates an M-PSK
            %   modulator object, H, with the ModulationOrder property set to M, the
            %   PhaseOffset property set to PHASE, and other specified property Names
            %   set to the specified Values. M and PHASE are value-only arguments. To
            %   specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the PSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with numeric or logical data types.
            %
            %   PSKModulator methods:
            %
            %   step     - Modulate input using M-PSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation PhaseOffset = pi/8
            %
            %   PSKModulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   PhaseOffset         - Phase of zeroth point of constellation
            %   BitInput            - Assume bit inputs
            %   SymbolMapping       - Constellation encoding
            %   CustomSymbolMapping - Custom constellation encoding
            %   OutputDataType      - Data type of output
            %
            %   % Example:
            %   %   Modulate data using 16-PSK modulation and visualize the data in a 
            %   %   scatter plot
            %
            %   % Create binary data for 24, 4-bit symbols 
            %   data = randi([0 1],96,1);
            %   % Create a 16-PSK modulator System object with bits as inputs and
            %   % Gray-coded signal constellation
            %   hModulator = comm.gpu.PSKModulator(16,'BitInput',true);
            %   % Change the phase offset to pi/16 
            %   hModulator.PhaseOffset = pi/16; 
            %   % Modulate and plot the data
            %   modData = step(hModulator, data); 
            %   scatterplot(modData)
            %
            %   See also comm.PSKModulator, comm.PSKDemodulator, comm.QPSKModulator.
        end

        function directcmpt_md2(in) %#ok<MANU>
        end

        function directcmpt_md4(in) %#ok<MANU>
        end

        function directcmpt_md8(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setupGPUImpl(in) %#ok<MANU>
        end

        function stepGPUBitInput(in) %#ok<MANU>
        end

        function stepGPUImpl(in) %#ok<MANU>
        end

        function stepGPUIntegerInput(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. The default is false.
        %
        %   When you set this property to true, the step method input must be a
        %   column vector of bit values whose length is an integer multiple of
        %   log2(ModulationOrder). This vector contains bit representations of
        %   integers between 0 and ModulationOrder-1. The data type of the input
        %   can be numeric or logical.
        %
        %   When you set the BitInput property to false, the step method input
        %   must be a column vector of integer symbol values between 0 and
        %   ModulationOrder-1. The data type of the input must be numeric.
        BitInput;

        %CustomSymbolMapping Custom constellation encoding
        %   Specify a custom constellation symbol mapping vector. This property is
        %   a row or column vector of size ModulationOrder and must have unique
        %   integer values in the range [0, ModulationOrder-1]. The values must be
        %   of data type double. The first element of this vector corresponds to
        %   the constellation point at an angle of 0 + PhaseOffset, with
        %   subsequent elements running counterclockwise. The last element
        %   corresponds to the constellation point at an angle of
        %   -pi/ModulationOrder + PhaseOffset. This property applies when you set
        %   the SymbolMapping property to 'Custom'. The default is 0:7.
        CustomSymbolMapping;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. The default is 8.
        ModulationOrder;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'single'.
        %   The default is 'double'.
        OutputDataType;

        %PhaseOffset Phase of zeroth point of constellation
        %   Specify the phase offset of the zeroth point of the constellation, in
        %   radians, as a real scalar. The default is pi/8.
        PhaseOffset;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) input bits to the corresponding symbol as one of
        %   'Binary' | 'Gray' | 'Custom'. The default is 'Gray'. When you set this
        %   property to 'Gray', the object uses a Gray-encoded signal
        %   constellation. When you set this property to 'Binary', the input
        %   integer m (0 <= m <= ModulationOrder-1) maps to the complex value
        %   exp(j*PhaseOffset + j*2*pi*m/ModulationOrder). When you set this
        %   property to 'Custom', the object uses the signal constellation defined
        %   in the CustomSymbolMapping property.
        SymbolMapping;

    end
end
