classdef IntegerToBit< handle
%IntegerToBit Convert vector of integers to vector of bits
%   H = comm.IntegerToBit creates an integer-to-bit converter System object,
%   H. The object maps a vector of integer-valued or fixed-point inputs to a
%   vector of bits. For fixed-point inputs, the object uses the stored 
%   integer value.
%
%   H = comm.IntegerToBit(Name,Value) creates an integer to bit converter
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.IntegerToBit(NUMBITS,Name,Value) creates an integer to bit
%   converter object, H, with the BitsPerInteger property set to NUMBITS and
%   other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) converts integer input, X, to corresponding bits, Y. The
%   input must be scalar or a column vector and the data type can be numeric
%   or fixed-point (fi objects). The output is a column vector with length
%   equal to length(X)*N, where N is the value of the BitsPerInteger
%   property. If any input value is outside the range of N, the object
%   issues an error. If the SignedIntegerInput property is false, the
%   input values must be between 0 and (2^N)-1. If SignedIntegerInput is
%   true, the input values must be between -(2^(N-1)) and (2^(N-1))-1.
%
%   IntegerToBit methods:
%
%   step     - Convert integers to bits (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create an integer-to-bit converter object with same property
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of integer-to-bit converter object
%
%   IntegerToBit properties:
%
%   BitsPerInteger      - Number of bits per integer
%   MSBFirst            - Output bit words with first bit as most
%                         significant bit
%   SignedIntegerInput  - Assume inputs are signed integers
%   OutputDataType      - Data type of output
%
%   % Example:
%   %   Convert randomly generated integers to 4-bit words
%
%   hIntToBit = comm.IntegerToBit(4);
%   intData = randi([0 2^hIntToBit.BitsPerInteger-1],3,1);
%   bitData = step(hIntToBit,intData);
%
%   See also comm.BitToInteger, de2bi, dec2bin.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=IntegerToBit
            %IntegerToBit Convert vector of integers to vector of bits
            %   H = comm.IntegerToBit creates an integer-to-bit converter System object,
            %   H. The object maps a vector of integer-valued or fixed-point inputs to a
            %   vector of bits. For fixed-point inputs, the object uses the stored 
            %   integer value.
            %
            %   H = comm.IntegerToBit(Name,Value) creates an integer to bit converter
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.IntegerToBit(NUMBITS,Name,Value) creates an integer to bit
            %   converter object, H, with the BitsPerInteger property set to NUMBITS and
            %   other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) converts integer input, X, to corresponding bits, Y. The
            %   input must be scalar or a column vector and the data type can be numeric
            %   or fixed-point (fi objects). The output is a column vector with length
            %   equal to length(X)*N, where N is the value of the BitsPerInteger
            %   property. If any input value is outside the range of N, the object
            %   issues an error. If the SignedIntegerInput property is false, the
            %   input values must be between 0 and (2^N)-1. If SignedIntegerInput is
            %   true, the input values must be between -(2^(N-1)) and (2^(N-1))-1.
            %
            %   IntegerToBit methods:
            %
            %   step     - Convert integers to bits (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create an integer-to-bit converter object with same property
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of integer-to-bit converter object
            %
            %   IntegerToBit properties:
            %
            %   BitsPerInteger      - Number of bits per integer
            %   MSBFirst            - Output bit words with first bit as most
            %                         significant bit
            %   SignedIntegerInput  - Assume inputs are signed integers
            %   OutputDataType      - Data type of output
            %
            %   % Example:
            %   %   Convert randomly generated integers to 4-bit words
            %
            %   hIntToBit = comm.IntegerToBit(4);
            %   intData = randi([0 2^hIntToBit.BitsPerInteger-1],3,1);
            %   bitData = step(hIntToBit,intData);
            %
            %   See also comm.BitToInteger, de2bi, dec2bin.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is connected to the input if the OutputDataType
            % property is set to 'Same as input', or if OutputDataType is set to
            % 'Full precision' and the input is floating-point
        end

    end
    methods (Abstract)
    end
    properties
        %BitsPerInteger Number of bits per integer
        %   Specify the number of bits the System object uses to represent each
        %   input integer. You must set this property to a scalar integer between
        %    1 and 32. The default is 3.
        BitsPerInteger;

        %MSBFirst Output bit words with first bit as most significant bit 
        %   Set this property to true to indicate that the first bit of the output
        %   bit words is the most significant bit (MSB). Set this property to
        %   false to indicate that the first bit of the output bit words is the
        %   least significant bit (LSB). The default is true.
        MSBFirst;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'Full precision' | 'Smallest
        %   unsigned integer' | 'Same as input' | 'double' | 'single' | 'int8' |
        %   'uint8' | 'int16' | 'uint16' | 'int32' | 'uint32' | 'logical'. The
        %   default is 'Full precision'. 
        %
        %   When you set this property to 'Full precision', the object determines
        %   the output data type based on the input data type. If the input data
        %   type is double or single precision, the output data type is the same
        %   as the input data type. Otherwise, the output data type is determined
        %   in the same way as when you set this property to 'Smallest unsigned
        %   integer'. Note that for integer data type inputs, a Fixed-Point
        %   Designer license is required when this property is set to 'Smallest
        %   unsigned integer' or 'Full precision'.
        %
        %   When you set this property to 'Same as input' the output data type
        %   will be the same as the input data type when the input data type is
        %   numeric or a fixed-point integer (fi object).
        OutputDataType;

        %SignedIntegerInput Assume inputs are signed integers
        %   Set this property to true if the integer inputs are signed. Set this
        %   property to false if the integer inputs are unsigned. If the
        %   SignedIntegerInput property is false, the input values must be
        %   between 0 and (2^N)-1, where N is the value you specified in the
        %   BitsPerInteger property. If SignedIntegerInput is true, the input
        %   values must be between -(2^(N-1)) and (2^(N-1))-1. The default is
        %   false.
        SignedIntegerInput;

    end
end
