classdef CoarseFrequencyEstimatorBase< handle
%CoarseFrequencyEstimatorBase Base class for
%PSKCoarseFrequencyEstimator and QAMCoarseFrequencyEstimator
%
%   See also dsp.FFT, comm.PhaseFrequencyOffset.

 
%   Copyright 2013 The MathWorks, Inc.

    methods
        function out=CoarseFrequencyEstimatorBase
            %CoarseFrequencyEstimatorBase Base class for
            %PSKCoarseFrequencyEstimator and QAMCoarseFrequencyEstimator
            %
            %   See also dsp.FFT, comm.PhaseFrequencyOffset.
        end

        function FFTEstimateOffset(in) %#ok<MANU>
            % Raise the input signal to the appropriate exponent
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
            % Calculate FFT length.  Use a power of 2.
        end

        function validateInputsImpl(in) %#ok<MANU>
            % Input must be complex
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %FrequencyResolution Desired frequency resolution (Hz)
        %   Specify the desired frequency resolution for offset frequency
        %   estimation as a positive, real scalar of data type double.  This
        %   property establishes the FFT length used to perform spectral
        %   analysis, and must be less than or equal to half the SampleRate
        %   property.  The default is 0.001.
        FrequencyResolution;

        %SampleRate Sample rate (Hz)
        %   Specify the sample rate in samples per second as a positive, real
        %   scalar of data type double.  The default is 1.
        SampleRate;

        %pFFT -  FFT calculation object
        pFFT;

        %pFFTLength -  FFT length
        pFFTLength;

    end
end
