classdef UpConverterFilterDesigner< handle
%UpConverterFilterDesigner Interpolation filter cascade designer
%   This object designs a cascade of interpolation filter System objects to
%   be used by the dsp.DigitalUpConverter class. The cascade consists of
%   four stages.
%   When  FilterSpecification is 'Design parameters':
%
%   Stage1   = halfband or lowpass interpolation filter (this
%              stage may or may not be bypassed, depending on the property
%              settings of the object)
%   Stage2   = CIC compensator interpolation filter
%   Stage3   = CIC interpolator filter (this stage will be implemented as a
%              dsp.FIRInterpolator System object when the Arithmetic
%              property is set to 'double' or 'single', or as a
%              dsp.CICInterpolator System object when the Arithmetic
%              property is set to 'fixed'.
%  GainStage = Gain stage to normalize the gain of the CIC interpolator.    
%
%  When  FilterSpecification is 'Coefficients':
%
%   Stage1   = FIR interpolation filter (this
%              stage may or may not be bypassed, depending on the property
%              settings of the object)
%   Stage2   = FIR interpolation filter
%   Stage3   = CIC interpolator filter (this stage will be implemented as a
%              dsp.FIRInterpolator System object when the Arithmetic
%              property is set to 'double' or 'single', or as a
%              dsp.CICInterpolator System object when the Arithmetic
%              property is set to 'fixed'.
%  GainStage = Gain stage to normalize the gain of the CIC interpolator.    

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=UpConverterFilterDesigner
            %UpConverterFilterDesigner Interpolation filter cascade designer
            %   This object designs a cascade of interpolation filter System objects to
            %   be used by the dsp.DigitalUpConverter class. The cascade consists of
            %   four stages.
            %   When  FilterSpecification is 'Design parameters':
            %
            %   Stage1   = halfband or lowpass interpolation filter (this
            %              stage may or may not be bypassed, depending on the property
            %              settings of the object)
            %   Stage2   = CIC compensator interpolation filter
            %   Stage3   = CIC interpolator filter (this stage will be implemented as a
            %              dsp.FIRInterpolator System object when the Arithmetic
            %              property is set to 'double' or 'single', or as a
            %              dsp.CICInterpolator System object when the Arithmetic
            %              property is set to 'fixed'.
            %  GainStage = Gain stage to normalize the gain of the CIC interpolator.    
            %
            %  When  FilterSpecification is 'Coefficients':
            %
            %   Stage1   = FIR interpolation filter (this
            %              stage may or may not be bypassed, depending on the property
            %              settings of the object)
            %   Stage2   = FIR interpolation filter
            %   Stage3   = CIC interpolator filter (this stage will be implemented as a
            %              dsp.FIRInterpolator System object when the Arithmetic
            %              property is set to 'double' or 'single', or as a
            %              dsp.CICInterpolator System object when the Arithmetic
            %              property is set to 'fixed'.
            %  GainStage = Gain stage to normalize the gain of the CIC interpolator.    
        end

        function checkPropertyValues(in) %#ok<MANU>
            %Verify that property values are within valid frequency ranges
        end

        function computeCICNullFrequencies(in) %#ok<MANU>
            % Compute frequency locations of CIC nulls
        end

        function computeFrequencySpecifications(in) %#ok<MANU>
            %Compute rate of operation and stopband frequencies for filter
            %sections.
        end

        function designFiltersMinOrder(in) %#ok<MANU>
            % Design cascade of minimum order interpolation filters that meets
            % specifications.
        end

        function designFiltersSpecifiedCoefficients(in) %#ok<MANU>
            % First stage design
        end

        function designFiltersSpecifiedOrders(in) %#ok<MANU>
            % Design cascade of interpolation filters with specified orders,
            % passband and stopband frequencies.
        end

        function mfiltToSystemObjects(in) %#ok<MANU>
            % Convert the mfilt objects that form the interpolation cascade to
            % system objects. output the System objects in a cell array with:
            % First element  = First stage (this element will be empty if first
            %                  stage is bypassed)
            % Second element = CIC compensator stage
            % Third element  = CIC stage
            % Fourth element = CIC gain can be a double or a fi object
            %
            % If varargin is not empty, then it contains the input data type to the
            % DUC System object and the output data type of all filters. In this
            % scenario we need to set all of the filter internals for each System
            % object.
        end

        function privIsSpecMet(in) %#ok<MANU>
            % Protected method can be called even if a final filter design is not
            % available yet. Returns true if the cascade response meets the filter
            % specifications.
        end

        function setCoefficientsWordLength(in) %#ok<MANU>
        end

        function setFilterSectionTypes(in) %#ok<MANU>
            %Determine if the first filter section is bypassed or not. If not, then
            %determine whether the first section should be a halfband or a lowpass
            %interpolation filter. Set the interpolation factor values for each
            %section.
        end

        function setInputDataTypes(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
