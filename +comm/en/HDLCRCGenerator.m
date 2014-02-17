classdef HDLCRCGenerator< handle
%HDLCRCGenerator Generate CRC code bits and append to input data.
%   H = comm.HDLCRCGenerator creates a cyclic redundancy code (CRC)
%   generator System object, H. This object generates CRC bits
%   according to a specified generator polynomial and appends them to
%   the input data.
%
%   H = comm.HDLCRCGenerator(Name,Value) creates a CRC generator
%   object, H, with the specified property Name set to the specified
%   Value. You can specify additional name-value pair arguments in any
%   order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.HDLCRCGenerator(POLY,Name,Value) creates a CRC generator
%   object, H, with the Polynomial property set to POLY, and other
%   specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   [Y,startOut,endOut,validOut] = step(H,X,startIn,endIn,validIn)
%   generates CRC checksums for an input X based on the control signals. 
%   The input X must be a binary column vector and the data type can be
%   double or logical. The input X can be part or the entire message to 
%   be encoded. The length of X should be less than or equal to the CRC 
%   length, and the CRC length should be divisible by the length of X. 
%   The CRC length is the order of the polynomial that you specify in the
%   Polynomial property. The output Y has the same length and data type as
%   input X.
%
%   All the control signals are scalars with data type logical.
%   startIn/startOut and endIn/endOut indicate the start and end of a
%   input/output. Input X is processed for CRC checksum computation when 
%   validIn is high. validOut indicates the validity of output message 
%   plus CRC checksums.
%
%
%   HDLCRCGenerator methods:
%
%   step     - Generate CRC code and append it to the input signal
%              (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CRC generator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CRC generator object
%
%   HDLCRCGenerator properties:
%
%   Polynomial         - Generator polynomial
%   InitialState       - Initial conditions of shift register
%   ReflectInput       - Reflect Input at byte wise if true
%   ReflectCRCChecksum - Reflect CRC Checksum if true
%   FinalXORValue      - Final XOR value with CRC Checksum
%
% Example: 
% % Encode a signal m using a CRC generator
%   % Using default polynomial with CRC length 16
%   hGen = comm.HDLCRCGenerator;
%   % run CRC Generator 6 steps
%   numSteps = 6;
%   % Control signals for all 6 steps
%   startIn = logical([1 0 0 0 0 0]);
%   endIn   = logical([0 1 0 0 0 0]);
%   validIn = logical([1 1 0 0 0 0]);
%   
%   % 32 bit data to be encoded, in two 16 by 1 columns
%   msg = randi([0 1],16,2); 
%   % random input to HDLCRCGenerator while it is processing the msg
%   randIn = randi([0, 1],16,numSteps-2);
%   dataIn = [msg randIn];
%   
%   % Run CRC Generator 6 steps
%   % Output data: dataOut
%   % Output Control signals: startOut, endOut, validOut
%   for i =  1: numSteps
%   [dataOut(:,i), startOut(i),endOut(i), validOut(i)] = step(hGen,...
%                              dataIn(:,i),startIn(i),endIn(i),validIn(i));
%   end

     
    
    
%  Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=HDLCRCGenerator
            %HDLCRCGenerator Generate CRC code bits and append to input data.
            %   H = comm.HDLCRCGenerator creates a cyclic redundancy code (CRC)
            %   generator System object, H. This object generates CRC bits
            %   according to a specified generator polynomial and appends them to
            %   the input data.
            %
            %   H = comm.HDLCRCGenerator(Name,Value) creates a CRC generator
            %   object, H, with the specified property Name set to the specified
            %   Value. You can specify additional name-value pair arguments in any
            %   order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.HDLCRCGenerator(POLY,Name,Value) creates a CRC generator
            %   object, H, with the Polynomial property set to POLY, and other
            %   specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   [Y,startOut,endOut,validOut] = step(H,X,startIn,endIn,validIn)
            %   generates CRC checksums for an input X based on the control signals. 
            %   The input X must be a binary column vector and the data type can be
            %   double or logical. The input X can be part or the entire message to 
            %   be encoded. The length of X should be less than or equal to the CRC 
            %   length, and the CRC length should be divisible by the length of X. 
            %   The CRC length is the order of the polynomial that you specify in the
            %   Polynomial property. The output Y has the same length and data type as
            %   input X.
            %
            %   All the control signals are scalars with data type logical.
            %   startIn/startOut and endIn/endOut indicate the start and end of a
            %   input/output. Input X is processed for CRC checksum computation when 
            %   validIn is high. validOut indicates the validity of output message 
            %   plus CRC checksums.
            %
            %
            %   HDLCRCGenerator methods:
            %
            %   step     - Generate CRC code and append it to the input signal
            %              (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create CRC generator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of CRC generator object
            %
            %   HDLCRCGenerator properties:
            %
            %   Polynomial         - Generator polynomial
            %   InitialState       - Initial conditions of shift register
            %   ReflectInput       - Reflect Input at byte wise if true
            %   ReflectCRCChecksum - Reflect CRC Checksum if true
            %   FinalXORValue      - Final XOR value with CRC Checksum
            %
            % Example: 
            % % Encode a signal m using a CRC generator
            %   % Using default polynomial with CRC length 16
            %   hGen = comm.HDLCRCGenerator;
            %   % run CRC Generator 6 steps
            %   numSteps = 6;
            %   % Control signals for all 6 steps
            %   startIn = logical([1 0 0 0 0 0]);
            %   endIn   = logical([0 1 0 0 0 0]);
            %   validIn = logical([1 1 0 0 0 0]);
            %   
            %   % 32 bit data to be encoded, in two 16 by 1 columns
            %   msg = randi([0 1],16,2); 
            %   % random input to HDLCRCGenerator while it is processing the msg
            %   randIn = randi([0, 1],16,numSteps-2);
            %   dataIn = [msg randIn];
            %   
            %   % Run CRC Generator 6 steps
            %   % Output data: dataOut
            %   % Output Control signals: startOut, endOut, validOut
            %   for i =  1: numSteps
            %   [dataOut(:,i), startOut(i),endOut(i), validOut(i)] = step(hGen,...
            %                              dataIn(:,i),startIn(i),endIn(i),validIn(i));
            %   end
        end

        function computeCRC(in) %#ok<MANU>
        end

        function derivePrivPropSettings(in) %#ok<MANU>
            % derivePrivPropSettings
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

        function loadObjectImpl(in) %#ok<MANU>
            % loadObjectImpl
        end

        function resetImpl(in) %#ok<MANU>
            % resetImpl
            % since the states have already been appropriately sized by
            % setupImpl, we just need to initialize them
        end

        function saveObjectImpl(in) %#ok<MANU>
            % saveObjectImpl
        end

        function setDiscreteStateImpl(in) %#ok<MANU>
            % setDiscreteStateImpl
            % Set discrete states      
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInitValue(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
            % Input validation
        end

    end
    methods (Abstract)
    end
    properties
        F;

        %FinalXORValue Final XOR value
        % The value with which the CRC checksum is to be XORed just prior
        % to being appended to the input data. This property can be
        % specified as a binary,double or single precision data type scalar
        % or vector. The vector length is the degree of the generator
        % polynomial that you specify in the Polynomial property. When you
        % specify Final XOR Value as a scalar, the object expands the value
        % to a row vector of length equal to the degree of the generator
        % polynomial. The default is 0.
        FinalXORValue;

        %InitialState Initial state
        %   Specify the initial conditions of the shift register as a
        %   binary, double or single precision data type scalar or vector.
        %   The vector length is the degree of the generator polynomial
        %   that you specify in the Polynomial property. When you specify
        %   initial conditions as a scalar, the object expands the value to
        %   a row vector of length equal to the degree of the generator
        %   polynomial. The default is 0.
        InitialState;

        %Polynomial
        %   Specify the generator polynomial as a binary row vector, with
        %   coefficients in descending order of powers. If you set this
        %   property to a binary vector, its length must be equal to the
        %   degree of  the polynomial plus 1. The default is
        %   [1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1].
        Polynomial;

        %ReflectCRCChecksum Reflect CRC checksum
        % A logical quantity that specifies whether the output CRC checksum
        % should be flipped around its center after the input data is
        % completely through the shift register.The default is false.
        ReflectCRCChecksum;

        %ReflectInput Reflect input
        % A logical quantity that specifies whether the input data should
        % be flipped on a bytewise basis prior to entering the shift
        % register. The default is false.
        ReflectInput;

        %counter1 -  = 0;
        counter1;

        %counter2 -  = 0;
        counter2;

        crcoutreg;

        dm;

        %endIn_delay -  = false;
        endIn_delay;

        %endOutReg -  = false;
        endOutReg;

        initVector;

        mReg;

        %outputCRC -  = false;
        outputCRC;

        %padZero - =false;
        padZero;

        %processCRC -  =false;
        processCRC;

        %processMsg -  = false;
        processMsg;

        reg;

        % not used - tValidOut = false;
        startOutReg;

        startOutbuffer;

        %sysenb -  = false;
        sysenb;

        %tEndOut -  =false;
        tEndOut;

        %tStartOut -  =false;
        tStartOut;

        validInReg;

        %validIn_delay -  = false;
        validIn_delay;

        %validOutReg -  = false;
        validOutReg;

        xorValue;

        yOutReg;

    end
end
