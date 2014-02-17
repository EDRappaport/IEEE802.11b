classdef LDPCDecoder< handle
%LDPCDecoder Decode binary low-density parity-check code
%   H = comm.LDPCDecoder creates a binary low-density parity-check (LDPC)
%   decoder System object, H. This object performs LDPC decoding based on
%   the specified parity-check matrix, where the object does not assume any
%   patterns in the parity-check matrix.
%
%   H = comm.LDPCDecoder(Name,Value) creates an LDPC decoder object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.LDPCDecoder(PARITY) creates an LDPC decoder object, H, with the
%   ParityCheckMatrix property set to PARITY.
%
%   Step method syntax:
%
%   Y = step(H,X) decodes input codeword, X, using an LDPC code that is
%   based on an (N-K) x N parity-check matrix. You specify the parity-check
%   matrix in the ParityCheckMatrix property. Input X must be a double
%   column vector with length equal N. Each element is the log-likelihood
%   ratio for a received bit (more likely to be 0 if the log-likelihood
%   ratio is positive). The first K elements correspond to the information
%   part of a codeword. The decoded data output vector, Y, contains either
%   only the message bits or the whole code word, based on the value of the 
%   OutputValue property.
%
%   [Y,NUMITER] = step(H,X) returns the actual number of iterations the
%   object performed when you set the NumIterationsOutputPort property to
%   true. The step method outputs NUMITER as a double scalar.
%
%   [Y,PARITY] = step(H,X) returns final parity checks the object calculated
%   when you set the FinalParityChecksOutputPort property to true. The step
%   method outputs PARITY as a double vector of length (N-K).
%
%   You can combine optional output arguments when you set their enabling
%   properties. Optional outputs must be listed in the same order as the
%   order of the enabling properties. For example,
%   
%   [Y,NUMITER,PARITY] = step(H,X)
%
%   LDPCDecoder methods:
%
%   step     - Decode input data (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create LDPC decoder object with same property values
%   isLocked - Locked status (logical)
%
%   LDPCDecoder properties:
%
%   ParityCheckMatrix             - Parity-check matrix
%   OutputValue                   - Select output value format
%   DecisionMethod                - Decision method
%   IterationTerminationCondition - Condition for iteration termination
%   MaximumIterationCount         - Maximum number of decoding iterations
%   NumIterationsOutputPort       - Output number of iterations performed
%   FinalParityChecksOutputPort   - Output final parity checks
%
%   % Example:
%   %   Transmit an LDPC-encoded, QPSK-modulated bit stream through an
%   %   AWGN channel, then demodulate, decode, and count errors
%
%   hEnc = comm.LDPCEncoder;
%   hMod = comm.PSKModulator(4, 'BitInput',true);
%   hChan = comm.AWGNChannel(...
%           'NoiseMethod','Signal to noise ratio (SNR)','SNR',1);
%   hDemod = comm.PSKDemodulator(4, 'BitOutput',true,...
%           'DecisionMethod','Approximate log-likelihood ratio', ...
%           'Variance', 1/10^(hChan.SNR/10));
%   hDec = comm.LDPCDecoder;
%   hError = comm.ErrorRate;
%   for counter = 1:10
%     data           = logical(randi([0 1], 32400, 1));
%     encodedData    = step(hEnc, data);
%     modSignal      = step(hMod, encodedData);
%     receivedSignal = step(hChan, modSignal);
%     demodSignal    = step(hDemod, receivedSignal);
%     receivedBits   = step(hDec, demodSignal);
%     errorStats     = step(hError, data, receivedBits);
%   end
%   fprintf('Error rate       = %1.2f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.gpu.LDPCDecoder, comm.LDPCEncoder, comm.BCHDecoder.

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=LDPCDecoder
            %LDPCDecoder Decode binary low-density parity-check code
            %   H = comm.LDPCDecoder creates a binary low-density parity-check (LDPC)
            %   decoder System object, H. This object performs LDPC decoding based on
            %   the specified parity-check matrix, where the object does not assume any
            %   patterns in the parity-check matrix.
            %
            %   H = comm.LDPCDecoder(Name,Value) creates an LDPC decoder object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.LDPCDecoder(PARITY) creates an LDPC decoder object, H, with the
            %   ParityCheckMatrix property set to PARITY.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) decodes input codeword, X, using an LDPC code that is
            %   based on an (N-K) x N parity-check matrix. You specify the parity-check
            %   matrix in the ParityCheckMatrix property. Input X must be a double
            %   column vector with length equal N. Each element is the log-likelihood
            %   ratio for a received bit (more likely to be 0 if the log-likelihood
            %   ratio is positive). The first K elements correspond to the information
            %   part of a codeword. The decoded data output vector, Y, contains either
            %   only the message bits or the whole code word, based on the value of the 
            %   OutputValue property.
            %
            %   [Y,NUMITER] = step(H,X) returns the actual number of iterations the
            %   object performed when you set the NumIterationsOutputPort property to
            %   true. The step method outputs NUMITER as a double scalar.
            %
            %   [Y,PARITY] = step(H,X) returns final parity checks the object calculated
            %   when you set the FinalParityChecksOutputPort property to true. The step
            %   method outputs PARITY as a double vector of length (N-K).
            %
            %   You can combine optional output arguments when you set their enabling
            %   properties. Optional outputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %   
            %   [Y,NUMITER,PARITY] = step(H,X)
            %
            %   LDPCDecoder methods:
            %
            %   step     - Decode input data (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create LDPC decoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   LDPCDecoder properties:
            %
            %   ParityCheckMatrix             - Parity-check matrix
            %   OutputValue                   - Select output value format
            %   DecisionMethod                - Decision method
            %   IterationTerminationCondition - Condition for iteration termination
            %   MaximumIterationCount         - Maximum number of decoding iterations
            %   NumIterationsOutputPort       - Output number of iterations performed
            %   FinalParityChecksOutputPort   - Output final parity checks
            %
            %   % Example:
            %   %   Transmit an LDPC-encoded, QPSK-modulated bit stream through an
            %   %   AWGN channel, then demodulate, decode, and count errors
            %
            %   hEnc = comm.LDPCEncoder;
            %   hMod = comm.PSKModulator(4, 'BitInput',true);
            %   hChan = comm.AWGNChannel(...
            %           'NoiseMethod','Signal to noise ratio (SNR)','SNR',1);
            %   hDemod = comm.PSKDemodulator(4, 'BitOutput',true,...
            %           'DecisionMethod','Approximate log-likelihood ratio', ...
            %           'Variance', 1/10^(hChan.SNR/10));
            %   hDec = comm.LDPCDecoder;
            %   hError = comm.ErrorRate;
            %   for counter = 1:10
            %     data           = logical(randi([0 1], 32400, 1));
            %     encodedData    = step(hEnc, data);
            %     modSignal      = step(hMod, encodedData);
            %     receivedSignal = step(hChan, modSignal);
            %     demodSignal    = step(hDemod, receivedSignal);
            %     receivedBits   = step(hDec, demodSignal);
            %     errorStats     = step(hError, data, receivedBits);
            %   end
            %   fprintf('Error rate       = %1.2f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.gpu.LDPCDecoder, comm.LDPCEncoder, comm.BCHDecoder.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DecisionMethod Decision method
        %   Specify the decision method used for decoding as one of 'Hard
        %   decision' | 'Soft decision'.  The default is 'Hard decision'. When you
        %   set this property to 'Hard decision', the output is decoded bits of
        %   double or logical data type. When you set this property to 'Soft
        %   decision', the output is log-likelihood ratios of double data type.
        DecisionMethod;

        %FinalParityChecksOutputPort Output final parity checks
        %   Set this property to true to output the final parity checks the object
        %   calculated. The default is false.
        FinalParityChecksOutputPort;

        %IterationTerminationCondition Condition for iteration termination
        %   Specify the condition to stop the decoding iterations as one of
        %   'Maximum iteration count' | 'Parity check satisfied'. The default is
        %   'Maximum iteration count'. When you set this property to 'Maximum
        %   iteration count', the object will iterate for the number of iterations
        %   you specify in the MaximumIterationCount property. When you set this
        %   property to 'Parity check satisfied', the object will determine
        %   if the parity checks are satisfied after each iteration and stops
        %   if all parity checks are satisfied.
        IterationTerminationCondition;

        %MaximumIterationCount Maximum number of decoding iterations
        %   Specify the maximum number of iterations the object uses as an integer
        %   valued numeric scalar. The default is 50. This applies when you set
        %   the IterationTerminationCondition property to 'Maximum iteration
        %   count'.
        MaximumIterationCount;

        %NumIterationsOutputPort Output number of iterations performed
        %   Set this property to true to output the actual number of iterations
        %   the object performed. The default is false.
        NumIterationsOutputPort;

        %OutputValue Select output value format
        %   Specify the output value format as one of 'Information part' | 'Whole
        %   codeword'. The default is 'Information part'. When you set this
        %   property to 'Information part', the output contains only the message
        %   bits and is a K element column vector, assuming an (N-K)xK parity
        %   check matrix. When you set this property to 'Whole codeword', the
        %   output contains the codeword bits and is an N element column vector.
        OutputValue;

        %ParityCheckMatrix Parity-check matrix
        %   Specify the parity-check matrix as either a binary valued sparse
        %   matrix P with dimension (N-K) by N, where N > K > 0, or a two-column
        %   non-sparse integer index matrix I that defines the row and column
        %   indices of the 1s in the parity-check matrix, i.e., P =
        %   sparse(I(:,1), I(:,2), 1). This property accepts numeric data types.
        %   When this property is a sparse matrix, it also accepts a logical data
        %   type. The upper bound for the value of N is (2^31)-1. The default is
        %   the sparse parity-check matrix of the half-rate LDPC code from the
        %   DVB-S.2 standard, which is the result of dvbs2ldpc(1/2).
        % 
        %   To generate code, set this property to a non-sparse index matrix. For
        %   instance, the index matrix for the DVB-S.2 standard can be obtained
        %   from dvbs2ldpc(R, 'indices') with the second input argument
        %   explicitly specified to 'indices', where R represents the code rate.
        ParityCheckMatrix;

    end
end
