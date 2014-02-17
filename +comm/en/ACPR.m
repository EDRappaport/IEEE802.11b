classdef ACPR< handle
%ACPR   Adjacent Channel Power Ratio measurements
%   H = comm.ACPR creates a System object, H, that measures adjacent channel
%   power ratio (ACPR) of an input signal. Use the ACPR object to measure
%   ACPR, as well as main and adjacent channel powers. The object measures
%   signal powers at the bands of interest by integrating the power spectral
%   density estimates obtained with a Welch spectral estimator. You can
%   control aspects of the spectral estimator with the SpectralEstimation
%   property.
%
%   ACPR measurements are defined as:  
%          
%   ACPR = (ADJPOW * MainMeasurementBandwidth)./(MAINPOW *
%   AdjacentMeasurementBandwidth)
%
%   ADJPOW is a vector of powers measured at the adjacent bands of interest.
%   MAINPOW is the power measured at the main channel band of interest.
%
%   H = comm.ACPR(Name,Value) creates an ACPR object H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   ACPR = step(H,X) returns a vector of the adjacent channel power ratio,
%   ACPR, measured in the input data, X. The measurements are at the
%   frequency bands that you specify with the MainChannelFrequency,
%   MainMeasurementBandwidth, AdjacentChannelOffset, and
%   AdjacentMeasurementBandwidth properties. Input X must be a double
%   precision column vector. The length of the output vector, ACPR, equals
%   the number of adjacent channels that you specify in the
%   AdjacentChannelOffset property.
%
%   [ACPR,MAINPOW] = step(H,X) returns the measured main channel power,
%   MAINPOW, when you set the MainChannelPowerOutputPort property to true.
%   The step method outputs the main channel power measured within the main
%   channel frequency band of interest that you specify with the
%   MainChannelFrequency and MainMeasurementBandwidth properties.
%
%   [ACPR,ADJPOW] = step(H,X) returns a vector of the measured adjacent
%   channel powers, ADJPOW, when you set the AdjacentChannelPowerOutputPort
%   property to true. The adjacent channel powers are measured at the
%   adjacent frequency bands of interest that you specify with the
%   AdjacentChannelOffset and AdjacentMeasurementBandwidth properties. The
%   length of the output vector, ADJPOW, equals the length of the vector
%   that you specify in the AdjacentChannelOffset property.
%
%   You can combine optional output arguments when you set their enabling
%   properties. Optional outputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   [ACPR MAINPOW, ADJPOW] = step(H,X)
%
%   ACPR methods:
%
%   step     - Measure ACPR of input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create ACPR measurement object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of ACPR measurement object
%
%   ACPR properties:
%
%   NormalizedFrequency            - Assume normalized frequency values
%   SampleRate                     - Sample rate of input signal
%   MainChannelFrequency           - Main channel center frequency
%   MainMeasurementBandwidth       - Main channel measurement bandwidth
%   AdjacentChannelOffset          - Adjacent channel frequency offsets
%   AdjacentMeasurementBandwidth   - Adjacent channel measurement bandwidths                                        
%   MeasurementFilterSource        - Source of the measurement filter
%   MeasurementFilter              - Measurement filter coefficients
%   SpectralEstimation             - Spectral estimation control 
%   SegmentLength                  - Segment length
%   OverlapPercentage              - Overlap percentage
%   Window                         - Window function
%   SidelobeAttenuation            - Sidelobe attenuation for Chebyshev 
%                                    window
%   FrequencyResolution            - Frequency resolution
%   FFTLength                      - FFT length
%   CustomFFTLength                - Custom FFT length
%   MaxHold                        - Max-hold setting control
%   PowerUnits                     - Power units
%   MainChannelPowerOutputPort     - Enable main channel power measurement
%                                    output
%   AdjacentChannelPowerOutputPort - Enable adjacent channel power
%                                    measurements output
%
%   % Example:
%   %   Measure ACPR of a 16-QAM signal with symbol rate of 3.84 Msps   
%   %   at -5 and +5 MHz frequency offsets. Set all measurement bandwidths
%   %   to 3.84 MHz
%
%   % Generate data with an alphabet size of 16 and modulate the data
%   x  = randi([0 16-1],5000,1);
%   hMod = comm.RectangularQAMModulator(16);
%   y = step(hMod,x);
%   % Usample the data by L = 8 using a rectangular pulse shape
%   L = 8;      
%   yPulse = rectpulse(y,L);                    
%   % Create an ACPR measurement object and measure the modulated signal
%   h = comm.ACPR(...
%          'SampleRate', 3.84e6*8,...
%          'MainChannelFrequency', 0,...
%          'MainMeasurementBandwidth', 3.84e6,...
%          'AdjacentChannelOffset', [-5e6 5e6],...
%          'AdjacentMeasurementBandwidth', 3.84e6,...
%          'MainChannelPowerOutputPort', true,...
%          'AdjacentChannelPowerOutputPort', true);
%   [ACPR,mainChnlPwr,adjChnlPwr] = step(h,yPulse)
%
%   See also comm.CCDF, comm.EVM, comm.MER.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=ACPR
            %ACPR   Adjacent Channel Power Ratio measurements
            %   H = comm.ACPR creates a System object, H, that measures adjacent channel
            %   power ratio (ACPR) of an input signal. Use the ACPR object to measure
            %   ACPR, as well as main and adjacent channel powers. The object measures
            %   signal powers at the bands of interest by integrating the power spectral
            %   density estimates obtained with a Welch spectral estimator. You can
            %   control aspects of the spectral estimator with the SpectralEstimation
            %   property.
            %
            %   ACPR measurements are defined as:  
            %          
            %   ACPR = (ADJPOW * MainMeasurementBandwidth)./(MAINPOW *
            %   AdjacentMeasurementBandwidth)
            %
            %   ADJPOW is a vector of powers measured at the adjacent bands of interest.
            %   MAINPOW is the power measured at the main channel band of interest.
            %
            %   H = comm.ACPR(Name,Value) creates an ACPR object H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   ACPR = step(H,X) returns a vector of the adjacent channel power ratio,
            %   ACPR, measured in the input data, X. The measurements are at the
            %   frequency bands that you specify with the MainChannelFrequency,
            %   MainMeasurementBandwidth, AdjacentChannelOffset, and
            %   AdjacentMeasurementBandwidth properties. Input X must be a double
            %   precision column vector. The length of the output vector, ACPR, equals
            %   the number of adjacent channels that you specify in the
            %   AdjacentChannelOffset property.
            %
            %   [ACPR,MAINPOW] = step(H,X) returns the measured main channel power,
            %   MAINPOW, when you set the MainChannelPowerOutputPort property to true.
            %   The step method outputs the main channel power measured within the main
            %   channel frequency band of interest that you specify with the
            %   MainChannelFrequency and MainMeasurementBandwidth properties.
            %
            %   [ACPR,ADJPOW] = step(H,X) returns a vector of the measured adjacent
            %   channel powers, ADJPOW, when you set the AdjacentChannelPowerOutputPort
            %   property to true. The adjacent channel powers are measured at the
            %   adjacent frequency bands of interest that you specify with the
            %   AdjacentChannelOffset and AdjacentMeasurementBandwidth properties. The
            %   length of the output vector, ADJPOW, equals the length of the vector
            %   that you specify in the AdjacentChannelOffset property.
            %
            %   You can combine optional output arguments when you set their enabling
            %   properties. Optional outputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   [ACPR MAINPOW, ADJPOW] = step(H,X)
            %
            %   ACPR methods:
            %
            %   step     - Measure ACPR of input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create ACPR measurement object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of ACPR measurement object
            %
            %   ACPR properties:
            %
            %   NormalizedFrequency            - Assume normalized frequency values
            %   SampleRate                     - Sample rate of input signal
            %   MainChannelFrequency           - Main channel center frequency
            %   MainMeasurementBandwidth       - Main channel measurement bandwidth
            %   AdjacentChannelOffset          - Adjacent channel frequency offsets
            %   AdjacentMeasurementBandwidth   - Adjacent channel measurement bandwidths                                        
            %   MeasurementFilterSource        - Source of the measurement filter
            %   MeasurementFilter              - Measurement filter coefficients
            %   SpectralEstimation             - Spectral estimation control 
            %   SegmentLength                  - Segment length
            %   OverlapPercentage              - Overlap percentage
            %   Window                         - Window function
            %   SidelobeAttenuation            - Sidelobe attenuation for Chebyshev 
            %                                    window
            %   FrequencyResolution            - Frequency resolution
            %   FFTLength                      - FFT length
            %   CustomFFTLength                - Custom FFT length
            %   MaxHold                        - Max-hold setting control
            %   PowerUnits                     - Power units
            %   MainChannelPowerOutputPort     - Enable main channel power measurement
            %                                    output
            %   AdjacentChannelPowerOutputPort - Enable adjacent channel power
            %                                    measurements output
            %
            %   % Example:
            %   %   Measure ACPR of a 16-QAM signal with symbol rate of 3.84 Msps   
            %   %   at -5 and +5 MHz frequency offsets. Set all measurement bandwidths
            %   %   to 3.84 MHz
            %
            %   % Generate data with an alphabet size of 16 and modulate the data
            %   x  = randi([0 16-1],5000,1);
            %   hMod = comm.RectangularQAMModulator(16);
            %   y = step(hMod,x);
            %   % Usample the data by L = 8 using a rectangular pulse shape
            %   L = 8;      
            %   yPulse = rectpulse(y,L);                    
            %   % Create an ACPR measurement object and measure the modulated signal
            %   h = comm.ACPR(...
            %          'SampleRate', 3.84e6*8,...
            %          'MainChannelFrequency', 0,...
            %          'MainMeasurementBandwidth', 3.84e6,...
            %          'AdjacentChannelOffset', [-5e6 5e6],...
            %          'AdjacentMeasurementBandwidth', 3.84e6,...
            %          'MainChannelPowerOutputPort', true,...
            %          'AdjacentChannelPowerOutputPort', true);
            %   [ACPR,mainChnlPwr,adjChnlPwr] = step(h,yPulse)
            %
            %   See also comm.CCDF, comm.EVM, comm.MER.
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Call setupImpl of super class
        end

        function stepImpl(in) %#ok<MANU>
            % Filter input if MeasurementFilterSource is set to 'Property'
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
            % Length of AdjacentMeasurementBandwidth can only be 1 or equal to
            % length of AdjacentChannelOffset
        end

    end
    methods (Abstract)
    end
    properties
        %AdjacentChannelOffset Adjacent channel frequency offsets
        %   Specify the adjacent channel offsets as a double precision scalar or
        %   as a row vector of frequencies that define the location of adjacent
        %   channels of interest. When you set the NormalizedFrequency property to
        %   true, you must specify normalized frequency offset values between -1
        %   and 1. When you set the NormalizedFrequency property to false, you
        %   must specify frequency offset values in Hertz. The offset values are
        %   the distance between the main channel center frequency and adjacent
        %   channel center frequencies. Positive offsets indicate adjacent
        %   channels to the right of the main channel center frequency, and
        %   negative offsets indicate adjacent channels to the left of the main
        %   channel center frequency. The default is [-100e3 100e3] Hz.
        AdjacentChannelOffset;

        %AdjacentChannelPowerOutputPort Enable adjacent channel power measurements
        %                               output
        %   When you set this property to true, the step method outputs a vector
        %   of adjacent channel power measurements. The adjacent channel powers
        %   correspond to the input signal's power measured in the bands that you
        %   define with the AdjacentChannelOffset and AdjacentMeasurementBandwidth
        %   properties. The step method returns power measurements in the units
        %   that you specify in the PowerUnits property. The default is false.
        AdjacentChannelPowerOutputPort;

        % AdjacentMeasurementBandwidth Adjacent channel measurement bandwidths
        %   Specify the measurement bandwidth for each adjacent channel. The
        %   object assumes that each adjacent bandwidth is centered at the
        %   frequency defined by the corresponding frequency offset in the
        %   AdjacentChannelOffset property. Set this property to a double
        %   precision scalar or row vector of length equal to the number of
        %   specified offsets in the AdjacentChannelOffset property. The default
        %   is the scalar, 50e3. When you set this property to a scalar, the
        %   object obtains all adjacent channel power measurements within equal
        %   measurement bandwidths.
        %
        %   When you set the NormalizedFrequency property to true, you must
        %   specify normalized bandwidth values between 0 and 1. When you set the
        %   NormalizedFrequency property to false, you must specify the adjacent
        %   channel bandwidth values in Hertz.
        AdjacentMeasurementBandwidth;

        %MainChannelFrequency Main channel center frequency
        %   Specify the main channel center frequency as a double precision
        %   scalar. When you set the NormalizedFrequency property to true you must
        %   specify the center frequency as a normalized value between -1 and 1.
        %   When you set the NormalizedFrequency property to false, you must
        %   specify the center frequency in Hertz. The object measures the main
        %   channel power in the bandwidth that you specify in the
        %   MainMeasurementBandwidth property, centered at the frequency that you
        %   specify in the MainChannelFrequency property. The default is 0 Hz.
        MainChannelFrequency;

        %MainChannelPowerOutputPort Enable main channel power measurement output
        %   When you set this property to true, the step method outputs the main
        %   channel power measurement. The main channel power is the power of the
        %   input signal measured in the band that you define with the
        %   MainChannelFrequency and MainMeasurementBandwidth properties. The step
        %   method returns power measurements in the units that you specify in the
        %   PowerUnits property. The default is false.
        MainChannelPowerOutputPort;

        %MainMeasurementBandwidth Main channel measurement bandwidth
        %   Specify the main channel measurement bandwidth as a double precision,
        %   positive scalar. When you set the NormalizedFrequency property to
        %   true, you must specify the measurement bandwidth as a normalized value
        %   between 0 and 1. When you set the NormalizedFrequency property to
        %   false, you must specify the measurement bandwidth in Hertz. The object
        %   measures the main channel power in the bandwidth that you specify in
        %   the MainMeasurementBandwidth property, centered at the frequency that
        %   you specify in the MainChannelFrequency property. The default is 50e3
        %   Hz.
        MainMeasurementBandwidth;

        %MeasurementFilter Measurement filter coefficients
        %   Specify the measurement filter coefficients as a double precision, row
        %   vector containing the coefficients of an FIR filter in descending
        %   order of powers of z. The response of the filter must be centered at
        %   DC. The ACPR object automatically shifts and applies the filter
        %   response at each of the main and adjacent channel center frequencies
        %   before obtaining the average power measurements. The internal filter
        %   states are persistent and will be cleared when you call the reset
        %   method. This property applies when you set the MeasurementFilterSource
        %   property to 'Property'. The default is 1, which is an all pass filter
        %   that has no effects on the measurements.
        MeasurementFilter;

        %MeasurementFilterSource Measurement filter source
        %   Specify the measurement filter source as one of 'None' | 'Property'.
        %   The default is 'None'. When you set this property to 'None' the object
        %   does not apply filtering to obtain ACPR measurements. When you set
        %   this property to 'Property', the object applies a measurement filter
        %   to the main channel and each of the adjacent channel bands before
        %   measuring the average power. In this case, you specify the measurement
        %   filter coefficients in the MeasurementFilter property.
        MeasurementFilterSource;

        %NormalizedFrequency Assume normalized frequency values
        %   Specify whether the frequency values are normalized. If you set this
        %   property to true, the object assumes that frequency values are
        %   normalized (in the [-1 1] range). If you set this property to false,
        %   the object assumes that frequency values are in Hertz. The default is
        %   false.
        NormalizedFrequency;

        %SampleRate Sample rate of input signal
        %   Specify the sample rate of the input signal, in samples per second, as
        %   a double precision, positive scalar. This property applies when you
        %   set the NormalizedFrequency property to false. The default is 1e6
        %   samples per second.
        SampleRate;

    end
end
