classdef ConvolutionalDeinterleaver< handle
%ConvolutionalDeinterleaver Convolutional Deinterleaver (GPU)
%   H = comm.gpu.ConvolutionalDeinterleaver creates a convolutional
%   deinterleaver System object, H. This object restores the original
%   ordering of a sequence that was interleaved using the convolutional
%   interleaver System object.
% 
%   H = comm.gpu.ConvolutionalDeinterleaver(Name,Value) creates a
%   convolutional deinterleaver System object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.ConvolutionalDeinterleaver(M,B,IC) creates a
%   convolutional deinterleaver System object H, with the NumRegisters
%   property set to M, the RegisterLengthStep property set to B, and the
%   InitialConditions property set to IC. M, B, and IC are value-only
%   arguments. To specify a value-only argument, you must also specify
%   all preceding value-only arguments.
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
%   hInt = comm.gpu.ConvolutionalInterleaver('NumRegisters', 3, ...
%                   'RegisterLengthStep', 2, ...
%                   'InitialConditions', [-1 -2 -3]');
%   hDeInt = comm.gpu.ConvolutionalDeinterleaver('NumRegisters', 3, ...
%                   'RegisterLengthStep', 2, ...
%                   'InitialConditions', [-1 -2 -3]');
%   data = gpuArray((0:20)');
%   intrlvData = step(hInt, data);
%   deintrlvData = step(hDeInt, intrlvData);
%   % compare the original sequence, interleaved sequence and restored
%   % sequence.
%   [data, intrlvData, deintrlvData]
%
%   See also comm.ConvolutionalDeinterleaver,
%   comm.gpu.ConvolutionalInterleaver.

 
%   Copyright 2011 The MathWorks, Inc.

    methods
        function out=ConvolutionalDeinterleaver
            %ConvolutionalDeinterleaver Convolutional Deinterleaver (GPU)
            %   H = comm.gpu.ConvolutionalDeinterleaver creates a convolutional
            %   deinterleaver System object, H. This object restores the original
            %   ordering of a sequence that was interleaved using the convolutional
            %   interleaver System object.
            % 
            %   H = comm.gpu.ConvolutionalDeinterleaver(Name,Value) creates a
            %   convolutional deinterleaver System object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.ConvolutionalDeinterleaver(M,B,IC) creates a
            %   convolutional deinterleaver System object H, with the NumRegisters
            %   property set to M, the RegisterLengthStep property set to B, and the
            %   InitialConditions property set to IC. M, B, and IC are value-only
            %   arguments. To specify a value-only argument, you must also specify
            %   all preceding value-only arguments.
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
            %   hInt = comm.gpu.ConvolutionalInterleaver('NumRegisters', 3, ...
            %                   'RegisterLengthStep', 2, ...
            %                   'InitialConditions', [-1 -2 -3]');
            %   hDeInt = comm.gpu.ConvolutionalDeinterleaver('NumRegisters', 3, ...
            %                   'RegisterLengthStep', 2, ...
            %                   'InitialConditions', [-1 -2 -3]');
            %   data = gpuArray((0:20)');
            %   intrlvData = step(hInt, data);
            %   deintrlvData = step(hDeInt, intrlvData);
            %   % compare the original sequence, interleaved sequence and restored
            %   % sequence.
            %   [data, intrlvData, deintrlvData]
            %
            %   See also comm.ConvolutionalDeinterleaver,
            %   comm.gpu.ConvolutionalInterleaver.
        end

        function generateDelayPattern(in) %#ok<MANU>
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

        %NumRegisters  Number of internal shift registers
        %   Specify the number of internal shift registers as a scalar, positive
        %   integer. The default is 6.
        NumRegisters;

        %RegisterLengthStep Number of additional symbols that fit in each
        %successive shift register
        %   Specify the number of additional symbols that fit in each successive
        %   shift register as a positive, scalar integer. The first register holds
        %   zero symbols. The default is 2.
        RegisterLengthStep;

    end
end
