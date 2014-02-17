classdef ConverterFilterDesignerBase< handle
%ConverterFilterDesignerBase Base class for the UpConverterFilterDesigner
%and DownConverterFilterDesigner classes.

 
%   Copyright 2010-2011 The MathWorks, Inc.

    methods
        function out=ConverterFilterDesignerBase
            %ConverterFilterDesignerBase Base class for the UpConverterFilterDesigner
            %and DownConverterFilterDesigner classes.
        end

        function addMask(in) %#ok<MANU>
            % Draw mask and add quantized filter response of cascade
        end

        function centerRipple(in) %#ok<MANU>
        end

        function getCICFIRCoefficients(in) %#ok<MANU>
            % Design an FIR filter with a CIC response using a cascade of boxcar
            % filters.
            % N is the number of sections.
            % Fac is the factor (decimation or interpolation)
        end

        function getMinOrderCICFIRCoefficients(in) %#ok<MANU>
            % Design a minimum order FIR filter with a CIC response using a cascade
            % of boxcar filters.
            % Fac is the (decimation or interpolation) factor
        end

        function getRefferenceCoefficients(in) %#ok<MANU>
            % Get refference coefficients of filter object h
        end

        function isDesignAvailable(in) %#ok<MANU>
        end

        function isRippleSpecMet(in) %#ok<MANU>
            % Returns true if the passband ripple specification is met    
        end

        function isStopbandAttenuationSpecMet(in) %#ok<MANU>
            % Returns true if the stopband attenuation specification is met in the
            % specified frequency interval.    
        end

        function measureAttenuation(in) %#ok<MANU>
            % Measure attenuation in a specified interval of frequencies.    
            % Input magResp is the magnitude response computed at frequencies in
            % FVect vector. Input cascadeGain is the gain of the passband. Input
            % interval is a 1x2 vector containing the frequency points of interest.
        end

        function measurePassbandRipple(in) %#ok<MANU>
            % Measure ripple in the passband.
            % Input magResp is the magnitude response computed at frequencies in
            % FVect vector. Input cascadeGain is the gain of the passband.
        end

        function optimizeCoefficientsWordLengths(in) %#ok<MANU>
            % Iterate until we find a word length that meets the specifications WL1
            % and WL2 are initial word lengths for the Stage1 and CIC compensator
            % sections (when obj is an up converter) or the word lengths for the CIC
            % compensator and Stage2 (when obj is a down converter)
        end

        function privFvtool(in) %#ok<MANU>
            % Plot response of cascade using fvtool. 
            % Fs is sampling frequency used in fvtool
            % cascadeGain is the gain of filter cascade
            % varargin contains other p-v pairs for fvtool
        end

        function reset(in) %#ok<MANU>
        end

        function setSectionFactors(in) %#ok<MANU>
        end

        function thisIsSpecMet(in) %#ok<MANU>
            % Returns true if the ripple and stopband attenuation specifications of
            % the filter response have been met.
            % FVect(end) must be larger than obj.pCascadeFilterStopbandFrequency
        end

    end
    methods (Abstract)
        checkPropertyValues; %#ok<NOIN>

        computeCICNullFrequencies; %#ok<NOIN>

        computeFrequencySpecifications; %#ok<NOIN>

        designFiltersMinOrder; %#ok<NOIN>

        designFiltersSpecifiedCoefficients; %#ok<NOIN>

        designFiltersSpecifiedOrders; %#ok<NOIN>

        mfiltToSystemObjects; %#ok<NOIN>

        privIsSpecMet; %#ok<NOIN>

        setCoefficientsWordLength; %#ok<NOIN>

        setFilterSectionTypes; %#ok<NOIN>

    end
    properties
        %FilterDesignIsAvailable Flag is true if a filter design is available
        FilterDesignIsAvailable;

        %pActualPassbandRipple
        pActualPassbandRipple;

        %pActualStopbandAttenuation
        pActualStopbandAttenuation;

        %pCICCompFilter Handle to an mfilt object that forms the CIC compensator
        %stage
        pCICCompFilter;

        %pCICFilter Handle to an mfilt object that forms the CIC stage
        pCICFilter;

        %pCascadeFilter Handle to an mfilt object containing the cascade response
        pCascadeFilter;

        %pCascadeFilterStopbandFrequency Stopband frequency of the cascade
        %response. This property will be used to verify attenuation in the
        %stopband of the cascade response.
        pCascadeFilterStopbandFrequency;

        %pFCICNulls Vector containing the frequency locations (in Hertz) of the
        %nulls of the CIC stage.
        pFCICNulls;

        %pFsStage1 Operating sampling frequency of first filter stage in Hertz
        pFsStage1;

        %pFsStage2 Operating sampling frequency of second filter stage in Hertz
        pFsStage2;

        %pFsStage3 Operating sampling frequency of third filter stage in Hertz
        pFsStage3;

        %pFstopStage2 Stopband frequency of second filter stage in Hertz
        pFstopStage2;

        %pGainFilter Handle to a dfilt object that forms the gain stage
        pGainFilter;

        %pM1 Interpolation or decimation factor for first filter stage
        pM1;

        %pM2 Interpolation or decimation factor for second filter stage
        pM2;

        %pM3 Interpolation or decimation factor for third filter stage
        pM3;

        %pNumMagRespMeasPoints Number of frequency points used to
        %measure magnitude response.
        pNumMagRespMeasPoints;

        %pPassBandRippleReductionFactor Factor to reduce passband ripple when
        %designing minimum order filters. 
        pPassBandRippleReductionFactor;

        %pPassbandFrequency Passband frequency in Hertz
        pPassbandFrequency;

        %pStopbandAttenuationStep Step to increase the attenuation when designing
        %minimum order filters. Must be in dB.
        pStopbandAttenuationStep;

    end
end
