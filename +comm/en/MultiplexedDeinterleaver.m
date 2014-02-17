classdef MultiplexedDeinterleaver< handle
%MultiplexedDeinterleaver Deinterleave input symbols using a set of
%shift registers with specified delays 
%   H = comm.MultiplexedDeinterleaver creates a multiplexed deinterleaver
%   System object, H. The object restores the original ordering of a
%   sequence that was interleaved using the multiplexed interleaver System
%   object.
%
%   H = comm.MultiplexedDeinterleaver(Name,Value) creates a multiplexed
%   deinterleaver object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X, that
%   was interleaved using a multiplexed interleaver and returns Y. The input
%   X must be a column vector. The data type for X can be numeric, logical,
%   or fixed-point (fi objects). Y has the same data type as X.
%
%   The multiplexed deinterleaver object uses N shift registers, where N is
%   the number of elements in the vector specified by the Delay property.
%   When a new input symbol enters the deinterleaver, a commutator switches
%   to a new register. The new symbol shifts in while the oldest symbol in
%   that register is shifted out. When the commutator reaches the Nth
%   register, upon the next new input, it returns to the first register. The
%   multiplexed deinterleaver associated with a multiplexed interleaver has
%   the same number of registers as the interleaver. The delay in a
%   particular deinterleaver register depends on the largest interleaver
%   delay minus the interleaver delay for the given register.
%
%   MultiplexedDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create multiplexed deinterleaver object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the multiplexed deinterleaver object
%
%   MultiplexedDeinterleaver properties:
%
%   Delay             - Interleaver delay
%   InitialConditions - Initial conditions of shift registers
%
%   % Example:
%   %   Interleave a sequence and then restore it
%
%   hInt = comm.MultiplexedInterleaver('Delay', [1 0 2]');
%   hDeInt = comm.MultiplexedDeinterleaver('Delay', [1 0 2]');
%   data = (1:20)';
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   % compare the original sequence, interleaved sequence and restored
%   % sequence.
%   display([data intData deIntData]);
%
%   See also comm.MultiplexedInterleaver, comm.ConvolutionalDeinterleaver. 

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=MultiplexedDeinterleaver
            %MultiplexedDeinterleaver Deinterleave input symbols using a set of
            %shift registers with specified delays 
            %   H = comm.MultiplexedDeinterleaver creates a multiplexed deinterleaver
            %   System object, H. The object restores the original ordering of a
            %   sequence that was interleaved using the multiplexed interleaver System
            %   object.
            %
            %   H = comm.MultiplexedDeinterleaver(Name,Value) creates a multiplexed
            %   deinterleaver object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X, that
            %   was interleaved using a multiplexed interleaver and returns Y. The input
            %   X must be a column vector. The data type for X can be numeric, logical,
            %   or fixed-point (fi objects). Y has the same data type as X.
            %
            %   The multiplexed deinterleaver object uses N shift registers, where N is
            %   the number of elements in the vector specified by the Delay property.
            %   When a new input symbol enters the deinterleaver, a commutator switches
            %   to a new register. The new symbol shifts in while the oldest symbol in
            %   that register is shifted out. When the commutator reaches the Nth
            %   register, upon the next new input, it returns to the first register. The
            %   multiplexed deinterleaver associated with a multiplexed interleaver has
            %   the same number of registers as the interleaver. The delay in a
            %   particular deinterleaver register depends on the largest interleaver
            %   delay minus the interleaver delay for the given register.
            %
            %   MultiplexedDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create multiplexed deinterleaver object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the multiplexed deinterleaver object
            %
            %   MultiplexedDeinterleaver properties:
            %
            %   Delay             - Interleaver delay
            %   InitialConditions - Initial conditions of shift registers
            %
            %   % Example:
            %   %   Interleave a sequence and then restore it
            %
            %   hInt = comm.MultiplexedInterleaver('Delay', [1 0 2]');
            %   hDeInt = comm.MultiplexedDeinterleaver('Delay', [1 0 2]');
            %   data = (1:20)';
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   % compare the original sequence, interleaved sequence and restored
            %   % sequence.
            %   display([data intData deIntData]);
            %
            %   See also comm.MultiplexedInterleaver, comm.ConvolutionalDeinterleaver. 
        end

    end
    methods (Abstract)
    end
    properties
        pIsInterleaver;

    end
end
