classdef KasamiSequence< handle
%KasamiSequence Generate a Kasami sequence
%   H = comm.KasamiSequence creates a KasamiSequence System object, H, that
%   generates a Kasami sequence.
%
%   H = comm.KasamiSequence(Name,Value) creates a Kasami sequence generator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the Kasami sequence in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The Kasami
%   sequence has a period of N = 2^n-1, where n is the degree of the
%   generator polynomial that you specify in the Polynomial property.
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
%   vector with a length equal to the number of samples per frame that you
%   specify in the SamplesPerFrame property. When the RESET input is a
%   non-zero scalar, the object resets to the initial conditions that you
%   specify in the InitialConditions property. It then generates a new
%   output frame. A column vector RESET input allows multiple resets within
%   an output frame. A non-zero value at the ith element of the vector
%   causes a reset at the ith output sample time.
%
%   You can combine optional input arguments when you set their enabling
%   properties. Optional inputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   Y = step(H, OUTPUTSIZE, RESET) 
%
%   KasamiSequence methods:
%
%   step     - Generate Kasami sequence samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Kasami sequence generator object with same property
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Kasami sequence generator object
%
%   KasamiSequence properties:
%
%   Polynomial         - Generator polynomial
%   InitialConditions  - Initial conditions of shift register
%   Index              - Sequence index
%   Shift              - Sequence offset from initial time
%   VariableSizeOutput - Enable variable-size outputs
%   MaximumOutputSize  - Maximum output size
%   SamplesPerFrame    - Number of output samples per frame
%   ResetInputPort     - Enable generator reset input
%   OutputDataType     - Data type of output
%
%   % Example: 
%   %   Generate 5 samples of a Kasami sequence of length 63
%
%   hks = comm.KasamiSequence('SamplesPerFrame', 5);
%   x   = step(hks)
%
%   See also comm.PNSequence, comm.GoldSequence.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=KasamiSequence
            %KasamiSequence Generate a Kasami sequence
            %   H = comm.KasamiSequence creates a KasamiSequence System object, H, that
            %   generates a Kasami sequence.
            %
            %   H = comm.KasamiSequence(Name,Value) creates a Kasami sequence generator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the Kasami sequence in column vector Y.
            %   Specify the frame length with the SamplesPerFrame property. The Kasami
            %   sequence has a period of N = 2^n-1, where n is the degree of the
            %   generator polynomial that you specify in the Polynomial property.
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
            %   vector with a length equal to the number of samples per frame that you
            %   specify in the SamplesPerFrame property. When the RESET input is a
            %   non-zero scalar, the object resets to the initial conditions that you
            %   specify in the InitialConditions property. It then generates a new
            %   output frame. A column vector RESET input allows multiple resets within
            %   an output frame. A non-zero value at the ith element of the vector
            %   causes a reset at the ith output sample time.
            %
            %   You can combine optional input arguments when you set their enabling
            %   properties. Optional inputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   Y = step(H, OUTPUTSIZE, RESET) 
            %
            %   KasamiSequence methods:
            %
            %   step     - Generate Kasami sequence samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Kasami sequence generator object with same property
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Kasami sequence generator object
            %
            %   KasamiSequence properties:
            %
            %   Polynomial         - Generator polynomial
            %   InitialConditions  - Initial conditions of shift register
            %   Index              - Sequence index
            %   Shift              - Sequence offset from initial time
            %   VariableSizeOutput - Enable variable-size outputs
            %   MaximumOutputSize  - Maximum output size
            %   SamplesPerFrame    - Number of output samples per frame
            %   ResetInputPort     - Enable generator reset input
            %   OutputDataType     - Data type of output
            %
            %   % Example: 
            %   %   Generate 5 samples of a Kasami sequence of length 63
            %
            %   hks = comm.KasamiSequence('SamplesPerFrame', 5);
            %   x   = step(hks)
            %
            %   See also comm.PNSequence, comm.GoldSequence.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Index Sequence index
        %   Specify the Index to select a Kasami sequence of interest from the set
        %   of possible sequences. The default is 0. Kasami sequences have a
        %   period equal to  N = 2^n - 1, where n is a nonnegative, even integer
        %   equal to the degree of the generator polynomial that you specify in
        %   the Polynomial property. There are two classes of Kasami sequences:
        %   those obtained from a small set and those obtained from a large set.
        %   You choose a Kasami sequence from the small set by setting the Index
        %   property to a numeric, scalar, integer value in the range
        %   [0...2^(n/2)-2]. You choose a sequence from the large set by setting
        %   the Index property to a numeric, integer 1x2 vector [k m] for k in
        %   [-2,..., 2^n-2], and m in [-1,..., 2^(n/2)-2].
        Index;

        %InitialConditions Initial conditions of shift register
        %   Specify the initial values of the shift register as a binary numeric
        %   scalar or as binary numeric vector. Set the vector length equal to the
        %   degree of the generator polynomial. If you set this property to a
        %   vector, each element of the vector corresponds to the initial value of
        %   the corresponding cell in the shift register. If you set this property
        %   to a scalar, the initial conditions of all the cells of the shift
        %   register are the specified scalar value. The scalar or at least one
        %   element of the specified vector must be non-zero for the object to
        %   generate a non-zero sequence. The default is [0 0 0 0 0 1].
        InitialConditions;

        %MaximumOutputSize Maximum output size
        %   Specify the maximum output size of the Kasami sequence as a positive
        %   integer 2-element row vector. The second element of the vector must
        %   be 1. The default is [10 1].
        %
        %   This property applies when you set the VariableSizeOutput property to
        %   true.
        MaximumOutputSize;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'logical'. The
        %   default is 'double'.
        OutputDataType;

        %Polynomial Generator polynomial
        %   Specify the polynomial that determines the shift register's feedback
        %   connections. You can specify the generator polynomial as a binary
        %   numeric vector that lists the coefficients of the polynomial in
        %   descending order of powers. The first and last elements must be equal
        %   to 1. The length of this vector must be n+1, where n is the degree of
        %   the generator polynomial. Alternatively, you can specify the generator
        %   polynomial as a vector containing the exponents of z for the nonzero
        %   terms of the polynomial in descending order of powers. The last entry
        %   must be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent the
        %   same polynomial, g(z) = z^8 + z^2 + 1. The default is [1 0 0 0 0 1 1].
        Polynomial;

        %ResetInputPort Enable generator reset input
        %   Set this property to true to enable an additional input to the step
        %   method that resets the states of the Kasami sequence generator to the
        %   initial conditions that you specify in the InitialConditions property.
        %   The default is false.
        ResetInputPort;

        %SamplesPerFrame Number of output samples per frame
        %   Specify the number of Kasami sequence samples that the step method
        %   outputs as a numeric, positive, integer scalar. If you set this
        %   property to a value of M, then the step method outputs M samples of a
        %   Kasami sequence that has a period of N = 2^n-1. Value n is the degree
        %   of the generator polynomial that you specify in the Polynomial
        %   property. The default value of this property is 1.
        SamplesPerFrame;

        %Shift Sequence offset from initial time
        %   Specify the offset of the Kasami sequence from its starting point as a
        %   positive or negative, numeric, integer scalar. The default is 0. The
        %   Kasami sequence has a period of N = 2^n-1, where n is the degree of
        %   the generator polynomial that you specify in the Polynomial property.
        %   The shift value is wrapped with respect to the sequence period.
        Shift;

        %VariableSizeOutput Enable variable-size outputs
        %   Set this property to true to enable an additional input to the step
        %   method. The default is false. When you set this property to true, the
        %   enabled input specifies the output size of the Kasami sequence used
        %   for the step. The input value must be less than or equal to the value
        %   of the MaximumOutputSize property.
        %   
        %   When you set this property to false, the SamplesPerFrame property
        %   specifies the number of output samples.
        VariableSizeOutput;

    end
end
