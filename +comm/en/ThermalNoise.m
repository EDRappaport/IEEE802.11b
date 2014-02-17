classdef ThermalNoise< handle
%ThermalNoise Add receiver thermal noise
%   H = comm.ThermalNoise creates a receiver thermal noise System object, H.
%   This object adds thermal noise to the complex, baseband input signal.
%
%   H = comm.ThermalNoise(Name,Value) creates a receiver thermal noise
%   object, H, with the specified property Name set to the specified Value.
%   You can specify additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   The thermal noise object uses the default MATLAB random stream. Reset
%   the default stream for repeatable simulations. Type 'help RandStream'
%   for more information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds thermal noise to the complex, baseband input signal,
%   X, and outputs the result in Y. The input signal X must be a complex,
%   double or single precision data type column vector or scalar.
%
%   ThermalNoise methods:
%
%   step     - Add receiver thermal noise to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create thermal noise object with same property values
%   isLocked - Locked status (logical)
%
%   ThermalNoise properties:
%
%   NoiseMethod      - Method to specify noise level
%   NoiseTemperature - Noise temperature
%   NoiseFigure      - Noise figure
%   NoiseFactor      - Noise factor
%   SampleRate       - Sample rate
%
%   % Example: 
%   %   Add thermal noise with a noise temperature of 290 degrees Kelvin to
%   %   QPSK data 
%
%   hTNoise = comm.ThermalNoise('NoiseTemperature',290);
%   % Create a modulator and obtain complex baseband signal
%   hMod = comm.QPSKModulator;
%   data = randi([0 3],32,1);
%   modData = step(hMod,data);
%   % Add noise to signal
%   noisyData = step(hTNoise,modData);
%
%   See also comm.AWGNChannel.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=ThermalNoise
            %ThermalNoise Add receiver thermal noise
            %   H = comm.ThermalNoise creates a receiver thermal noise System object, H.
            %   This object adds thermal noise to the complex, baseband input signal.
            %
            %   H = comm.ThermalNoise(Name,Value) creates a receiver thermal noise
            %   object, H, with the specified property Name set to the specified Value.
            %   You can specify additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   The thermal noise object uses the default MATLAB random stream. Reset
            %   the default stream for repeatable simulations. Type 'help RandStream'
            %   for more information.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) adds thermal noise to the complex, baseband input signal,
            %   X, and outputs the result in Y. The input signal X must be a complex,
            %   double or single precision data type column vector or scalar.
            %
            %   ThermalNoise methods:
            %
            %   step     - Add receiver thermal noise to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create thermal noise object with same property values
            %   isLocked - Locked status (logical)
            %
            %   ThermalNoise properties:
            %
            %   NoiseMethod      - Method to specify noise level
            %   NoiseTemperature - Noise temperature
            %   NoiseFigure      - Noise figure
            %   NoiseFactor      - Noise factor
            %   SampleRate       - Sample rate
            %
            %   % Example: 
            %   %   Add thermal noise with a noise temperature of 290 degrees Kelvin to
            %   %   QPSK data 
            %
            %   hTNoise = comm.ThermalNoise('NoiseTemperature',290);
            %   % Create a modulator and obtain complex baseband signal
            %   hMod = comm.QPSKModulator;
            %   data = randi([0 3],32,1);
            %   modData = step(hMod,data);
            %   % Add noise to signal
            %   noisyData = step(hTNoise,modData);
            %
            %   See also comm.AWGNChannel.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function releaseImpl(in) %#ok<MANU>
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
        %NoiseFactor Noise factor
        %   Specify the noise factor as a factor relative to a noise temperature
        %   of 290 degrees Kelvin. You must set this property to a numeric, real
        %   scalar greater than or equal to 1. This property applies when you set
        %   the NoiseMethod property to 'Noise factor'. The default is 2, which
        %   corresponds to a noise temperature of 290*(NoiseFactor-1) = 290
        %   degrees Kelvin.
        NoiseFactor;

        %NoiseFigure Noise figure
        %   Specify the noise figure in decibels relative to a noise temperature
        %   of 290 degrees Kelvin. You must set this property to a numeric,
        %   nonnegative, real scalar. This property applies when you set the
        %   NoiseMethod property to 'Noise figure'. The default is 3.01 decibels,
        %   which corresponds to a noise temperature of
        %   290*(10^(NoiseFigure/10)-1). This approximates 290 degrees Kelvin.
        NoiseFigure;

        %NoiseMethod Method to specify noise level
        %   Select the method to specify the noise level as one of 'Noise
        %   temperature' | 'Noise figure' | 'Noise factor'. The default is 'Noise
        %   temperature'.
        NoiseMethod;

        %NoiseTemperature Noise temperature
        %   Specify the noise temperature in degrees Kelvin as a numeric,
        %   nonnegative, real scalar. This property applies when you set the
        %   NoiseMethod property to 'Noise temperature'. The default is 290
        %   degrees Kelvin.
        NoiseTemperature;

        %SampleRate Sample rate
        %   Specify the sample rate of the input samples in Hz as a numeric, real,
        %   positive scalar. The object computes the variance of the noise added
        %   to the input signal as (kT*SampleRate). The value k is Boltzmann's
        %   constant and T is the noise temperature specified explicitly or
        %   implicitly via one of the noise methods. The default is 1.
        SampleRate;

    end
end
