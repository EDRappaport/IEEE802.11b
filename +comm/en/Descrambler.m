classdef Descrambler< handle
%Descrambler Descramble input signal
%   H = comm.Descrambler creates a descrambler System object, H. This object
%   descrambles the input data using a linear feedback shift register that
%   you specify with the Polynomial property.
%
%   H = comm.Descrambler(Name,Value) creates a descrambler object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.Descrambler(N,POLY,COND,Name,Value) creates a descrambler
%   object, H, with the CalculationBase property set to N, the Polynomial
%   property set to POLY, the InitialConditions property set to COND, and
%   other specified property Names set to the specified Values. N, POLY and
%   COND are value-only arguments. To specify a value-only argument, you
%   must also specify all preceding value-only arguments. You can specify
%   name-value pair arguments in any order.
%
%   Step method syntax:
%
%   Y = step(H,X) descrambles input data, X, and returns the result in Y. X
%   must be a double precision, logical, or integer column vector.  The
%   output Y is same data type and length as the input vector, X.
%
%   Descrambler methods:
%
%   step     - Descramble input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create descrambler object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of descrambler object
%
%   Descrambler properties:
%
%   CalculationBase   - Range of input data
%   Polynomial        - Linear feedback shift register connections
%   InitialConditions - Initial values of linear feedback shift register
%
%   % Example:
%   %   Scramble and descramble random data with values in the range [0 7]
%   
%   % Create scrambler and descrambler objects with calculation base of 8
%   N = 8;
%   hSCR = comm.Scrambler(N, [1 0 1 1 0 1 0 1],...
%           [0 3 2 2 5 1 7]);                  
%   hDSCR = comm.Descrambler(N, [1 0 1 1 0 1 0 1],...
%           [0 3 2 2 5 1 7]); 
%   for counter = 1:10
%     data = randi([0 N-1], 4, 1);
%     scrData = step(hSCR, data);
%     deScrData = step(hDSCR, scrData);
%     [data, scrData, deScrData]
%   end
%
%   See also comm.Scrambler, comm.PNSequence.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=Descrambler
            %Descrambler Descramble input signal
            %   H = comm.Descrambler creates a descrambler System object, H. This object
            %   descrambles the input data using a linear feedback shift register that
            %   you specify with the Polynomial property.
            %
            %   H = comm.Descrambler(Name,Value) creates a descrambler object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.Descrambler(N,POLY,COND,Name,Value) creates a descrambler
            %   object, H, with the CalculationBase property set to N, the Polynomial
            %   property set to POLY, the InitialConditions property set to COND, and
            %   other specified property Names set to the specified Values. N, POLY and
            %   COND are value-only arguments. To specify a value-only argument, you
            %   must also specify all preceding value-only arguments. You can specify
            %   name-value pair arguments in any order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) descrambles input data, X, and returns the result in Y. X
            %   must be a double precision, logical, or integer column vector.  The
            %   output Y is same data type and length as the input vector, X.
            %
            %   Descrambler methods:
            %
            %   step     - Descramble input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create descrambler object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of descrambler object
            %
            %   Descrambler properties:
            %
            %   CalculationBase   - Range of input data
            %   Polynomial        - Linear feedback shift register connections
            %   InitialConditions - Initial values of linear feedback shift register
            %
            %   % Example:
            %   %   Scramble and descramble random data with values in the range [0 7]
            %   
            %   % Create scrambler and descrambler objects with calculation base of 8
            %   N = 8;
            %   hSCR = comm.Scrambler(N, [1 0 1 1 0 1 0 1],...
            %           [0 3 2 2 5 1 7]);                  
            %   hDSCR = comm.Descrambler(N, [1 0 1 1 0 1 0 1],...
            %           [0 3 2 2 5 1 7]); 
            %   for counter = 1:10
            %     data = randi([0 N-1], 4, 1);
            %     scrData = step(hSCR, data);
            %     deScrData = step(hDSCR, scrData);
            %     [data, scrData, deScrData]
            %   end
            %
            %   See also comm.Scrambler, comm.PNSequence.
        end

    end
    methods (Abstract)
    end
    properties
        pIsDescrambler;

    end
end
