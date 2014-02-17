classdef MemorylessNonlinearity< handle
%MemorylessNonlinearity Apply memoryless nonlinearity to input signal
%   H = comm.MemorylessNonlinearity creates a memoryless nonlinearity System
%   object, H, that models receiver radio frequency (RF) impairments.
%
%   H = comm.MemorylessNonlinearity(Name,Value) creates a memoryless
%   nonlinearity object, H, with the specified property Name set to the
%   specified Value. You can specify additional name-value pair arguments in
%   any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) applies memoryless nonlinearity to the input, X, using the
%   nonlinearity method you specify in the Method property, and returns the
%   result in Y. The input X must be a complex scalar or column vector of
%   data type double or single precision. The output, Y, is of the same data
%   type as the input, X.
%
%   MemorylessNonlinearity methods:
%
%   step     - Apply memoryless nonlinearity to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create memoryless nonlinearity object with same property 
%              values
%   isLocked - Locked status (logical)
%
%   MemorylessNonlinearity properties:
%
%   Method                - Method used to model nonlinearity
%   InputScaling          - Scale factor applied to input signal
%   LinearGain            - Linear gain applied to output signal
%   IIP3                  - Third order input intercept point
%   AMPMConversion        - AM/PM conversion factor
%   AMAMParameters        - AM/AM conversion parameters
%   AMPMParameters        - AM/PM conversion parameters
%   PowerLowerLimit       - Lower input power limit
%   PowerUpperLimit       - Upper input power limit
%   OutputScaling         - Scale factor applied to output signal
%   Smoothness            - Smoothness factor
%   OutputSaturationLevel - Output saturation level
%   
%   % Example:
%   %   Apply "Saleh model" nonlinearity to a 16-QAM signal
%
%   % Create 16-QAM modulator
%   hMod = comm.RectangularQAMModulator('ModulationOrder',16,...
%               'NormalizationMethod','Average power', 'AveragePower',1e-2);
%   % Create Memoryless Nonlinearity System object
%   hNonlin = comm.MemorylessNonlinearity('Method', 'Saleh model');
%   % Generate modulated symbols
%   modData = step(hMod, randi([0 15], 1000, 1));
%   % Apply Nonlinearity model and plot the result
%   y = step(hNonlin, modData);
%   scatterplot(y)
%
%   See also comm.PhaseNoise.

 
%   Copyright 2010-2013 The MathWorks, Inc.

    methods
        function out=MemorylessNonlinearity
            %MemorylessNonlinearity Apply memoryless nonlinearity to input signal
            %   H = comm.MemorylessNonlinearity creates a memoryless nonlinearity System
            %   object, H, that models receiver radio frequency (RF) impairments.
            %
            %   H = comm.MemorylessNonlinearity(Name,Value) creates a memoryless
            %   nonlinearity object, H, with the specified property Name set to the
            %   specified Value. You can specify additional name-value pair arguments in
            %   any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) applies memoryless nonlinearity to the input, X, using the
            %   nonlinearity method you specify in the Method property, and returns the
            %   result in Y. The input X must be a complex scalar or column vector of
            %   data type double or single precision. The output, Y, is of the same data
            %   type as the input, X.
            %
            %   MemorylessNonlinearity methods:
            %
            %   step     - Apply memoryless nonlinearity to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create memoryless nonlinearity object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %
            %   MemorylessNonlinearity properties:
            %
            %   Method                - Method used to model nonlinearity
            %   InputScaling          - Scale factor applied to input signal
            %   LinearGain            - Linear gain applied to output signal
            %   IIP3                  - Third order input intercept point
            %   AMPMConversion        - AM/PM conversion factor
            %   AMAMParameters        - AM/AM conversion parameters
            %   AMPMParameters        - AM/PM conversion parameters
            %   PowerLowerLimit       - Lower input power limit
            %   PowerUpperLimit       - Upper input power limit
            %   OutputScaling         - Scale factor applied to output signal
            %   Smoothness            - Smoothness factor
            %   OutputSaturationLevel - Output saturation level
            %   
            %   % Example:
            %   %   Apply "Saleh model" nonlinearity to a 16-QAM signal
            %
            %   % Create 16-QAM modulator
            %   hMod = comm.RectangularQAMModulator('ModulationOrder',16,...
            %               'NormalizationMethod','Average power', 'AveragePower',1e-2);
            %   % Create Memoryless Nonlinearity System object
            %   hNonlin = comm.MemorylessNonlinearity('Method', 'Saleh model');
            %   % Generate modulated symbols
            %   modData = step(hMod, randi([0 15], 1000, 1));
            %   % Apply Nonlinearity model and plot the result
            %   y = step(hNonlin, modData);
            %   scatterplot(y)
            %
            %   See also comm.PhaseNoise.
        end

        function getAttributesFromInput(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function processTunedPropertiesImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
            % Input cannot be fi-double or fi-single. This check can be moved to
            % validateInputsImpl when we have a mechanism to know, without looking
            % at actual input data, that this data is a fi object.
        end

        function stepImpl(in) %#ok<MANU>
            % scale input
        end

        function validateInputsImpl(in) %#ok<MANU>
            % input must be complex
        end

    end
    methods (Abstract)
    end
    properties
        %AMAMParameters AM/AM conversion parameters
        %   Specify the AM/AM conversion parameters that the object uses to
        %   compute the amplitude gain for an input signal as a real vector of
        %   data type double or single. This property applies when you set the
        %   Method property to 'Saleh model' or 'Ghorbani model'. If you set the
        %   Method property to 'Saleh model', this property is a two element
        %   vector that specifies alpha and beta values; otherwise, this property
        %   is a four element vector that specifies x1, x2, x3, and x4 values. The
        %   default is [2.1587 1.1517] for the Saleh model and [8.1081 1.5413
        %   6.5202 -0.0718] for the Ghorbani model. This property is tunable.
        AMAMParameters;

        %AMPMConversion AM/PM conversion factor
        %   Specify the AM/PM conversion factor (in degrees per decibel) as a real
        %   scalar of data type double or single. This property applies when you
        %   set the Method property to 'Cubic polynomial' or 'Hyperbolic tangent'.
        %   The default is 10. This property is tunable.
        AMPMConversion;

        %AMPMParameters AM/PM conversion parameters
        %   Specify the AM/PM conversion parameters used to compute the phase
        %   change for an input signal as a real vector of data type double or
        %   single. This property applies when you set the Method property to
        %   'Saleh model' or 'Ghorbani model'. If you set the Method property to
        %   'Saleh model', this property is a two element vector that specifies
        %   alpha and beta values; otherwise, this property is a four element
        %   vector that specifies y1, y2, y3, and y4 values. The default is
        %   [4.0033 9.1040] for the Saleh model and [4.6645 2.0965 10.88 -0.003]
        %   for the Ghorbani model. This property is tunable.
        AMPMParameters;

        %IIP3 Third order input intercept point
        %   Specify the third order input intercept point (in dBm) as a real
        %   scalar of data type double or single. This property applies when you
        %   set the Method property to 'Cubic polynomial' or 'Hyperbolic tangent'.
        %   The default is 30. This property is tunable.
        IIP3;

        %InputScaling Scale factor applied to input signal
        %   Specify the scale factor (in decibels), which the object applies to
        %   the input signal as a real scalar of data type double or single. This
        %   property applies when you set the Method property to 'Saleh model' or
        %   'Ghorbani model'. The default is 0. This property is tunable.
        InputScaling;

        %LinearGain Linear gain applied to output signal
        %   Specify the linear gain (in decibels) that the object applies to the
        %   output signal as a real scalar of data type double or single. This
        %   property applies when you set the Method property to 'Cubic
        %   polynomial', 'Hyperbolic tangent', or 'Rapp model'. The default is 0.
        %   This property is tunable.
        LinearGain;

        %Method Method used to model nonlinearity
        %   Specify the nonlinearity method as one of 'Cubic polynomial' |
        %   'Hyperbolic tangent' | 'Saleh model' | 'Ghorbani model' |'Rapp model'.
        %   The default is 'Cubic polynomial'.
        Method;

        %OutputSaturationLevel Output saturation level
        %   Specify the output saturation level as a real scalar of data type
        %   double or single. This property applies when you set the Method
        %   property to 'Rapp model'. The default is 1. This property is tunable.
        OutputSaturationLevel;

        %OutputScaling Scale factor applied to output signal
        %   Specify the scale factor (in decibels) that the object applies to the
        %   output signal as a real scalar of data type double or single. This
        %   property applies when you set the Method property to 'Saleh model' or
        %   'Ghorbani model'. The default is 0. This property is tunable.
        OutputScaling;

        %PowerLowerLimit Lower input power limit
        %   Specify the minimum input power (in dBm) for which AM/PM conversion
        %   scales linearly with input power value. Below this value, the phase
        %   shift resulting from AM/PM conversion is zero. You must set
        %   PowerLowerLimit to a real scalar of data type double or single. This
        %   property applies when you set the Method property to 'Cubic
        %   polynomial' or 'Hyperbolic tangent'. The default is 10. This property
        %   is tunable.
        PowerLowerLimit;

        %PowerUpperLimit Upper input power limit
        %   Specify the maximum input power (in dBm) for which AM/PM conversion
        %   scales linearly with input power value. Above this value, the phase
        %   shift resulting from AM/PM conversion is constant. You must set the
        %   PowerUpperLimit property to a real scalar, which is greater than the
        %   PowerLowerLimit property and of data type double or single. This
        %   property applies when you set the Method property to 'Cubic
        %   polynomial' or 'Hyperbolic tangent'. The default is inf. This property
        %   is tunable.
        PowerUpperLimit;

        %Smoothness Smoothness factor
        %   Specify the smoothness factor as a real scalar of data type double or
        %   single. This property applies when you set the Method property to
        %   'Rapp model'. The default is 0.5. This property is tunable.
        Smoothness;

    end
end
