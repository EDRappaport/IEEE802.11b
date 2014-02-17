classdef LDPCDecoder< handle
%LDPCDecoder LDPC Decoder (GPU)
%   H = comm.gpu.LDPCDecoder creates a binary low-density parity-check
%   (LDPC) decoder System object, H. This object performs LDPC decoding
%   based on the specified parity-check matrix, where the object does not
%   assume any patterns in the parity-check matrix.
%
%   Use of this object requires a Parallel Computing Toolbox license.
%
%   H = comm.gpu.LDPCDecoder(Name,Value) creates an LDPC decoder object, H,
%   with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.gpu.LDPCDecoder(PARITY) creates an LDPC decoder object, H, with
%   the ParityCheckMatrix property set to PARITY.
%
%   Step method syntax:
%
%   Y = step(H,X) decodes input codeword, X, using an LDPC code that is
%   based on an (N-K) x N parity-check matrix. You specify the parity-check
%   matrix in the ParityCheckMatrix property. The input X must be a column
%   vector of type double or single. Each element is the log-likelihood
%   ratio for a received bit (more likely to be 0 if the log-likelihood
%   ratio is positive).  This System object is capable of decoding multiple
%   frames of input data simultaneously.  The length of the input X must be
%   a multiple of N.  The first K elements of every N elements correspond to
%   the information part of a codeword. The decoded data output vector, Y,
%   contains either only the message bits or the whole code word(s), based
%   on the value of the OutputValue property.
%
%   [Y,NUMITER] = step(H,X) returns the actual number of iterations the
%   object performed when you set the NumIterationsOutputPort property to
%   true. The step method outputs NUMITER as a double scalar. 
%
%   [Y,PARITY] = step(H,X) returns final parity checks the object calculated
%   when you set the FinalParityChecksOutputPort property to true. The step
%   method outputs PARITY as a logical vector of length (N-K).
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
%   hDec = comm.gpu.LDPCDecoder;
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
%   See also comm.LDPCDecoder, comm.LDPCEncoder.
%

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=LDPCDecoder
            %LDPCDecoder LDPC Decoder (GPU)
            %   H = comm.gpu.LDPCDecoder creates a binary low-density parity-check
            %   (LDPC) decoder System object, H. This object performs LDPC decoding
            %   based on the specified parity-check matrix, where the object does not
            %   assume any patterns in the parity-check matrix.
            %
            %   Use of this object requires a Parallel Computing Toolbox license.
            %
            %   H = comm.gpu.LDPCDecoder(Name,Value) creates an LDPC decoder object, H,
            %   with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.gpu.LDPCDecoder(PARITY) creates an LDPC decoder object, H, with
            %   the ParityCheckMatrix property set to PARITY.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) decodes input codeword, X, using an LDPC code that is
            %   based on an (N-K) x N parity-check matrix. You specify the parity-check
            %   matrix in the ParityCheckMatrix property. The input X must be a column
            %   vector of type double or single. Each element is the log-likelihood
            %   ratio for a received bit (more likely to be 0 if the log-likelihood
            %   ratio is positive).  This System object is capable of decoding multiple
            %   frames of input data simultaneously.  The length of the input X must be
            %   a multiple of N.  The first K elements of every N elements correspond to
            %   the information part of a codeword. The decoded data output vector, Y,
            %   contains either only the message bits or the whole code word(s), based
            %   on the value of the OutputValue property.
            %
            %   [Y,NUMITER] = step(H,X) returns the actual number of iterations the
            %   object performed when you set the NumIterationsOutputPort property to
            %   true. The step method outputs NUMITER as a double scalar. 
            %
            %   [Y,PARITY] = step(H,X) returns final parity checks the object calculated
            %   when you set the FinalParityChecksOutputPort property to true. The step
            %   method outputs PARITY as a logical vector of length (N-K).
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
            %   hDec = comm.gpu.LDPCDecoder;
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
            %   See also comm.LDPCDecoder, comm.LDPCEncoder.
            %
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
            %Throughout this code msgsPerFrame means the number of connections in the
            %Tanner Graph, or equivalently, the number of ones in the Parity Check
            %Matrix. Here messages refers to the data sent back-and-forth in the
            %message passing decoding algorithm. Here a frame means one received
            %codeword.
        end

    end
    methods (Abstract)
    end
    properties
        %DecisionMethod Decision method
        %   Specify the decision method used for decoding as one of 'Hard
        %   decision' | 'Soft decision'.  The default is 'Hard decision'. When you
        %   set this property to 'Hard decision', the output is decoded bits of
        %   type logical.  When you set this property to 'Soft decision', the
        %   output is log-likelihood ratios of type double or single.
        DecisionMethod;

        %FinalParityChecksOutputPort Output final parity checks
        %   Set this property to true to output the final parity checks the object
        %   calculated. The default is false.
        FinalParityChecksOutputPort;

        GSyndrome;

        GbigQ;

        GcnodeStartInq;

        Gcnodenumel;

        GfnodeStartInr;

        Gfnodenumel;

        Gq2r;

        Gq_arr;

        Gr2q;

        Gr_arr;

        %IterationTerminationCondition Condition for iteration termination
        %   Specify the condition to stop the decoding iterations as one of
        %   'Maximum iteration count' | 'Parity check satisfied'. The default is
        %   'Maximum iteration count'. When you set this property to 'Maximum
        %   iteration count', the object will iterate for the number of iterations
        %   you specify in the MaximumIterationCount property. When you set this
        %   property to 'Parity check satisfied', the object will determine
        %   whether the parity checks are satisfied after each iteration and stop
        %   if all are satisfied. A setting of 'Parity check satisfied' is not
        %   valid for multiframe decoding.
        IterationTerminationCondition;

        %MaximumIterationCount Maximum number of decoding iterations
        %   Specify the maximum number of iterations the object uses as an integer
        %   valued numeric scalar. The default is 50.
        MaximumIterationCount;

        %NumIterationsOutputPort Output number of iterations performed
        %   Set this property to true to output the actual number of iterations
        %   the object performed. The default is false.
        NumIterationsOutputPort;

        %OutputValue Select output value format
        %   Specify the output value format as one of 'Information part' | 'Whole
        %   codeword'. The default is 'Information part'. When you set this
        %   property to 'Information part', the output contains only the message
        %   bits and is a multiple of K length column vector, assuming an (N-K)xK
        %   parity check matrix. When you set this property to 'Whole codeword',
        %   the output contains the codeword bits and is a multiple of N element
        %   column vector.
        OutputValue;

        PCfindCols;

        %ParityCheckMatrix Parity-check matrix
        %   Specify the parity-check matrix as a binary valued, numeric or logical
        %   data type, sparse matrix with dimension (N-K) by N, where N > K > 0.
        %   The upper bound for the value of N is (2^31)-1. The default is the
        %   parity-check matrix of the half-rate LDPC code from the DVB-S.2
        %   standard, which is the result of dvbs2ldpc(1/2).
        ParityCheckMatrix;

        inputReorderKernel;

        updateQkernel;

        updateRkernel;

    end
end
