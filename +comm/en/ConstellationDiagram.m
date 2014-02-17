classdef ConstellationDiagram< handle
%ConstellationDiagram Display modulated symbols in the I/Q plane
%   H = comm.ConstellationDiagram returns a System object, H, that can
%   display real and complex valued floating and fixed-point signals in the
%   I/Q plane.
%
%   H = comm.ConstellationDiagram('Name', Value, ...) returns a
%   Constellation Diagram System object, H, with each specified property
%   name set to the specified value. You can specify name-value pair
%   arguments in any order as (Name 1, Value 1, Name 2, Value 2, ....).
%
%   Step method syntax:
%
%   step(H, X) displays the signal, X, in the Constellation Diagram figure.
%
%   ConstellationDiagram methods:
%
%   step     - Display signal in the Constellation Diagram figure (see above)
%   release  - Allow property value and input characteristics changes, and
%              release Constellation Diagram resources
%   clone    - Create Constellation Diagram object with same property values
%   isLocked - Display locked status (logical)
%   reset    - Clear Constellation Diagram figure
%   show     - Turn on visibility of Constellation Diagram figure
%   hide     - Turn off visibility of Constellation Diagram figure
%
%   ConstellationDiagram properties:
%
%   Name                       - Caption to display on Constellation Diagram window
%   SamplesPerSymbol           - Number of samples used to represent a symbol
%   SampleOffset               - Number of samples to skip before plotting points
%   SymbolsToDisplaySource     - Source of symbols to Display
%   SymbolsToDisplay           - Number of symbols displayed
%   ReferenceConstellation     - The ideal constellation of the input signal
%   ReferenceMarker            - Specify the marker for reference display
%   ReferenceColor             - Specify the color  for reference display
%                                constellation
%   ShowReferenceConstellation - Option to turn on the display of the reference 
%   Position                   - Scope window position in pixels
%   ShowGrid                   - Option to turn on grid
%   ShowLegend                 - Option to turn on legend 
%   ColorFading                - Option to add color fading effect
%   Title                      - Display title
%   XLimits                    - X-axis limits
%   YLimits                    - Y-axis limits
%   XLabel                     - X-axis label
%   YLabel                     - Y-axis label
%   MeasurementInterval        - The measurement interval
%   EVMNormalization           - EVM normalization 
%
%   % Example 1:
%   % Input signal has one sample per symbol:
%   hMod = comm.RectangularQAMModulator('ModulationOrder', 16); 
%   hAWGN   = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)',...
%                                  'SNR', 20);                             
%   hScope = comm.ConstellationDiagram('ReferenceConstellation', constellation(hMod),...
%                                      'XLimits', [-4 4], 'YLimits', [-4 4]);
%   d = randi([0 15], 100, 1);          % Generate data symbols
%   sym = step(hMod, d);                % Generate modulated symbols
%   rcv = step(hAWGN, sym);             % Add AWGN
%   step(hScope, rcv)                   % Step scope
%
%   % Example 2:
%   % Input signal has multiple samples per symbol, the ConstellationDiagram
%   % will decimate and plot one sample per symbol.
%   hMod = comm.RectangularQAMModulator('ModulationOrder', 16); 
%   hScope = comm.ConstellationDiagram('SamplesPerSymbol', 8, ...
%            'ReferenceConstellation', constellation(hMod), ...
%            'XLimits', [-4 4], 'YLimits', [-4 4]);
%   hAWGN   = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)',...
%            'SNR', 20);                         
%   % Create a normalized upsampling filter
%   hInterp = comm.RaisedCosineTransmitFilter('Shape', 'Normal',...
%             'OutputSamplesPerSymbol',hScope.SamplesPerSymbol,...
%             'FilterSpanInSymbols',8,'RolloffFactor',0.5,'Gain',2.6457);
%   d = randi([0 15], 1000, 1);         % Generate data symbols
%   sym = step(hMod, d);                % Generate modulated symbols
%   xmt = step(hInterp, sym);           % Upsample
%   rcv = step(hAWGN, xmt);             % Add AWGN
%   step(hScope, rcv)                   % Step scope
%

 
%   Copyright 2012-2013 The MathWorks, Inc.

    methods
        function out=ConstellationDiagram
            %ConstellationDiagram Display modulated symbols in the I/Q plane
            %   H = comm.ConstellationDiagram returns a System object, H, that can
            %   display real and complex valued floating and fixed-point signals in the
            %   I/Q plane.
            %
            %   H = comm.ConstellationDiagram('Name', Value, ...) returns a
            %   Constellation Diagram System object, H, with each specified property
            %   name set to the specified value. You can specify name-value pair
            %   arguments in any order as (Name 1, Value 1, Name 2, Value 2, ....).
            %
            %   Step method syntax:
            %
            %   step(H, X) displays the signal, X, in the Constellation Diagram figure.
            %
            %   ConstellationDiagram methods:
            %
            %   step     - Display signal in the Constellation Diagram figure (see above)
            %   release  - Allow property value and input characteristics changes, and
            %              release Constellation Diagram resources
            %   clone    - Create Constellation Diagram object with same property values
            %   isLocked - Display locked status (logical)
            %   reset    - Clear Constellation Diagram figure
            %   show     - Turn on visibility of Constellation Diagram figure
            %   hide     - Turn off visibility of Constellation Diagram figure
            %
            %   ConstellationDiagram properties:
            %
            %   Name                       - Caption to display on Constellation Diagram window
            %   SamplesPerSymbol           - Number of samples used to represent a symbol
            %   SampleOffset               - Number of samples to skip before plotting points
            %   SymbolsToDisplaySource     - Source of symbols to Display
            %   SymbolsToDisplay           - Number of symbols displayed
            %   ReferenceConstellation     - The ideal constellation of the input signal
            %   ReferenceMarker            - Specify the marker for reference display
            %   ReferenceColor             - Specify the color  for reference display
            %                                constellation
            %   ShowReferenceConstellation - Option to turn on the display of the reference 
            %   Position                   - Scope window position in pixels
            %   ShowGrid                   - Option to turn on grid
            %   ShowLegend                 - Option to turn on legend 
            %   ColorFading                - Option to add color fading effect
            %   Title                      - Display title
            %   XLimits                    - X-axis limits
            %   YLimits                    - Y-axis limits
            %   XLabel                     - X-axis label
            %   YLabel                     - Y-axis label
            %   MeasurementInterval        - The measurement interval
            %   EVMNormalization           - EVM normalization 
            %
            %   % Example 1:
            %   % Input signal has one sample per symbol:
            %   hMod = comm.RectangularQAMModulator('ModulationOrder', 16); 
            %   hAWGN   = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)',...
            %                                  'SNR', 20);                             
            %   hScope = comm.ConstellationDiagram('ReferenceConstellation', constellation(hMod),...
            %                                      'XLimits', [-4 4], 'YLimits', [-4 4]);
            %   d = randi([0 15], 100, 1);          % Generate data symbols
            %   sym = step(hMod, d);                % Generate modulated symbols
            %   rcv = step(hAWGN, sym);             % Add AWGN
            %   step(hScope, rcv)                   % Step scope
            %
            %   % Example 2:
            %   % Input signal has multiple samples per symbol, the ConstellationDiagram
            %   % will decimate and plot one sample per symbol.
            %   hMod = comm.RectangularQAMModulator('ModulationOrder', 16); 
            %   hScope = comm.ConstellationDiagram('SamplesPerSymbol', 8, ...
            %            'ReferenceConstellation', constellation(hMod), ...
            %            'XLimits', [-4 4], 'YLimits', [-4 4]);
            %   hAWGN   = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)',...
            %            'SNR', 20);                         
            %   % Create a normalized upsampling filter
            %   hInterp = comm.RaisedCosineTransmitFilter('Shape', 'Normal',...
            %             'OutputSamplesPerSymbol',hScope.SamplesPerSymbol,...
            %             'FilterSpanInSymbols',8,'RolloffFactor',0.5,'Gain',2.6457);
            %   d = randi([0 15], 1000, 1);         % Generate data symbols
            %   sym = step(hMod, d);                % Generate modulated symbols
            %   xmt = step(hInterp, sym);           % Upsample
            %   rcv = step(hAWGN, xmt);             % Add AWGN
            %   step(hScope, rcv)                   % Step scope
            %
        end

        function LatePropertyCheck(in) %#ok<MANU>
            % Some properties have restrictions depending on each other.
            % Do the validation check for these properties in the setup stage
        end

        function getNumInputsImpl(in) %#ok<MANU>
        end

        function getScopeCfg(in) %#ok<MANU>
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function updateImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %ColorFading Option to add color fading effect
        %   When this property is set to true, the points in the display fade as 
        %   the interval of time after they are first plotted increases. This is
        %   for animation that resembles an oscilloscope. The default value of 
        %   this property is false. This property is tunable.
        ColorFading;

        %EVMNormalization EVM normalization
        %    Specify the normalization method that the object uses in the EVM
        %    calculation as one of 'Average constellation power' or 
        %    'Peak constellation power'. The default value of this property is 
        %    'Average constellation power'. This property is tunable.
        EVMNormalization;

        %MeasurementInterval The measurement interval
        %   When the input signal contains one sample per symbol and the reference 
        %   constellation is provided, this System object can measure the signal 
        %   quality in terms of EVM and MER. The measurement panel can be evoked by 
        %   clicking on the Signal Quality button. This property specifies the window 
        %   length for the measurement. The value of this property must be less 
        %   or equal to the value of SymbolsToDisplay property.  If the number 
        %   of data input is less than MeasurementInterval, it will wait for 
        %   more data before measurement can be calculated. The default value 
        %   of this property is 2. This property is tunable.
        MeasurementInterval;

        %Name Caption to display on Constellation Diagram window
        %   Specify the caption to display on the Constellation Diagram window
        %   as any string. The default value of this property is 
        %   'Constellation Diagram'. This property is tunable.
        Name;

        %ReferenceColor  Specify the color for reference display. The default 
        %   value of this property is [1 0 0] (red). This property is tunable.
        ReferenceColor;

        %ReferenceConstellation The ideal constellation of the input signal
        %   The object can display the ReferenceConstellation with its own 
        %   marker. To obtain the signal quality measurement, you must set the 
        %   ReferenceConstellation property to a valid value. The default value 
        %   of this property is:
        %   [0.7071+0.7071i  -0.7071+0.7071i  -0.7071-0.7071i 0.7070-0.7071i]. 
        %   This property is tunable.
        ReferenceConstellation;

        %ReferenceMarker Specify the marker for reference display The default
        %   value of this property  is '+'. This property is tunable.
        ReferenceMarker;

        %SampleOffset Number of samples to skip before plotting points
        %   A nonnegative integer less than the number of samples per symbol. 
        %   This value specifies the number of samples to skip when decimating
        %   the input signal. The default value of this property is 0. This 
        %   property is tunable.
        SampleOffset;

        %SamplesPerSymbol Number of samples used to represent a symbol
        %   Specify the number of samples that represent a symbol. When the 
        %   SamplesPerSymbol property is greater than 1, the object downsamples 
        %   and plots the input signal. The default value of this property is 1. 
        %   This property is tunable.
        SamplesPerSymbol;

        %ShowGrid Option to display grid
        %   Set this property to true to display grid. The default value of 
        %   this property is false. This property is tunable.
        ShowGrid;

        %ShowLegend Option to display legend
        %   Set this property to true to display legend. The default value of 
        %   this property is false. This property is tunable.
        ShowLegend;

        %ShowReferenceConstellation  Option to display the reference constellation 
        %   Set this property to true to show reference constellation on the 
        %   display. The default value of this property is true. This property 
        %   is tunable.
        ShowReferenceConstellation;

        %SymbolsToDisplay The maximum number of symbols that can be displayed
        %  when input signal is long. This property is applicable when the
        %  SymbolsToDisplaySource property value is 'Property'. Always plot the
        %  latest SymbolsToDisplay symbols. The default value of this property
        %  is 256. This property is tunable.
        SymbolsToDisplay;

        %SymbolsToDisplaySource Source of symbols to display
        %   Specify the source of symbols to display as one of 
        %   [{'Input frame length'} | 'Property']. When SymbolsToDisplaySource
        %   is set to 'Input frame length' ConstellationDiagram calculates the
        %   number of symbols to display as the input frame length divided by
        %   the value of the SamplesPerSymbol property.
        %
        %  When this property is set to 'Property', the maximum number of
        %  symbols to display is the value of the SymbolsToDisplay property.
        %  This property is tunable.
        SymbolsToDisplaySource;

        %Title Display title
        %   Specify the display title as a string. The default value of this 
        %   property is ''. This property is tunable.
        Title;

        %XLabel X-axis label
        %   Specify the x-axis label as a string. The default value of this
        %   property is 'In-phase Amplitude'. This property is tunable.
        XLabel;

        %XLimits X-axis limits
        %   Specify the x-axis limits as a two-element numeric vector: 
        %   [xmin xmax]. The default value of this property is [-1.375 1.375]. 
        %   This property is tunable
        XLimits;

        %YLabel Y-axis label
        %   Specify the y-axis label as a string. The default value of this
        %   property is 'Quadrature Amplitude'. This property is tunable.
        YLabel;

        %YLimits Y-axis limits
        %   Specify the y-axis limits as a two-element numeric vector: 
        %   [ymin ymax]. The default value of this property is [-1.375 1.375]. 
        %   This property is tunable
        YLimits;

    end
end
