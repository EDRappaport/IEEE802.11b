classdef QPSKModulator< handle
%QPSKModulator Modulate using QPSK method
%   H = comm.QPSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the quadrature phase shift keying
%   (QPSK) method.
%
%   H = comm.QPSKModulator(Name,Value) creates a QPSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.QPSKModulator(PHASE,Name,Value) creates a QPSK modulator
%   object, H, with the PhaseOffset property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the QPSK modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with numeric, logical, or fixed-point data types.
%
%   QPSKModulator methods:
%
%   step     - Modulate input using QPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create QPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   QPSKModulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation
%   BitInput       - Assume bit inputs
%   SymbolMapping  - Constellation encoding
%   OutputDataType - Data type of output
%
%   The QPSKModulator object supports fixed-point operations. For more
%   information, type comm.QPSKModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using QPSK and visualize the data in a scatter plot
%
%      % Create binary data for 48, 2-bit symbols
%      data = randi([0 1],96,1);
%      % Create a QPSK modulator System object with bits as inputs and
%      % Gray-coded signal constellation
%      hModulator = comm.QPSKModulator('BitInput',true);
%      % Change the phase offset to pi/16
%      hModulator.PhaseOffset = pi/16;
%      % Modulate and plot the data
%      modData = step(hModulator, data);
%      scatterplot(modData)
%
%   See also comm.QPSKDemodulator, comm.PSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=QPSKModulator
            %QPSKModulator Modulate using QPSK method
            %   H = comm.QPSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the quadrature phase shift keying
            %   (QPSK) method.
            %
            %   H = comm.QPSKModulator(Name,Value) creates a QPSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.QPSKModulator(PHASE,Name,Value) creates a QPSK modulator
            %   object, H, with the PhaseOffset property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the QPSK modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with numeric, logical, or fixed-point data types.
            %
            %   QPSKModulator methods:
            %
            %   step     - Modulate input using QPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create QPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   QPSKModulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation
            %   BitInput       - Assume bit inputs
            %   SymbolMapping  - Constellation encoding
            %   OutputDataType - Data type of output
            %
            %   The QPSKModulator object supports fixed-point operations. For more
            %   information, type comm.QPSKModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using QPSK and visualize the data in a scatter plot
            %
            %      % Create binary data for 48, 2-bit symbols
            %      data = randi([0 1],96,1);
            %      % Create a QPSK modulator System object with bits as inputs and
            %      % Gray-coded signal constellation
            %      hModulator = comm.QPSKModulator('BitInput',true);
            %      % Change the phase offset to pi/16
            %      hModulator.PhaseOffset = pi/16;
            %      % Modulate and plot the data
            %      modData = step(hModulator, data);
            %      scatterplot(modData)
            %
            %   See also comm.QPSKDemodulator, comm.PSKModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.QPSKModulator System object fixed-point
            %               information
            %   comm.QPSKModulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.QPSKModulator
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. The default is false.
        %
        %   When you set this property to true, the step method input must be a
        %   column vector of bit values whose length is an integer multiple of 2.
        %   This vector contains bit representations of integers between 0 and 3.
        %   The data type of the input can be numeric, logical, or unsigned fixed
        %   point of word length 1 (fi object).
        %   
        %   When you set this property to false, the step method input must be a
        %   column vector of integer symbol values between 0 and 3.  The data type
        %   of the input can be numeric or unsigned fixed point of word length 2
        %   (fi object).
        BitInput;

        %CustomOutputDataType Fixed-point data type of output
        %   Specify the output fixed-point type as a numerictype object with a
        %   Signedness of Auto. This property applies when you set the
        %   OutputDataType property to 'Custom'. The default is
        %   numerictype([],16).
        %
        %   See also numerictype.
        CustomOutputDataType;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'single' | 'Custom'.
        %   The default is 'double'.
        OutputDataType;

        %PhaseOffset Phase of zeroth point of constellation
        %   Specify the phase offset of the zeroth point of the constellation, in
        %   radians, as a real scalar. The default is pi/4.
        PhaseOffset;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or a group of 2 input bits to
        %   the corresponding symbol as one of 'Binary' | 'Gray'. The default is
        %   'Gray'. When you set this property to 'Gray', the object uses a
        %   Gray-encoded signal constellation. When you set this property to
        %   'Binary', the input integer m (0 <= m <= 3) maps to the complex value
        %   exp(j*PhaseOffset + j*2*pi*m/4).
        SymbolMapping;

    end
end
