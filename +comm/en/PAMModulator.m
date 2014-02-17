classdef PAMModulator< handle
%PAMModulator Modulate using M-ary PAM method
%   H = comm.PAMModulator creates a modulator System object, H. This object
%   modulates the input signal using the M-ary pulse amplitude modulation
%   (M-PAM) method.
%
%   H = comm.PAMModulator(Name,Value) creates an M-PAM modulator object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PAMModulator(M,Name,Value) creates an M-PAM modulator object,
%   H, with the ModulationOrder property set to M and other specified
%   property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the M-PAM modulator System
%   object, H. It returns the baseband modulated output, Y. Depending on the
%   value of the BitInput property, input X can be an integer or bit valued
%   column vector with numeric, logical, or fixed-point data types.
%
%   PAMModulator methods:
%
%   step     - Modulate input using PAM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PAM modulator object with same property values
%   isLocked - Locked status (logical)
%   constellation - Ideal signal constellation 
%    
%   PAMModulator properties:
%
%   ModulationOrder     - Number of points in signal constellation
%   BitInput            - Assume bit inputs
%   SymbolMapping       - Constellation encoding
%   NormalizationMethod - Constellation normalization method
%   MinimumDistance     - Minimum distance between symbols
%   AveragePower        - Average power of constellation
%   PeakPower           - Peak power of constellation
%   OutputDataType      - Data type of output
%
%   Fixed-point property information:
%
%   The PAMModulator object supports fixed-point operations. For more
%   information, type comm.PAMModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using 16-PAM modulation and visualize the data in a 
%   %   scatter plot
%
%   % Create binary data for 100, 4-bit symbols 
%   data = randi([0 1],400,1);
%   % Create a 16-PAM modulator System object with bits as inputs and
%   % Gray-coded signal constellation
%   hModulator = comm.PAMModulator(16,'BitInput',true);
%   % Modulate and plot the data
%   modData = step(hModulator, data); 
%   scatterplot(modData)
%
%   See also comm.PAMDemodulator.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PAMModulator
            %PAMModulator Modulate using M-ary PAM method
            %   H = comm.PAMModulator creates a modulator System object, H. This object
            %   modulates the input signal using the M-ary pulse amplitude modulation
            %   (M-PAM) method.
            %
            %   H = comm.PAMModulator(Name,Value) creates an M-PAM modulator object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PAMModulator(M,Name,Value) creates an M-PAM modulator object,
            %   H, with the ModulationOrder property set to M and other specified
            %   property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the M-PAM modulator System
            %   object, H. It returns the baseband modulated output, Y. Depending on the
            %   value of the BitInput property, input X can be an integer or bit valued
            %   column vector with numeric, logical, or fixed-point data types.
            %
            %   PAMModulator methods:
            %
            %   step     - Modulate input using PAM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PAM modulator object with same property values
            %   isLocked - Locked status (logical)
            %   constellation - Ideal signal constellation 
            %    
            %   PAMModulator properties:
            %
            %   ModulationOrder     - Number of points in signal constellation
            %   BitInput            - Assume bit inputs
            %   SymbolMapping       - Constellation encoding
            %   NormalizationMethod - Constellation normalization method
            %   MinimumDistance     - Minimum distance between symbols
            %   AveragePower        - Average power of constellation
            %   PeakPower           - Peak power of constellation
            %   OutputDataType      - Data type of output
            %
            %   Fixed-point property information:
            %
            %   The PAMModulator object supports fixed-point operations. For more
            %   information, type comm.PAMModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using 16-PAM modulation and visualize the data in a 
            %   %   scatter plot
            %
            %   % Create binary data for 100, 4-bit symbols 
            %   data = randi([0 1],400,1);
            %   % Create a 16-PAM modulator System object with bits as inputs and
            %   % Gray-coded signal constellation
            %   hModulator = comm.PAMModulator(16,'BitInput',true);
            %   % Modulate and plot the data
            %   modData = step(hModulator, data); 
            %   scatterplot(modData)
            %
            %   See also comm.PAMDemodulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.PAMModulator System object  
            %               fixed-point information
            %   comm.PAMModulator.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.PAMModulator
            %   System object.
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
        %   unsigned fixed point of word length ceil(log2(ModulationOrder)) (fi
        %   object).
        BitInput;

        %CustomOutputDataType Fixed-point data type of output
        %   Specify the output fixed-point type as a numerictype object with a
        %   Signedness of Auto. This property applies when you set the
        %   OutputDataType property to 'Custom'. The default is
        %   numerictype([],16).
        %
        %   See also numerictype.
        CustomOutputDataType;

        %MinimumDistance Minimum distance between symbols
        %   Specify the distance between two nearest constellation points as a
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Minimum distance between symbols'.
        %   The default is 2.
        MinimumDistance;

        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation as a
        %   positive, integer scalar. When you set the BitInput property to false,
        %   ModulationOrder must be even. When you set the BitInput property to
        %   true, ModulationOrder must be an integer power of two. The default is
        %   4.
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
        %   positive, real, numeric scalar. This property applies when you set the
        %   NormalizationMethod property to 'Peak power'. The default is 1.
        PeakPower;

        %SymbolMapping Constellation encoding
        %   Specify how the object maps an integer or group of
        %   log2(ModulationOrder) input bits to the corresponding symbol as one of
        %   'Binary' | 'Gray'. The default is 'Gray'. When you set this property
        %   to 'Gray', the object uses a Gray-encoded signal constellation. When
        %   you set this property to 'Binary', the input integer m (0 <= m <=
        %   ModulationOrder-1) maps to the complex value 2m - ModulationOrder + 1.
        SymbolMapping;

    end
end
