classdef GeneralQAMModulator< handle
%GeneralQAMModulator Modulate using arbitrary QAM constellation
%   H = comm.GeneralQAMModulator creates a modulator System object, H. This
%   object modulates the input signal using a general quadrature amplitude
%   modulation (QAM) method.
%
%   H = comm.GeneralQAMModulator(Name,Value) creates a QAM modulator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.GeneralQAMModulator(CONST,Name,Value) creates a General QAM
%   modulator object, H, with the Constellation property set to CONST, and
%   other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) modulates input data, X, with the general QAM modulator
%   System object, H. It returns the baseband modulated output, Y. The input
%   must be an integer scalar or an integer-valued column vector. The data
%   type of the input can be numeric or unsigned fixed point of word length
%   ceil(log2(ModulationOrder)) (fi object).
%
%   GeneralQAMModulator methods:
%
%   step     - Modulate input using arbitrary QAM constellation (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create general QAM modulator object with same property
%              values
%   isLocked - Locked status (logical)
%
%   GeneralQAMModulator properties:
%
%   Constellation  - Signal constellation
%   OutputDataType - Data type of output
%
%   The GeneralQAMModulator object supports fixed-point operations. For more
%   information, type comm.GeneralQAMModulator.helpFixedPoint.
%
%   % Example:
%   %   Modulate data using an arbitrary three point constellation and 
%   %   visualize the data in a scatter plot
%
%      hQAMMod = comm.GeneralQAMModulator;     
%      % Setup a three point constellation
%      hQAMMod.Constellation = [1 1i -1];
%      data = randi([0 2],100,1);
%      modData = step(hQAMMod, data);
%      scatterplot(modData)
%
%   See also comm.GeneralQAMDemodulator, comm.RectangularQAMModulator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=GeneralQAMModulator
            %GeneralQAMModulator Modulate using arbitrary QAM constellation
            %   H = comm.GeneralQAMModulator creates a modulator System object, H. This
            %   object modulates the input signal using a general quadrature amplitude
            %   modulation (QAM) method.
            %
            %   H = comm.GeneralQAMModulator(Name,Value) creates a QAM modulator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.GeneralQAMModulator(CONST,Name,Value) creates a General QAM
            %   modulator object, H, with the Constellation property set to CONST, and
            %   other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) modulates input data, X, with the general QAM modulator
            %   System object, H. It returns the baseband modulated output, Y. The input
            %   must be an integer scalar or an integer-valued column vector. The data
            %   type of the input can be numeric or unsigned fixed point of word length
            %   ceil(log2(ModulationOrder)) (fi object).
            %
            %   GeneralQAMModulator methods:
            %
            %   step     - Modulate input using arbitrary QAM constellation (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create general QAM modulator object with same property
            %              values
            %   isLocked - Locked status (logical)
            %
            %   GeneralQAMModulator properties:
            %
            %   Constellation  - Signal constellation
            %   OutputDataType - Data type of output
            %
            %   The GeneralQAMModulator object supports fixed-point operations. For more
            %   information, type comm.GeneralQAMModulator.helpFixedPoint.
            %
            %   % Example:
            %   %   Modulate data using an arbitrary three point constellation and 
            %   %   visualize the data in a scatter plot
            %
            %      hQAMMod = comm.GeneralQAMModulator;     
            %      % Setup a three point constellation
            %      hQAMMod.Constellation = [1 1i -1];
            %      data = randi([0 2],100,1);
            %      modData = step(hQAMMod, data);
            %      scatterplot(modData)
            %
            %   See also comm.GeneralQAMDemodulator, comm.RectangularQAMModulator.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.GeneralQAMModulator System object 
            %               fixed-point information
            %   comm.GeneralQAMModulator.helpFixedPoint displays information
            %   about fixed-point properties and operations of the
            %   comm.GeneralQAMModulator System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Constellation Signal constellation
        %   Specify the constellation points as real or complex double precision
        %   data type vector. The length of the vector, M, determines the
        %   modulation order. The step method inputs must be integers between 0
        %   and M-1. The object maps an input integer m to the (m+1)st value in
        %   the Constellation vector. The default value is exp(2*pi*1i*(0:7)/8).
        Constellation;

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

    end
end
