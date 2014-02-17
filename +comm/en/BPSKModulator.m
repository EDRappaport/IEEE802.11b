classdef BPSKModulator< handle
%BPSKModulator Modulate using BPSK method
%   H = comm.BPSKModulator creates a modulator System object, H. This object
%   modulates the input signal using the binary phase shift keying (BPSK)
%   method.
%
%   H = comm.BPSKModulator(Name,Value) creates a BPSK modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.BPSKModulator(PHASE,Name,Value) creates a BPSK modulator
%   object, H, with the PhaseOffset property set to PHASE, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the BPSK modulator System
%   object, H. It returns the baseband modulated output, Y. The input must
%   be a column vector of bits. The data type of the input can be numeric,
%   logical, or unsigned fixed point of word length 1 (fi object).
%
%   BPSKModulator methods:
%
%   step     - Modulate input using BPSK method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create BPSK modulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   BPSKModulator properties:
%
%   PhaseOffset    - Phase of zeroth point of constellation
%   OutputDataType - Data type of output
%
%   The BPSKModulator object supports fixed-point operations. For more
%   information, type comm.BPSKModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using BPSK and visualize the data in a scatter plot
%
%   % Create binary data symbols
%   data = randi([0 1], 96, 1);
%   % Create a BPSK modulator System object
%   hModulator = comm.BPSKModulator;
%   % Change the phase offset to pi/16
%   hModulator.PhaseOffset = pi/16;
%   % Modulate and plot the data
%   modData = step(hModulator, data);
%   scatterplot(modData)
%
%   See also comm.BPSKDemodulator, comm.PSKModulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=BPSKModulator
            %BPSKModulator Modulate using BPSK method
            %   H = comm.BPSKModulator creates a modulator System object, H. This object
            %   modulates the input signal using the binary phase shift keying (BPSK)
            %   method.
            %
            %   H = comm.BPSKModulator(Name,Value) creates a BPSK modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.BPSKModulator(PHASE,Name,Value) creates a BPSK modulator
            %   object, H, with the PhaseOffset property set to PHASE, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the BPSK modulator System
            %   object, H. It returns the baseband modulated output, Y. The input must
            %   be a column vector of bits. The data type of the input can be numeric,
            %   logical, or unsigned fixed point of word length 1 (fi object).
            %
            %   BPSKModulator methods:
            %
            %   step     - Modulate input using BPSK method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create BPSK modulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   BPSKModulator properties:
            %
            %   PhaseOffset    - Phase of zeroth point of constellation
            %   OutputDataType - Data type of output
            %
            %   The BPSKModulator object supports fixed-point operations. For more
            %   information, type comm.BPSKModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using BPSK and visualize the data in a scatter plot
            %
            %   % Create binary data symbols
            %   data = randi([0 1], 96, 1);
            %   % Create a BPSK modulator System object
            %   hModulator = comm.BPSKModulator;
            %   % Change the phase offset to pi/16
            %   hModulator.PhaseOffset = pi/16;
            %   % Modulate and plot the data
            %   modData = step(hModulator, data);
            %   scatterplot(modData)
            %
            %   See also comm.BPSKDemodulator, comm.PSKModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.BPSKDemodulator System object fixed-point
            %               information
            %   comm.BPSKDemodulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.BPSKModulator 
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
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
        %   radians, as a finite, real scalar. The default is 0.
        PhaseOffset;

    end
end
