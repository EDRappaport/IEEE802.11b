classdef PhaseFrequencyOffset< handle
%PhaseFrequencyOffset Apply phase and frequency offsets to input signal
%   H = comm.PhaseFrequencyOffset creates a phase and frequency offset
%   System object, H. This object applies phase and frequency offsets to an
%   input signal.
%
%   H = comm.PhaseFrequencyOffset(Name,Value) creates a phase and frequency
%   offset object, H, with the specified property Name set to the specified
%   Value. You can specify additional name-value pair arguments in any order
%   as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   Y = step(H,X) applies phase and frequency offsets to input X, and
%   returns Y. The input X is a double or single precision matrix X, of
%   dimensions MxN. M is the number of time samples in the input signals and
%   N is number of channels. Both M and N can be equal to 1. The object adds
%   phase and frequency offsets independently to each column of X. The data
%   type and dimensions of X and Y are the same.
%
%   Y = step(H,X,FRQ) uses FRQ as the frequency offset that the object
%   applies to input X when you set the FrequencyOffsetSource property to
%   'Input port'. When the X input is an MxN matrix, the value for FRQ can
%   be a numeric scalar, an Mx1 or 1xN numeric vector, or an MxN numeric
%   matrix. When the FRQ input is a scalar, the object applies a constant
%   frequency offset, FRQ, to each column of X. When the FRQ input is an Mx1
%   vector, the object applies time varying frequency offsets, which are
%   specified in the FRQ vector, to each column of X. When the FRQ input is
%   a 1xN vector, the object applies the ith constant frequency offset in
%   FRQ to the ith column of X. When the FRQ input is an MxN matrix, the
%   object applies the ith time varying frequency offsets, specified in the
%   ith column of FRQ, to the ith column of X.
%
%   PhaseFrequencyOffset methods:
%
%   step     - Apply phase and frequency offsets to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create phase and frequency offset object with same property 
%              values
%   isLocked - Locked status (logical)
%
%   PhaseFrequencyOffset properties:
%
%   PhaseOffset           - Phase offset
%   FrequencyOffsetSource - Source of frequency offset
%   FrequencyOffset       - Frequency offset
%   SampleRate            - Sample rate
%
%   % Example:
%   %   Introduce phase offset to a rectangular 16-QAM signal
%
%   data = (0:15)';
%   M = 16; % Modulation order
%   hMod = comm.RectangularQAMModulator(M);
%   hPFO = comm.PhaseFrequencyOffset('PhaseOffset', 20,'SampleRate',1e6);
%   % Modulate data
%   modData = step(hMod, data);
%   scatterplot(modData); 
%   title(' Original Constellation');xlim([-5 5]);ylim([-5 5]) 
%   % Introduce phase offset 
%   impairedData = step(hPFO,modData); 
%   scatterplot(impairedData); 
%   title('Constellation after phase offset');xlim([-5 5]);ylim([-5 5])
%         
%   See also comm.ThermalNoise, comm.PhaseNoise, 
%            comm.MemorylessNonlinearity.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=PhaseFrequencyOffset
            %PhaseFrequencyOffset Apply phase and frequency offsets to input signal
            %   H = comm.PhaseFrequencyOffset creates a phase and frequency offset
            %   System object, H. This object applies phase and frequency offsets to an
            %   input signal.
            %
            %   H = comm.PhaseFrequencyOffset(Name,Value) creates a phase and frequency
            %   offset object, H, with the specified property Name set to the specified
            %   Value. You can specify additional name-value pair arguments in any order
            %   as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) applies phase and frequency offsets to input X, and
            %   returns Y. The input X is a double or single precision matrix X, of
            %   dimensions MxN. M is the number of time samples in the input signals and
            %   N is number of channels. Both M and N can be equal to 1. The object adds
            %   phase and frequency offsets independently to each column of X. The data
            %   type and dimensions of X and Y are the same.
            %
            %   Y = step(H,X,FRQ) uses FRQ as the frequency offset that the object
            %   applies to input X when you set the FrequencyOffsetSource property to
            %   'Input port'. When the X input is an MxN matrix, the value for FRQ can
            %   be a numeric scalar, an Mx1 or 1xN numeric vector, or an MxN numeric
            %   matrix. When the FRQ input is a scalar, the object applies a constant
            %   frequency offset, FRQ, to each column of X. When the FRQ input is an Mx1
            %   vector, the object applies time varying frequency offsets, which are
            %   specified in the FRQ vector, to each column of X. When the FRQ input is
            %   a 1xN vector, the object applies the ith constant frequency offset in
            %   FRQ to the ith column of X. When the FRQ input is an MxN matrix, the
            %   object applies the ith time varying frequency offsets, specified in the
            %   ith column of FRQ, to the ith column of X.
            %
            %   PhaseFrequencyOffset methods:
            %
            %   step     - Apply phase and frequency offsets to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create phase and frequency offset object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %
            %   PhaseFrequencyOffset properties:
            %
            %   PhaseOffset           - Phase offset
            %   FrequencyOffsetSource - Source of frequency offset
            %   FrequencyOffset       - Frequency offset
            %   SampleRate            - Sample rate
            %
            %   % Example:
            %   %   Introduce phase offset to a rectangular 16-QAM signal
            %
            %   data = (0:15)';
            %   M = 16; % Modulation order
            %   hMod = comm.RectangularQAMModulator(M);
            %   hPFO = comm.PhaseFrequencyOffset('PhaseOffset', 20,'SampleRate',1e6);
            %   % Modulate data
            %   modData = step(hMod, data);
            %   scatterplot(modData); 
            %   title(' Original Constellation');xlim([-5 5]);ylim([-5 5]) 
            %   % Introduce phase offset 
            %   impairedData = step(hPFO,modData); 
            %   scatterplot(impairedData); 
            %   title('Constellation after phase offset');xlim([-5 5]);ylim([-5 5])
            %         
            %   See also comm.ThermalNoise, comm.PhaseNoise, 
            %            comm.MemorylessNonlinearity.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %FrequencyOffset Frequency offset
        %   Specify the frequency offset in Hertz. If the step method input, X, is
        %   an MxN matrix, then the FrequencyOffset property is a numeric scalar,
        %   an Mx1 or 1xN numeric vector, or an MxN numeric matrix. This property
        %   applies when you set the FrequencyOffsetSource property to 'Property'.
        %   The default is 0.
        %
        %   When you set the FrequencyOffset property to a scalar, the object
        %   applies the constant specified frequency offset to each column of X.
        %   When you set the FrequencyOffset property to an Mx1 vector, the object
        %   applies the time varying frequency offsets, specified in
        %   FrequencyOffset, to each column of X. When you set the FrequencyOffset
        %   property to a 1xN vector, the object applies the ith constant
        %   frequency offset in FrequencyOffset to the ith column of X. When you
        %   set the FrequencyOffset property to an MxN matrix, the object applies
        %   the ith time varying frequency offset, specified in the ith column of
        %   FrequencyOffset, to the ith column of X. This property is tunable.
        FrequencyOffset;

        %FrequencyOffsetSource Source of frequency offset
        %   Specify the source of the frequency offset as one of 'Property' |
        %   'Input port'. If you set this property to 'Property', you can specify
        %   the frequency offset using the FrequencyOffset property. If you set
        %   this property to 'Input port', you specify the frequency offset as a
        %   step method input. The default is 'Property'.
        FrequencyOffsetSource;

        %PhaseOffset Phase offset
        %   Specify the phase offset in degrees. If the step method X input is an
        %   MxN matrix, the PhaseOffset property can be set to a numeric scalar,
        %   an Mx1 or 1xN numeric vector, or an MxN numeric matrix. When you set
        %   the PhaseOffset property to a scalar, the object applies the constant
        %   specified phase offset to each column of X. When you set the
        %   PhaseOffset property to an Mx1 vector, the object applies time varying
        %   phase offsets, specified in the vector in PhaseOffset, to each column
        %   of X. When you set the PhaseOffset property to a 1xN vector, the
        %   object applies the ith constant phase offset in PhaseOffset to the ith
        %   column of X. When you set the PhaseOffset property to an MxN matrix,
        %   the object applies the ith time varying phase offsets, specified in
        %   the ith column of PhaseOffset, to the ith column of X. The default is
        %   0. This property is tunable.
        PhaseOffset;

        %SampleRate Sample rate
        %   Specify the sample rate of the input samples in Hz as a double
        %   precision, real, positive scalar. The default is 1 Hz.
        SampleRate;

    end
end
