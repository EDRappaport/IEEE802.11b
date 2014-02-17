classdef RectangularQAMTCMDemodulator< handle
%RectangularQAMTCMDemodulator Demodulate convolutionally encoded data mapped
%to rectangular QAM constellation
%   H = comm.RectangularQAMTCMDemodulator creates a trellis-coded,
%   rectangular, quadrature amplitude (QAM TCM) demodulator System object,
%   H. This object demodulates convolutionally encoded data that has been
%   mapped to a rectangular QAM constellation.
%
%   H = comm.RectangularQAMTCMDemodulator(Name,Value) creates a rectangular,
%   QAM TCM, demodulator object, H, with the specified property Name set to
%   the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.RectangularQAMTCMDemodulator(TRELLIS,Name,Value) creates a
%   rectangular QAM TCM demodulator object, H, with the TrellisStructure
%   property set to TRELLIS and other specified property Names set to the
%   specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) demodulates the rectangular QAM modulated input data, X,
%   and uses the Viterbi algorithm to decode the resulting demodulated,
%   convolutionally encoded bits. X must be a complex, double or single
%   precision column vector. The step method outputs a demodulated, binary
%   data column vector, Y. When the convolutional encoder represents a rate
%   K/N code, the length of the output vector is K*L, where L is the
%   length of the input vector, X.
%  
%   Y = step(H,X,R) resets the decoder to the all-zeros state when you input
%   a reset signal, R that is non-zero. R must be a double precision or
%   logical, scalar integer. This syntax applies when you set the
%   ResetInputPort property to true.
%
%   RectangularQAMTCMDemodulator methods:
%
%   step     - Demodulate using rectangular QAM TCM method (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create rectangular QAM TCM demodulator object with same 
%              property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of the rectangular QAM TCM demodulator object
%
%   RectangularQAMTCMDemodulator properties:
%
%   TrellisStructure  - Trellis structure of convolutional code
%   TerminationMethod - Termination method of encoded frame
%   TracebackDepth    - Traceback depth for Viterbi decoder
%   ResetInputPort    - Enable demodulator reset input
%   ModulationOrder   - Number of points in signal constellation
%   OutputDataType    - Data type of output
%
%   % Example:
%   %   Modulate and demodulate data using rectangular 16-QAM TCM modulation
%
%   hMod = comm.RectangularQAMTCMModulator;
%   hAWGN = comm.AWGNChannel('NoiseMethod', ...
%                   'Signal to noise ratio (SNR)',...
%                   'SNR',5, 'SignalPower', 10);
%   hDemod = comm.RectangularQAMTCMDemodulator('TracebackDepth',16);
%   % Create an error rate calculator with delay in bits equal to
%   % TracebackDepth times the number of bits per symbol
%   delay = hDemod.TracebackDepth* ...
%               log2(hDemod.TrellisStructure.numInputSymbols);
%   hErrorCalc = comm.ErrorRate('ReceiveDelay', delay);
%   for counter = 1:10
%     % Transmit frames of 200 3-bit symbols
%     data = randi([0 1],600,1);
%     modSignal = step(hMod, data);
%     noisySignal = step(hAWGN, modSignal);
%     receivedData = step(hDemod, noisySignal);
%     errorStats = step(hErrorCalc, data, receivedData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
% 
%   See also comm.RectangularQAMTCMModulator, comm.GeneralQAMTCMDemodulator,
%            comm.ViterbiDecoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=RectangularQAMTCMDemodulator
            %RectangularQAMTCMDemodulator Demodulate convolutionally encoded data mapped
            %to rectangular QAM constellation
            %   H = comm.RectangularQAMTCMDemodulator creates a trellis-coded,
            %   rectangular, quadrature amplitude (QAM TCM) demodulator System object,
            %   H. This object demodulates convolutionally encoded data that has been
            %   mapped to a rectangular QAM constellation.
            %
            %   H = comm.RectangularQAMTCMDemodulator(Name,Value) creates a rectangular,
            %   QAM TCM, demodulator object, H, with the specified property Name set to
            %   the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.RectangularQAMTCMDemodulator(TRELLIS,Name,Value) creates a
            %   rectangular QAM TCM demodulator object, H, with the TrellisStructure
            %   property set to TRELLIS and other specified property Names set to the
            %   specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) demodulates the rectangular QAM modulated input data, X,
            %   and uses the Viterbi algorithm to decode the resulting demodulated,
            %   convolutionally encoded bits. X must be a complex, double or single
            %   precision column vector. The step method outputs a demodulated, binary
            %   data column vector, Y. When the convolutional encoder represents a rate
            %   K/N code, the length of the output vector is K*L, where L is the
            %   length of the input vector, X.
            %  
            %   Y = step(H,X,R) resets the decoder to the all-zeros state when you input
            %   a reset signal, R that is non-zero. R must be a double precision or
            %   logical, scalar integer. This syntax applies when you set the
            %   ResetInputPort property to true.
            %
            %   RectangularQAMTCMDemodulator methods:
            %
            %   step     - Demodulate using rectangular QAM TCM method (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create rectangular QAM TCM demodulator object with same 
            %              property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of the rectangular QAM TCM demodulator object
            %
            %   RectangularQAMTCMDemodulator properties:
            %
            %   TrellisStructure  - Trellis structure of convolutional code
            %   TerminationMethod - Termination method of encoded frame
            %   TracebackDepth    - Traceback depth for Viterbi decoder
            %   ResetInputPort    - Enable demodulator reset input
            %   ModulationOrder   - Number of points in signal constellation
            %   OutputDataType    - Data type of output
            %
            %   % Example:
            %   %   Modulate and demodulate data using rectangular 16-QAM TCM modulation
            %
            %   hMod = comm.RectangularQAMTCMModulator;
            %   hAWGN = comm.AWGNChannel('NoiseMethod', ...
            %                   'Signal to noise ratio (SNR)',...
            %                   'SNR',5, 'SignalPower', 10);
            %   hDemod = comm.RectangularQAMTCMDemodulator('TracebackDepth',16);
            %   % Create an error rate calculator with delay in bits equal to
            %   % TracebackDepth times the number of bits per symbol
            %   delay = hDemod.TracebackDepth* ...
            %               log2(hDemod.TrellisStructure.numInputSymbols);
            %   hErrorCalc = comm.ErrorRate('ReceiveDelay', delay);
            %   for counter = 1:10
            %     % Transmit frames of 200 3-bit symbols
            %     data = randi([0 1],600,1);
            %     modSignal = step(hMod, data);
            %     noisySignal = step(hAWGN, modSignal);
            %     receivedData = step(hDemod, noisySignal);
            %     errorStats = step(hErrorCalc, data, receivedData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            % 
            %   See also comm.RectangularQAMTCMModulator, comm.GeneralQAMTCMDemodulator,
            %            comm.ViterbiDecoder.
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
        %   number of point must be 4, 8, 16, 32, or 64. The ModulationOrder
        %   property value must equal the number of possible input symbols to the
        %   convolutional decoder of the rectangular QAM TCM demodulator object.
        %   The ModulationOrder must equal 2^N for a rate K/N convolutional code.
        %   The default is 16.
        ModulationOrder;

        %TrellisStructure Trellis structure of convolutional code
        %   Specify trellis as a MATLAB structure that contains the trellis
        %   description of the convolutional code. Use the istrellis function to
        %   check if a structure is a valid trellis structure. The default is the
        %   result of poly2trellis([3 1 1], [ 5 2 0 0; 0 0 1 0; 0 0 0 1]).
        %
        %   See also istrellis, poly2trellis.
        TrellisStructure;

    end
end
