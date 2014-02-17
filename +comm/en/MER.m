classdef MER< handle
%MER    Measure modulation error ratio
%   H = comm.MER creates a modulation error ratio (MER) System object H.
%   This object measures the signal-to-noise ratio (SNR) in digital
%   modulation applications. Use the MER object to measure MER, minimum MER,
%   and percentile MER, all in decibels.
%
%   H = comm.MER(Name,Value) creates an MER object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   MERDB = step(H,REFSYM,RXSYM) outputs MER (in dB), MERDB, measured in the
%   received signal, RXSYM, based on the reference signal, REFSYM. REFSYM,
%   and RXSYM inputs are complex column vectors of equal dimensions and data
%   type. The data type can be double, single, signed integer, or signed
%   fixed point with power-of-two slope and zero bias. The step method
%   outputs the MERDB measurement based solely on the current input frame.
%   All outputs of this object are of data type double.
%
%   [MERDB,MINMER] = step(H,REFSYM,RXSYM) outputs the minimum MER (in dB),
%   MINMER, measured in the received signal, RXSYM, when you set the
%   MinimumMEROutputPort property to true. The step method outputs the
%   MINMER measurement based on the reference signal, REFSYM. MINMER is the
%   minimum MER value measured in the current input frame.
%
%   [MERDB,PMER] = step(H,REFSYM,RXSYM) outputs the percentile MER (in dB),
%   PMER, measured in the received signal, RXSYM, when you set the
%   XPercentileMEROutputPort property to true. The step method outputs the
%   PMER measurement based on the reference signal, REFSYM. The object sets
%   PMER equal to a value just smaller than the XPercentileValue percent of
%   all the MER values. For example, if you set the XPercentileValue
%   property to 95, then 95% of all MER measurements are above the PMER
%   value. The object calculates the persistent measurement PMER, using all
%   the input frames since the last reset.
%
%   [MERDB,NUMSYM] = step(H,REFSYM,RXSYM) outputs the number of symbols,
%   NUMSYM, used to calculate the X-Percentile MER measurements when you set
%   the SymbolCountOutputPort property to true.
%
%   You can combine optional output arguments when you set their enabling
%   properties. Optional outputs must be listed in the same order as the
%   order of the enabling properties. For example,
%
%   [MERDB,MINMER,PMER,NUMSYM] = step(H,REFSYM,RXSYM)
%
%   MER methods:
%
%   step     - Measure MER of input (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create MER measurement object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of MER measurement object
%
%   MER properties:
% 
%   MinimumMEROutputPort     - Enable minimum MER measurement output
%   XPercentileMEROutputPort - Enable X-percentile MER measurement output
%   XPercentileValue         - X-percentile value
%   SymbolCountOutputPort    - Enable symbol count output
%
%   % Example:
%   %   Measure MER of a noisy 16-QAM modulated signal.  Determine 90th
%   %   percentile point, which is the value where 90% of all MER values are 
%   %   above that point
%
%   hMod = comm.RectangularQAMModulator(16);
%   hAWGN = comm.AWGNChannel('NoiseMethod',...
%                'Signal to noise ratio (SNR)',...
%                'SNR', 20, 'SignalPower', 10);  
%   % Create an MER object, output minimum and 90-percentile MER, and symbol
%   % count
%   hMER = comm.MER('MinimumMEROutputPort', true, ...
%                'XPercentileMEROutputPort', true,'XPercentileValue', 90,...
%                'SymbolCountOutputPort',true);
%   % Generate modulated symbols and add noise
%   refsym = step(hMod, randi([0 15], 1000, 1));
%   rxsym = step(hAWGN, refsym);
%   % Calculate measurements
%   [MERdB,MinMER,PercentileMER,NumSym] = step(hMER,refsym,rxsym) 
%
%   See also comm.EVM, comm.ACPR, comm.CCDF.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MER
            %MER    Measure modulation error ratio
            %   H = comm.MER creates a modulation error ratio (MER) System object H.
            %   This object measures the signal-to-noise ratio (SNR) in digital
            %   modulation applications. Use the MER object to measure MER, minimum MER,
            %   and percentile MER, all in decibels.
            %
            %   H = comm.MER(Name,Value) creates an MER object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as
            %   (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   MERDB = step(H,REFSYM,RXSYM) outputs MER (in dB), MERDB, measured in the
            %   received signal, RXSYM, based on the reference signal, REFSYM. REFSYM,
            %   and RXSYM inputs are complex column vectors of equal dimensions and data
            %   type. The data type can be double, single, signed integer, or signed
            %   fixed point with power-of-two slope and zero bias. The step method
            %   outputs the MERDB measurement based solely on the current input frame.
            %   All outputs of this object are of data type double.
            %
            %   [MERDB,MINMER] = step(H,REFSYM,RXSYM) outputs the minimum MER (in dB),
            %   MINMER, measured in the received signal, RXSYM, when you set the
            %   MinimumMEROutputPort property to true. The step method outputs the
            %   MINMER measurement based on the reference signal, REFSYM. MINMER is the
            %   minimum MER value measured in the current input frame.
            %
            %   [MERDB,PMER] = step(H,REFSYM,RXSYM) outputs the percentile MER (in dB),
            %   PMER, measured in the received signal, RXSYM, when you set the
            %   XPercentileMEROutputPort property to true. The step method outputs the
            %   PMER measurement based on the reference signal, REFSYM. The object sets
            %   PMER equal to a value just smaller than the XPercentileValue percent of
            %   all the MER values. For example, if you set the XPercentileValue
            %   property to 95, then 95% of all MER measurements are above the PMER
            %   value. The object calculates the persistent measurement PMER, using all
            %   the input frames since the last reset.
            %
            %   [MERDB,NUMSYM] = step(H,REFSYM,RXSYM) outputs the number of symbols,
            %   NUMSYM, used to calculate the X-Percentile MER measurements when you set
            %   the SymbolCountOutputPort property to true.
            %
            %   You can combine optional output arguments when you set their enabling
            %   properties. Optional outputs must be listed in the same order as the
            %   order of the enabling properties. For example,
            %
            %   [MERDB,MINMER,PMER,NUMSYM] = step(H,REFSYM,RXSYM)
            %
            %   MER methods:
            %
            %   step     - Measure MER of input (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create MER measurement object with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of MER measurement object
            %
            %   MER properties:
            % 
            %   MinimumMEROutputPort     - Enable minimum MER measurement output
            %   XPercentileMEROutputPort - Enable X-percentile MER measurement output
            %   XPercentileValue         - X-percentile value
            %   SymbolCountOutputPort    - Enable symbol count output
            %
            %   % Example:
            %   %   Measure MER of a noisy 16-QAM modulated signal.  Determine 90th
            %   %   percentile point, which is the value where 90% of all MER values are 
            %   %   above that point
            %
            %   hMod = comm.RectangularQAMModulator(16);
            %   hAWGN = comm.AWGNChannel('NoiseMethod',...
            %                'Signal to noise ratio (SNR)',...
            %                'SNR', 20, 'SignalPower', 10);  
            %   % Create an MER object, output minimum and 90-percentile MER, and symbol
            %   % count
            %   hMER = comm.MER('MinimumMEROutputPort', true, ...
            %                'XPercentileMEROutputPort', true,'XPercentileValue', 90,...
            %                'SymbolCountOutputPort',true);
            %   % Generate modulated symbols and add noise
            %   refsym = step(hMod, randi([0 15], 1000, 1));
            %   rxsym = step(hAWGN, refsym);
            %   % Calculate measurements
            %   [MERdB,MinMER,PercentileMER,NumSym] = step(hMER,refsym,rxsym) 
            %
            %   See also comm.EVM, comm.ACPR, comm.CCDF.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %MinimumMEROutputPort Enable minimum MER measurement output
        %   When you set this property to true, the step method outputs minimum
        %   MER measurements. The step method outputs the minimum MER output as
        %   the minimum MER value measured in the current input frame. The default
        %   is false.
        MinimumMEROutputPort;

        %SymbolCountOutputPort Enable symbol count output
        %   When you set this property to true, the step method outputs the number
        %   of accumulated symbols that have been used to calculate the
        %   X-Percentile MER measurements since the last reset. This property
        %   applies when you set the XPercentileMEROutputPort property to true.
        %   The default is false.
        SymbolCountOutputPort;

        %XPercentileMEROutputPort Enable X-percentile MER measurement output
        %   When you set this property to true, the step method outputs
        %   X-percentile MER measurements. The X-percentile MER measurements are
        %   persistent. They are obtained based on all the input frames since the
        %   last reset. The default is false.
        XPercentileMEROutputPort;

        %XPercentileValue X-percentile value
        %   Specify the X-percentile value (in percent) that the object uses to
        %   calculate the Xth percentile of the MER measurements. Set this
        %   property to a real scalar between 0 and 100, inclusive. The data type
        %   of this property can be double, single, or integer. This property
        %   applies when you set the XPercentileMEROutputPort property to true.
        %   The Xth percentile is the MER value above which X% of all the computed
        %   MER values lie. The default is 95.
        XPercentileValue;

    end
end
