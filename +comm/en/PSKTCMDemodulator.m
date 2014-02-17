classdef PSKTCMDemodulator< handle
%PSKTCMDemodulator Demodulate convolutionally encoded data mapped to M-ary
%PSK constellation
%   H = comm.PSKTCMDemodulator creates a trellis-coded, M-ary phase shift,
%   keying (PSK TCM) demodulator System object, H. This object demodulates
%   convolutionally encoded data that has been mapped to an M-PSK
%   constellation.
%
%   H = comm.PSKTCMDemodulator(Name,Value) creates a PSK TCM demodulator
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PSKTCMDemodulator(TRELLIS,Name,Value) creates a PSK TCM
%   demodulator System object, H, with the TrellisStructure property set to
%   TRELLIS and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates the PSK modulated input data, X, and uses the
%   Viterbi algorithm to decode the resulting demodulated, convolutionally
%   encoded bits. X must be a complex, double or single precision column
%   vector. The step method outputs a demodulated, binary data column
%   vector, Y. When the convolutional encoder represents a rate K/N code,
%   the length of the output vector is K*L, where L is the length of the
%   input vector, X.
%
%   Y = step(H,X,R) resets the decoder to the all-zeros state when you input
%   a reset signal, R that is non-zero. R must be a double precision or
%   logical, scalar integer. This syntax applies when you set the
%   ResetInputPort property to true.
%
%   PSKTCMDemodulator methods:
%
%   step     - Demodulate using PSK TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create PSK TCM demodulator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the PSK TCM demodulator object
%
%   PSKTCMDemodulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   TracebackDepth    - Traceback depth for Viterbi decoder
%   ResetInputPort    - Enable demodulator reset input
%   ModulationOrder   - Number of points in signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate and demodulate data using 8-PSK TCM modulation
%
%   % Define a trellis structure with 4-ary input symbols and 8-ary output 
%   % symbols
%   t =  poly2trellis([5 4],[23 35 0; 0 5 13]);
%   hMod = comm.PSKTCMModulator(t,'ModulationOrder', 8);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)','SNR',6);
%   hDemod = comm.PSKTCMDemodulator(t, 'ModulationOrder', 8, ...
%                   'TracebackDepth',16);
%   % Create an error rate calculator with delay in bits equal to
%   % TracebackDepth times the number of bits per symbol
%   hError = comm.ErrorRate('ReceiveDelay',...
%                   hDemod.TracebackDepth*log2(t.numInputSymbols));
%   for counter = 1:10
%     % Transmit frames of 250 2-bit symbols
%     data = randi([0 1],500,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.PSKTCMModulator, comm.GeneralQAMTCMDemodulator,
%            comm.RectangularQAMTCMDemodulator, comm.ViterbiDecoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PSKTCMDemodulator
            %PSKTCMDemodulator Demodulate convolutionally encoded data mapped to M-ary
            %PSK constellation
            %   H = comm.PSKTCMDemodulator creates a trellis-coded, M-ary phase shift,
            %   keying (PSK TCM) demodulator System object, H. This object demodulates
            %   convolutionally encoded data that has been mapped to an M-PSK
            %   constellation.
            %
            %   H = comm.PSKTCMDemodulator(Name,Value) creates a PSK TCM demodulator
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PSKTCMDemodulator(TRELLIS,Name,Value) creates a PSK TCM
            %   demodulator System object, H, with the TrellisStructure property set to
            %   TRELLIS and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates the PSK modulated input data, X, and uses the
            %   Viterbi algorithm to decode the resulting demodulated, convolutionally
            %   encoded bits. X must be a complex, double or single precision column
            %   vector. The step method outputs a demodulated, binary data column
            %   vector, Y. When the convolutional encoder represents a rate K/N code,
            %   the length of the output vector is K*L, where L is the length of the
            %   input vector, X.
            %
            %   Y = step(H,X,R) resets the decoder to the all-zeros state when you input
            %   a reset signal, R that is non-zero. R must be a double precision or
            %   logical, scalar integer. This syntax applies when you set the
            %   ResetInputPort property to true.
            %
            %   PSKTCMDemodulator methods:
            %
            %   step     - Demodulate using PSK TCM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create PSK TCM demodulator object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the PSK TCM demodulator object
            %
            %   PSKTCMDemodulator properties:
            %
            %   TrellisStructure  - Trellis structure of convolutional code
            %   TerminationMethod - Termination method of encoded frame
            %   TracebackDepth    - Traceback depth for Viterbi decoder
            %   ResetInputPort    - Enable demodulator reset input
            %   ModulationOrder   - Number of points in signal constellation
            %   OutputDataType    - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate data using 8-PSK TCM modulation
            %
            %   % Define a trellis structure with 4-ary input symbols and 8-ary output 
            %   % symbols
            %   t =  poly2trellis([5 4],[23 35 0; 0 5 13]);
            %   hMod = comm.PSKTCMModulator(t,'ModulationOrder', 8);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)','SNR',6);
            %   hDemod = comm.PSKTCMDemodulator(t, 'ModulationOrder', 8, ...
            %                   'TracebackDepth',16);
            %   % Create an error rate calculator with delay in bits equal to
            %   % TracebackDepth times the number of bits per symbol
            %   hError = comm.ErrorRate('ReceiveDelay',...
            %                   hDemod.TracebackDepth*log2(t.numInputSymbols));
            %   for counter = 1:10
            %     % Transmit frames of 250 2-bit symbols
            %     data = randi([0 1],500,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.PSKTCMModulator, comm.GeneralQAMTCMDemodulator,
            %            comm.RectangularQAMTCMDemodulator, comm.ViterbiDecoder.
        end

        function getInitializationParameters(in) %#ok<MANU>
            % Initialization parameters
        end

    end
    methods (Abstract)
    end
    properties
        %ModulationOrder Number of points in signal constellation
        %   Specify the number of points in the signal constellation used to map
        %   the convolutionally encoded data as a positive, integer scalar. The
        %   number of point must be 4, 8, or 16. The ModulationOrder property
        %   value must equal the number of possible input symbols to the
        %   convolutional decoder of the PSK TCM demodulator object. The
        %   ModulationOrder must equal 2^N for a rate K/N convolutional code. The
        %   default is 8.
        ModulationOrder;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if the structure is a valid trellis structure. The default is
        %   the result of poly2trellis([1 3], [1 0 0; 0 5 2]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
