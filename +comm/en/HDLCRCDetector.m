classdef HDLCRCDetector< handle
%HDLCRCDetector Detect errors in input data using CRC
%   H = comm.HDLCRCDetector creates a cyclic redundancy code (CRC) detector
%   System object, H, that detects errors in the input data according to a
%   specified generator polynomial.
%
%   H = comm.HDLCRCDetector(Name,Value) creates a CRC detector object, H, 
%   with the specified property Name set to the specified Value. You can 
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.HDLCRCDetector(POLY,Name,Value) creates a CRC detector object,
%   H, with the Polynomial property set to POLY, and other specified 
%   property Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,startOut,endOut,validOut,err] = step(H,X,startIn,endIn,validIn)
%   computes CRC checksums for an input message X based on the control
%   signals and compares the computed checksum with input checksum. The 
%   output err is high if the two checksums are not equal. 
%
%   The input X must be a binary column vector and the data type can be
%   double or logical. The input X can be part or the entire message to 
%   be encoded. The length of X should be less than or equal to the CRC 
%   length, and the CRC length should be divisible by the length of X. 
%   The CRC length is the order of the polynomial that you specify in the
%   Polynomial property. The output Y outputs the message after removing 
%   the checksum bits. Y has the same length and data type as input X.
%
%   All the control signals are scalars with data type logical.
%   startIn/startOut and endIn/endOut indicate the start and end of a
%   input/output message. Input X is processed for CRC checksum
%   computation when validIn is high. validOut indicates the validation
%   of output message. err is valid only when endOut signal is high.
%
%
%   HDLCRCDetector methods:
%
%   step     - Generate CRC code and append it to the input signal
%              (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CRC generator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CRC generator object
%
%   HDLCRCDetector properties:
%
%   Polynomial         - Generator polynomial
%   InitialState       - Initial conditions of shift register
%   ReflectInput       - Reflect Input at byte wise if true
%   ReflectCRCChecksum - Reflect CRC Checksum if true
%   FinalXORValue      - Final XOR value with CRC Checksum
%
% % Example: 
% % Encode and Decode a signal m using a CRC generator and CRC Detector
%   % Using default polynomial with CRC length 16
%   hGen = comm.HDLCRCGenerator;
%   hDet = comm.HDLCRCDetector;
%
%   % run CRC Generator 10 steps
%   numSteps = 10;
%
%   % Control signals for all 10 steps
%   startIn = logical([1 0 0 0 0 0 0 0 0 0]);
%   endIn   = logical([0 1 0 0 0 0 0 0 0 0]);
%   validIn = logical([1 1 0 0 0 0 0 0 0 0]);
%   
%   % 32 bit data to be encoded, in two 16 by 1 columns
%   msg = randi([0 1],16,2); 
%   % random input to HDLCRCGenerator while it is processing the msg
%   randIn = randi([0, 1],16,numSteps-2);
%   dataIn = [msg randIn];
%   
%   % Run CRC Generator 10 steps
%   % Output data: dataOutGen
%   % Output Control signals: startOutGen, endOutGen, validOutGen
%   for i =  1: numSteps
%   [dataOutGen(:,i),startOutGen(i),endOutGen(i),validOutGen(i)] = step(hGen,...
%                              dataIn(:,i),startIn(i),endIn(i),validIn(i));
%   end
%   
%   % Add noise to encoded message 
%   dataOutGen(2,4) = ~dataOutGen(2,4);
%   
%   % Run CRC Detector 10 steps
%   % Output data: dataOut
%   % Output Control signals: startOut, endOut, validOut,err
%    for i = 1:numSteps 
%    [dataOut(:,i), startOut(i),endOut(i), validOut(i),err(i)] = step(hDet,...
%              dataOutGen(:,i),startOutGen(i),endOutGen(i),validOutGen(i));
%    end

     
    
    
%  Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=HDLCRCDetector
            %HDLCRCDetector Detect errors in input data using CRC
            %   H = comm.HDLCRCDetector creates a cyclic redundancy code (CRC) detector
            %   System object, H, that detects errors in the input data according to a
            %   specified generator polynomial.
            %
            %   H = comm.HDLCRCDetector(Name,Value) creates a CRC detector object, H, 
            %   with the specified property Name set to the specified Value. You can 
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.HDLCRCDetector(POLY,Name,Value) creates a CRC detector object,
            %   H, with the Polynomial property set to POLY, and other specified 
            %   property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,startOut,endOut,validOut,err] = step(H,X,startIn,endIn,validIn)
            %   computes CRC checksums for an input message X based on the control
            %   signals and compares the computed checksum with input checksum. The 
            %   output err is high if the two checksums are not equal. 
            %
            %   The input X must be a binary column vector and the data type can be
            %   double or logical. The input X can be part or the entire message to 
            %   be encoded. The length of X should be less than or equal to the CRC 
            %   length, and the CRC length should be divisible by the length of X. 
            %   The CRC length is the order of the polynomial that you specify in the
            %   Polynomial property. The output Y outputs the message after removing 
            %   the checksum bits. Y has the same length and data type as input X.
            %
            %   All the control signals are scalars with data type logical.
            %   startIn/startOut and endIn/endOut indicate the start and end of a
            %   input/output message. Input X is processed for CRC checksum
            %   computation when validIn is high. validOut indicates the validation
            %   of output message. err is valid only when endOut signal is high.
            %
            %
            %   HDLCRCDetector methods:
            %
            %   step     - Generate CRC code and append it to the input signal
            %              (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CRC generator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CRC generator object
            %
            %   HDLCRCDetector properties:
            %
            %   Polynomial         - Generator polynomial
            %   InitialState       - Initial conditions of shift register
            %   ReflectInput       - Reflect Input at byte wise if true
            %   ReflectCRCChecksum - Reflect CRC Checksum if true
            %   FinalXORValue      - Final XOR value with CRC Checksum
            %
            % % Example: 
            % % Encode and Decode a signal m using a CRC generator and CRC Detector
            %   % Using default polynomial with CRC length 16
            %   hGen = comm.HDLCRCGenerator;
            %   hDet = comm.HDLCRCDetector;
            %
            %   % run CRC Generator 10 steps
            %   numSteps = 10;
            %
            %   % Control signals for all 10 steps
            %   startIn = logical([1 0 0 0 0 0 0 0 0 0]);
            %   endIn   = logical([0 1 0 0 0 0 0 0 0 0]);
            %   validIn = logical([1 1 0 0 0 0 0 0 0 0]);
            %   
            %   % 32 bit data to be encoded, in two 16 by 1 columns
            %   msg = randi([0 1],16,2); 
            %   % random input to HDLCRCGenerator while it is processing the msg
            %   randIn = randi([0, 1],16,numSteps-2);
            %   dataIn = [msg randIn];
            %   
            %   % Run CRC Generator 10 steps
            %   % Output data: dataOutGen
            %   % Output Control signals: startOutGen, endOutGen, validOutGen
            %   for i =  1: numSteps
            %   [dataOutGen(:,i),startOutGen(i),endOutGen(i),validOutGen(i)] = step(hGen,...
            %                              dataIn(:,i),startIn(i),endIn(i),validIn(i));
            %   end
            %   
            %   % Add noise to encoded message 
            %   dataOutGen(2,4) = ~dataOutGen(2,4);
            %   
            %   % Run CRC Detector 10 steps
            %   % Output data: dataOut
            %   % Output Control signals: startOut, endOut, validOut,err
            %    for i = 1:numSteps 
            %    [dataOut(:,i), startOut(i),endOut(i), validOut(i),err(i)] = step(hDet,...
            %              dataOutGen(:,i),startOutGen(i),endOutGen(i),validOutGen(i));
            %    end
        end

        function getHeaderImpl(in) %#ok<MANU>
            %getHeaderImpl   Return header for object display
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getInputNamesImpl(in) %#ok<MANU>
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function getOutputNamesImpl(in) %#ok<MANU>
        end

        function outputCRCGen(in) %#ok<MANU>
            % delay
            %            obj.outputCRC =  obj.counter2 > obj.depth;
            %
            %              if obj.counter2== 2*obj.depth
            %                 obj.counter2 =0;
            %                 obj.counter2En = false;
            %              end
            %
            %            if obj.counter2En
            %                obj.counter2= obj.counter2+1;
            %             end
            %
            %             if obj.endInReg
            %
            %                 obj.counter2En = true;
            %             end
            %             obj.endInReg = endIn;
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInitValue(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
            % Input validation
            %obj.validateVectorInputs(m,'Input message');
        end

    end
    methods (Abstract)
    end
    properties
        %FinalXORValue Final XOR value
        % The value with which the CRC checksum is to be XORed just prior
        % to being appended to the input data. This property can be
        % specified as a binary,double or single precision data type scalar
        % or vector. The vector length is the degree of the generator
        % polynomial that you specify in the Polynomial property. When you
        % specify Final XOR Value as a scalar, the object expands the value
        % to a row vector of length equal to the degree of the generator
        % polynomial. The default value is 0.
        FinalXORValue;

        %InitialState Initial state
        %   Specify the initial conditions of the shift register as a
        %   binary, double or single precision data type scalar or vector.
        %   The vector length is the degree of the generator polynomial
        %   that you specify in the Polynomial property. When you specify
        %   initial conditions as a scalar, the object expands the value to
        %   a row vector of length equal to the degree of the generator
        %   polynomial. The default value is 0.
        InitialState;

        %Polynomial
        %   Specify the generator polynomial as a binary row vector, with
        %   coefficients in descending order of powers. If you set this
        %   property to a binary vector, its length must be equal to the
        %   degree of  the polynomial plus 1.
        Polynomial;

        %ReflectCRCChecksum Reflect CRC checksum
        % A logical quantity that specifies whether the output CRC checksum
        % should be flipped around its center after the input data is
        % completely through the shift register.
        ReflectCRCChecksum;

        %ReflectInput Reflect input
        % A logical quantity that specifies whether the input data should
        % be flipped on a bytewise basis prior to entering the shift
        % register.
        ReflectInput;

    end
end
