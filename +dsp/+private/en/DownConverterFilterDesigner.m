classdef DownConverterFilterDesigner< handle
%DownConverterFilterDesigner Decimation filter cascade designer
%   This object designs a cascade of decimation filter System objects to be
%   used by the dsp.DigitalDownConverter class. The cascade consists of four
%   stages. 
%   When  FilterSpecification is 'Design parameters':
%
%   Stage1    = CIC decimator filter (this stage will be implemented as a
%               dsp.FIRDecimator System object when the Arithmetic property
%               is set to 'Double' or 'Single', or as a dsp.CICDecimator
%               System object when the Arithmetic property is set to
%               'fixed'.
%   Stage2    = CIC compensator decimation filter
%   Stage3    = halfband or lowpass decimation filter (this
%               stage may or may not be bypassed, depending on the property
%               settings of the object)
%   GainStage = Gain stage to normalize the gain of the CIC decimator.  
%
%   When  FilterSpecification is 'Coefficients':
%
%   Stage1    = CIC decimator filter (this stage will be implemented as a
%               dsp.FIRDecimator System object when the Arithmetic property
%               is set to 'Double' or 'Single', or as a dsp.CICDecimator
%               System object when the Arithmetic property is set to
%               'fixed'.
%   Stage2    = FIR decimation filter
%   Stage3    = FIR decimation filter (this stage may or may not be 
%               bypassed, depending on the property settings of the object)
%   GainStage = Gain stage to normalize the gain of the CIC decimator. 

 
%   Copyright 2010-2012 The MathWorks, Inc.

    methods
        function out=DownConverterFilterDesigner
            %DownConverterFilterDesigner Decimation filter cascade designer
            %   This object designs a cascade of decimation filter System objects to be
            %   used by the dsp.DigitalDownConverter class. The cascade consists of four
            %   stages. 
            %   When  FilterSpecification is 'Design parameters':
            %
            %   Stage1    = CIC decimator filter (this stage will be implemented as a
            %               dsp.FIRDecimator System object when the Arithmetic property
            %               is set to 'Double' or 'Single', or as a dsp.CICDecimator
            %               System object when the Arithmetic property is set to
            %               'fixed'.
            %   Stage2    = CIC compensator decimation filter
            %   Stage3    = halfband or lowpass decimation filter (this
            %               stage may or may not be bypassed, depending on the property
            %               settings of the object)
            %   GainStage = Gain stage to normalize the gain of the CIC decimator.  
            %
            %   When  FilterSpecification is 'Coefficients':
            %
            %   Stage1    = CIC decimator filter (this stage will be implemented as a
            %               dsp.FIRDecimator System object when the Arithmetic property
            %               is set to 'Double' or 'Single', or as a dsp.CICDecimator
            %               System object when the Arithmetic property is set to
            %               'fixed'.
            %   Stage2    = FIR decimation filter
            %   Stage3    = FIR decimation filter (this stage may or may not be 
            %               bypassed, depending on the property settings of the object)
            %   GainStage = Gain stage to normalize the gain of the CIC decimator. 
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
            % Design cascade of minimum order decimation filters that meets
            % specifications.
        end

        function designFiltersSpecifiedCoefficients(in) %#ok<MANU>
            % Design first stage (CIC)
        end

        function designFiltersSpecifiedOrders(in) %#ok<MANU>
            % Design cascade of decimation filters with specified orders,
            % passband and stopband frequencies.
        end

        function mfiltToSystemObjects(in) %#ok<MANU>
            % Convert the mfilt objects that form the decimation cascade to
            % system objects. output the System objects in a cell array with:
            % First element  = CIC stage
            % Second element = CIC compensator stage
            % Third element  = Third stage (this element will be empty if third
            %                  stage is bypassed)
            % Fourth element = CIC gain can be a double or a fi object
            %
            % If varargin is not empty, then it contains the filters input data
            % type. In this scenario we need to set all of the filter internals for
            % each System object.
        end

        function privIsSpecMet(in) %#ok<MANU>
            % Protected method can be called even if a final filter design is not
            % available yet. Returns true if the cascade response meets the filter
            % specifications.
        end

        function setCoefficientsWordLength(in) %#ok<MANU>
        end

        function setFilterSectionTypes(in) %#ok<MANU>
            %Determine if the third filter section is bypassed or not. If not, then
            %determine whether the third section should be a halfband or a lowpass
            %decimation filter. Set the decimation factor values for each section.
        end

        function setInputDataTypes(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
