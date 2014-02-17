classdef EVM< handle
%EVM    Measure error vector magnitude
%   H = comm.EVM creates an error vector magnitude (EVM) System object, H.
%   This object measures the amount of impairment in a modulated signal. Use
%   the EVM object to measure RMS EVM, maximum EVM, and percentile EVM, all
%   in percentages.
%
%   H = comm.EVM(Name,Value) creates an EVM object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   RMSEVM = step(H,REFSYM,RXSYM) outputs the root-mean-square EVM (in
%   percent), RMSEVM, measured in the received signal, RXSYM, based on the
%   reference signal, REFSYM. REFSYM and RXSYM inputs are complex column
%   vectors of equal dimensions and data type. The data type can be double,
%   single, signed integer, or signed fixed point with power-of-two slope
%   and zero bias. The step method outputs the RMSEVM measurement based
%   solely on the current input frame.
%
%   [RMSEVM,MAXEVM] = step(H,REFSYM,RXSYM) outputs the maximum EVM (in
%   percent), MAXEVM, measured in the received signal, RXSYM, when you set
%   the MaximumEVMOutputPort property to true. The step method outputs the
%   MAXEVM measurement based on the reference signal, REFSYM. MAXEVM
%   represents the worst-case EVM value measured in the current input frame.
%
%   [RMSEVM,PEVM] = step(H,REFSYM,RXSYM) outputs the percentile EVM (in
%   percent), PEVM, measured in the received signal, RXSYM, when you set the
%   XPercentileEVMOutputPort property to true. The step method outputs the
%   PEVM measurement based on the reference signal, REFSYM. The object sets
%   PEVM equal to a value just greater than the XPercentileValue percent of
%   all the EVM values. For example, if you set the XPercentileValue
%   property to 95, then 95% of all EVM measurements are below the PEVM
%   value. The object calculates the persistent measurement PEVM, using all
%   the input frames since the last reset.
%
%   [RMSEVM,NUMSYM] = step(H,REFSYM,RXSYM) outputs the number of symbols,
%   NUMSYM, used to calculate the X-Percentile EVM measurements when you set
%   the SymbolCountOutputPort property to true.
% 
%   All outputs of the object are of data type double.
%
%   You can combine optional output arguments when you set their enabling
%   properties. Optional outputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   [RMSEVM,MAXEVM,PEVM,NUMSYM] = step(H,REFSYM,RXSYM)   
%
%   EVM methods:
%
%   step     - Measure EVM of input (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create EVM measurement object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of EVM measurement object
%
%   EVM properties:
%
%   Normalization             - EVM normalization method
%   AverageConstellationPower - Average constellation power
%   PeakConstellationPower    - Peak constellation power
%   MaximumEVMOutputPort      - Enable maximum EVM measurement output
%   XPercentileEVMOutputPort  - Enable X-percentile EVM measurement output
%   XPercentileValue          - X-percentile value
%   SymbolCountOutputPort     - Enable symbol count output 
%
%   % Example:
%   %   Measure EVM of a noisy 16-QAM modulated signal. Determine the 90th
%   %   percentile point as the measured EVM value that is greater than 90%
%   %   of all measured EVM values.
%
%   hMod = comm.RectangularQAMModulator(16); 
%   hAWGN = comm.AWGNChannel('NoiseMethod',...
%           'Signal to noise ratio (SNR)',...
%           'SNR', 20, 'SignalPower', 10); 
%   % Create an EVM object, output maximum and 90-percentile EVM
%   % measurements, and symbol count
%   hEVM = comm.EVM('MaximumEVMOutputPort',true,...
%           'XPercentileEVMOutputPort', true, 'XPercentileValue', 90,...
%           'SymbolCountOutputPort', true);    
%   % Generate modulated symbols and add noise
%   refsym = step(hMod, randi([0 15], 1000, 1));
%   rxsym = step(hAWGN, refsym);
%   % Calculate measurements
%   [RMSEVM,MaxEVM,PercentileEVM,NumSym] = step(hEVM,refsym,rxsym) 
%
%   See also comm.MER, comm.ACPR, comm.CCDF.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=EVM
            %EVM    Measure error vector magnitude
            %   H = comm.EVM creates an error vector magnitude (EVM) System object, H.
            %   This object measures the amount of impairment in a modulated signal. Use
            %   the EVM object to measure RMS EVM, maximum EVM, and percentile EVM, all
            %   in percentages.
            %
            %   H = comm.EVM(Name,Value) creates an EVM object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   RMSEVM = step(H,REFSYM,RXSYM) outputs the root-mean-square EVM (in
            %   percent), RMSEVM, measured in the received signal, RXSYM, based on the
            %   reference signal, REFSYM. REFSYM and RXSYM inputs are complex column
            %   vectors of equal dimensions and data type. The data type can be double,
            %   single, signed integer, or signed fixed point with power-of-two slope
            %   and zero bias. The step method outputs the RMSEVM measurement based
            %   solely on the current input frame.
            %
            %   [RMSEVM,MAXEVM] = step(H,REFSYM,RXSYM) outputs the maximum EVM (in
            %   percent), MAXEVM, measured in the received signal, RXSYM, when you set
            %   the MaximumEVMOutputPort property to true. The step method outputs the
            %   MAXEVM measurement based on the reference signal, REFSYM. MAXEVM
            %   represents the worst-case EVM value measured in the current input frame.
            %
            %   [RMSEVM,PEVM] = step(H,REFSYM,RXSYM) outputs the percentile EVM (in
            %   percent), PEVM, measured in the received signal, RXSYM, when you set the
            %   XPercentileEVMOutputPort property to true. The step method outputs the
            %   PEVM measurement based on the reference signal, REFSYM. The object sets
            %   PEVM equal to a value just greater than the XPercentileValue percent of
            %   all the EVM values. For example, if you set the XPercentileValue
            %   property to 95, then 95% of all EVM measurements are below the PEVM
            %   value. The object calculates the persistent measurement PEVM, using all
            %   the input frames since the last reset.
            %
            %   [RMSEVM,NUMSYM] = step(H,REFSYM,RXSYM) outputs the number of symbols,
            %   NUMSYM, used to calculate the X-Percentile EVM measurements when you set
            %   the SymbolCountOutputPort property to true.
            % 
            %   All outputs of the object are of data type double.
            %
            %   You can combine optional output arguments when you set their enabling
            %   properties. Optional outputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   [RMSEVM,MAXEVM,PEVM,NUMSYM] = step(H,REFSYM,RXSYM)   
            %
            %   EVM methods:
            %
            %   step     - Measure EVM of input (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create EVM measurement object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of EVM measurement object
            %
            %   EVM properties:
            %
            %   Normalization             - EVM normalization method
            %   AverageConstellationPower - Average constellation power
            %   PeakConstellationPower    - Peak constellation power
            %   MaximumEVMOutputPort      - Enable maximum EVM measurement output
            %   XPercentileEVMOutputPort  - Enable X-percentile EVM measurement output
            %   XPercentileValue          - X-percentile value
            %   SymbolCountOutputPort     - Enable symbol count output 
            %
            %   % Example:
            %   %   Measure EVM of a noisy 16-QAM modulated signal. Determine the 90th
            %   %   percentile point as the measured EVM value that is greater than 90%
            %   %   of all measured EVM values.
            %
            %   hMod = comm.RectangularQAMModulator(16); 
            %   hAWGN = comm.AWGNChannel('NoiseMethod',...
            %           'Signal to noise ratio (SNR)',...
            %           'SNR', 20, 'SignalPower', 10); 
            %   % Create an EVM object, output maximum and 90-percentile EVM
            %   % measurements, and symbol count
            %   hEVM = comm.EVM('MaximumEVMOutputPort',true,...
            %           'XPercentileEVMOutputPort', true, 'XPercentileValue', 90,...
            %           'SymbolCountOutputPort', true);    
            %   % Generate modulated symbols and add noise
            %   refsym = step(hMod, randi([0 15], 1000, 1));
            %   rxsym = step(hAWGN, refsym);
            %   % Calculate measurements
            %   [RMSEVM,MaxEVM,PercentileEVM,NumSym] = step(hEVM,refsym,rxsym) 
            %
            %   See also comm.MER, comm.ACPR, comm.CCDF.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %AverageConstellationPower Average constellation power
        %   Specify the average constellation power (in watts) that the object
        %   uses to normalize the EVM measurements. Set this property to a
        %   positive, real scalar of data type double, single or integer. This
        %   property applies when you set the Normalization property to 'Average
        %   constellation power'. The default is 1.
        AverageConstellationPower;

        %MaximumEVMOutputPort Enable maximum EVM measurement output
        %   When you set this property to true, the step method outputs maximum
        %   EVM measurements. The maximum EVM output is the maximum EVM value
        %   measured in the current input frame. The default is false.
        MaximumEVMOutputPort;

        %Normalization EVM normalization method
        %   Specify the normalization method that the object uses in the EVM
        %   calculation as one of 'Average reference signal power' | 'Average
        %   constellation power' | 'Peak constellation power'. The default is
        %   'Average reference signal power'.
        Normalization;

        %PeakConstellationPower Peak constellation power
        %   Specify the peak constellation power (in watts) that the object uses
        %   to normalize the EVM measurements. Set this property to a positive,
        %   real scalar of data type double, single or integer. This property
        %   applies when you set the Normalization property to 'Peak constellation
        %   power'. The default is 1.
        PeakConstellationPower;

        %SymbolCountOutputPort Enable symbol count output 
        %   When you set this property to true, the step method outputs the number
        %   of accumulated symbols that have been used to calculate the
        %   X-Percentile EVM measurements since the last reset. This property
        %   applies when you set the XPercentileEVMOutputPort property to true.
        %   The default is false.
        SymbolCountOutputPort;

        %XPercentileEVMOutputPort Enable X-percentile EVM measurement output
        %   When you set this property to true, the step method outputs
        %   X-percentile EVM measurements. The X-percentile EVM measurements are
        %   persistent. They are obtained based on all the input frames since the
        %   last reset. The default is false.
        XPercentileEVMOutputPort;

        %XPercentileValue X-percentile value
        %   Specify the X-percentile value (in percent) that the object uses to
        %   calculate the Xth percentile of the EVM measurements. The Xth
        %   percentile is the EVM value below which X% of all the computed EVM
        %   values lie. Set this property to a real scalar between 0 and 100,
        %   inclusive. The data type of this property can be double, single or
        %   integer. This property applies when you set the
        %   XPercentileEVMOutputPort property to true. The default is 95.
        XPercentileValue;

    end
end
