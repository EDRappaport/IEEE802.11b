classdef MuellerMullerTimingSynchronizer< handle
%MuellerMullerTimingSynchronizer Recover symbol timing phase using
%Mueller-Muller method 
%   H = comm.MuellerMullerTimingSynchronizer creates a timing synchronizer
%   System object, H. The object recovers the symbol timing phase of the
%   input signal using the Mueller-Muller method. Mueller-Muller timing
%   synchronization is a decision-directed, data-aided feedback method that
%   requires prior recovery of the carrier phase. You typically use this
%   method for systems that use binary linear modulation.
%
%   H = comm.MuellerMullerTimingSynchronizer(Name,Value) creates a
%   Mueller-Muller timing recovery object, H, with the specified property
%   Name set to the specified Value. You can specify additional name-value
%   pair arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
%   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
%   input signal X. The input X must be a double or single precision complex
%   column vector. The length of X is N*K, where N is the value you specify
%   in the property SamplesPerSymbol and K is the number of symbols. The
%   output, Y, is the signal value for each symbol, which you use to make
%   symbol decisions. Y is a column vector of length K with the same data
%   type as X.
%
%   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
%   you input a reset signal, R, that is non-zero. R must be a logical or 
%   double scalar. This syntax applies when you set the ResetInputPort 
%   property to true.
%
%   MuellerMullerTimingSynchronizer methods:
%
%   step     - Recover timing phase (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Mueller-Muller timing phase synchronizer object 
%              with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Mueller-Muller timing phase synchronizer
%              object
%
%   MuellerMullerTimingSynchronizer properties:
%
%   SamplesPerSymbol - Number of samples representing each symbol
%   ErrorUpdateGain  - Error update step size
%   ResetInputPort   - Enable synchronization reset input
%   ResetCondition   - Condition for timing phase recovery reset
%
%   % Example: 
%   %   Recover timing phase using the Mueller-Muller method
%
%   % Initialize some data 
%   L = 16; M = 2; numSymb = 100; snrdB = 30;
%   R = 25; rolloff = 0.75; filtSpan = 6; g = 0.07; delay = 6.6498;
%   % Create System objects  
%   hMod = comm.DPSKModulator(M, 'PhaseRotation', 0);
%   hTxFilter = comm.RaisedCosineTransmitFilter(...
%                   'OutputSamplesPerSymbol',L,...
%                   'FilterSpanInSymbols',filtSpan,...
%                   'RolloffFactor',rolloff);
%   hDelay = dsp.VariableFractionalDelay('MaximumDelay', L);
%   hChan = comm.AWGNChannel(...
%                   'NoiseMethod',  'Signal to noise ratio (SNR)', ...
%                   'SNR', snrdB, 'SignalPower', 1/L);
%   hRxFilter = comm.RaisedCosineReceiveFilter(...
%                   'InputSamplesPerSymbol',L,...
%                   'DecimationFactor',1,...
%                   'FilterSpanInSymbols',filtSpan,...
%                   'RolloffFactor',rolloff);
%   hSync = comm.MuellerMullerTimingSynchronizer('SamplesPerSymbol', L, ...
%                   'ErrorUpdateGain', g);
%   % Generate random data    
%   data = randi([0 M-1], numSymb, 1);
%   % Modulate and filter transmitter data
%   modData = step(hMod, data);
%   filterData = step(hTxFilter, modData);
%   % Introduce a random delay.
%   delayedData = step(hDelay, filterData, delay);
%   % Add noise
%   chData = step(hChan, delayedData);
%   % Filter the receiver data
%   rxData = step(hRxFilter, chData);
%   % Estimate the delay from the received signal   
%   [~, phase] = step(hSync, rxData);
%   fprintf(1, 'Actual Timing Delay: %f\n', delay);
%   fprintf(1, 'Estimated Timing Delay: %f\n', phase(end));
%
%   See also comm.EarlyLateGateTimingSynchronizer,
%            comm.GMSKTimingSynchronizer.

 
%   Copyright 2009-2013 The MathWorks, Inc.

    methods
        function out=MuellerMullerTimingSynchronizer
            %MuellerMullerTimingSynchronizer Recover symbol timing phase using
            %Mueller-Muller method 
            %   H = comm.MuellerMullerTimingSynchronizer creates a timing synchronizer
            %   System object, H. The object recovers the symbol timing phase of the
            %   input signal using the Mueller-Muller method. Mueller-Muller timing
            %   synchronization is a decision-directed, data-aided feedback method that
            %   requires prior recovery of the carrier phase. You typically use this
            %   method for systems that use binary linear modulation.
            %
            %   H = comm.MuellerMullerTimingSynchronizer(Name,Value) creates a
            %   Mueller-Muller timing recovery object, H, with the specified property
            %   Name set to the specified Value. You can specify additional name-value
            %   pair arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %   Step method syntax:
            %
            %   [Y,PHASE] = step(H,X) performs timing phase recovery and returns the
            %   time-synchronized signal, Y, and the estimated timing phase, PHASE, for
            %   input signal X. The input X must be a double or single precision complex
            %   column vector. The length of X is N*K, where N is the value you specify
            %   in the property SamplesPerSymbol and K is the number of symbols. The
            %   output, Y, is the signal value for each symbol, which you use to make
            %   symbol decisions. Y is a column vector of length K with the same data
            %   type as X.
            %
            %   [Y,PHASE] = step(H,X,R) restarts the timing phase recovery process when
            %   you input a reset signal, R, that is non-zero. R must be a logical or 
            %   double scalar. This syntax applies when you set the ResetInputPort 
            %   property to true.
            %
            %   MuellerMullerTimingSynchronizer methods:
            %
            %   step     - Recover timing phase (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create Mueller-Muller timing phase synchronizer object 
            %              with same property values
            %   isLocked - Locked status (logical)
            %   reset    - Reset states of Mueller-Muller timing phase synchronizer
            %              object
            %
            %   MuellerMullerTimingSynchronizer properties:
            %
            %   SamplesPerSymbol - Number of samples representing each symbol
            %   ErrorUpdateGain  - Error update step size
            %   ResetInputPort   - Enable synchronization reset input
            %   ResetCondition   - Condition for timing phase recovery reset
            %
            %   % Example: 
            %   %   Recover timing phase using the Mueller-Muller method
            %
            %   % Initialize some data 
            %   L = 16; M = 2; numSymb = 100; snrdB = 30;
            %   R = 25; rolloff = 0.75; filtSpan = 6; g = 0.07; delay = 6.6498;
            %   % Create System objects  
            %   hMod = comm.DPSKModulator(M, 'PhaseRotation', 0);
            %   hTxFilter = comm.RaisedCosineTransmitFilter(...
            %                   'OutputSamplesPerSymbol',L,...
            %                   'FilterSpanInSymbols',filtSpan,...
            %                   'RolloffFactor',rolloff);
            %   hDelay = dsp.VariableFractionalDelay('MaximumDelay', L);
            %   hChan = comm.AWGNChannel(...
            %                   'NoiseMethod',  'Signal to noise ratio (SNR)', ...
            %                   'SNR', snrdB, 'SignalPower', 1/L);
            %   hRxFilter = comm.RaisedCosineReceiveFilter(...
            %                   'InputSamplesPerSymbol',L,...
            %                   'DecimationFactor',1,...
            %                   'FilterSpanInSymbols',filtSpan,...
            %                   'RolloffFactor',rolloff);
            %   hSync = comm.MuellerMullerTimingSynchronizer('SamplesPerSymbol', L, ...
            %                   'ErrorUpdateGain', g);
            %   % Generate random data    
            %   data = randi([0 M-1], numSymb, 1);
            %   % Modulate and filter transmitter data
            %   modData = step(hMod, data);
            %   filterData = step(hTxFilter, modData);
            %   % Introduce a random delay.
            %   delayedData = step(hDelay, filterData, delay);
            %   % Add noise
            %   chData = step(hChan, delayedData);
            %   % Filter the receiver data
            %   rxData = step(hRxFilter, chData);
            %   % Estimate the delay from the received signal   
            %   [~, phase] = step(hSync, rxData);
            %   fprintf(1, 'Actual Timing Delay: %f\n', delay);
            %   fprintf(1, 'Estimated Timing Delay: %f\n', phase(end));
            %
            %   See also comm.EarlyLateGateTimingSynchronizer,
            %            comm.GMSKTimingSynchronizer.
        end

    end
    methods (Abstract)
    end
end
