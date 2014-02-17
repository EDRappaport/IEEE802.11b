classdef CRCDetector< handle
%CRCDetector Detect errors in input data using CRC
%   H = comm.CRCDetector creates a cyclic redundancy code (CRC) detector
%   System object, H, that detects errors in the input data according to a
%   specified generator polynomial.
%
%   H = comm.CRCDetector(Name,Value) creates a CRC detector object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.CRCDetector(POLY,Name,Value) creates a CRC detector object, H,
%   with the Polynomial property set to POLY, and other specified property
%   Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,ERR] = step(H,X) computes checksums for the entire input frame, X. X
%   must be a binary column vector and the data type can be double or
%   logical. The step method outputs a row vector ERR, with size equal to
%   the number of checksums that you specify in the ChecksumsPerFrame
%   property. The elements of ERR are 0 if the checksum computation yields
%   a zero value, and 1 otherwise. The method outputs Y, with the set of
%   ChecksumsPerFrame message words concatenated after removing the
%   checksums bits. The object sets the length of output Y as
%   length(X) - ChecksumsPerFrame*P, where P is the order of the polynomial
%   that you specify in the Polynomial property.
%
%   CRCDetector methods:
%
%   step     - Detect errors in input data using CRC (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CRC detector object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CRC detector object
%
%   CRCDetector properties:
%
%   Polynomial        - Generator polynomial
%   InitialConditions - Initial conditions of shift register
%   DirectMethod      - Direct method (logical)
%   ReflectInputBytes - Reflect input bytes (logical)
%   ReflectChecksums  - Reflect checksums before final XOR (logical)
%   FinalXOR          - Final XOR value
%   ChecksumsPerFrame - Number of checksums per input frame
%
%   % Example:
%   %   Encode a signal and then detect the errors
%
%   % Transmit two message words of length 6
%   x = logical([1 0 1 1 0 1 0 1 1 1 0 1]');
%   % Encode the message words using a CRC generator
%   hGen = comm.CRCGenerator([1 0 0 1], 'ChecksumsPerFrame',2);
%   codeword = step(hGen, x);
%   % Add one bit error to each codeword
%   errorPattern = randerr(2,9,1).';
%   codewordWithError = xor(codeword, errorPattern(:)); 
%   % Decode messages with and without errors using a CRC decoder
%   hDetect = comm.CRCDetector([1 0 0 1], 'ChecksumsPerFrame',2);
%   [tx, err] = step(hDetect, codeword); 
%   [tx1, err1] = step(hDetect, codewordWithError);
%   disp(err)  % err is [0;0], no errors in transmitted message words
%   disp(err1) % err1 is [1;1], errors in both transmitted message words
%
%   See also comm.CRCGenerator.

 
%   Copyright 2008-2013 The MathWorks, Inc.

    methods
        function out=CRCDetector
            %CRCDetector Detect errors in input data using CRC
            %   H = comm.CRCDetector creates a cyclic redundancy code (CRC) detector
            %   System object, H, that detects errors in the input data according to a
            %   specified generator polynomial.
            %
            %   H = comm.CRCDetector(Name,Value) creates a CRC detector object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.CRCDetector(POLY,Name,Value) creates a CRC detector object, H,
            %   with the Polynomial property set to POLY, and other specified property
            %   Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,ERR] = step(H,X) computes checksums for the entire input frame, X. X
            %   must be a binary column vector and the data type can be double or
            %   logical. The step method outputs a row vector ERR, with size equal to
            %   the number of checksums that you specify in the ChecksumsPerFrame
            %   property. The elements of ERR are 0 if the checksum computation yields
            %   a zero value, and 1 otherwise. The method outputs Y, with the set of
            %   ChecksumsPerFrame message words concatenated after removing the
            %   checksums bits. The object sets the length of output Y as
            %   length(X) - ChecksumsPerFrame*P, where P is the order of the polynomial
            %   that you specify in the Polynomial property.
            %
            %   CRCDetector methods:
            %
            %   step     - Detect errors in input data using CRC (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CRC detector object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CRC detector object
            %
            %   CRCDetector properties:
            %
            %   Polynomial        - Generator polynomial
            %   InitialConditions - Initial conditions of shift register
            %   DirectMethod      - Direct method (logical)
            %   ReflectInputBytes - Reflect input bytes (logical)
            %   ReflectChecksums  - Reflect checksums before final XOR (logical)
            %   FinalXOR          - Final XOR value
            %   ChecksumsPerFrame - Number of checksums per input frame
            %
            %   % Example:
            %   %   Encode a signal and then detect the errors
            %
            %   % Transmit two message words of length 6
            %   x = logical([1 0 1 1 0 1 0 1 1 1 0 1]');
            %   % Encode the message words using a CRC generator
            %   hGen = comm.CRCGenerator([1 0 0 1], 'ChecksumsPerFrame',2);
            %   codeword = step(hGen, x);
            %   % Add one bit error to each codeword
            %   errorPattern = randerr(2,9,1).';
            %   codewordWithError = xor(codeword, errorPattern(:)); 
            %   % Decode messages with and without errors using a CRC decoder
            %   hDetect = comm.CRCDetector([1 0 0 1], 'ChecksumsPerFrame',2);
            %   [tx, err] = step(hDetect, codeword); 
            %   [tx1, err1] = step(hDetect, codewordWithError);
            %   disp(err)  % err is [0;0], no errors in transmitted message words
            %   disp(err1) % err1 is [1;1], errors in both transmitted message words
            %
            %   See also comm.CRCGenerator.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %ChecksumsPerFrame Number of checksums per input frame
        %   Specify the number of checksums available at each input frame, X. The
        %   default value of this property is 1. If the length of the step method
        %   input frame is N and the degree of the generator polynomial as P,
        %   then N - ChecksumsPerFrame*P must be divisible by ChecksumsPerFrame.
        %   The object sets the size of the message word as N -
        %   ChecksumsPerFrame*P, after the checksum bits have been removed from
        %   the input frame. This message word corresponds to the first step
        %   method output, Y. The step method then outputs a vector, ERR, with
        %   length equal to the value that you specify in the ChecksumsPerFrame
        %   property.
        %
        %   For example, if the input codeword is size 16, the generator
        %   polynomial has degree 3, you set the ChecksumsPerFrame property to 2,
        %   then the System object:
        %
        %     1) Computes two checksums of size 3, one from the first half of
        %        the received codeword, and the other from the second half of the
        %        received codeword.
        %
        %     2) Concatenates the two halves of the message word as a single
        %        vector of length 10 and outputs this vector through the first
        %        output of the step method.
        %
        %     3) Outputs a length 2 binary vector through the second output of
        %        the step method. The vector values depend on whether the
        %        computed checksums are zero. A 1 in the ith element of the
        %        vector indicates that an error occurred in transmitting the
        %        corresponding ith segment of the input codeword.
        ChecksumsPerFrame;

        %DirectMethod Direct method
        %   Set this property to true to use the direct algorithm for CRC
        %   checksum calculation. Refer to the Communications System Toolbox ->
        %   System Design -> Error Detection and Correction -> Cyclic Redundancy
        %   Check Coding -> CRC Algorithm section to learn more about the direct
        %   and non-direct algorithms. The default value of this property is
        %   false.
        DirectMethod;

        %FinalXOR Final XOR value
        %   Specify the value with which the CRC checksum is to be XORed as a
        %   binary scalar or vector. The object applies the XOR operation just
        %   prior to comparing with the input checksum. The vector length is the
        %   degree of the generator polynomial that you specify in the Polynomial
        %   property. When you specify the final XOR value as a scalar, the
        %   object expands the value to a row vector with a length equal to the
        %   degree of the generator polynomial. The default value of this
        %   property is 0, which is equivalent to no XOR operation.
        FinalXOR;

        %InitialConditions Initial conditions of shift register
        %   Specify the initial conditions of the shift register as a binary
        %   scalar or vector. The vector length is the degree of the generator
        %   polynomial that you specify in the Polynomial property. When you
        %   specify initial conditions as a scalar, the object expands the value
        %   to a row vector with a length equal to the degree of the generator
        %   polynomial. The default value of this property is 0.
        InitialConditions;

        %Polynomial Generator polynomial
        %   Specify the generator polynomial as a binary or integer row vector,
        %   with coefficients in descending order of powers. If you set this
        %   property to a binary vector, its length must be equal to the degree
        %   of the polynomial plus 1. If you set this property to an integer
        %   vector, it contains the powers of the nonzero terms of the
        %   polynomial. For example, [1 0 0 0 0 0 1 0 1] and [8 2 0] represent
        %   the same polynomial, g(z) = z^8 + z^2 + 1.
        %
        %   The following table lists commonly used generator polynomials.
        %   -------------------------------------------------------------------
        %   |CRC Method       | Generator polynomial                          |
        %   -------------------------------------------------------------------
        %   |CRC-32           | [32 26 23 22 16 12 11 10 8 7 5 4 2 1 0]       |
        %   |CRC-24           | [24 23 14 12 8 0]                             |
        %   |CRC-16           | [16 15 2 0]                                   |
        %   |Reversed CRC-16  | [16 14 1 0]                                   |
        %   |CRC-8 	          | [8 7 6 4 2 0]                                 |
        %   |CRC-4 	          | [4 3 2 1 0]                                   |
        %   -------------------------------------------------------------------
        %
        %   The default value of this property is [1 0 0 0 1 0 0 0 0 0 0 1 0 0 0
        %   0 1] which is equivalent to vector [16 12 5 0].
        Polynomial;

        %ReflectChecksums Reflect checksums before final XOR
        %   Set this property to true to flip the CRC checksums around their
        %   centers after the input data are completely through the shift
        %   register. The default value of this property is false.
        ReflectChecksums;

        %ReflectInputBytes Reflect input bytes
        %   Set this property to true to flip the input data on a bytewise basis
        %   prior to entering the data into the shift register. When this
        %   property is set to true, the input frame length divided by the
        %   ChecksumsPerFrame property value minus the degree of the generator
        %   polynomial, which you specify in the Polynomial property, must be an
        %   integer multiple of 8. The default value of this property is false.
        ReflectInputBytes;

    end
end
