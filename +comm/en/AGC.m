classdef AGC< handle
%AGC Automatic gain controller
%   H = comm.AGC creates an automatic gain controller (AGC) System object,
%   H, that adaptively adjusts its gain to achieve a constant signal level
%   at the output.
%
%   H = comm.AGC(Name,Value) creates an AGC object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H, X) applies an adaptive gain to the input X, to achieve a
%   unity signal level at the output, Y. X must be a double or single
%   precision column vector. AGC determines the output signal level based
%   on the DetectorMethod setting.
%
%   AGC methods:
%
%   step     - Generate Barker code samples (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create AGC object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of AGC object
%
%   AGC properties:
%
%   DetectorMethod - Detector method
%   LoopMethod     - Loop method
%   UpdatePeriod   - Period of gain updates in samples
%   StepSize       - Step size for gain updates
%   MaximumGain    - Maximum gain (dB)
%   GainOutputPort - Enable gain output
%
%   % Example:
%   %   Set the received symbol magnitude to approximately 1 for
%   %   a QPSK signal.
%
%   hMod = comm.PSKModulator(4, 'PhaseOffset', pi/4);
%   hChan = comm.AWGNChannel('EbNo', 20);
%   hAGC = comm.AGC;
%   d = randi([0 3], 10000, 1);
%   x = step(hMod, d);
%   c = 4*step(hChan, x);
%   y = step(hAGC, c);
%   % Plot after AGC reaches steady state
%   figure;plot(c(1000:end), '*')
%   hold on;plot(y(1000:end), 'or'); grid on; axis square
%   legend('Input of AGC', 'Output of AGC')

 
%   Copyright 2011-2013 The MathWorks, Inc.

    methods
        function out=AGC
            %AGC Automatic gain controller
            %   H = comm.AGC creates an automatic gain controller (AGC) System object,
            %   H, that adaptively adjusts its gain to achieve a constant signal level
            %   at the output.
            %
            %   H = comm.AGC(Name,Value) creates an AGC object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H, X) applies an adaptive gain to the input X, to achieve a
            %   unity signal level at the output, Y. X must be a double or single
            %   precision column vector. AGC determines the output signal level based
            %   on the DetectorMethod setting.
            %
            %   AGC methods:
            %
            %   step     - Generate Barker code samples (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create AGC object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of AGC object
            %
            %   AGC properties:
            %
            %   DetectorMethod - Detector method
            %   LoopMethod     - Loop method
            %   UpdatePeriod   - Period of gain updates in samples
            %   StepSize       - Step size for gain updates
            %   MaximumGain    - Maximum gain (dB)
            %   GainOutputPort - Enable gain output
            %
            %   % Example:
            %   %   Set the received symbol magnitude to approximately 1 for
            %   %   a QPSK signal.
            %
            %   hMod = comm.PSKModulator(4, 'PhaseOffset', pi/4);
            %   hChan = comm.AWGNChannel('EbNo', 20);
            %   hAGC = comm.AGC;
            %   d = randi([0 3], 10000, 1);
            %   x = step(hMod, d);
            %   c = 4*step(hChan, x);
            %   y = step(hAGC, c);
            %   % Plot after AGC reaches steady state
            %   figure;plot(c(1000:end), '*')
            %   hold on;plot(y(1000:end), 'or'); grid on; axis square
            %   legend('Input of AGC', 'Output of AGC')
        end

        function getDiscreteStateSpecificationImpl(in) %#ok<MANU>
            % Return state information for Gain
        end

        function getIconImpl(in) %#ok<MANU>
        end

        function getInputNamesImpl(in) %#ok<MANU>
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function getOutputNamesImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %DetectorMethod Detector method
        %   Specify the detector method as one of 'Rectifier' | 'Square Law'. The
        %   default is 'Rectifier'.
        %
        %   When you set the DetectorMethod to 'Rectifier', the AGC detector
        %   outputs a voltage value proportional to the envelope amplitude of the
        %   output signal. The detector first rectifies the input signal and then
        %   passes through a filter to average the rectified signal. The AGC
        %   adjusts the gain to obtain unity voltage at the output of the
        %   detector.
        %   
        %   When you set the DetectorMethod to 'Square law', the AGC detector
        %   outputs a power value that is proportional to the square of the
        %   output voltage. The detector first squares the input signal and then
        %   passes through a filter. The AGC adjusts the gain to obtain unity
        %   power at the output of the detector.
        DetectorMethod;

        %GainOutputPort Enable gain output
        %   When you set this property to true, the step method outputs
        %   instantaneous gain values. The default is false.
        GainOutputPort;

        %LoopMethod Loop method
        %   Specify the loop method of the AGC as one of 'Linear' |
        %   'Logarithmic'. The default is 'Linear'. 
        %
        %   When you set the LoopMethod to 'Linear', the AGC uses the direct
        %   value of the detector output to determine gain value. Such a loop
        %   tends to respond large increases in the input signal level fairly
        %   quickly. However, the response to large decreases in the input signal
        %   level tends to be slow.
        %
        %   When you set the LoopMethod to 'Logarithmic', the AGC uses the
        %   logarithm of the detector output to determine the gain value. Such a
        %   loop acts faster to changes in the input signal level, especially to
        %   large decreases in the input signal level.
        LoopMethod;

        %MaximumGain Maximum gain (dB)
        %   Specify the maximum gain of the AGC in dB as a positive scalar. The
        %   default is 30. If the signal at the input of the AGC has a very low
        %   signal level, the AGC gain may increase rapidly. You can use this
        %   property to limit the gain AGC can apply to the input signal.
        MaximumGain;

        %StepSize Step size
        %   Specify the step size for gain updates as a double or single
        %   precision, real, positive scalar. The default is 0.1. If you
        %   increase the loop gain, AGC responds to changes at the input signal
        %   level faster. However, gain pumping also increase.
        StepSize;

        %UpdatePeriod Period of gain updates in samples
        %   Specify the period of the gain updates as a double or single
        %   precision, real integer valued scalar. The number of input samples
        %   must be an integer multiple of update period. The default is 100.
        %   Setting the period greater than one increases the speed of the AGC
        %   algorithm.
        UpdatePeriod;

    end
end
