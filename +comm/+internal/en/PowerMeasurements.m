classdef PowerMeasurements< handle
%PowerMeasurement PowerMeasurement class

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PowerMeasurements
            %PowerMeasurement PowerMeasurement class
        end

        function computeAveragePower(in) %#ok<MANU>
            % This method computes the average power within a band defined by the
            % frequency range matrix pFreqRange. The average power is computed
            % using the pPSD estimate matrix.
        end

        function computePSD(in) %#ok<MANU>
        end

        function initpPSD(in) %#ok<MANU>
            %initpPSD Initialize the pPSD matrix.
            %   Matrix that holds PSD calculations. If MaxHold is on, pPSD contains
            %   the accumulated max hold PSDs. Otherwise, it contains instantaneous
            %   PSDs. obj.pNumPSDChans defines the number of columns in the matrix.
            %   The number of rows is equal to the current FFT length.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
            % getHiddenProps
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function processTunedPropertiesImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Calculate segment length for pSpectralEstimator object
        end

    end
    methods (Abstract)
    end
    properties
        %CustomFFTLength Custom FFT length
        %   Specify the number of FFT points that the spectral estimator uses as a
        %   numeric, positive, integer scalar. This property applies when you set
        %   the FFTLength property to 'Custom'. The default is 256.
        CustomFFTLength;

        % FFTLength FFT length
        %   Specify the FFT length that the Welch spectral estimator uses as one
        %   of 'Next power of 2' | 'Same as segment length' | 'Custom'. The
        %   default is 'Next power of 2'. If you set this property to 'Custom'
        %   then a CustomFFTLength property becomes available to specify the
        %   desired FFT length. If you set this property to 'Next power of 2' then
        %   the object sets the length of the FFT to the next power of 2 greater
        %   than the spectral estimator segment length or to 256, whichever is
        %   greater. If you set this property to 'Same as segment length', the
        %   object sets the length of the FFT to the spectral estimator segment
        %   length or to 256, whichever is greater.
        FFTLength;

        %FrequencyResolution Frequency resolution
        %   Specify the frequency resolution of the spectral estimator as a double
        %   precision scalar. When you set the NormalizedFrequency property to
        %   true, you must specify the frequency resolution as a normalized value
        %   between 0 and 1. When you set the NormalizedFrequency property to
        %   false, you must specify the frequency resolution in Hertz. The object
        %   uses the value in the FrequencyResolution property to calculate the
        %   size of the data window used by the spectral estimator. This property
        %   applies when you set the SpectralEstimation property to 'Specify
        %   frequency resolution'. The default is 10625 Hz.
        FrequencyResolution;

        %MaxHold Max-hold setting control
        %   Specify the maximum hold setting. When you set this property to true,
        %   the object compares the current estimated power spectral density
        %   vector (obtained with the current input data frame) to the previous
        %   max-hold accumulated power spectral density vector, (obtained at the
        %   previous call to the step method). The object stores the maximum
        %   values at each frequency bin and uses them to compute average power
        %   measurements. You clear the max-hold spectrum by calling the reset
        %   method on the object. When you set this property to false, the object
        %   obtains power measurements using instantaneous power spectral density
        %   estimates. The default is false. This property is tunable.
        MaxHold;

        %NormalizedFrequency Normalized frequency
        NormalizedFrequency;

        %OverlapPercentage Overlap percentage
        %   Specify the percentage of overlap between each segment in the spectral
        %   estimator as a double precision scalar in the [0 100] interval. This
        %   property applies when you set the SpectralEstimation property to
        %   'Specify window parameters'. The default is 0 percent.
        OverlapPercentage;

        %PowerUnits Power units.
        %   Specify power measurement units as one of 'dBm' | 'dBW' | 'Watts'. The
        %   default is 'dBm'. When you set this property to 'dBm', or 'dBW', then
        %   the step method outputs ACPR measurements in a dBc scale (adjacent
        %   channel power referenced to main channels power). If you set this
        %   property to 'Watts', the step method outputs ACPR measurements in a
        %   linear scale.
        PowerUnits;

        %SampleRate Sample rate 
        SampleRate;

        %SegmentLength Segment length
        %   Specify the segment length, in samples, for the spectral estimator as
        %   a numeric, positive, integer scalar. The length of the segment allows
        %   you to make tradeoffs between frequency resolution and variance in the
        %   spectral estimates. A long segment length results in better
        %   resolution. A short segment length results in more averaging and a
        %   decrease in variance. This property applies when you set the
        %   SpectralEstimation property to 'Specify window parameters'. The
        %   default is 64.
        SegmentLength;

        % SidelobeAttenuation Sidelobe attenuation for Chebyshev window
        %   Specify the sidelobe attenuation, in decibels, for the Chebyshev
        %   window function as a double precision, non-negative scalar. This
        %   property applies when you set the SpectralEstimation property to
        %   'Specify window parameters' and the Window property to 'Chebyshev'.
        %   The default is 100 dB.
        SidelobeAttenuation;

        %SpectralEstimation Spectral estimation control
        %   Specify the spectral estimation control as one of 'Auto' | 'Specify
        %   frequency resolution' | 'Specify window parameters'. The default is
        %   'Auto'.
        %
        %   When you set this property to 'Auto', the object obtains power
        %   measurements with a Welch spectral estimator with zero percent
        %   overlap, a Hamming window, and a segment length equal to the length of
        %   the input data vector. In this setting, the spectral estimator is set
        %   to achieve the maximum frequency resolution attainable with the input
        %   data length.
        %
        %   When you set this property to 'Specify frequency resolution', you
        %   specify the desired spectral frequency resolution, in normalized units
        %   or in Hertz, using the FrequencyResolution property. In this setting,
        %   the object uses the value in the FrequencyResolution property to
        %   automatically compute the size of the spectral estimator data window.
        %
        %   When you set this property to 'Specify window parameters' several
        %   spectral estimator properties become available so that you can control
        %   the Welch spectral estimation settings. These properties are:
        %   SegmentLength, OverlapPercentage, Window, and SidelobeAttenuation.
        %   Side lobe attenuation applies only when Window = 'Chebyshev'. When you
        %   set the SpectralEstimation property to 'Specify window parameters',
        %   the FrequencyResolution property does not apply and you control the
        %   resolution using the above properties.
        SpectralEstimation;

        % Window Window function
        %   Specify a window function for the spectral estimator as one of
        %   'Bartlett' | 'Bartlett-Hanning' | 'Blackman' | 'Blackman-Harris' |
        %   'Bohman' | 'Chebyshev' | 'Flat Top' | 'Hamming' | 'Hann' | 'Nuttall' |
        %   'Parzen' | 'Rectangular' | 'Triangular'. The default is 'Hamming'. A
        %   Hamming window has 42.5 dB of sidelobe attenuation. This may mask
        %   spectral content below this value, relative to the peak spectral
        %   content. Choosing different windows allows you to make tradeoffs
        %   between resolution and sidelobe attenuation. This property applies
        %   when you set the SpectralEstimation property to 'Specify window
        %   parameters'.
        Window;

    end
end
