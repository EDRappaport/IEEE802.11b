classdef BitToInteger< handle
%BitToInteger Convert vector of bits to vector of integers
%   H = comm.BitToInteger creates a bit-to-integer converter System object,
%   H. The object maps a vector of bits to a corresponding vector of 
%   integer values.
%
%   H = comm.BitToInteger(Name,Value) creates a bit-to-integer converter
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.BitToInteger(NUMBITS,Name,Value) creates a bit-to-integer
%   converter System object, H, with the BitsPerInteger property set to
%   NUMBITS, and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) converts binary input, X, to corresponding integers, Y.
%   The input must be a scalar or a column vector and the data type can be
%   numeric, logical, or unsigned fixed point of word length 1 (fi object).
%   The length of input X must be an integer multiple of the value you
%   specify in the BitsPerInteger property. The object outputs a column
%   vector with a length equal to length(X)/BitsPerInteger. If you set the
%   SignedIntegerOutput property to false, the object maps each group of
%   bits to an integer between 0 and (2^BitsPerInteger)-1. A group of bits
%   contains N bits, where N is the value of the BitsPerInteger property. If
%   you set the SignedIntegerOutput property to true, the object maps each
%   group of BitsPerInteger bits to an integer between
%   -(2^(BitsPerInteger-1)) and (2^(BitsPerInteger-1))-1.
%
%   BitToInteger methods:
%
%   step     - Convert bits to integers (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create bit to integer converter object with same property
%              values
%   isLocked - Locked status (logical)
%
%   BitToInteger properties:
%
%   BitsPerInteger      - Number of bits per integer
%   MSBFirst            - Assume first bit of input bit words is most
%                         significant bit
%   SignedIntegerOutput - Output signed integers
%   OutputDataType      - Data type of output
%
%   % Example:
%   %   Convert randomly generated 4-bit words to integers
%
%   hBitToInt = comm.BitToInteger(4);
%   % Generate three 4-bit words
%   bitData = randi([0 1],3*hBitToInt.BitsPerInteger,1);
%   intData = step(hBitToInt,bitData);
% 
%   See also comm.IntegerToBit, bi2de, bin2dec.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=BitToInteger
            %BitToInteger Convert vector of bits to vector of integers
            %   H = comm.BitToInteger creates a bit-to-integer converter System object,
            %   H. The object maps a vector of bits to a corresponding vector of 
            %   integer values.
            %
            %   H = comm.BitToInteger(Name,Value) creates a bit-to-integer converter
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.BitToInteger(NUMBITS,Name,Value) creates a bit-to-integer
            %   converter System object, H, with the BitsPerInteger property set to
            %   NUMBITS, and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) converts binary input, X, to corresponding integers, Y.
            %   The input must be a scalar or a column vector and the data type can be
            %   numeric, logical, or unsigned fixed point of word length 1 (fi object).
            %   The length of input X must be an integer multiple of the value you
            %   specify in the BitsPerInteger property. The object outputs a column
            %   vector with a length equal to length(X)/BitsPerInteger. If you set the
            %   SignedIntegerOutput property to false, the object maps each group of
            %   bits to an integer between 0 and (2^BitsPerInteger)-1. A group of bits
            %   contains N bits, where N is the value of the BitsPerInteger property. If
            %   you set the SignedIntegerOutput property to true, the object maps each
            %   group of BitsPerInteger bits to an integer between
            %   -(2^(BitsPerInteger-1)) and (2^(BitsPerInteger-1))-1.
            %
            %   BitToInteger methods:
            %
            %   step     - Convert bits to integers (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create bit to integer converter object with same property
            %              values
            %   isLocked - Locked status (logical)
            %
            %   BitToInteger properties:
            %
            %   BitsPerInteger      - Number of bits per integer
            %   MSBFirst            - Assume first bit of input bit words is most
            %                         significant bit
            %   SignedIntegerOutput - Output signed integers
            %   OutputDataType      - Data type of output
            %
            %   % Example:
            %   %   Convert randomly generated 4-bit words to integers
            %
            %   hBitToInt = comm.BitToInteger(4);
            %   % Generate three 4-bit words
            %   bitData = randi([0 1],3*hBitToInt.BitsPerInteger,1);
            %   intData = step(hBitToInt,bitData);
            % 
            %   See also comm.IntegerToBit, bi2de, bin2dec.
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
        %   Specify the number of input bits that the object maps to each
        %   output integer. You can set this property to a scalar integer 
        %   between 1 and 32. The default is 3.
        BitsPerInteger;

        %MSBFirst Assume first bit of input bit words is most significant bit
        %   Set this property to true to indicate that the first bit of the input
        %   bit words is the most significant bit (MSB). Set this property to
        %   false to indicate that the first bit of the input bit words is the
        %   least significant bit (LSB). The default is true.
        MSBFirst;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'Full precision' | 'Smallest
        %   integer' | 'Same as input' | 'double' | 'single' | 'int8' | 'uint8' |
        %   'int16' | 'uint16' | 'int32' | 'uint32',  when you set the
        %   SignedIntegerOutput property to false. When you set the
        %   SignedIntegerOutput property to true, specify the output data type as
        %   one of 'Full precision' | 'Smallest integer' | 'double' | 'single' |
        %   'int8' | 'int16' | 'int32'.  The default is 'Full precision'.
        %
        %   When you set this property to 'Same as input' the output data type
        %   will be the same as the input data type when the input data type is
        %   numeric or fixed-point (fi object).
        %
        %   When you set this property to 'Full precision', the object determines
        %   the output data type based on the input data type. If the input data
        %   type is double or single precision, the output data type is the same
        %   as the input data type. Otherwise, the output data type is determined
        %   in the same way as when you set this property to 'Smallest integer'.
        %   Note that for integer data type inputs, a Fixed-Point Designer license
        %   is required when this property is set to 'Smallest integer' or 'Full
        %   precision'.
        OutputDataType;

        %SignedIntegerOutput Output signed integers
        %   Set this property to true to generate signed integer outputs. Set this
        %   property to false to generate unsigned integer outputs. If you set
        %   this property to false, the output values are integers between 0 and
        %   (2^N)-1, where N is the value you specified in the BitsPerInteger 
        %   property. If you set this property to true, the output values are 
        %   integers between -(2^(N-1)) and (2^(N-1))-1. The default is false.
        SignedIntegerOutput;

    end
end
