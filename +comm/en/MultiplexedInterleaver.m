classdef MultiplexedInterleaver< handle
%MultiplexedInterleaver Permute input symbols using a set of shift
%registers with specified delays 
%   H = comm.MultiplexedInterleaver creates a multiplexed interleaver System
%   object, H. The object permutes the symbols in the input signal using a
%   set of shift registers with specified delays.
%
%   H = comm.MultiplexedInterleaver(Name,Value) creates a multiplexed
%   interleaver object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) permutes input sequence, X, and returns interleaved
%   sequence, Y. The input X must be a column vector and the data type can
%   be numeric, logical, or fixed-point (fi objects). Y has the same data
%   type as X.
%
%   The multiplexed interleaver object consists of N registers, each with a
%   specified delay. With each new input symbol, a commutator switches to a
%   new register and the new symbol is shifted in while the oldest symbol in
%   that register is shifted out. When the commutator reaches the Nth
%   register, upon the next new input, it returns to the first register.
%
%   MultiplexedInterleaver methods:
%
%   step     - Interleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create multiplexed interleaver object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the multiplexed interleaver object
%
%   MultiplexedInterleaver properties:
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
%   % compare the original sequence, interleaved sequence, and restored
%   % sequence
%   [data, intData, deIntData]
%
%   See also comm.MultiplexedDeinterleaver, comm.ConvolutionalInterleaver. 

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=MultiplexedInterleaver
            %MultiplexedInterleaver Permute input symbols using a set of shift
            %registers with specified delays 
            %   H = comm.MultiplexedInterleaver creates a multiplexed interleaver System
            %   object, H. The object permutes the symbols in the input signal using a
            %   set of shift registers with specified delays.
            %
            %   H = comm.MultiplexedInterleaver(Name,Value) creates a multiplexed
            %   interleaver object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) permutes input sequence, X, and returns interleaved
            %   sequence, Y. The input X must be a column vector and the data type can
            %   be numeric, logical, or fixed-point (fi objects). Y has the same data
            %   type as X.
            %
            %   The multiplexed interleaver object consists of N registers, each with a
            %   specified delay. With each new input symbol, a commutator switches to a
            %   new register and the new symbol is shifted in while the oldest symbol in
            %   that register is shifted out. When the commutator reaches the Nth
            %   register, upon the next new input, it returns to the first register.
            %
            %   MultiplexedInterleaver methods:
            %
            %   step     - Interleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create multiplexed interleaver object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the multiplexed interleaver object
            %
            %   MultiplexedInterleaver properties:
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
            %   % compare the original sequence, interleaved sequence, and restored
            %   % sequence
            %   [data, intData, deIntData]
            %
            %   See also comm.MultiplexedDeinterleaver, comm.ConvolutionalInterleaver. 
        end

    end
    methods (Abstract)
    end
    properties
        pIsInterleaver;

    end
end
