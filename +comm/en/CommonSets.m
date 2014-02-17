classdef CommonSets< handle
%CommonSets Commonly used string sets in comm package

   
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=CommonSets
            %CommonSets Commonly used string sets in comm package
        end

        function getSet(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        AlgebraicIntlvMethod;

        Algorithm;

        AutoOrProperty;

        BinaryGrayCustom;

        BinaryGrayUsr;

        BinaryOrGray;

        BitDataType;

        BitOrInt;

        BooleanOrDouble;

        DecisionOptions;

        DoubleInt8;

        DoubleLogicalSmallestUnsigned;

        DoubleOrSingle;

        FrequencyPulseShapes;

        IntDataType;

        LogicalOrDouble;

        NoneOrProperty;

        NormalizationMethods;

        NormalizationOptions;

        OutDataType;

        OutDataType1;

        OutDataType2;

        Polarity;

        PolynomialOptions;

        ResetOptions;

        ResetRegisterOptions;

        SameAsInputDoubleLogical;

        SignedIntDataType;

        SignedOutDataType;

        SpecifyInputs;

        TerminationMethod;

        UnsignedBitDataType;

        UnsignedIntDataType;

        %Signed sources cannot inherit / same as input / etc.
        UnsignedSrcDataType;

    end
end
