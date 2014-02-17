classdef DiscreteTimeVCO< handle
%DiscreteTimeVCO Generate variable frequency sinusoid
%   H = comm.DiscreteTimeVCO creates a discrete-time voltage-controlled
%   oscillator (VCO) System object, H. This object generates a sinusoidal
%   signal with its frequency shifted from the specified quiescent frequency
%   to a value proportional to the input signal.
%
%   H = comm.DiscreteTimeVCO(Name,Value) creates a discrete-time VCO object,
%   H, with the specified property Name set to the specified Value. You can
%   specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) generates a sinusoidal signal, Y, with frequency shifted,
%   from the value you specify in the QuiescentFrequency property, to a
%   value proportional to the input signal, X. The input, X, must be a
%   double or single precision, real, scalar value. The output, Y, has the
%   same data type and size as the input, X.
%
%   DiscreteTimeVCO methods:
%
%   step     - Generate sinusoid signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create discrete-time VCO object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of discrete-time VCO object
%
%   DiscreteTimeVCO properties:
%
%   OutputAmplitude    - Amplitude of output signal
%   QuiescentFrequency - Frequency of output signal when input is zero
%   Sensitivity        - Sensitivity of frequency shift of output signal
%   InitialPhase       - Initial phase of output signal
%   SampleRate         - Sample rate of input
%
%   % Example: 
%   %   Generate an FSK signal using a discrete time VCO
%
%   % Create a SignalSource System object and generate random data
%   hreader = dsp.SignalSource;
%   hreader.Signal = randi([0 7],10,1);
%   % Rectangular pulse shaping
%   hreader.Signal = rectpulse(hreader.Signal, 100);
%   % Create a signal logger System object
%   hlogger = dsp.SignalSink; 
%   % Create a discrete time VCO object and generate an FSK signal
%   hdvco = comm.DiscreteTimeVCO('OutputAmplitude',8, ...
%                                'QuiescentFrequency',1);
%   while(~isDone(hreader))
%     sig = step(hreader);
%     y = step(hdvco,sig);
%     step(hlogger,y);
%   end
%   oscsig = hlogger.Buffer;
%   % Plot FSK signal
%   t = [0:length(oscsig)-1]'/hdvco.SampleRate;
%   plot(t,hreader.Signal,'--r', 'LineWidth',3); hold on;
%   plot(t,oscsig,'-b'); hold off;
%   xlabel('time (s)');
%   legend('Input Signal', 'FSK Signal');
% 
%   See also comm.CPMCarrierPhaseSynchronizer,
%            comm.PSKCarrierPhaseSynchronizer.

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DiscreteTimeVCO
            %DiscreteTimeVCO Generate variable frequency sinusoid
            %   H = comm.DiscreteTimeVCO creates a discrete-time voltage-controlled
            %   oscillator (VCO) System object, H. This object generates a sinusoidal
            %   signal with its frequency shifted from the specified quiescent frequency
            %   to a value proportional to the input signal.
            %
            %   H = comm.DiscreteTimeVCO(Name,Value) creates a discrete-time VCO object,
            %   H, with the specified property Name set to the specified Value. You can
            %   specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) generates a sinusoidal signal, Y, with frequency shifted,
            %   from the value you specify in the QuiescentFrequency property, to a
            %   value proportional to the input signal, X. The input, X, must be a
            %   double or single precision, real, scalar value. The output, Y, has the
            %   same data type and size as the input, X.
            %
            %   DiscreteTimeVCO methods:
            %
            %   step     - Generate sinusoid signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create discrete-time VCO object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of discrete-time VCO object
            %
            %   DiscreteTimeVCO properties:
            %
            %   OutputAmplitude    - Amplitude of output signal
            %   QuiescentFrequency - Frequency of output signal when input is zero
            %   Sensitivity        - Sensitivity of frequency shift of output signal
            %   InitialPhase       - Initial phase of output signal
            %   SampleRate         - Sample rate of input
            %
            %   % Example: 
            %   %   Generate an FSK signal using a discrete time VCO
            %
            %   % Create a SignalSource System object and generate random data
            %   hreader = dsp.SignalSource;
            %   hreader.Signal = randi([0 7],10,1);
            %   % Rectangular pulse shaping
            %   hreader.Signal = rectpulse(hreader.Signal, 100);
            %   % Create a signal logger System object
            %   hlogger = dsp.SignalSink; 
            %   % Create a discrete time VCO object and generate an FSK signal
            %   hdvco = comm.DiscreteTimeVCO('OutputAmplitude',8, ...
            %                                'QuiescentFrequency',1);
            %   while(~isDone(hreader))
            %     sig = step(hreader);
            %     y = step(hdvco,sig);
            %     step(hlogger,y);
            %   end
            %   oscsig = hlogger.Buffer;
            %   % Plot FSK signal
            %   t = [0:length(oscsig)-1]'/hdvco.SampleRate;
            %   plot(t,hreader.Signal,'--r', 'LineWidth',3); hold on;
            %   plot(t,oscsig,'-b'); hold off;
            %   xlabel('time (s)');
            %   legend('Input Signal', 'FSK Signal');
            % 
            %   See also comm.CPMCarrierPhaseSynchronizer,
            %            comm.PSKCarrierPhaseSynchronizer.
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function outputImpl(in) %#ok<MANU>
            % cast output to the same data type as the input
        end

        function processTunedPropertiesImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Input cannot be fi-double or fi-single. This check can be moved to
            % validateInputsImpl when we have a mechanism to know, without looking at
            % actual input data, that this data is a fi object.
        end

        function updateImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
            % complex input is not supported
        end

    end
    methods (Abstract)
    end
    properties
        %InitialPhase Initial phase of output signal
        %   Specify the initial phase of the output signal, in radians, as a
        %   double or single precision, real, scalar value. The default is 0.
        InitialPhase;

        %OutputAmplitude Amplitude of output signal
        %   Specify the amplitude of the output signal as a double or single
        %   precision, scalar value. The default is 1. This property is tunable.
        OutputAmplitude;

        %QuiescentFrequency Frequency of output signal when input is zero
        %   Specify the quiescent frequency of the output signal in Hertz, as a
        %   double or single precision, real, scalar value. The default is 10.
        %   This property is tunable.
        QuiescentFrequency;

        %SampleRate Sample rate of input
        %   Specify the sample rate of the input, in Hz, as a double or
        %   single precision, positive, scalar value. The default is 100.
        SampleRate;

        %Sensitivity Sensitivity of frequency shift of output signal
        %   Specify the sensitivity of the output signal frequency shift to the
        %   input as a double or single precision, real, scalar value. This value
        %   scales the input voltage and, consequently, the shift from the
        %   quiescent frequency value. The units of Sensitivity are Hertz per
        %   volt. The default is 1. This property is tunable.
        Sensitivity;

    end
end
