classdef PNSequence< handle
%PNSequence Generate a pseudo-noise (PN) sequence
%   H = comm.PNSequence creates a pseudo-noise (PN) sequence generator
%   System object, H. This object generates a sequence of pseudo-random
%   binary numbers using a linear-feedback shift register (LFSR). A simple
%   shift register generator (SSRG or Fibonacci) configuration implements
%   the LFSR.
%
%   H = comm.PNSequence(Name,Value) creates a PN sequence generator object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H) outputs a frame of the PN sequence in column vector Y.
%   Specify the frame length with the SamplesPerFrame property. The PN
%   sequence has a period of N = 2^n-1, where n is the degree of the
%   generator polynomial that you specify in the Polynomial property.
%
%   Y = step(H,INITCOND) uses INITCOND as the initial conditions value when
%   you set the InitialConditionsSource property to 'Input port'. INITCOND
%   must be a numeric scalar or numeric, binary vector with length equal to
%   the degree of the generator polynomial specified in the Polynomial
%   property.
%
%   Y = step(H,MASK) uses MASK as the shift value when you set the
%   MaskSource property to 'Input port'. MASK must be a numeric, binary
%   vector with length equal to the degree of the generator polynomial
%   specified in the Polynomial property. Refer to the Mask property help
%   for details of the mask calculation.
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
%   the SamplesPerFrame property. When the RESET input is a non zero scalar,
%   the object resets to the initial conditions that you specify in the
%   InitialConditions property and then generates a new output frame. A
%   column vector RESET input allows multiple resets within an output frame.
%   A non-zero value at the ith element of the vector will cause a reset at
%   the ith output sample time.
%
%   You can combine optional input arguments when you set their enabling
%   properties. Optional inputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   Y = step(H, INITCOND, MASK, OUTPUTSIZE) or 
%   Y = step(H, MASK, OUTPUTSIZE, RESET)
%
%   PNSequence methods:
%
%   step     - Generate PN sequence samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PN sequence generator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of PN sequence generator object
%
%   PNSequence properties:
%
%   Polynomial              - Generator polynomial
%   InitialConditionsSource - Source of initial conditions
%   InitialConditions       - Initial conditions of shift register
%   MaskSource              - Source of mask to shift PN sequence
%   Mask                    - Mask to shift PN sequence
%   VariableSizeOutput      - Enable variable-size outputs
%   MaximumOutputSize       - Maximum output size
%   SamplesPerFrame         - Number of outputs per frame
%   ResetInputPort          - Enable generator reset input
%   BitPackedOutput         - Output integer representations of bit-packed words
%   NumPackedBits           - Number of bits per bit-packed word
%   SignedOutput            - Output signed bit-packed words
%   OutputDataType          - Data type of output
%
%   % Example: 
%   %   Get 2 frames of 14 samples of a maximal length PN-sequence of
%   %   period 2^3-1 (i.e. get two periods of the sequence)
%
%   hpn = comm.PNSequence('Polynomial',[3 2 0], ...
%          'SamplesPerFrame', 14, 'InitialConditions',[0 0 1]);
%   x1 = step(hpn);
%   x2 = step(hpn);
%   [x1 x2]
%
%   See also comm.KasamiSequence, comm.GoldSequence.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=PNSequence
            %PNSequence Generate a pseudo-noise (PN) sequence
            %   H = comm.PNSequence creates a pseudo-noise (PN) sequence generator
            %   System object, H. This object generates a sequence of pseudo-random
            %   binary numbers using a linear-feedback shift register (LFSR). A simple
            %   shift register generator (SSRG or Fibonacci) configuration implements
            %   the LFSR.
            %
            %   H = comm.PNSequence(Name,Value) creates a PN sequence generator object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H) outputs a frame of the PN sequence in column vector Y.
            %   Specify the frame length with the SamplesPerFrame property. The PN
            %   sequence has a period of N = 2^n-1, where n is the degree of the
            %   generator polynomial that you specify in the Polynomial property.
            %
            %   Y = step(H,INITCOND) uses INITCOND as the initial conditions value when
            %   you set the InitialConditionsSource property to 'Input port'. INITCOND
            %   must be a numeric scalar or numeric, binary vector with length equal to
            %   the degree of the generator polynomial specified in the Polynomial
            %   property.
            %
            %   Y = step(H,MASK) uses MASK as the shift value when you set the
            %   MaskSource property to 'Input port'. MASK must be a numeric, binary
            %   vector with length equal to the degree of the generator polynomial
            %   specified in the Polynomial property. Refer to the Mask property help
            %   for details of the mask calculation.
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
            %   the SamplesPerFrame property. When the RESET input is a non zero scalar,
            %   the object resets to the initial conditions that you specify in the
            %   InitialConditions property and then generates a new output frame. A
            %   column vector RESET input allows multiple resets within an output frame.
            %   A non-zero value at the ith element of the vector will cause a reset at
            %   the ith output sample time.
            %
            %   You can combine optional input arguments when you set their enabling
            %   properties. Optional inputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   Y = step(H, INITCOND, MASK, OUTPUTSIZE) or 
            %   Y = step(H, MASK, OUTPUTSIZE, RESET)
            %
            %   PNSequence methods:
            %
            %   step     - Generate PN sequence samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PN sequence generator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of PN sequence generator object
            %
            %   PNSequence properties:
            %
            %   Polynomial              - Generator polynomial
            %   InitialConditionsSource - Source of initial conditions
            %   InitialConditions       - Initial conditions of shift register
            %   MaskSource              - Source of mask to shift PN sequence
            %   Mask                    - Mask to shift PN sequence
            %   VariableSizeOutput      - Enable variable-size outputs
            %   MaximumOutputSize       - Maximum output size
            %   SamplesPerFrame         - Number of outputs per frame
            %   ResetInputPort          - Enable generator reset input
            %   BitPackedOutput         - Output integer representations of bit-packed words
            %   NumPackedBits           - Number of bits per bit-packed word
            %   SignedOutput            - Output signed bit-packed words
            %   OutputDataType          - Data type of output
            %
            %   % Example: 
            %   %   Get 2 frames of 14 samples of a maximal length PN-sequence of
            %   %   period 2^3-1 (i.e. get two periods of the sequence)
            %
            %   hpn = comm.PNSequence('Polynomial',[3 2 0], ...
            %          'SamplesPerFrame', 14, 'InitialConditions',[0 0 1]);
            %   x1 = step(hpn);
            %   x2 = step(hpn);
            %   [x1 x2]
            %
            %   See also comm.KasamiSequence, comm.GoldSequence.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %BitPackedOutput Output integer representations of bit-packed words
        %   Set this property to true to enable bit-packed outputs. In this case,
        %   the step method outputs a column vector of length M that contains
        %   integer representations of bit words of length P. M is the number of
        %   samples per frame specified in the SamplesPerFrame property. P is the
        %   size of the bit packed words specified in the NumPackedBits property.
        %   The first bit from the left in the bit-packed word is considered the
        %   most significant bit. The default is false.
        BitPackedOutput;

        %InitialConditions Initial conditions of shift register 
        %   Specify the initial values of the shift register as a binary, numeric
        %   scalar or a binary, numeric vector. Set the vector length equal to the
        %   degree of the generator polynomial. If you set this property to a
        %   vector, each element of the vector corresponds to the initial value of
        %   the corresponding cell in the shift register. If you set this property
        %   to a scalar, the initial conditions of all the cells of the shift
        %   register are the specified scalar value. The scalar or at least one
        %   element of the specified vector must be nonzero for the object to
        %   generate a nonzero sequence. The default is [0 0 0 0 0 1].
        InitialConditions;

        %InitialConditionsSource Source of initial conditions
        %   Specify the source of the initial conditions that determines the
        %   start of the PN sequence as one of  'Property' | 'Input port'. The
        %   default is 'Property'. When you set this property to 'Property', the
        %   initial conditions can be specified as a scalar or binary vector
        %   using the InitialConditions property. When you set this property to
        %   'Input port', the initial conditions, which is an input to the step
        %   method, can be specified as a binary scalar or a binary vector with a
        %   length equal to the degree of the generator polynomial specified in
        %   the Polynomial property.
        InitialConditionsSource;

        %Mask Mask to shift PN sequence
        %   Specify the mask that determines how the PN sequence is shifted from
        %   its starting point as a numeric, integer scalar or as a binary vector.
        %
        %   When you set this property to an integer scalar, its value is the
        %   length of the shift. A scalar shift can be positive or negative. When
        %   the PN sequence has a period of N = 2^n-1, where n is the degree of
        %   the generator polynomial that you specify in the Polynomial property,
        %   the object wraps shift values that are negative or greater than N.
        %
        %   When you set this property to a binary vector, its length must be
        %   equal to the degree of the generator polynomial specified in the
        %   Polynomial property. The mask vector that represents m(z) = z^D modulo
        %   g(z), where g(z) is the generator polynomial, corresponds to a shift
        %   of D. For example, for a generator polynomial of degree of 4, the mask
        %   vector corresponding to D = 2 is [0 1 0 0], which represents the
        %   polynomial m(z) = z^2. You can calculate the mask vector using the
        %   shift2mask function.
        %
        %   This property applies when you set the MaskSource property to
        %   'Property'. The default is 0.
        Mask;

        %MaskSource Source of mask to shift PN sequence
        %   Specify the source of the mask that determines the shift of the PN
        %   sequence as one of  'Property' | 'Input port'. The default is
        %   'Property'. When you set this property to 'Property', the mask can be
        %   specified as a scalar or binary vector using the Mask property. When
        %   you set this property to 'Input port', the mask, which is an input to
        %   the step method, can only be specified as a binary vector with a
        %   length equal to the degree of the generator polynomial specified in
        %   the Polynomial property.
        MaskSource;

        %MaximumOutputSize Maximum output size
        %   Specify the maximum output size of the PN sequence as a positive
        %   integer 2-element row vector. The second element of the vector must
        %   be 1. The default is [10 1].
        %
        %   This property applies when you set the VariableSizeOutput property to
        %   true.
        MaximumOutputSize;

        %NumPackedBits Number of bits per bit-packed word
        %   Specify the number of bits to pack into each output data word as a
        %   numeric, integer scalar between 1 and 32. This property applies when
        %   you set the BitPackedOutput property to true. The default is 8.
        NumPackedBits;

        %OutputDataType Data type of output
        %   Specify the output data type as one of 'double' | 'logical' |
        %   'Smallest unsigned integer' when the BitPackedOutput property is
        %   false. Specify the output data type as one of 'double' | 'Smallest
        %   integer' when the BitPackedOutput property is true. The default is
        %   'double'. Note that a Fixed-Point Designer license is required when
        %   this property is set to 'Smallest unsigned integer'.
        OutputDataType;

        %Polynomial Generator polynomial
        %   Specify the polynomial that determines the shift register's feedback
        %   connections. You can specify the generator polynomial as a numeric,
        %   binary vector that lists the coefficients of the polynomial in
        %   descending order of powers. The first and last elements must be equal
        %   to 1 and the length of this vector must be n+1. The value n is the
        %   degree of the generator polynomial. Alternatively, you can specify the
        %   generator polynomial as a numeric vector containing the exponents of z
        %   for the nonzero terms of the polynomial in descending order of powers.
        %   The last entry must be 0. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0]
        %   represent the same polynomial, g(z) = z^8 + z^2 + 1. The PN sequence
        %   has a period of N = 2^n-1. The default is [1 0 0 0 0 1 1].
        Polynomial;

        %ResetInputPort Enable generator reset input
        %   Set this property to true to enable an additional input to the step
        %   method. This input resets the states of the PN sequence generator to
        %   the initial conditions specified in the InitialConditions property.
        %   The default is false.
        ResetInputPort;

        %SamplesPerFrame Number of outputs per frame
        %   Specify the number of PN sequence samples that the step method outputs
        %   as a numeric, positive, integer scalar. If you set this property to a
        %   value of M, then the step method outputs M samples of a PN sequence
        %   that has a period of N = 2^n-1. The value n represents the degree of
        %   the generator polynomial that you specify in the Polynomial property.
        %   If you set the BitPackedOutput property to false, the samples are bits
        %   from the PN sequence. If you set the BitPackedOutput property to true,
        %   then the output corresponds to SamplesPerFrame groups of bit-packed
        %   samples. The default is 1. 
        %
        %   This property applies when you set the VariableSizeOutput property to
        %   false.
        SamplesPerFrame;

        %SignedOutput Output signed bit-packed words
        %   Set this property to true to obtain signed, bit-packed, output words.
        %   In this case, a 1 in the most significant bit (sign bit) indicates a
        %   negative value. Negative numbers are represented in a 2's complement
        %   format. This property applies when you set the BitPackedOutput
        %   property to true. The default is false.
        SignedOutput;

        %VariableSizeOutput Enable variable-size outputs
        %   Set this property to true to enable an additional input to the step
        %   method. The default is false. When you set this property to true, the
        %   enabled input specifies the output size of the PN sequence used for
        %   the step. The input value must be less than or equal to the value of
        %   the MaximumOutputSize property.
        %   
        %   When you set this property to false, the SamplesPerFrame property
        %   specifies the number of output samples.
        VariableSizeOutput;

    end
end
