classdef AlgebraicDeinterleaver< handle
%AlgebraicDeinterleaver Deinterleave input symbols using algebraically
%derived permutation vector 
%   H = comm.AlgebraicDeinterleaver creates a deinterleaver System object,
%   H. The object restores the original ordering of a sequence from the 
%   corresponding algebraic interleaver object.
%
%   H = comm.AlgebraicDeinterleaver(Name,Value) returns an Algebraic
%   deinterleaver System object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) restores the original ordering of the sequence, X, that
%   was interleaved using an algebraic interleaver. An algebraically derived
%   permutation vector based on the algebraic method you specify in the 
%   Method property forms the base of the output, Y. X must be a column vector of
%   length specified by the Length property. X can be numeric, logical, or
%   fixed-point (fi objects). Y has the same data type as X.
%
%   AlgebraicDeinterleaver methods:
%
%   step     - Deinterleave input sequence (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create algebraic deinterleaver object with same property
%              values
%   isLocked - Locked status (logical)
%
%   AlgebraicDeinterleaver properties:
%
%   Method               - Algebraic method to generate permutation vector
%   Length               - Number of elements in input vector
%   MultiplicativeFactor - Cycle vector computation factor
%   CyclicShift          - Amount of cyclic shift
%   PrimitiveElement     - Primitive element
%
%   % Example:
%   %   Interleave and deinterleave data
%
%   hInt = comm.AlgebraicInterleaver('Length', 16);
%   hDeInt = comm.AlgebraicDeinterleaver('Length', 16);
%   data = randi(7, 16, 1);
%   intData = step(hInt, data);
%   deIntData = step(hDeInt, intData);
%   [data, intData, deIntData]
%
%   See also comm.AlgebraicInterleaver, comm.BlockDeinterleaver. 

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=AlgebraicDeinterleaver
            %AlgebraicDeinterleaver Deinterleave input symbols using algebraically
            %derived permutation vector 
            %   H = comm.AlgebraicDeinterleaver creates a deinterleaver System object,
            %   H. The object restores the original ordering of a sequence from the 
            %   corresponding algebraic interleaver object.
            %
            %   H = comm.AlgebraicDeinterleaver(Name,Value) returns an Algebraic
            %   deinterleaver System object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) restores the original ordering of the sequence, X, that
            %   was interleaved using an algebraic interleaver. An algebraically derived
            %   permutation vector based on the algebraic method you specify in the 
            %   Method property forms the base of the output, Y. X must be a column vector of
            %   length specified by the Length property. X can be numeric, logical, or
            %   fixed-point (fi objects). Y has the same data type as X.
            %
            %   AlgebraicDeinterleaver methods:
            %
            %   step     - Deinterleave input sequence (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create algebraic deinterleaver object with same property
            %              values
            %   isLocked - Locked status (logical)
            %
            %   AlgebraicDeinterleaver properties:
            %
            %   Method               - Algebraic method to generate permutation vector
            %   Length               - Number of elements in input vector
            %   MultiplicativeFactor - Cycle vector computation factor
            %   CyclicShift          - Amount of cyclic shift
            %   PrimitiveElement     - Primitive element
            %
            %   % Example:
            %   %   Interleave and deinterleave data
            %
            %   hInt = comm.AlgebraicInterleaver('Length', 16);
            %   hDeInt = comm.AlgebraicDeinterleaver('Length', 16);
            %   data = randi(7, 16, 1);
            %   intData = step(hInt, data);
            %   deIntData = step(hDeInt, intData);
            %   [data, intData, deIntData]
            %
            %   See also comm.AlgebraicInterleaver, comm.BlockDeinterleaver. 
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %CyclicShift Amount of cyclic shift
        %   Specify the amount by which the object shifts indices, when it creates 
        %   the final permutation vector, as a non-negative integer
        %   scalar. This property applies when you set the Method property to
        %   'Takeshita-Costello'. The default is 0.
        CyclicShift;

        %Length  Number of elements in input vector
        %   Specify the number of elements in the input as a positive integer
        %   scalar. If you set the Method property to 'Welch-Costas', then Length+1
        %   must be a prime number. If you set the Method property to
        %   'Takeshita-Costello', then Length property must be a power of two. The
        %   default is 256.
        Length;

        %Method  Algebraic method to generate permutation vector
        %   Specify the algebraic method as one of 'Takeshita-Costello' |
        %   'Welch-Costas'. The default is 'Takeshita-Costello'. 
        %   The algebraic interleaver performs all computations in modulo N,
        %   where N is the length you set in the Length property. Note these
        %   parameters and restrictions for each method.
        %
        %   For 'Welch-Costas', the value of (N+1) must be a prime number, 
        %   where N is the value you specify in the Length property. You must
        %   set the PrimitiveElement property to an integer, A, between 1 and N. 
        %   This integer represents a primitive element of the finite field 
        %   GF(N+1). See the PrimitiveElement property description. 
        %
        %   For 'Takeshita-Costello', you must set the Length property to a value 
        %   equal to 2^m, for any integer m. You must also set the 
        %   MultiplicativeFactor property to an odd integer which is less than 
        %   the value of the Length property. You also set the CyclicShift 
        %   property to a nonnegative integer which is less than the value of the 
        %   Length property. 
        %     
        %   The 'Takeshita-Costello' interleaver method uses a cycle vector of
        %   length N, which you specify in the Length property. The cycle vector
        %   calculation uses the equation, mod(k*(n-1)*n/2, N)+1, for any integer n,   
        %   between 1 and N. The object creates an intermediate permutation 
        %   function using the relationship, P(c(n)) = c(n+1). Shifting the 
        %   elements of the intermediate permutation vector left by the
        %   CyclicShift property produces the interleaver's actual permutation
        %   vector.
        Method;

        %MultiplicativeFactor Cycle vector computation factor
        %   Specify the factor the object uses to compute the interleaver's   
        %   cycle vector as a positive integer scalar. This property 
        %   applies when you set the Method property to 'Takeshita-Costello'.
        %   The default is 13.
        MultiplicativeFactor;

        %PrimitiveElement Primitive element
        %   Specify primitive element, A, as an element of order N in the finite
        %   field GF(N+1). N is the value you specify in the Length property.
        %   Every nonzero element of GF(N+1) can be expressed as A raised to 
        %   some integer power. In a Welch-Costas interleaver, the permutation 
        %   maps the integer k to mod(A^k,N+1)-1. This property applies when you 
        %   set the Method property to 'Welch-Costas'. The default is 6.
        PrimitiveElement;

    end
end
