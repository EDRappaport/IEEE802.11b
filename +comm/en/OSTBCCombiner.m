classdef OSTBCCombiner< handle
%OSTBCCombiner Combine inputs using orthogonal space-time block code 
%   H = comm.OSTBCCombiner creates an orthogonal space-time block code
%   (OSTBC) combiner System object, H. This object combines the input signal
%   (from all of the receive antennas) with the channel estimate signal to
%   extract the soft information of the symbols encoded by an OSTBC.
%
%   H = comm.OSTBCCombiner(Name,Value) creates an OSTBC Combiner object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.OSTBCCombiner(N,M,Name,Value) creates an OSTBC Combiner object,
%   H, with the NumTransmitAntennas property set to N, the
%   NumReceiveAntennas property set to M, and other specified property Names
%   set to the specified Values. N and M are value-only arguments. To
%   specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   Step method syntax:
%
%   Y = step(H,X,CEST) combines the received data, X, and the channel
%   estimate, CEST, to extract the symbols encoded by an OSTBC. Both X and
%   CEST are complex-valued and of the same data type, which can be double,
%   single, or signed fixed point with power-of-two slope and zero bias.
%   When the step method input X has double or single precision, the output,
%   Y, has the same data type as the input. The input channel estimate can
%   remain constant or can vary during each codeword block transmission. The
%   combining algorithm uses the estimate only for the first symbol period
%   per codeword block. 
%
%   The time domain length, T/SymbolRate, must be a multiple of the codeword
%   block length. T is the output symbol sequence length in the time domain.
%   Specifically, when you set the NumTransmitAntennas property to 2,
%   T/SymbolRate must be a multiple of 2. When you set the
%   NumTransmitAntennas property greater than 2, T/SymbolRate must be a
%   multiple of 4.
%
%   For an input of T/SymbolRate rows by NumReceiveAntennas columns, the
%   input channel estimate, CEST, must be a matrix of size T/SymbolRate by
%   NumTransmitAntennas by NumReceiveAntennas. In this case, the extracted
%   symbol data, Y, is a column vector with T elements.
%
%   Input matrix size can be F by T/SymbolRate by NumReceiveAntennas, where
%   F is an optional dimension (typically frequency domain) over which the
%   combining calculation is independent. In this case, the input channel
%   estimate, CEST, must be a matrix of size F by T/SymbolRate by
%   NumTransmitAntennas by NumReceiveAntennas. The extracted symbol data, Y,
%   is an F rows by T columns matrix.
%
%   OSTBCCombiner methods:
%
%   step     - Combine inputs using OSTBC (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create OSTBC combiner object with same property values
%   isLocked - Locked status (logical)
%
%   OSTBCCombiner properties:
%
%   NumTransmitAntennas - Number of transmit antennas
%   SymbolRate          - Symbol rate of code
%   NumReceiveAntennas  - Number of receive antennas
%
%   Fixed-point property information:
%
%   The OSTBCCombiner object supports fixed-point operations. For more
%   information, type comm.OSTBCCombiner.helpFixedPoint.
%
%   % Example:
%   %   Encode and decode QPSK modulated data with OSTBC and calculate
%   %   error rate
%
%   % Define system parameters
%   numTx = 2; numRx = 1; Rs = 1e6; maxDopp = 30; numBits = 1024; SNR = 10;
%   % Create modulator and encoder System objects
%   hMod = comm.QPSKModulator(...
%           'BitInput',      true,...
%           'SymbolMapping', 'Gray');
%   hDemod = comm.QPSKDemodulator(...
%           'SymbolMapping', 'Gray',...
%           'BitOutput',      true);
%   hOSTBCEnc = comm.OSTBCEncoder(...
%           'NumTransmitAntennas', numTx);
%   hOSTBCComb = comm.OSTBCCombiner(...
%           'NumTransmitAntennas', numTx,...
%           'NumReceiveAntennas',  numRx);
%   % Create MIMO channel System object
%   hChan = comm.MIMOChannel(...
%           'SampleRate',               Rs,...
%           'MaximumDopplerShift',      maxDopp,...
%           'SpatialCorrelation',       false,...
%           'NumTransmitAntennas',      numTx,...
%           'NumReceiveAntennas',       numRx,...
%           'PathGainsOutputPort',      true);
%   % Create AWGN channel System object
%   hAWGN = comm.AWGNChannel(...
%           'NoiseMethod', 'Signal to noise ratio (SNR)',...
%           'SNR',         SNR,...
%           'SignalPower', 1);
%
%   % Generate data
%   data = randi([0 1], numBits, 1);
%   % Modulate data
%   modData = step(hMod, data);
%   % Encode modulated data using OSTBC
%   encData = step(hOSTBCEnc, modData);  
%   % Transmit through Rayleigh and AWGN channels
%   [chanOut, pathGains] = step(hChan, encData);  
%   rxSignal = step(hAWGN, chanOut);  
%   % Decode and demodulate received signal
%   decData = step(hOSTBCComb, rxSignal, squeeze(pathGains));
%   receivedData = step(hDemod, decData);
%   % Compute number of bit errors in received data
%   errors = biterr(data, receivedData);
%   fprintf(1, ['\nThere were %d errors in the received signal ' ...
%               'out of %d bits transmitted\n'], errors, length(data));
%
%   See also comm.OSTBCEncoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=OSTBCCombiner
            %OSTBCCombiner Combine inputs using orthogonal space-time block code 
            %   H = comm.OSTBCCombiner creates an orthogonal space-time block code
            %   (OSTBC) combiner System object, H. This object combines the input signal
            %   (from all of the receive antennas) with the channel estimate signal to
            %   extract the soft information of the symbols encoded by an OSTBC.
            %
            %   H = comm.OSTBCCombiner(Name,Value) creates an OSTBC Combiner object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.OSTBCCombiner(N,M,Name,Value) creates an OSTBC Combiner object,
            %   H, with the NumTransmitAntennas property set to N, the
            %   NumReceiveAntennas property set to M, and other specified property Names
            %   set to the specified Values. N and M are value-only arguments. To
            %   specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X,CEST) combines the received data, X, and the channel
            %   estimate, CEST, to extract the symbols encoded by an OSTBC. Both X and
            %   CEST are complex-valued and of the same data type, which can be double,
            %   single, or signed fixed point with power-of-two slope and zero bias.
            %   When the step method input X has double or single precision, the output,
            %   Y, has the same data type as the input. The input channel estimate can
            %   remain constant or can vary during each codeword block transmission. The
            %   combining algorithm uses the estimate only for the first symbol period
            %   per codeword block. 
            %
            %   The time domain length, T/SymbolRate, must be a multiple of the codeword
            %   block length. T is the output symbol sequence length in the time domain.
            %   Specifically, when you set the NumTransmitAntennas property to 2,
            %   T/SymbolRate must be a multiple of 2. When you set the
            %   NumTransmitAntennas property greater than 2, T/SymbolRate must be a
            %   multiple of 4.
            %
            %   For an input of T/SymbolRate rows by NumReceiveAntennas columns, the
            %   input channel estimate, CEST, must be a matrix of size T/SymbolRate by
            %   NumTransmitAntennas by NumReceiveAntennas. In this case, the extracted
            %   symbol data, Y, is a column vector with T elements.
            %
            %   Input matrix size can be F by T/SymbolRate by NumReceiveAntennas, where
            %   F is an optional dimension (typically frequency domain) over which the
            %   combining calculation is independent. In this case, the input channel
            %   estimate, CEST, must be a matrix of size F by T/SymbolRate by
            %   NumTransmitAntennas by NumReceiveAntennas. The extracted symbol data, Y,
            %   is an F rows by T columns matrix.
            %
            %   OSTBCCombiner methods:
            %
            %   step     - Combine inputs using OSTBC (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create OSTBC combiner object with same property values
            %   isLocked - Locked status (logical)
            %
            %   OSTBCCombiner properties:
            %
            %   NumTransmitAntennas - Number of transmit antennas
            %   SymbolRate          - Symbol rate of code
            %   NumReceiveAntennas  - Number of receive antennas
            %
            %   Fixed-point property information:
            %
            %   The OSTBCCombiner object supports fixed-point operations. For more
            %   information, type comm.OSTBCCombiner.helpFixedPoint.
            %
            %   % Example:
            %   %   Encode and decode QPSK modulated data with OSTBC and calculate
            %   %   error rate
            %
            %   % Define system parameters
            %   numTx = 2; numRx = 1; Rs = 1e6; maxDopp = 30; numBits = 1024; SNR = 10;
            %   % Create modulator and encoder System objects
            %   hMod = comm.QPSKModulator(...
            %           'BitInput',      true,...
            %           'SymbolMapping', 'Gray');
            %   hDemod = comm.QPSKDemodulator(...
            %           'SymbolMapping', 'Gray',...
            %           'BitOutput',      true);
            %   hOSTBCEnc = comm.OSTBCEncoder(...
            %           'NumTransmitAntennas', numTx);
            %   hOSTBCComb = comm.OSTBCCombiner(...
            %           'NumTransmitAntennas', numTx,...
            %           'NumReceiveAntennas',  numRx);
            %   % Create MIMO channel System object
            %   hChan = comm.MIMOChannel(...
            %           'SampleRate',               Rs,...
            %           'MaximumDopplerShift',      maxDopp,...
            %           'SpatialCorrelation',       false,...
            %           'NumTransmitAntennas',      numTx,...
            %           'NumReceiveAntennas',       numRx,...
            %           'PathGainsOutputPort',      true);
            %   % Create AWGN channel System object
            %   hAWGN = comm.AWGNChannel(...
            %           'NoiseMethod', 'Signal to noise ratio (SNR)',...
            %           'SNR',         SNR,...
            %           'SignalPower', 1);
            %
            %   % Generate data
            %   data = randi([0 1], numBits, 1);
            %   % Modulate data
            %   modData = step(hMod, data);
            %   % Encode modulated data using OSTBC
            %   encData = step(hOSTBCEnc, modData);  
            %   % Transmit through Rayleigh and AWGN channels
            %   [chanOut, pathGains] = step(hChan, encData);  
            %   rxSignal = step(hAWGN, chanOut);  
            %   % Decode and demodulate received signal
            %   decData = step(hOSTBCComb, rxSignal, squeeze(pathGains));
            %   receivedData = step(hDemod, decData);
            %   % Compute number of bit errors in received data
            %   errors = biterr(data, receivedData);
            %   fprintf(1, ['\nThere were %d errors in the received signal ' ...
            %               'out of %d bits transmitted\n'], errors, length(data));
            %
            %   See also comm.OSTBCEncoder.
        end

        function helpFixedPoint(in) %#ok<MANU>
            %helpFixedPoint Display comm.OSTBCCombiner System object
            %               fixed-point information
            %   comm.OSTBCCombiner.helpFixedPoint displays information about
            %   fixed-point properties and operations of the comm.OSTBCCombiner
            %   System object.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
            % Output data type is always the same as that of the input if the input
            % is floating-point. 
        end

    end
    methods (Abstract)
    end
    properties
        %AccumulatorDataType Data type of accumulator
        %   Specify the accumulator data type as one of 'Full precision' | 'Same as
        %   product' | 'Custom'. The default is 'Full precision'.
        AccumulatorDataType;

        %CustomAccumulatorDataType Fixed-point data type of accumulator
        %   Specify the accumulator fixed-point type as a scaled numerictype
        %   object with a Signedness of Auto. This property applies when you set
        %   the AccumulatorDataType property to 'Custom'. The default is
        %   numerictype([],32,16).
        %
        %   See also numerictype.
        CustomAccumulatorDataType;

        %CustomDivisionDataType Fixed-point data type of division
        %   Specify the division fixed-point type as a scaled numerictype object
        %   with a Signedness of Auto. This property applies when you set the
        %   DivisionDataType property to 'Custom'. The default is
        %   numerictype([],32,16).
        %
        %   See also numerictype.
        CustomDivisionDataType;

        %CustomEnergyAccumulatorDataType Fixed-point data type of energy
        %                                accumulator
        %   Specify the energy accumulator fixed-point type as a scaled
        %   numerictype object with a Signedness of Auto. This property applies
        %   when you set the EnergyAccumulatorDataType property to 'Custom'. The
        %   default is numerictype([],32,16).
        %
        %   See also numerictype.
        CustomEnergyAccumulatorDataType;

        %CustomEnergyProductDataType Fixed-point data type of energy product
        %   Specify the energy product fixed-point type as a scaled numerictype
        %   object with a Signedness of Auto. This property applies when you set
        %   the EnergyProductDataType property to 'Custom'. The default is
        %   numerictype([],32,16).
        %
        %   See also numerictype.
        CustomEnergyProductDataType;

        %CustomProductDataType Fixed-point data type of product
        %   Specify the product fixed-point type as a scaled numerictype object
        %   with a Signedness of Auto. This property applies when you set the
        %   ProductDataType property to 'Custom'. The default is
        %   numerictype([],32,16).
        %
        %   See also numerictype.
        CustomProductDataType;

        %DivisionDataType Data type of division
        %   Specify the division data type as one of 'Same as accumulator' |
        %   'Custom'. The default is 'Same as accumulator'. This property sets the
        %   data type at the output of the division operation to normalize
        %   diversity combining by the total energy in the MIMO channel.
        DivisionDataType;

        %EnergyAccumulatorDataType Data type of energy accumulator
        %   Specify the energy accumulator data type as one of 'Full precision' |
        %   'Same as energy product' | 'Same as accumulator' | 'Custom'. The
        %   default is 'Full precision'. This property sets the data type of the
        %   summation in the denominator to calculate the total energy in the MIMO
        %   channel.
        EnergyAccumulatorDataType;

        %EnergyProductDataType Data type of energy product
        %   Specify the complex energy product data type as one of 'Full precision'
        %   | 'Same as product' | 'Custom'. The default is 'Full precision'. This
        %   property sets the data type of the complex product in the denominator
        %   to calculate the total energy in the MIMO channel.
        EnergyProductDataType;

        %NumReceiveAntennas Number of receive antennas
        %   Specify the number of antennas at the receiver as a double precision,
        %   real, scalar integer value from 1 to 8. The default is 1.
        NumReceiveAntennas;

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

        %ProductDataType Data type of product
        %   Specify the product data type as one of 'Full precision' | 'Custom'.
        %   The default is 'Full precision'.
        ProductDataType;

        %RoundingMethod Rounding of fixed-point numeric values
        %   Specify the rounding method as one of 'Ceiling' | 'Convergent' |
        %   'Floor' | 'Nearest' | 'Round' | 'Simplest' | 'Zero'. The default is
        %   'Floor'.
        RoundingMethod;

        %SymbolRate Symbol rate of code
        %   Specify the symbol rate of the code as one of 3/4 | 1/2. The default
        %   is 3/4. This property applies when the NumTransmitAntennas property is
        %   greater than 2. For 2 transmit antennas, the symbol rate defaults to
        %   1.
        SymbolRate;

    end
end
