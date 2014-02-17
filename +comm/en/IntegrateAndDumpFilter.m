classdef IntegrateAndDumpFilter< handle
%IntegrateAndDumpFilter Integrate discrete-time signal with periodic resets
%   H = comm.IntegrateAndDumpFilter creates an integrate and dump filter
%   System object, H. This object integrates over a number of samples in an
%   integration period, and then resets at the end of that period.
%
%   H = comm.IntegrateAndDumpFilter(Name,Value) creates an integrate and
%   dump filter object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.IntegrateAndDumpFilter(PERIOD,Name,Value) creates an integrate
%   and dump filter object, H, with the IntegrationPeriod property set to
%   PERIOD, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) periodically integrates blocks of N samples from the input
%   data, X, and returns the result in Y. N is the number of samples that
%   you specify in the IntegrationPeriod property. X is a column vector or a
%   matrix and the data type is double, single or fixed-point (fi objects).
%   X must have K*N rows for some positive integer K, with one or more
%   columns. The object treats each column as an independent channel with
%   integration occurring along every column. The dimensions of output Y
%   depend on the value you set for the DecimateOutput property.
%
%   IntegrateAndDumpFilter methods:
%
%   step     - Integrate input signal with periodic resets (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create integrate and dump filter object with same property 
%              values
%   isLocked - Locked status (logical)
%
%   IntegrateAndDumpFilter properties:
%
%   IntegrationPeriod - Integration period
%   Offset            - Number of offset samples
%   DecimateOutput    - Decimate output
%
%   The IntegrateAndDumpFilter object supports fixed-point operations. For
%   more information, type comm.IntegrateAndDumpFilter.helpFixedPoint.
%
%   % Example: 
%   %   Integrate a signal using an integration period of 5 samples and an
%   %   offset of 3 samples
%
%   hInt = comm.IntegrateAndDumpFilter(5);
%   hInt.Offset = 3;
%   % Data matrix contains three columns (i.e. three channels)
%   data = reshape(1:30, 10, 3);
%   result = step(hInt, data)

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=IntegrateAndDumpFilter
            %IntegrateAndDumpFilter Integrate discrete-time signal with periodic resets
            %   H = comm.IntegrateAndDumpFilter creates an integrate and dump filter
            %   System object, H. This object integrates over a number of samples in an
            %   integration period, and then resets at the end of that period.
            %
            %   H = comm.IntegrateAndDumpFilter(Name,Value) creates an integrate and
            %   dump filter object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.IntegrateAndDumpFilter(PERIOD,Name,Value) creates an integrate
            %   and dump filter object, H, with the IntegrationPeriod property set to
            %   PERIOD, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) periodically integrates blocks of N samples from the input
            %   data, X, and returns the result in Y. N is the number of samples that
            %   you specify in the IntegrationPeriod property. X is a column vector or a
            %   matrix and the data type is double, single or fixed-point (fi objects).
            %   X must have K*N rows for some positive integer K, with one or more
            %   columns. The object treats each column as an independent channel with
            %   integration occurring along every column. The dimensions of output Y
            %   depend on the value you set for the DecimateOutput property.
            %
            %   IntegrateAndDumpFilter methods:
            %
            %   step     - Integrate input signal with periodic resets (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create integrate and dump filter object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %
            %   IntegrateAndDumpFilter properties:
            %
            %   IntegrationPeriod - Integration period
            %   Offset            - Number of offset samples
            %   DecimateOutput    - Decimate output
            %
            %   The IntegrateAndDumpFilter object supports fixed-point operations. For
            %   more information, type comm.IntegrateAndDumpFilter.helpFixedPoint.
            %
            %   % Example: 
            %   %   Integrate a signal using an integration period of 5 samples and an
            %   %   offset of 3 samples
            %
            %   hInt = comm.IntegrateAndDumpFilter(5);
            %   hInt.Offset = 3;
            %   % Data matrix contains three columns (i.e. three channels)
            %   data = reshape(1:30, 10, 3);
            %   result = step(hInt, data)
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.IntegrateAndDumpFilter System object
            %               fixed-point information
            %   comm.IntegrateAndDumpFilter.helpFixedPoint displays information
            %   about fixed-point properties and operations of the
            %   comm.IntegrateAndDumpFilter System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is always the same as that of the input if the input
            % data type is floating-point. It is also connected to the input if the
            % OutputDataType property is set to 'Same as input' or if it is set to
            % 'Same as accumulator' and the 'AccumulatorDataType' property is set to
            % 'Same as input'.
        end

    end
    methods (Abstract)
    end
    properties
        %AccumulatorDataType Data type of accumulator
        %   Specify the accumulator fixed-point data type as one of [{'Full
        %   precision'} | 'Same as input' | 'Custom']. This property is
        %   applicable when the FullPrecisionOverride property is false.
        AccumulatorDataType;

        %CustomAccumulatorDataType Fixed-point data type of accumulator
        %   Specify the accumulator fixed-point type as a an auto-signed, scaled
        %   numerictype object. This property is applicable when the
        %   FullPrecisionOverride property is false and when the
        %   AccumulatorDataType property is 'Custom'. The default value of this
        %   property is numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomAccumulatorDataType;

        %CustomOutputDataType Output word and fraction lengths
        %   Specify the output fixed-point type as an auto-signed, scaled
        %   numerictype object. This property is applicable when the
        %   FullPrecisionOverride property is false and when the
        %   OutputDataType property is 'Custom'. The default value of this
        %   property is numerictype([],32,30).
        %
        %   See also numerictype.  
        CustomOutputDataType;

        %DecimateOutput Decimate output
        %   Specify whether the step method returns intermediate cumulative sum
        %   results or decimates intermediate results.
        %
        %   If you set this property to true, the step method returns one output
        %   sample, consisting of the final integration value, for each block of
        %   IntegrationPeriod input samples. If the inputs are
        %   (K*IntegrationPeriod)xL matrices, then the outputs are KxL matrices.
        %
        %   If you set this property to false, the step method returns
        %   IntegrationPeriod output samples, consisting of the intermediate
        %   cumulative sum values, for each block of IntegrationPeriod input
        %   samples. In this case, inputs and outputs have the same dimensions.
        %   The default is true.
        DecimateOutput;

        %FullPrecisionOverride Full precision override for fixed-point arithmetic
        %   Specify whether to use full precision rules. If you set
        %   FullPrecisionOverride to true the object computes all
        %   internal arithmetic and output data types using full
        %   precision rules. These rules guarantee that no quantization
        %   occurs within the object. Bits are added as needed to ensure
        %   that no round-off or overflow occurs. If you set
        %   FullPrecisionOverride to false, fixed-point data types
        %   are controlled through individual property settings.
        FullPrecisionOverride;

        %IntegrationPeriod Integration period
        %   Specify the integration period, in samples, as an integer, positive
        %   scalar greater than 1. The integration period defines the length of
        %   the sample blocks that the object integrates between resets. The
        %   default is 8.
        IntegrationPeriod;

        %Offset Number of offset samples
        %   Specify a nonnegative, integer vector or scalar specifying the number
        %   of input samples that the object discards from each column of input
        %   data at the beginning of data processing (i.e., when you call the step
        %   method for the first time). When you set the Offset property to a
        %   non-zero value, the object outputs one or more zeros during the
        %   initial period while it discards input samples. When you specify the
        %   Offset property as a vector of length L, the ith element of the vector
        %   corresponds to the offset for the ith column of the input data matrix,
        %   which has L columns. When you specify the Offset property as a scalar,
        %   the object applies the same offset to each column of the input data
        %   matrix. The offset is a transient effect, not a persistent delay. The
        %   default is 0.
        Offset;

        %OutputDataType Data type of output
        %   Specify the output fixed-point data type as one of [{'Same as
        %   accumulator'} | 'Same as input' | 'Custom']. This property is
        %   applicable when the FullPrecisionOverride property is false.
        OutputDataType;

        %OverflowAction Action when fixed-point numeric values overflow
        %   Specify the overflow action as one of [{'Wrap'} | 'Saturate']. This
        %   property is applicable when the object is not in a full precision
        %   configuration.
        OverflowAction;

        %RoundingMethod Rounding of fixed-point numeric values
        %   Specify the rounding method as one of ['Ceiling' | 'Convergent' |
        %   {'Floor'} | 'Nearest' | 'Round' | 'Simplest' | 'Zero']. This
        %   property is applicable when the object is not in a full precision
        %   configuration.
        RoundingMethod;

    end
end
