classdef ConvolutionalInterleaver< handle
%ConvolutionalInterleaver Permute input symbols using shift registers 
%   H = comm.ConvolutionalInterleaver creates a convolutional interleaver
%   System object, H. This object permutes the symbols in the input signal
%   using a set of shift registers.
%
%   H = comm.ConvolutionalInterleaver(Name,Value) creates a convolutional
%   interleaver System object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The input X must be a column vector. The data type can be
%   numeric, logical, or fixed-point (fi objects). Y has the same data type
%   as X.
%
%   The convolutional interleaver object uses a set of N shift registers,
%   where N is the value specified by the NumRegisters property. The object
%   sets the delay value of the kth shift register to the product of (k-1)
%   and the RegisterLengthStep property value. With each new input symbol, a
%   commutator switches to a new register and the new symbol shifts in while
%   the oldest symbol in that register shifts out. When the commutator
%   reaches the Nth register and the next new input occurs , it returns to
%   the first register.
%
%   ConvolutionalInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create convolutional interleaver object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the convolutional interleaver object
%
%   ConvolutionalInterleaver properties:
%
%   NumRegisters       - Number of internal shift registers
%   RegisterLengthStep - Number of additional symbols that fit in each
%                        successive shift register
%   InitialConditions  - Initial conditions of shift registers
%
%   % Example:
%   %   Interleave and deinterleave random data
%
%   hInt = comm.ConvolutionalInterleaver('NumRegisters', 3, ...
%                   'RegisterLengthStep', 2, ...
%                   'InitialConditions', [-1 -2 -3]');
%   hDeInt = comm.ConvolutionalDeinterleaver('NumRegisters', 3, ...
%                   'RegisterLengthStep', 2, ...
%                   'InitialConditions', [-1 -2 -3]');
%   data = (0:20)';
%   intrlvData = step(hInt, data);
%   deintrlvData = step(hDeInt, intrlvData);
%   % compare the original sequence, interleaved sequence and restored
%   % sequence.
%   [data, intrlvData, deintrlvData]
%
%   See also comm.ConvolutionalDeinterleaver, comm.MultiplexedInterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=ConvolutionalInterleaver
            %ConvolutionalInterleaver Permute input symbols using shift registers 
            %   H = comm.ConvolutionalInterleaver creates a convolutional interleaver
            %   System object, H. This object permutes the symbols in the input signal
            %   using a set of shift registers.
            %
            %   H = comm.ConvolutionalInterleaver(Name,Value) creates a convolutional
            %   interleaver System object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The input X must be a column vector. The data type can be
            %   numeric, logical, or fixed-point (fi objects). Y has the same data type
            %   as X.
            %
            %   The convolutional interleaver object uses a set of N shift registers,
            %   where N is the value specified by the NumRegisters property. The object
            %   sets the delay value of the kth shift register to the product of (k-1)
            %   and the RegisterLengthStep property value. With each new input symbol, a
            %   commutator switches to a new register and the new symbol shifts in while
            %   the oldest symbol in that register shifts out. When the commutator
            %   reaches the Nth register and the next new input occurs , it returns to
            %   the first register.
            %
            %   ConvolutionalInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create convolutional interleaver object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the convolutional interleaver object
            %
            %   ConvolutionalInterleaver properties:
            %
            %   NumRegisters       - Number of internal shift registers
            %   RegisterLengthStep - Number of additional symbols that fit in each
            %                        successive shift register
            %   InitialConditions  - Initial conditions of shift registers
            %
            %   % Example:
            %   %   Interleave and deinterleave random data
            %
            %   hInt = comm.ConvolutionalInterleaver('NumRegisters', 3, ...
            %                   'RegisterLengthStep', 2, ...
            %                   'InitialConditions', [-1 -2 -3]');
            %   hDeInt = comm.ConvolutionalDeinterleaver('NumRegisters', 3, ...
            %                   'RegisterLengthStep', 2, ...
            %                   'InitialConditions', [-1 -2 -3]');
            %   data = (0:20)';
            %   intrlvData = step(hInt, data);
            %   deintrlvData = step(hDeInt, intrlvData);
            %   % compare the original sequence, interleaved sequence and restored
            %   % sequence.
            %   [data, intrlvData, deintrlvData]
            %
            %   See also comm.ConvolutionalDeinterleaver, comm.MultiplexedInterleaver. 
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %InitialConditions Initial conditions of shift registers
        %   Specify the values that are initially stored in each shift register
        %   (except the first shift register, which has zero delay) as a numeric
        %   scalar or vector. If you set this property to a scalar, then all shift
        %   registers, except the first one, store the same specified value. If
        %   you set it to a column vector with length equal to the value of the
        %   NumRegisters property, then the ith shift register stores the ith
        %   element of the specified vector. The value of the first element of
        %   this property is unimportant, since the first shift register has zero
        %   delay. The default is 0.
        InitialConditions;

        %RegisterLengthStep Number of additional symbols that fit in each
        %successive shift register
        %   Specify the number of additional symbols that fit in each successive
        %   shift register as a positive, scalar integer. The first register holds
        %   zero symbols. The default is 2.
        RegisterLengthStep;

        %pIsInterleaver Private property to distinguish interleaver/deinterleaver
        pIsInterleaver;

    end
end
