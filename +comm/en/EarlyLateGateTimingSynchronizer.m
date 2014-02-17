classdef EarlyLateGateTimingSynchronizer< handle
%EarlyLateGateTimingSynchronizer Recover symbol timing phase using 
%early-late gate method
%   H = comm.EarlyLateGateTimingSynchronizer creates a timing phase
%   synchronizer System object, H. The object recovers the symbol timing
%   phase of the input signal using the early-late gate method. Early-late  
%   gate timing synchronization is a non-data-aided feedback method. You 
%   typically use this method for systems that use linear modulation 
%   with Nyquist pulses (raised cosine filters).
%
%   H = comm.EarlyLateGateTimingSynchronizer(Name,Value) creates an
%   early-late gate timing synchronizer object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as 
%   (Name1,Value1,...,NameN,ValueN).
%   
%   Step method syntax:
%
%   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
%   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
%   input signal X. The input X must be a double or single precision
%   complex column vector. The ideal is when the timing phase estimate 
%   is zero and the input signal has symmetric Nyquist pulses. In this
%   case, the timing error detector for the early-late gate method requires 
%   samples that span one symbol interval. 
%
%   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
%   you input a reset signal, R, that is non-zero. R must be a double
%   precision  or logical scalar. This syntax applies when you set the
%   ResetInputPort property to true.
%
%   EarlyLateGateTimingSynchronizer methods:
%
%   step     - Recover timing phase (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create early-late gate timing phase synchronizer object
%              with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of early-late gate timing phase synchronizer
%              object
%
%   EarlyLateGateTimingSynchronizer properties:
%
%   SamplesPerSymbol - Number of samples representing each symbol
%   ErrorUpdateGain  - Error update step size
%   ResetInputPort   - Enable synchronization reset input
%   ResetCondition   - Condition for timing phase recovery reset
%
%   % Example:
%   %   Recover timing phase using the early-late gate method
%
%   % Initialize some data 
%   L = 16; M = 16; numSymb = 1000; snrdB = 30;
%   R = 25; rolloff = 0.75; filtSpan = 6; g = 0.07; delay = 6.6498;
%   % Create System objects  
%   hMod = comm.RectangularQAMModulator(M, ...
%                   'NormalizationMethod', 'Average power');
%   hTxFilter = comm.RaisedCosineTransmitFilter(...
%                   'OutputSamplesPerSymbol',L,...
%                   'FilterSpanInSymbols',filtSpan,...
%                   'RolloffFactor',rolloff);
%   hDelay = dsp.VariableFractionalDelay('MaximumDelay', L);
%   hChan = comm.AWGNChannel('NoiseMethod',  ...
%                   'Signal to noise ratio (SNR)', 'SNR', snrdB, ...
%                   'SignalPower', 1/L);
%   hRxFilter = comm.RaisedCosineReceiveFilter(...
%                   'InputSamplesPerSymbol',L,...
%                   'FilterSpanInSymbols',filtSpan,...
%                   'RolloffFactor',rolloff,...
%                   'DecimationFactor',1);
%   hSync = comm.EarlyLateGateTimingSynchronizer(...
%                       'SamplesPerSymbol', L, ...
%                       'ErrorUpdateGain', g);
%   % Generate random data    
%   data = randi([0 M-1], numSymb, 1);
%   % Modulate and filter transmitter data.
%   modData = step(hMod, data);
%   filterData = step(hTxFilter, modData);
%   % Introduce a random delay and add noise
%   delayedData = step(hDelay, filterData, delay);
%   chData = step(hChan, delayedData);
%   % Filter receiver data.
%   rxData = step(hRxFilter, chData);
%   % Estimate the delay from the received signal   
%   [~, phase] = step(hSync, rxData);
%   fprintf(1, 'Actual Timing Delay: %f\n', delay);
%   fprintf(1, 'Estimated Timing Delay: %f\n', phase(end));
%
%   See also comm.GardnerTimingSynchronizer, 
%            comm.MSKTimingSynchronizer.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=EarlyLateGateTimingSynchronizer
            %EarlyLateGateTimingSynchronizer Recover symbol timing phase using 
            %early-late gate method
            %   H = comm.EarlyLateGateTimingSynchronizer creates a timing phase
            %   synchronizer System object, H. The object recovers the symbol timing
            %   phase of the input signal using the early-late gate method. Early-late  
            %   gate timing synchronization is a non-data-aided feedback method. You 
            %   typically use this method for systems that use linear modulation 
            %   with Nyquist pulses (raised cosine filters).
            %
            %   H = comm.EarlyLateGateTimingSynchronizer(Name,Value) creates an
            %   early-late gate timing synchronizer object, H, with the specified
            %   property Name set to the specified Value. You can specify additional
            %   name-value pair arguments in any order as 
            %   (Name1,Value1,...,NameN,ValueN).
            %   
            %   Step method syntax:
            %
            %   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
            %   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
            %   input signal X. The input X must be a double or single precision
            %   complex column vector. The ideal is when the timing phase estimate 
            %   is zero and the input signal has symmetric Nyquist pulses. In this
            %   case, the timing error detector for the early-late gate method requires 
            %   samples that span one symbol interval. 
            %
            %   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
            %   you input a reset signal, R, that is non-zero. R must be a double
            %   precision  or logical scalar. This syntax applies when you set the
            %   ResetInputPort property to true.
            %
            %   EarlyLateGateTimingSynchronizer methods:
            %
            %   step     - Recover timing phase (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create early-late gate timing phase synchronizer object
            %              with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of early-late gate timing phase synchronizer
            %              object
            %
            %   EarlyLateGateTimingSynchronizer properties:
            %
            %   SamplesPerSymbol - Number of samples representing each symbol
            %   ErrorUpdateGain  - Error update step size
            %   ResetInputPort   - Enable synchronization reset input
            %   ResetCondition   - Condition for timing phase recovery reset
            %
            %   % Example:
            %   %   Recover timing phase using the early-late gate method
            %
            %   % Initialize some data 
            %   L = 16; M = 16; numSymb = 1000; snrdB = 30;
            %   R = 25; rolloff = 0.75; filtSpan = 6; g = 0.07; delay = 6.6498;
            %   % Create System objects  
            %   hMod = comm.RectangularQAMModulator(M, ...
            %                   'NormalizationMethod', 'Average power');
            %   hTxFilter = comm.RaisedCosineTransmitFilter(...
            %                   'OutputSamplesPerSymbol',L,...
            %                   'FilterSpanInSymbols',filtSpan,...
            %                   'RolloffFactor',rolloff);
            %   hDelay = dsp.VariableFractionalDelay('MaximumDelay', L);
            %   hChan = comm.AWGNChannel('NoiseMethod',  ...
            %                   'Signal to noise ratio (SNR)', 'SNR', snrdB, ...
            %                   'SignalPower', 1/L);
            %   hRxFilter = comm.RaisedCosineReceiveFilter(...
            %                   'InputSamplesPerSymbol',L,...
            %                   'FilterSpanInSymbols',filtSpan,...
            %                   'RolloffFactor',rolloff,...
            %                   'DecimationFactor',1);
            %   hSync = comm.EarlyLateGateTimingSynchronizer(...
            %                       'SamplesPerSymbol', L, ...
            %                       'ErrorUpdateGain', g);
            %   % Generate random data    
            %   data = randi([0 M-1], numSymb, 1);
            %   % Modulate and filter transmitter data.
            %   modData = step(hMod, data);
            %   filterData = step(hTxFilter, modData);
            %   % Introduce a random delay and add noise
            %   delayedData = step(hDelay, filterData, delay);
            %   chData = step(hChan, delayedData);
            %   % Filter receiver data.
            %   rxData = step(hRxFilter, chData);
            %   % Estimate the delay from the received signal   
            %   [~, phase] = step(hSync, rxData);
            %   fprintf(1, 'Actual Timing Delay: %f\n', delay);
            %   fprintf(1, 'Estimated Timing Delay: %f\n', phase(end));
            %
            %   See also comm.GardnerTimingSynchronizer, 
            %            comm.MSKTimingSynchronizer.
        end

    end
    methods (Abstract)
    end
end
