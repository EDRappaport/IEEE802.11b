classdef GoldSequence< handle
%GoldSequence Generate a Gold sequence
%   H = comm.GoldSequence creates a Gold sequence generator System object,
%   H, that generates a pseudo-random Gold sequence.
%
%   H = comm.GoldSequence(Name,Value) creates a Gold sequence generator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Gold sequence in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The object
%   uses two PN sequence generators to generate a preferred pair of
%   sequences with period N = 2^n-1. Then the object XORs these sequences to
%   produce the output Gold sequence.  The value in n is the degree of the
%   generator polynomials that you specify in the FirstPolynomial and
%   SecondPolynomial properties.
%
%   Y = step(H,SECINITCOND) uses SECINITCOND as the initial conditions for
%   the second PN sequence when you set the SecondInitialConditionsSource
%   property to 'Input port'. SECINITCOND must be a numeric scalar or a
%   numeric, binary vector with length equal to the degree of the second
%   generator polynomial specified in the SecondPolynomial property.
%
%   Y = step(H,OUTPUTSIZE) uses OUTPUTSIZE as the output size for the
%   current step when you set the VariableSizeOutput property to true. The
%   OUTPUTSIZE input must be a non-negative integer scalar or 2-element row
%   vector. The scalar or the first element of the row vector must be
%   less than or equal to the first element of MaximumOutputSize property
%   value. The second element of the OUTPUTSIZE row vector input must be 1.
%
%   Y = step(H,RESET) uses RESET as the reset signal when you set the
%   ResetInputPort property to true. The data type of the RESET input must
%   be double precision or logical. RESET can be a scalar value or a column
%   vector with length equal to the number of samples per frame specified in
%   the SamplesPerFrame property. When the RESET input is a non-zero scalar,
%   the object resets to the initial conditions that you specify in the
%   FirstInitialConditions and SecondInitialConditions properties. It then
%   generates a new output frame. A column vector RESET input allows
%   multiple resets within an output frame. A non-zero value at the ith
%   element of the vector causes a reset at the ith output sample time.
%
%   You can combine optional input arguments when you set their enabling
%   properties. Optional inputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   Y = step(H, SECINITCOND, OUTPUTSIZE) or Y = step(H, OUTPUTSIZE, RESET)
%
%   GoldSequence methods:
%
%   step     - Generate Gold sequence samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Gold sequence generator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Gold sequence generator object
%
%   GoldSequence properties:
%
%   FirstPolynomial               - Generator polynomial for first preferred 
%                                   PN sequence
%   FirstInitialConditions        - Initial conditions for first PN sequence 
%                                   generator
%   SecondPolynomial              - Generator polynomial for second preferred PN
%                                   sequence
%   SecondInitialConditionsSource - Source of initial conditions for second
%                                   PN sequence
%   SecondInitialConditions       - Initial conditions for second PN sequence
%                                   generator
%   Index                         - Index of output sequence of interest
%   Shift                         - Sequence offset from initial time
%   VariableSizeOutput            - Enable variable-size outputs
%   MaximumOutputSize             - Maximum output size
%   SamplesPerFrame               - Number of output samples per frame
%   ResetInputPort                - Enable generator reset input
%   OutputDataType                - Data type of output
%
%   % Example:
%   %   Get 10 samples of a Gold sequence of period 2^5-1
%
%   hgld = comm.GoldSequence('FirstPolynomial',[5 2 0],...
%            'SecondPolynomial', [5 4 3 2 0],...
%            'FirstInitialConditions', [0 0 0 0 1],...
%            'SecondInitialConditions', [0 0 0 0 1],...
%            'Index', 4, 'SamplesPerFrame', 10);
%   x = step(hgld)
%
%   See also comm.KasamiSequence, comm.PNSequence.

 
%   Copyright 2008-2012 The MathWorks, Inc.

    methods
        function out=GoldSequence
            %GoldSequence Generate a Gold sequence
            %   H = comm.GoldSequence creates a Gold sequence generator System object,
            %   H, that generates a pseudo-random Gold sequence.
            %
            %   H = comm.GoldSequence(Name,Value) creates a Gold sequence generator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the Gold sequence in column vector Y.
            %   Specify the frame length with the SamplesPerFrame property. The object
            %   uses two PN sequence generators to generate a preferred pair of
            %   sequences with period N = 2^n-1. Then the object XORs these sequences to
            %   produce the output Gold sequence.  The value in n is the degree of the
            %   generator polynomials that you specify in the FirstPolynomial and
            %   SecondPolynomial properties.
            %
            %   Y = step(H,SECINITCOND) uses SECINITCOND as the initial conditions for
            %   the second PN sequence when you set the SecondInitialConditionsSource
            %   property to 'Input port'. SECINITCOND must be a numeric scalar or a
            %   numeric, binary vector with length equal to the degree of the second
            %   generator polynomial specified in the SecondPolynomial property.
            %
            %   Y = step(H,OUTPUTSIZE) uses OUTPUTSIZE as the output size for the
            %   current step when you set the VariableSizeOutput property to true. The
            %   OUTPUTSIZE input must be a non-negative integer scalar or 2-element row
            %   vector. The scalar or the first element of the row vector must be
            %   less than or equal to the first element of MaximumOutputSize property
            %   value. The second element of the OUTPUTSIZE row vector input must be 1.
            %
            %   Y = step(H,RESET) uses RESET as the reset signal when you set the
            %   ResetInputPort property to true. The data type of the RESET input must
            %   be double precision or logical. RESET can be a scalar value or a column
            %   vector with length equal to the number of samples per frame specified in
            %   the SamplesPerFrame property. When the RESET input is a non-zero scalar,
            %   the object resets to the initial conditions that you specify in the
            %   FirstInitialConditions and SecondInitialConditions properties. It then
            %   generates a new output frame. A column vector RESET input allows
            %   multiple resets within an output frame. A non-zero value at the ith
            %   element of the vector causes a reset at the ith output sample time.
            %
            %   You can combine optional input arguments when you set their enabling
            %   properties. Optional inputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   Y = step(H, SECINITCOND, OUTPUTSIZE) or Y = step(H, OUTPUTSIZE, RESET)
            %
            %   GoldSequence methods:
            %
            %   step     - Generate Gold sequence samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Gold sequence generator object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Gold sequence generator object
            %
            %   GoldSequence properties:
            %
            %   FirstPolynomial               - Generator polynomial for first preferred 
            %                                   PN sequence
            %   FirstInitialConditions        - Initial conditions for first PN sequence 
            %                                   generator
            %   SecondPolynomial              - Generator polynomial for second preferred PN
            %                                   sequence
            %   SecondInitialConditionsSource - Source of initial conditions for second
            %                                   PN sequence
            %   SecondInitialConditions       - Initial conditions for second PN sequence
            %                                   generator
            %   Index                         - Index of output sequence of interest
            %   Shift                         - Sequence offset from initial time
            %   VariableSizeOutput            - Enable variable-size outputs
            %   MaximumOutputSize             - Maximum output size
            %   SamplesPerFrame               - Number of output samples per frame
            %   ResetInputPort                - Enable generator reset input
            %   OutputDataType                - Data type of output
            %
            %   % Example:
            %   %   Get 10 samples of a Gold sequence of period 2^5-1
            %
            %   hgld = comm.GoldSequence('FirstPolynomial',[5 2 0],...
            %            'SecondPolynomial', [5 4 3 2 0],...
            %            'FirstInitialConditions', [0 0 0 0 1],...
            %            'SecondInitialConditions', [0 0 0 0 1],...
            %            'Index', 4, 'SamplesPerFrame', 10);
            %   x = step(hgld)
            %
            %   See also comm.KasamiSequence, comm.PNSequence.
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function releaseImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Validate reset input port dimensions
        end

        function stepImpl(in) %#ok<MANU>
            % A non-empty varargin contains either the [input outputsize and/or
            % reset signal] or [secondInit and/or input outputsize]
        end

    end
    methods (Abstract)
    end
    properties
        %FirstInitialConditions Initial conditions for first PN sequence generator
        %   Specify the initial conditions for the shift register of the first
        %   preferred PN sequence generator. The initial conditions are a numeric,
        %   binary scalar, or a numeric, binary vector with length equal to the
        %   degree of the first generator  polynomial specified in the
        %   FirstPolynomial property. If you set this property to a vector, each
        %   element of the vector corresponds to the initial value of the
        %   corresponding cell in the shift register. If you set this property to
        %   a scalar, the initial conditions of all shift register cells are the
        %   specified scalar value. The default is [0 0 0 0 0 1].
        FirstInitialConditions;

        %FirstPolynomial Generator polynomial for first preferred PN sequence
        %   Specify the polynomial that determines the feedback connections for
        %   the shift register of the first preferred PN sequence generator. You
        %   can specify the generator polynomial as a numeric, binary vector that
        %   lists the coefficients of the polynomial in descending order of
        %   powers. The first and last elements must be equal to 1 and the length
        %   of this vector must be n+1, where n is the degree of the generator
        %   polynomial. Alternatively, you can specify the generator polynomial as
        %   a numeric vector containing the exponents of z for the non-zero terms
        %   of the polynomial in descending order of powers. The last entry must
        %   be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent the same
        %   polynomial, g(z) = z^8 + z^2 + 1. The degree of the first generator
        %   polynomial must be equal to the degree of the second generator
        %   polynomial specified in the SecondPolynomial property. The default is
        %   [1 0 0 0 0 1 1].
        FirstPolynomial;

        %Index Index of output sequence of interest
        %   Specify the index of the output sequence of interest from the set of
        %   available sequences as a scalar integer in the range [-2, 2^n-2]. n is
        %   the degree of the generator polynomials you specify in the
        %   FirstPolynomial and SecondPolynomial properties. The index values -2
        %   and -1 correspond to the first and second preferred PN sequences as
        %   generated by the FirstPolynomial and SecondPolynomial, respectively.
        %
        %   The set G(u, v) of available Gold sequences is defined by G(u, v) =
        %   {u, v, (u xor T^v), (u xor T^2v), ..., (u xor T^(N-1)v)}, where T
        %   represents the operator that shifts vectors cyclically to the left by
        %   one place, and u, v are two preferred PN sequences. Note that G(u,v)
        %   contains N+2 Gold sequences of period N. You select the desired
        %   sequence from this set using the Index property. The default is 0.
        Index;

        %MaximumOutputSize Maximum output size
        %   Specify the maximum output size of the Gold sequence as a positive
        %   integer 2-element row vector. The second element of the vector must
        %   be 1. The default is [10 1].
        %
        %   This property applies when you set the VariableSizeOutput property to
        %   true.
        MaximumOutputSize;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'logical' |
        %   'Smallest unsigned integer'. The default is 'double'.
        OutputDataType;

        %ResetInputPort Enable generator reset input
        %   Set this property to true to enable an additional reset input to the
        %   step method. This input resets the states of the two shift registers
        %   of the Gold sequence generator to the initial conditions specified in
        %   the FirstInitialConditions and SecondInitialConditions properties. The
        %   default is false.
        ResetInputPort;

        %SamplesPerFrame Number of output samples per frame
        %   Specify the number of Gold sequence samples that the step method
        %   outputs as a numeric, integer scalar. If you set this property to a
        %   value of M, then the step method outputs M samples of a Gold sequence
        %   that has a period of N = 2^n-1. The value of n represents the degree
        %   of the generator polynomials that you specify in the FirstPolynomial
        %   and SecondPolynomial properties. The default is 1.
        SamplesPerFrame;

        %SecondInitialConditions Initial conditions for second PN sequence
        %                        generator
        %   Specify the initial conditions for the shift register of the second
        %   preferred PN sequence generator as a numeric, binary scalar, or as a
        %   numeric, binary vector with length equal to the degree of the second
        %   generator polynomial specified in the SecondPolynomial property. If
        %   you set this property to a vector, each element of the vector
        %   corresponds to the initial value of the corresponding cell in the
        %   shift register. If you set this property to a scalar, the initial
        %   conditions of all shift register cells are the specified scalar value.
        %   The default is [0 0 0 0 0 1].
        SecondInitialConditions;

        %SecondInitialConditionsSource Source of initial conditions for second PN
        %                              sequence
        %   Specify the source of the initial conditions that determines the
        %   start of the second PN sequence as one of  'Property' | 'Input port'.
        %   The default is 'Property'. When you set this property to 'Property',
        %   the initial conditions can be specified as a scalar or binary vector
        %   using the SecondInitialConditions property. When you set this
        %   property to 'Input port', the initial conditions, which is an input
        %   to the step method, can be specified as a binary scalar or a binary
        %   vector with a length equal to the degree of the generator polynomial
        %   specified by the SecondPolynomial property.
        SecondInitialConditionsSource;

        %SecondPolynomial Generator polynomial for second preferred PN sequence
        %   Specify the polynomial that determines the feedback connections for
        %   the shift register of the second preferred PN sequence generator. You
        %   can specify the generator polynomial as a binary, numeric vector that
        %   lists the coefficients of the polynomial in descending order of
        %   powers. The first and last elements must be equal to 1 and the length
        %   of this vector must be n+1, where n is the degree of the generator
        %   polynomial. Alternatively, you can specify the generator polynomial as
        %   a numeric vector containing the exponents of z for the nonzero terms
        %   of the polynomial in descending order of powers. The last entry must
        %   be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent the same
        %   polynomial, g(z) = z^8 + z^2 + 1. The degree of the second generator
        %   polynomial must equal the degree of the first generator polynomial
        %   specified in the FirstPolynomial property. The default is [1 1 0 0 1 1
        %   1].
        SecondPolynomial;

        %Shift Sequence offset from initial time
        %   Specify the offset of the Gold sequence from its starting point as a
        %   positive or negative, numeric, integer scalar. The Gold sequence has a
        %   period of N = 2^n-1, where n is the degree of the generator
        %   polynomials specified in the FirstPolynomial and SecondPolynomial
        %   properties. The shift value is wrapped with respect to the sequence
        %    period. The default is 0.
        Shift;

        %VariableSizeOutput Enable variable-size outputs
        %   Set this property to true to enable an additional input to the step
        %   method. The default is false. When you set this property to true, the
        %   enabled input specifies the output size of the Gold sequence used for
        %   the step. The input value must be less than or equal to the value of
        %   the MaximumOutputSize property.
        %   
        %   When you set this property to false, the SamplesPerFrame property
        %   specifies the number of output samples.
        VariableSizeOutput;

    end
end
