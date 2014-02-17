classdef OQPSKModulator< handle
%OQPSKModulator Modulate using OQPSK method
%   H = comm.OQPSKModulator creates a modulator System object, H, that
%   modulates the input signal using the offset quadrature phase shift
%   keying (OQPSK) method.
%
%   H = comm.OQPSKModulator(Name,Value) creates an OQPSK modulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.OQPSKModulator(PHASE,Name,Value) creates an OQPSK modulator
%   object, H, with the PhaseOffset property set to PHASE and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the OQPSK modulator object,
%   H, and returns baseband modulated output, Y. Depending on the value of
%   the BitInput property, input X can be an integer or bit valued column
%   vector with numeric, logical, or fixed-point data types.
%
%   The OQPSK modulator object upsamples by a factor of two. If the input X
%   is length N samples, represented either as integers or bits, the output
%   Y is length 2*N. The step method outputs an initial condition of zero,
%   which is unrelated to the input values.
%
%   OQPSKModulator methods:
%
%   step     - Modulate input using OQPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create OQPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset modulator state 
%   constellation - Ideal signal constellation 
%
%   OQPSKModulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation from pi/4
%   BitInput       - Assume input is bits
%   OutputDataType - Data type of output
%
%   The OQPSKModulator object supports fixed-point operations. For more
%   information, type comm.OQPSKModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using OQPSK and visualize the modulated data in a 
%   %   scatter plot
%
%   % Create binary data for 1000, 2-bit symbols
%   data = randi([0 1],2000,1);
%   % Create an OQPSK modulator System object and accept bits as inputs and 
%   % set a phase offset of pi/16
%   hModulator = comm.OQPSKModulator(pi/16,'BitInput',true);
%   % Modulate and plot the data, ignore the first output symbol
%   modData = step(hModulator, data);
%   scatterplot(modData(2:end))
%
%   See also comm.OQPSKDemodulator, comm.QPSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=OQPSKModulator
            %OQPSKModulator Modulate using OQPSK method
            %   H = comm.OQPSKModulator creates a modulator System object, H, that
            %   modulates the input signal using the offset quadrature phase shift
            %   keying (OQPSK) method.
            %
            %   H = comm.OQPSKModulator(Name,Value) creates an OQPSK modulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.OQPSKModulator(PHASE,Name,Value) creates an OQPSK modulator
            %   object, H, with the PhaseOffset property set to PHASE and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the OQPSK modulator object,
            %   H, and returns baseband modulated output, Y. Depending on the value of
            %   the BitInput property, input X can be an integer or bit valued column
            %   vector with numeric, logical, or fixed-point data types.
            %
            %   The OQPSK modulator object upsamples by a factor of two. If the input X
            %   is length N samples, represented either as integers or bits, the output
            %   Y is length 2*N. The step method outputs an initial condition of zero,
            %   which is unrelated to the input values.
            %
            %   OQPSKModulator methods:
            %
            %   step     - Modulate input using OQPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create OQPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset modulator state 
            %   constellation - Ideal signal constellation 
            %
            %   OQPSKModulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation from pi/4
            %   BitInput       - Assume input is bits
            %   OutputDataType - Data type of output
            %
            %   The OQPSKModulator object supports fixed-point operations. For more
            %   information, type comm.OQPSKModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using OQPSK and visualize the modulated data in a 
            %   %   scatter plot
            %
            %   % Create binary data for 1000, 2-bit symbols
            %   data = randi([0 1],2000,1);
            %   % Create an OQPSK modulator System object and accept bits as inputs and 
            %   % set a phase offset of pi/16
            %   hModulator = comm.OQPSKModulator(pi/16,'BitInput',true);
            %   % Modulate and plot the data, ignore the first output symbol
            %   modData = step(hModulator, data);
            %   scatterplot(modData(2:end))
            %
            %   See also comm.OQPSKDemodulator, comm.QPSKModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.OQPSKModulator System object 
            %               fixed-point information
            %   comm.OQPSKModulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the
            %   comm.OQPSKModulator System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitInput Assume input is bits
        %   Specify whether the input is bits or integers. The default is false.
        %   
        %   When you set this property to true, the input values are bit
        %   representations of integers between 0 and 3. The input must be a
        %   column vector of bit values with length that is an integer multiple of
        %   2. The data type of the input can be numeric, logical, or unsigned
        %   fixed point of word length 1 (fi object).
        %   
        %   When you set this property to false, the input must be a column vector
        %   of integer values between 0 and 3. The data type of the input can be
        %   numeric or unsigned fixed point of word length 2 (fi object).
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

        %PhaseOffset Phase of zeroth point of constellation from pi/4
        %   Specify the phase offset of the zeroth point of the constellation
        %   shifted from pi/4, in radians, as a finite, real valued scalar. The
        %   default is 0.
        PhaseOffset;

    end
end
