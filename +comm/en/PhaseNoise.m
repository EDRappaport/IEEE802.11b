classdef PhaseNoise< handle
%PhaseNoise Apply phase noise to a complex, baseband signal
%   H = comm.PhaseNoise creates a phase noise System object, H. This object
%   applies phase noise with the specified level at the specified frequency
%   offset to a complex, baseband input signal.
%
%   H = comm.PhaseNoise(Name,Value) creates a phase noise object, H, with
%   the specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   H = comm.PhaseNoise(LEVEL,OFFSET,SAMPLERATE,Name,Value) creates a phase
%   noise object, H, with the Level property set to LEVEL, the
%   FrequencyOffset property set to OFFSET, the SampleRate property set to
%   SAMPLERATE, and other specified property Names set to the specified
%   Values. LEVEL, OFFSET, and SAMPLERATE are value-only arguments. To
%   specify a value-only argument, you must also specify all preceding
%   value-only arguments. You can specify name-value pair arguments in any
%   order.
%
%   The phase noise object uses the default MATLAB random stream. Reset the
%   default stream for repeatable simulations. Type 'help rng' for more
%   information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds phase noise with the specified level, at the
%   specified frequency offset, to the input X and returns the result in Y.
%   X must be a complex scalar or column vector of data type double. The
%   step method outputs, Y, with the same data type and dimensions as the
%   input.
%
%   PhaseNoise methods:
%
%   step      - Apply phase noise to input signal (see above)
%   release   - Allow property value and input characteristics changes
%   clone     - Create phase noise object with same property values
%   isLocked  - Locked status (logical)
%   visualize - Plot response of phase noise filter
%
%   PhaseNoise properties:
%
%   Level           - Phase noise level
%   FrequencyOffset - Frequency offset
%   SampleRate      - Sample rate
%   
%   % Example:
%   %   Add spectrally shaped phase noise to a 16-QAM signal.
%
%   % Create 16-QAM modulator
%   hMod = comm.RectangularQAMModulator(16, ...
%              'NormalizationMethod','Average power', 'AveragePower',10);
%   % Create phase noise System object
%   hPhNoise = comm.PhaseNoise('Level',[-60 -80], ...
%                              'FrequencyOffset',[20 200], ...
%                              'SampleRate',1024);
%   % Generate modulated symbols
%   modData = step(hMod, randi([0 15], 1000, 1));
%   % Apply phase noise and plot the result
%   y = step(hPhNoise, modData);
%   scatterplot(y)
% 
%   See also comm.PhaseFrequencyOffset, comm.MemorylessNonlinearity.

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=PhaseNoise
            %PhaseNoise Apply phase noise to a complex, baseband signal
            %   H = comm.PhaseNoise creates a phase noise System object, H. This object
            %   applies phase noise with the specified level at the specified frequency
            %   offset to a complex, baseband input signal.
            %
            %   H = comm.PhaseNoise(Name,Value) creates a phase noise object, H, with
            %   the specified property Name set to the specified Value. You can specify
            %   additional name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   H = comm.PhaseNoise(LEVEL,OFFSET,SAMPLERATE,Name,Value) creates a phase
            %   noise object, H, with the Level property set to LEVEL, the
            %   FrequencyOffset property set to OFFSET, the SampleRate property set to
            %   SAMPLERATE, and other specified property Names set to the specified
            %   Values. LEVEL, OFFSET, and SAMPLERATE are value-only arguments. To
            %   specify a value-only argument, you must also specify all preceding
            %   value-only arguments. You can specify name-value pair arguments in any
            %   order.
            %
            %   The phase noise object uses the default MATLAB random stream. Reset the
            %   default stream for repeatable simulations. Type 'help rng' for more
            %   information.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) adds phase noise with the specified level, at the
            %   specified frequency offset, to the input X and returns the result in Y.
            %   X must be a complex scalar or column vector of data type double. The
            %   step method outputs, Y, with the same data type and dimensions as the
            %   input.
            %
            %   PhaseNoise methods:
            %
            %   step      - Apply phase noise to input signal (see above)
            %   release   - Allow property value and input characteristics changes
            %   clone     - Create phase noise object with same property values
            %   isLocked  - Locked status (logical)
            %   visualize - Plot response of phase noise filter
            %
            %   PhaseNoise properties:
            %
            %   Level           - Phase noise level
            %   FrequencyOffset - Frequency offset
            %   SampleRate      - Sample rate
            %   
            %   % Example:
            %   %   Add spectrally shaped phase noise to a 16-QAM signal.
            %
            %   % Create 16-QAM modulator
            %   hMod = comm.RectangularQAMModulator(16, ...
            %              'NormalizationMethod','Average power', 'AveragePower',10);
            %   % Create phase noise System object
            %   hPhNoise = comm.PhaseNoise('Level',[-60 -80], ...
            %                              'FrequencyOffset',[20 200], ...
            %                              'SampleRate',1024);
            %   % Generate modulated symbols
            %   modData = step(hMod, randi([0 15], 1000, 1));
            %   % Apply phase noise and plot the result
            %   y = step(hPhNoise, modData);
            %   scatterplot(y)
            % 
            %   See also comm.PhaseFrequencyOffset, comm.MemorylessNonlinearity.
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
            % create filter System object
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
            % input must be complex
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

        function visualize(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %FrequencyOffset Frequency offset
        %   Specify the frequency offset in Hertz as a positive, real scalar or
        %   increasing vector of data type double. The default is [20 200].
        FrequencyOffset;

        %Level Phase noise level
        %   Specify the phase noise level in decibels relative to carrier per
        %   Hertz (dBc/Hz) as a negative, real scalar or vector of data type
        %   double. The default is [-60 -80].
        Level;

        %SampleRate Sample rate
        %   Specify the sample rate in samples per second as a positive, real
        %   scalar of data type double.  This property is not used when Level and
        %   FrequencyOffset are specified as scalars.  The default is 1024.
        SampleRate;

    end
end
