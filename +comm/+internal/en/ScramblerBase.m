classdef ScramblerBase< handle
%ScramblerBase Base class for comm.Scrambler and comm.Descrambler 

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=ScramblerBase
            %ScramblerBase Base class for comm.Scrambler and comm.Descrambler 
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %CalculationBase Range of input data
        %   Specify calculation base as a positive, integer, scalar value. The
        %   step method input and output integers are in the range [0,
        %   CalculationBase-1]. The default is 4.
        CalculationBase;

        %InitialConditions Initial values of linear feedback shift register
        %   Specify the initial values of the linear feedback shift register as an
        %   integer row vector with values in [0 CalculationBase-1]. The length of
        %   this property vector must equal the order of the Polynomial property
        %   vector. The default is [0 1 2 3].
        InitialConditions;

        %Polynomial Linear feedback shift register connections
        %   Specify the polynomial that determines the shift register feedback
        %   connections. You can the generator polynomial as a numeric, binary
        %   vector that lists the coefficients of the polynomial in order of
        %   ascending powers of z^-1, where p(z^-1) = 1 + p1z^-1 + p2z^-2 + ... is
        %   the generator polynomial. The first and last elements must be 1.
        %   Alternatively, you can specify the generator polynomial as a numeric
        %   vector containing the exponents of z^-1 for the nonzero terms of the
        %   polynomial, in order of ascending powers of z^-1. In this case, the
        %   first vector element must be 0. For example, both [1 0 0 0 0 0 1 0 1]
        %   and [0 -6 -8] specify the same polynomial p(z^-1) = 1 + z^-6 + z^-8.
        %   The default is [1 1 1 0 1].
        Polynomial;

        pIsDescrambler;

    end
end
