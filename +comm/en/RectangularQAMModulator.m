classdef RectangularQAMModulator< handle
%RectangularQAMModulator Modulate using rectangular QAM method
%   H = comm.RectangularQAMModulator creates a modulator object, H. This
%   object modulates the input using the rectangular quadrature amplitude
%   modulation (QAM) method.
%
%   H = comm.RectangularQAMModulator(Name,Value) creates a rectangular QAM
%   modulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RectangularQAMModulator(M,Name,Value) creates a rectangular QAM
%   modulator object, H, with the ModulationOrder property set to M, and
%   other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the rectangular QAM
%   modulator object, H. It returns the baseband modulated output, Y.
%   Depending on the value of the BitInput property, input X can be an
%   integer or bit valued column vector with numeric, logical, or
%   fixed-point data types.
%
%   RectangularQAMModulator methods:
%
%   step     - Modulate input using rectangular QAM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create rectangular QAM modulator object with same property
%              values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%
%   RectangularQAMModulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   PhaseOffset         - Phase offset of constellation
%   BitInput            - Assume bit inputs
%   SymbolMapping       - Constellation encoding
%   CustomSymbolMapping - Custom constellation encoding
%   NormalizationMethod - Constellation normalization method
%   MinimumDistance     - Minimum distance between symbols
%   AveragePower        - Average power of constellation
%   PeakPower           - Peak power of constellation
%   OutputDataType      - Data type of output
%
%   The RectangularQAMModulator object supports fixed-point operations. For
%   more information, type comm.RectangularQAMModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using rectangular QAM modulation and visualize the 
%   %   data in a scatter plot
%
%   % Create binary data for 32, 3-bit symbols
%   data = randi([0 1],96,1);
%   % Create a rectangular 8-QAM modulator System object with bits as 
%   % inputs and Gray-coded signal constellation
%   hModulator = comm.RectangularQAMModulator(8,'BitInput',true);
%   % Rotate the constellation by pi/4 radians
%   hModulator.PhaseOffset = pi/4;
%   % Modulate and plot the data
%   modData = step(hModulator, data); 
%   scatterplot(modData)
%
%   See also comm.RectangularQAMDemodulator, comm.GeneralQAMModulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=RectangularQAMModulator
            %RectangularQAMModulator Modulate using rectangular QAM method
            %   H = comm.RectangularQAMModulator creates a modulator object, H. This
            %   object modulates the input using the rectangular quadrature amplitude
            %   modulation (QAM) method.
            %
            %   H = comm.RectangularQAMModulator(Name,Value) creates a rectangular QAM
            %   modulator object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RectangularQAMModulator(M,Name,Value) creates a rectangular QAM
            %   modulator object, H, with the ModulationOrder property set to M, and
            %   other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the rectangular QAM
            %   modulator object, H. It returns the baseband modulated output, Y.
            %   Depending on the value of the BitInput property, input X can be an
            %   integer or bit valued column vector with numeric, logical, or
            %   fixed-point data types.
            %
            %   RectangularQAMModulator methods:
            %
            %   step     - Modulate input using rectangular QAM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create rectangular QAM modulator object with same property
            %              values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %
            %   RectangularQAMModulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   PhaseOffset         - Phase offset of constellation
            %   BitInput            - Assume bit inputs
            %   SymbolMapping       - Constellation encoding
            %   CustomSymbolMapping - Custom constellation encoding
            %   NormalizationMethod - Constellation normalization method
            %   MinimumDistance     - Minimum distance between symbols
            %   AveragePower        - Average power of constellation
            %   PeakPower           - Peak power of constellation
            %   OutputDataType      - Data type of output
            %
            %   The RectangularQAMModulator object supports fixed-point operations. For
            %   more information, type comm.RectangularQAMModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using rectangular QAM modulation and visualize the 
            %   %   data in a scatter plot
            %
            %   % Create binary data for 32, 3-bit symbols
            %   data = randi([0 1],96,1);
            %   % Create a rectangular 8-QAM modulator System object with bits as 
            %   % inputs and Gray-coded signal constellation
            %   hModulator = comm.RectangularQAMModulator(8,'BitInput',true);
            %   % Rotate the constellation by pi/4 radians
            %   hModulator.PhaseOffset = pi/4;
            %   % Modulate and plot the data
            %   modData = step(hModulator, data); 
            %   scatterplot(modData)
            %
            %   See also comm.RectangularQAMDemodulator, comm.GeneralQAMModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.RectangularQAMModulator System object 
            %               fixed-point information
            %   comm.RectangularQAMModulator.helpFixedPoint displays
            %   information about fixed-point properties and operations of the
            %   comm.RectangularQAMModulator System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %AveragePower Average power of constellation
        %   Specify the average power of the symbols in the constellation as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Average power'. The default is 1.
        AveragePower;

        %BitInput Assume bit inputs
        %   Specify whether the input is bits or integers. The default is false.
        %
        %   When you set this property to true, the step method input must be a
        %   column vector of bit values whose length is an integer multiple of
        %   log2(ModulationOrder). This vector contains bit representations of
        %   integers between 0 and ModulationOrder-1. The data type of the input
        %   can be numeric, logical, or unsigned fixed point of word length 1 (fi
        %   object).
        %  
        %   When you set this property to false, the step method input must be a
        %   column vector of integer symbol values between 0 and
        %   ModulationOrder-1. The data type of the input can be numeric or
        %   unsigned fixed point of word length log2(ModulationOrder) (fi object).
        BitInput;

        %CustomOutputDataType Fixed-point data type of output
        %   Specify the output fixed-point type as a numerictype object with a
        %   Signedness of Auto. This property applies when you set the
        %   OutputDataType property to 'Custom'. The default is
        %   numerictype([],16).
        %
        %   See also numerictype.
        CustomOutputDataType;

        %CustomSymbolMapping Custom constellation encoding
        %   Specify a custom constellation symbol mapping vector. This property is
        %   a row or column vector of size ModulationOrder with unique integer
        %   values in the range [0, ModulationOrder-1]. The values must be of data
        %   type double. The first element of this vector corresponds to the
        %   top-leftmost point of the constellation, with subsequent elements
        %   running down column-wise, from left to right. The last element
        %   corresponds to the bottom-rightmost point. This property applies when
        %   you set the SymbolMapping property is 'Custom'. The default is 0:15.
        CustomSymbolMapping;

        %MinimumDistance Minimum distance between symbols
        %   Specify the distance between two nearest constellation points as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Minimum distance between symbols'.
        %   The default is 2.
        MinimumDistance;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as scalar
        %   that is a positive integer power of two. The default is 16.
        ModulationOrder;

        %NormalizationMethod Constellation normalization method
        %   Specify the method used to normalize the signal constellation as one
        %   of 'Minimum distance between symbols' | 'Average power' | 'Peak
        %   power'. The default is 'Minimum distance between symbols'.
        NormalizationMethod;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'single' | 'Custom'.
        %   The default is 'double'.
        OutputDataType;

        %PeakPower Peak power of constellation
        %   Specify the maximum power of the symbols in the constellation as a
        %   positive real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Peak power'. The default is 1.
        PeakPower;

        %PhaseOffset Phase offset of constellation
        %   Specify the phase offset of the signal constellation, in radians, as a
        %   real scalar. The default is 0.
        PhaseOffset;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) input bits to the corresponding symbol as one of
        %   'Binary' | 'Gray' | 'Custom'. The default is 'Gray'. When you set this
        %   property to 'Gray', the System object uses a Gray-coded signal
        %   constellation. When you set this property to 'Binary', the object uses
        %   a natural binary-coded constellation. When you set this property to
        %   'Custom', the object uses the signal constellation defined in the
        %   CustomSymbolMapping property.
        SymbolMapping;

    end
end
