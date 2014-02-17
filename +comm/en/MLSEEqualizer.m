classdef MLSEEqualizer< handle
%MLSEEqualizer Equalize using maximum likelihood sequence estimation
%   H = comm.MLSEEqualizer creates a maximum likelihood sequence estimation
%   equalizer (MLSEE) System object, H. This object uses the Viterbi
%   algorithm and a channel estimate to equalize a linearly modulated signal
%   that has been transmitted through a dispersive channel.
%
%   H = comm.MLSEEqualizer(Name,Value) creates an MLSEE object, H, with the
%   specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.MLSEEqualizer(CHANNEL,Name,Value) creates an MLSEE object, H,
%   with the Channel property set to CHANNEL, and other specified property
%   Names set to the specified Values.
%
%   Step method syntax:
%
%   Y = step(H,X) equalizes the linearly modulated data input, X, using the
%   Viterbi algorithm. The step method outputs Y, the maximum likelihood
%   sequence estimate of the signal. Input X must be a column vector of data
%   type double or single.
%
%   Y = step(H,X,CHANNEL) uses CHANNEL as the channel coefficients when you
%   set the ChannelSource property to 'Input port'. The channel coefficients
%   input, CHANNEL, must be a numeric, column vector containing the
%   coefficients of an FIR filter in descending order of powers of z. The
%   length of this vector is the channel memory, which must be a multiple of
%   the samples per input symbol specified in the SamplesPerSymbol property.
%
%   Y = step(H,X,RESET) uses RESET as the reset signal when you set the
%   TerminationMethod property to 'Continuous' and the ResetInputPort
%   property to true. The object resets when RESET has a non-zero value.
%   RESET must be a double precision or logical scalar.
%
%   You can combine optional input arguments when you set their enabling
%   properties. Optional inputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   Y = step(H,X,CHANNEL,RESET) 
%
%   MLSEEqualizer methods:
%
%   step     - Equalize input using MLSEE (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create MLSEE object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of MLSEE object
%
%   MLSEEqualizer properties:
%
%   ChannelSource     - Source of channel coefficients
%   Channel           - Channel coefficients
%   Constellation     - Input signal constellation
%   TracebackDepth    - Traceback depth of Viterbi algorithm
%   TerminationMethod - Termination method of Viterbi algorithm
%   ResetInputPort    - Enable equalizer reset input
%   PreambleSource    - Source of preamble
%   Preamble          - Preamble that precedes input signals
%   PostambleSource   - Source of postamble
%   Postamble         - Postamble that follows input signals
%   SamplesPerSymbol  - Number of samples per symbol
%
%   % Example: 
%   %   Equalize a QPSK signal transmitted through a dispersive channel 
%   %   using MLSE
%
%   hMod = comm.QPSKModulator(0,'SymbolMapping','Binary');
%   hDemod = comm.QPSKDemodulator(0,'SymbolMapping','Binary');
%   % Channel coefficients
%   chCoeffs = [.986; .845; .237; .12345+.31i]; 
%   hMLSEE = comm.MLSEEqualizer('TracebackDepth',10,...
%                     'Channel',chCoeffs, 'Constellation',[1 1i -1 -1i]);
%   % Create an error rate calculator
%   hError = comm.ErrorRate;
%   for n = 1:50
%     data= randi([0 3],100,1);
%     modSignal = step(hMod, data);
%     % Introduce channel distortion.
%     chanOutput = filter(chCoeffs,1,modSignal); 
%     % Equalize the channel output and demodulate
%     eqSignal = step(hMLSEE,chanOutput);
%     demodData = step(hDemod,eqSignal);
%     % Compute BER
%     errorStats = step(hError, data, demodData);
%   end
%   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
%     errorStats(1), errorStats(2))
%
%   See also comm.ViterbiDecoder.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MLSEEqualizer
            %MLSEEqualizer Equalize using maximum likelihood sequence estimation
            %   H = comm.MLSEEqualizer creates a maximum likelihood sequence estimation
            %   equalizer (MLSEE) System object, H. This object uses the Viterbi
            %   algorithm and a channel estimate to equalize a linearly modulated signal
            %   that has been transmitted through a dispersive channel.
            %
            %   H = comm.MLSEEqualizer(Name,Value) creates an MLSEE object, H, with the
            %   specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.MLSEEqualizer(CHANNEL,Name,Value) creates an MLSEE object, H,
            %   with the Channel property set to CHANNEL, and other specified property
            %   Names set to the specified Values.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) equalizes the linearly modulated data input, X, using the
            %   Viterbi algorithm. The step method outputs Y, the maximum likelihood
            %   sequence estimate of the signal. Input X must be a column vector of data
            %   type double or single.
            %
            %   Y = step(H,X,CHANNEL) uses CHANNEL as the channel coefficients when you
            %   set the ChannelSource property to 'Input port'. The channel coefficients
            %   input, CHANNEL, must be a numeric, column vector containing the
            %   coefficients of an FIR filter in descending order of powers of z. The
            %   length of this vector is the channel memory, which must be a multiple of
            %   the samples per input symbol specified in the SamplesPerSymbol property.
            %
            %   Y = step(H,X,RESET) uses RESET as the reset signal when you set the
            %   TerminationMethod property to 'Continuous' and the ResetInputPort
            %   property to true. The object resets when RESET has a non-zero value.
            %   RESET must be a double precision or logical scalar.
            %
            %   You can combine optional input arguments when you set their enabling
            %   properties. Optional inputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   Y = step(H,X,CHANNEL,RESET) 
            %
            %   MLSEEqualizer methods:
            %
            %   step     - Equalize input using MLSEE (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create MLSEE object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of MLSEE object
            %
            %   MLSEEqualizer properties:
            %
            %   ChannelSource     - Source of channel coefficients
            %   Channel           - Channel coefficients
            %   Constellation     - Input signal constellation
            %   TracebackDepth    - Traceback depth of Viterbi algorithm
            %   TerminationMethod - Termination method of Viterbi algorithm
            %   ResetInputPort    - Enable equalizer reset input
            %   PreambleSource    - Source of preamble
            %   Preamble          - Preamble that precedes input signals
            %   PostambleSource   - Source of postamble
            %   Postamble         - Postamble that follows input signals
            %   SamplesPerSymbol  - Number of samples per symbol
            %
            %   % Example: 
            %   %   Equalize a QPSK signal transmitted through a dispersive channel 
            %   %   using MLSE
            %
            %   hMod = comm.QPSKModulator(0,'SymbolMapping','Binary');
            %   hDemod = comm.QPSKDemodulator(0,'SymbolMapping','Binary');
            %   % Channel coefficients
            %   chCoeffs = [.986; .845; .237; .12345+.31i]; 
            %   hMLSEE = comm.MLSEEqualizer('TracebackDepth',10,...
            %                     'Channel',chCoeffs, 'Constellation',[1 1i -1 -1i]);
            %   % Create an error rate calculator
            %   hError = comm.ErrorRate;
            %   for n = 1:50
            %     data= randi([0 3],100,1);
            %     modSignal = step(hMod, data);
            %     % Introduce channel distortion.
            %     chanOutput = filter(chCoeffs,1,modSignal); 
            %     % Equalize the channel output and demodulate
            %     eqSignal = step(hMLSEE,chanOutput);
            %     demodData = step(hDemod,eqSignal);
            %     % Compute BER
            %     errorStats = step(hError, data, demodData);
            %   end
            %   fprintf('Error rate = %f\nNumber of errors = %d\n', ...
            %     errorStats(1), errorStats(2))
            %
            %   See also comm.ViterbiDecoder.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Channel Channel coefficients
        %   Specify the channel as a numeric, column vector containing the
        %   coefficients of an FIR filter in descending order of powers of z. The
        %   length of this vector is the channel memory, which must be a multiple
        %   of the samples per symbol that you specify in the SamplesPerSymbol
        %   property. This property applies when you set the ChannelSource
        %   property to 'Property'. The default is [1;0.7;0.5;0.3].
        Channel;

        %ChannelSource Source of channel coefficients
        %   Specify the source of the channel coefficients as one of 'Input
        %   port' | 'Property'. The default is 'Property'.
        ChannelSource;

        %Constellation Input signal constellation
        %   Specify the constellation of the input modulated signal. Constellation
        %   is a complex vector. The kth element of the vector is the
        %   constellation point to which the modulator maps the integer k-1. The
        %   default is [1+1i -1+1i -1-1i 1-1i].
        Constellation;

        %Postamble Postamble that follows input signals
        %   Specify a postamble that is expected to follow the data in the input
        %   signal as an integer row vector. The values of the postamble should be
        %   between 0 and M-1, where M is the length of the Constellation
        %   property. An integer value of k-1 in the vector corresponds to the kth
        %   entry in the vector specified in the Constellation property. This
        %   property applies when you set the TerminationMethod property to
        %   'Truncated' and the PostambleSource property to 'Property'. The
        %   default is [0 2 3 1].
        Postamble;

        %PostambleSource Source of postamble
        %   Specify the source of the postamble that is expected to follow the
        %   input signal as one of 'None' | 'Property'. The default is 'None'. Set
        %   this property to 'Property' to specify a postamble in the Postamble
        %   property. This property applies when you set the TerminationMethod
        %   property to 'Truncated'.
        PostambleSource;

        %Preamble Preamble that precedes input signals
        %   Specify a preamble that is expected to precede the data in the input
        %   signal as an integer, row vector. The values of the preamble should be
        %   between 0 and M-1, where M is the length of the signal constellation
        %   that you specify in the Constellation property. An integer value of
        %   k-1 in the vector corresponds to the kth entry in the vector stored in
        %   the Constellation property. This property applies when you set the
        %   TerminationMethod property to 'Truncated' and the PreambleSource
        %   property to 'Property'. The default is [0 3 2 1].
        Preamble;

        %PreambleSource Source of preamble
        %   Specify the source of the preamble that is expected to precede the
        %   input signal as one of 'None' | 'Property'. The default is 'None'. Set
        %   this property to 'Property' to specify a preamble via the Preamble
        %   property. This property applies when you set the TerminationMethod
        %   property to 'Truncated'.
        PreambleSource;

        %ResetInputPort Enable equalizer reset input
        %   Set this property to true to enable an additional input to the step
        %   method. When this input is a non-zero, double precision or logical
        %   scalar, the object resets the states of the equalizer. This property
        %   applies when you set the TerminationMethod property to 'Continuous'.
        %   The default is false.
        ResetInputPort;

        %SamplesPerSymbol Number of samples per symbol
        %   Specify the number of samples per symbol in the input signal as an
        %   integer scalar. The default is 1.
        SamplesPerSymbol;

        %TerminationMethod Termination method of Viterbi algorithm
        %   Specify TerminationMethod of the Viterbi algorithm as one of
        %   'Continuous' | 'Truncated'. The default is 'Truncated'.
        %
        %   When you set this property to 'Continuous', the object initializes the
        %   Viterbi algorithm metrics of all the states to 0 in the first call to
        %   the step method. Then, it saves its internal state metric at the end
        %   of each frame, for use with the next frame.
        %
        %   When you set this property to 'Truncated' the object resets at every
        %   frame. The Viterbi algorithm processes each frame of data
        %   independently, resetting the state metric at the end of each frame.
        %   The traceback path always starts at the state with the minimum metric.
        %   The initialization of the state metrics depends on whether you specify
        %   a preamble or postamble. If you set the PreambleSource property to
        %   'None', the object initializes the metrics of all the states to 0 at
        %   the beginning of each data frame. If you set the PreambleSource
        %   property to 'Property', the object uses the preamble, that you specify
        %   in the Preamble property, to initialize the state metrics at the
        %   beginning of each data frame. When you specify a preamble, the
        %   traceback path ends at one of the states represented by that preamble.
        %   If you set the PostambleSource property to 'None', the traceback path
        %   starts at the state with the smallest metric. If you set the
        %   PostambleSource property to 'Property', the traceback path begins at
        %   the state represented by the postamble that you specify in the
        %   Postamble property. If the postamble does not decode to a unique
        %   state, the decoder identifies the smallest of all possible decoded
        %   states that are represented by the postamble and begins traceback
        %   decoding at that state.
        %
        %   When you set the TerminationMethod property to 'Truncated', the step
        %   method input data signal must contain at least TracebackDepth symbols,
        %   not including an optional preamble.
        TerminationMethod;

        %TracebackDepth Traceback depth of Viterbi algorithm
        %   Specify the number of trellis branches (equivalently, the number of
        %   symbols) the Viterbi algorithm uses to construct each traceback path.
        %   The traceback depth influences the decoding accuracy and delay. The
        %   decoding delay is the number of zero symbols that precede the first
        %   decoded symbol in the output. When you set the TerminationMethod
        %   property to 'Continuous', the decoding delay consists of
        %   TracebackDepth zero symbols. When you set the TerminationMethod
        %   property to 'Truncated', there is no output delay. The default is 21.
        TracebackDepth;

    end
end
