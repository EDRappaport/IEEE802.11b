classdef ConvolutionalDeinterleaver< handle
%ConvolutionalDeinterleaver Restore ordering of symbols using shift
%registers
%   H = comm.ConvolutionalDeinterleaver creates a convolutional
%   deinterleaver System object, H. This object restores the original
%   ordering of a sequence that was interleaved using the convolutional
%   interleaver System object.
%
%   H = comm.ConvolutionalDeinterleaver(Name,Value) creates a convolutional
%   deinterleaver System object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X, that
%   was interleaved using a convolutional interleaver and returns Y. The
%   input X must be a column vector. The data type can be numeric, logical,
%   or fixed-point (fi objects). Y has the same data type as X.
%
%   The convolutional deinterleaver object uses a set of N shift registers,
%   where N is the value specified by the NumRegisters property. The object
%   sets the delay value of the kth shift register to the product of (k-1)
%   and RegisterLengthStep property value. With each new input symbol, a
%   commutator switches to a new register and the new symbol shifts in while
%   the oldest symbol in that register shifts out. When the commutator
%   reaches the Nth register and the next new input occurs, it returns to
%   the first register.
%
%   ConvolutionalDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create convolutional deinterleaver object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the convolutional deinterleaver object
%
%   ConvolutionalDeinterleaver properties:
%
%   NumRegisters       - Number of internal shift registers
%   RegisterLengthStep - Symbol capacity difference of each successive
%                        shift register
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
%   See also comm.ConvolutionalInterleaver, comm.MultiplexedInterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=ConvolutionalDeinterleaver
            %ConvolutionalDeinterleaver Restore ordering of symbols using shift
            %registers
            %   H = comm.ConvolutionalDeinterleaver creates a convolutional
            %   deinterleaver System object, H. This object restores the original
            %   ordering of a sequence that was interleaved using the convolutional
            %   interleaver System object.
            %
            %   H = comm.ConvolutionalDeinterleaver(Name,Value) creates a convolutional
            %   deinterleaver System object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X, that
            %   was interleaved using a convolutional interleaver and returns Y. The
            %   input X must be a column vector. The data type can be numeric, logical,
            %   or fixed-point (fi objects). Y has the same data type as X.
            %
            %   The convolutional deinterleaver object uses a set of N shift registers,
            %   where N is the value specified by the NumRegisters property. The object
            %   sets the delay value of the kth shift register to the product of (k-1)
            %   and RegisterLengthStep property value. With each new input symbol, a
            %   commutator switches to a new register and the new symbol shifts in while
            %   the oldest symbol in that register shifts out. When the commutator
            %   reaches the Nth register and the next new input occurs, it returns to
            %   the first register.
            %
            %   ConvolutionalDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create convolutional deinterleaver object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the convolutional deinterleaver object
            %
            %   ConvolutionalDeinterleaver properties:
            %
            %   NumRegisters       - Number of internal shift registers
            %   RegisterLengthStep - Symbol capacity difference of each successive
            %                        shift register
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
            %   See also comm.ConvolutionalInterleaver, comm.MultiplexedInterleaver. 
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %InitialConditions Initial conditions of shift registers
        %   Specify the values that are initially stored in each shift register
        %   (except the last shift register, which has zero delay) as a numeric
        %   scalar or vector. If you set this property to a scalar, then all shift
        %   registers, except the last one, store the same specified value. If you
        %   set it to a column vector with length equal to the value of the
        %   NumRegisters property, then the ith shift register stores the
        %   (N-i+1)th element of the specified vector. The value of the first
        %   element of this property is unimportant, since the last shift register
        %   has zero delay. The default is 0.
        InitialConditions;

        %RegisterLengthStep Symbol capacity difference of each successive shift
        %register
        %   Specify the difference in symbol capacity of each successive shift
        %   register, where the last register holds zero symbols as a positive,
        %   scalar integer. The default is 2.
        RegisterLengthStep;

        %pIsInterleaver Private property to distinguish interleaver/deinterleaver
        pIsInterleaver;

    end
end
