classdef OSTBCEncoder< handle
%OSTBCEncoder Encode input using orthogonal space-time block code
%   H = comm.OSTBCEncoder creates an orthogonal space-time block code
%   (OSTBC) encoder System object, H. This object maps the input symbols
%   block-wise and concatenates the output codeword matrices in the time
%   domain.
%
%   H = comm.OSTBCEncoder(Name,Value) creates an OSTBC encoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.OSTBCEncoder(N,Name,Value) creates an OSTBC encoder object, H,
%   with the NumTransmitAntennas property set to N and other specified
%   property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes the input data, X, using OSTBC encoder object, H.
%   The input is a complex-valued column vector or matrix of data type
%   double, single, or signed fixed-point with power-of-two slope and zero
%   bias. The step method output, Y, is the same data type as the input
%   data.
%    
%   The time domain length, T, of X must be a multiple of the number of
%   symbols in each codeword matrix. Specifically, when you set the
%   NumTransmitAntennas property is 2 or the SymbolRate property is 1/2, T
%   must be a multiple of 2 and when the SymbolRate property to 3/4, T must
%   be a multiple of 3.
%
%   For a time or spatial domain input of T rows by 1 column, the encoded
%   output data, Y, is a (T/SymbolRate) by NumTransmitAntennas matrix. The
%   input matrix size can be F rows by T columns, where F is the additional
%   dimension (typically the frequency domain) over which the encoding
%   calculation is independent. In this case, the output is an F by
%   (T/SymbolRate) by NumTransmitAntennas matrix.
%
%   OSTBCEncoder methods:
% 
%   step     - Encode inputs using OSTBC (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create OSTBC encoder object with same property values
%   isLocked - Locked status (logical)
%
%   OSTBCEncoder properties:
% 
%   NumTransmitAntennas - Number of transmit antennas
%   SymbolRate          - Symbol rate of code
%
%   The OSTBCEncoder object supports fixed-point operations. For more
%   information, type comm.OSTBCEncoder.helpFixedPoint.
%
%   % Example:
%   %   Encode BPSK modulated data with OSTBC
%
%   % Generate random binary data 
%   data = randi([0 1], 8, 1); 
%   %Create BPSK Modulator and obtain modulated data 
%   hMod = comm.BPSKModulator;
%   modData = step(hMod, data);
% 
%   % Create OSTBC Encoder and encode modulated signal 
%   hOSTBCEnc = comm.OSTBCEncoder; 
%   encData = step(hOSTBCEnc, modData)
% 
%   See also comm.OSTBCCombiner.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=OSTBCEncoder
            %OSTBCEncoder Encode input using orthogonal space-time block code
            %   H = comm.OSTBCEncoder creates an orthogonal space-time block code
            %   (OSTBC) encoder System object, H. This object maps the input symbols
            %   block-wise and concatenates the output codeword matrices in the time
            %   domain.
            %
            %   H = comm.OSTBCEncoder(Name,Value) creates an OSTBC encoder object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.OSTBCEncoder(N,Name,Value) creates an OSTBC encoder object, H,
            %   with the NumTransmitAntennas property set to N and other specified
            %   property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes the input data, X, using OSTBC encoder object, H.
            %   The input is a complex-valued column vector or matrix of data type
            %   double, single, or signed fixed-point with power-of-two slope and zero
            %   bias. The step method output, Y, is the same data type as the input
            %   data.
            %    
            %   The time domain length, T, of X must be a multiple of the number of
            %   symbols in each codeword matrix. Specifically, when you set the
            %   NumTransmitAntennas property is 2 or the SymbolRate property is 1/2, T
            %   must be a multiple of 2 and when the SymbolRate property to 3/4, T must
            %   be a multiple of 3.
            %
            %   For a time or spatial domain input of T rows by 1 column, the encoded
            %   output data, Y, is a (T/SymbolRate) by NumTransmitAntennas matrix. The
            %   input matrix size can be F rows by T columns, where F is the additional
            %   dimension (typically the frequency domain) over which the encoding
            %   calculation is independent. In this case, the output is an F by
            %   (T/SymbolRate) by NumTransmitAntennas matrix.
            %
            %   OSTBCEncoder methods:
            % 
            %   step     - Encode inputs using OSTBC (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create OSTBC encoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   OSTBCEncoder properties:
            % 
            %   NumTransmitAntennas - Number of transmit antennas
            %   SymbolRate          - Symbol rate of code
            %
            %   The OSTBCEncoder object supports fixed-point operations. For more
            %   information, type comm.OSTBCEncoder.helpFixedPoint.
            %
            %   % Example:
            %   %   Encode BPSK modulated data with OSTBC
            %
            %   % Generate random binary data 
            %   data = randi([0 1], 8, 1); 
            %   %Create BPSK Modulator and obtain modulated data 
            %   hMod = comm.BPSKModulator;
            %   modData = step(hMod, data);
            % 
            %   % Create OSTBC Encoder and encode modulated signal 
            %   hOSTBCEnc = comm.OSTBCEncoder; 
            %   encData = step(hOSTBCEnc, modData)
            % 
            %   See also comm.OSTBCCombiner.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.OSTBCEncoder System object fixed-point
            %               information
            %   comm.OSTBCEncoder.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.OSTBCEncoder
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %NumTransmitAntennas Number of transmit antennas
        %   Specify the number of antennas at the transmitter as one of 2 | 3 | 4.
        %   The default is 2.
        NumTransmitAntennas;

        %OverflowAction Action when fixed-point numeric values overflow
        %   Specify the overflow action as one of 'Wrap' | 'Saturate'. The default
        %   is 'Wrap'. This property specifies the action to be taken if the
        %   magnitude of a fixed-point calculation result does not fit into the
        %   range of the data type and scaling that stores the result.
        OverflowAction;

        %SymbolRate Symbol rate of code
        %   Specify the symbol rate of the code as one of 3/4 | 1/2. The default
        %   is 3/4. This property applies when you set the NumTransmitAntennas
        %   property to greater than 2. For 2 transmit antennas, the symbol rate
        %   defaults to 1.
        SymbolRate;

    end
end
