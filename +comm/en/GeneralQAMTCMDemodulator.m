classdef GeneralQAMTCMDemodulator< handle
%GeneralQAMTCMDemodulator Demodulate convolutionally encoded data mapped to
%arbitrary QAM constellation
%   H = comm.GeneralQAMTCMDemodulator creates a trellis-coded, general
%   quadrature amplitude (QAM TCM) demodulator System object, H. This object
%   demodulates convolutionally encoded data that has been mapped to an
%   arbitrary QAM constellation.
%
%   H = comm.GeneralQAMTCMDemodulator(Name,Value) creates a general QAM TCM
%   demodulator object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.GeneralQAMTCMDemodulator(TRELLIS,Name,Value) creates a general
%   QAM TCM demodulator object, H, with the TrellisStructure property set to
%   TRELLIS and other specified property Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates the general QAM modulated input data, X, and
%   uses the Viterbi algorithm to decode the resulting demodulated
%   convolutionally encoded bits. X must be a complex double or single
%   precision column vector. The step method outputs a demodulated binary
%   column data vector, Y. When the convolutional encoder represents a rate
%   K/N code, the length of the output vector equals K*L, where L is the
%   length of the input vector, X.
%  
%   Y = step(H,X,R) resets the decoder states of the general QAM TCM
%   demodulator System object to the all-zeros state when you input a
%   non-zero reset signal, R. R must be a double precision or logical scalar
%   integer. This syntax applies when you set the ResetInputPort property to
%   true.
%
%   GeneralQAMTCMDemodulator methods:
%
%   step     - Demodulate using general QAM TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create general QAM TCM demodulator object with same property 
%              values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the general QAM TCM demodulator object
%
%   GeneralQAMTCMDemodulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   TracebackDepth    - Traceback depth for Viterbi decoder
%   ResetInputPort    - Enable demodulator reset input
%   Constellation     - Signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate and demodulate data using QAM TCM modulation with an
%   %   arbitrary four-point constellation
%
%   % Define a trellis structure with binary inputs and 4-ary symbol 
%   % outputs and define an arbitrary four-point constellation
%   t = poly2trellis(7,[171 133]);
%   const = exp(pi*1i*[1 2 3 6]/4);
%   hMod = comm.GeneralQAMTCMModulator(t, 'Constellation', const);
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)', ...
%                   'SNR',5, 'SignalPower',0.875);
%   hDemod = comm.GeneralQAMTCMDemodulator(t, 'Constellation', const);
%   % Create an error rate calculator with delay in bits equal to
%   % TracebackDepth times the number of bits per symbol
%   hError = comm.ErrorRate(...
%          'ReceiveDelay', hDemod.TracebackDepth*log2(t.numInputSymbols));
%   for counter = 1:10
%     data = randi([0 1],500,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hError, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
% 
%   See also comm.GeneralQAMTCMModulator, comm.RectangularQAMTCMDemodulator,
%            comm.ViterbiDecoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=GeneralQAMTCMDemodulator
            %GeneralQAMTCMDemodulator Demodulate convolutionally encoded data mapped to
            %arbitrary QAM constellation
            %   H = comm.GeneralQAMTCMDemodulator creates a trellis-coded, general
            %   quadrature amplitude (QAM TCM) demodulator System object, H. This object
            %   demodulates convolutionally encoded data that has been mapped to an
            %   arbitrary QAM constellation.
            %
            %   H = comm.GeneralQAMTCMDemodulator(Name,Value) creates a general QAM TCM
            %   demodulator object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.GeneralQAMTCMDemodulator(TRELLIS,Name,Value) creates a general
            %   QAM TCM demodulator object, H, with the TrellisStructure property set to
            %   TRELLIS and other specified property Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates the general QAM modulated input data, X, and
            %   uses the Viterbi algorithm to decode the resulting demodulated
            %   convolutionally encoded bits. X must be a complex double or single
            %   precision column vector. The step method outputs a demodulated binary
            %   column data vector, Y. When the convolutional encoder represents a rate
            %   K/N code, the length of the output vector equals K*L, where L is the
            %   length of the input vector, X.
            %  
            %   Y = step(H,X,R) resets the decoder states of the general QAM TCM
            %   demodulator System object to the all-zeros state when you input a
            %   non-zero reset signal, R. R must be a double precision or logical scalar
            %   integer. This syntax applies when you set the ResetInputPort property to
            %   true.
            %
            %   GeneralQAMTCMDemodulator methods:
            %
            %   step     - Demodulate using general QAM TCM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create general QAM TCM demodulator object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the general QAM TCM demodulator object
            %
            %   GeneralQAMTCMDemodulator properties:
            %
            %   TrellisStructure  - Trellis structure of convolutional code
            %   TerminationMethod - Termination method of encoded frame
            %   TracebackDepth    - Traceback depth for Viterbi decoder
            %   ResetInputPort    - Enable demodulator reset input
            %   Constellation     - Signal constellation
            %   OutputDataType    - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate data using QAM TCM modulation with an
            %   %   arbitrary four-point constellation
            %
            %   % Define a trellis structure with binary inputs and 4-ary symbol 
            %   % outputs and define an arbitrary four-point constellation
            %   t = poly2trellis(7,[171 133]);
            %   const = exp(pi*1i*[1 2 3 6]/4);
            %   hMod = comm.GeneralQAMTCMModulator(t, 'Constellation', const);
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)', ...
            %                   'SNR',5, 'SignalPower',0.875);
            %   hDemod = comm.GeneralQAMTCMDemodulator(t, 'Constellation', const);
            %   % Create an error rate calculator with delay in bits equal to
            %   % TracebackDepth times the number of bits per symbol
            %   hError = comm.ErrorRate(...
            %          'ReceiveDelay', hDemod.TracebackDepth*log2(t.numInputSymbols));
            %   for counter = 1:10
            %     data = randi([0 1],500,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hError, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            % 
            %   See also comm.GeneralQAMTCMModulator, comm.RectangularQAMTCMDemodulator,
            %            comm.ViterbiDecoder.
        end

        function getInitializationParameters(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Constellation Signal constellation
        %   Specify a double or single precision complex vector that lists the
        %   points in the signal constellation that was used to map the
        %   convolutionally encoded data. The constellation must be specified in
        %   set-partitioned order. See documentation for the General TCM Encoder
        %   block for more information on set-partitioned order. The length of the
        %   constellation vector must equal the number of possible input symbols
        %   to the convolutional decoder of the general QAM TCM demodulator
        %   object. This corresponds to 2^N for a rate K/N convolutional code. The
        %   default corresponds to a set-partitioned order for the points of an
        %   8-PSK signal constellation, which is exp(2*pi*j*[0 4 2 6 1 5 3 7]/8).
        Constellation;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis([1 3], [1 0 0; 0 5 2]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
