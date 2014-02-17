classdef LDPCEncoder< handle
%LDPCEncoder Encode binary low-density parity-check code
%   H = comm.LDPCEncoder creates a binary low-density parity-check (LDPC)
%   encoder System object, H. This object performs LDPC encoding based on
%   the specified parity-check matrix.
%
%   H = comm.LDPCEncoder(Name,Value) creates an LDPC encoder object, H,
%   with the specified property Name set to the specified Value.
%
%   H = comm.LDPCEncoder(PARITY) creates an LDPC encoder object, H, with the
%   ParityCheckMatrix property set to PARITY.
%
%   Step method syntax:
%
%   Y = step(H,X) encodes input binary message, X, using an LDPC code that
%   is based on an (N-K) x N parity-check matrix. You specify the
%   parity-check matrix in the ParityCheckMatrix property. Input X must be a
%   numeric or logical column vector with length equal K. The length of the
%   encoded data output vector, Y, is N.  It is a solution to the
%   parity-check equation, with the first K bits equal to the input, X.
%
%   LDPCEncoder methods:
%
%   step     - Encode input data (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create LDPC encoder object with same property values
%   isLocked - Locked status (logical)
%
%   LDPCEncoder properties:
%
%   ParityCheckMatrix - Parity-check matrix
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
%   See also comm.LDPCDecoder, comm.BCHEncoder.

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=LDPCEncoder
            %LDPCEncoder Encode binary low-density parity-check code
            %   H = comm.LDPCEncoder creates a binary low-density parity-check (LDPC)
            %   encoder System object, H. This object performs LDPC encoding based on
            %   the specified parity-check matrix.
            %
            %   H = comm.LDPCEncoder(Name,Value) creates an LDPC encoder object, H,
            %   with the specified property Name set to the specified Value.
            %
            %   H = comm.LDPCEncoder(PARITY) creates an LDPC encoder object, H, with the
            %   ParityCheckMatrix property set to PARITY.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) encodes input binary message, X, using an LDPC code that
            %   is based on an (N-K) x N parity-check matrix. You specify the
            %   parity-check matrix in the ParityCheckMatrix property. Input X must be a
            %   numeric or logical column vector with length equal K. The length of the
            %   encoded data output vector, Y, is N.  It is a solution to the
            %   parity-check equation, with the first K bits equal to the input, X.
            %
            %   LDPCEncoder methods:
            %
            %   step     - Encode input data (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create LDPC encoder object with same property values
            %   isLocked - Locked status (logical)
            %
            %   LDPCEncoder properties:
            %
            %   ParityCheckMatrix - Parity-check matrix
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
            %   See also comm.LDPCDecoder, comm.BCHEncoder.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
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
