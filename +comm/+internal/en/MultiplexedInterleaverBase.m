classdef MultiplexedInterleaverBase< handle
%MultiplexedInterleaverBase Base class for multiplexed interleavers
%
%   See also comm.MultiplexedInterleaver, comm.MultiplexedDeinterleaver. 

 
%   Copyright 2010 The MathWorks, Inc.

    methods
        function out=MultiplexedInterleaverBase
            %MultiplexedInterleaverBase Base class for multiplexed interleavers
            %
            %   See also comm.MultiplexedInterleaver, comm.MultiplexedDeinterleaver. 
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Delay Interleaver delay
        %   Specify the lengths of the shift registers as an integer column
        %   vector. The default is [2;0;1;3;10].
        Delay;

        %InitialConditions Initial conditions of shift registers
        %   Specify the initial values in each shift register as a numeric scalar
        %   or a column vector. When you set this property to a scalar, all shift
        %   registers store the same scalar value. When you set this property to a
        %   column vector, its length must equal the length of the Delay property.
        %   This vector contains initial conditions, where the ith shift register
        %   stores the ith initial condition from this vector. The default is 0.
        InitialConditions;

        %pIsInterleaver Private property to distinguish interleaver/deinterleaver
        pIsInterleaver;

    end
end
