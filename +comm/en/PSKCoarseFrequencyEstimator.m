classdef PSKCoarseFrequencyEstimator< handle
%PSKCoarseFrequencyEstimator Estimate frequency offset for a PSK signal
%   H = comm.PSKCoarseFrequencyEstimator creates a PSK coarse frequency
%   offset estimator object, H.  This object uses an open-loop technique to
%   estimate the carrier frequency offset in a received PSK signal.
%
%   H = comm.PSKCoarseFrequencyEstimator(Name,Value) creates a PSK coarse
%   frequency offset estimator object, H, with the specified property Name
%   set to the specified Value. You can specify additional name-value pair
%   arguments in any order as (Name1,Value1,...,NameN,ValueN).
%
%
%   Step method syntax:
%
%   Y = step(H,X) estimates the carrier frequency offset of the input X and
%   returns the result in Y.  X must be a complex column vector of data
%   type double.  The step method outputs the estimate Y as a scalar of
%   type double.
%
%   PSKCoarseFrequencyEstimator methods:
%
%   step      - Estimate the carrier frequency offset of input signal
%   release   - Allow property value and input characteristics changes
%   clone     - Create offset estimator object with same property values
%   isLocked  - Locked status (logical)
%   reset     - Reset states of PSKCoarseFrequencyEstimator object
%
%   PSKCoarseFrequencyEstimator properties:
%
%   ModulationOrder     - Modulation order
%   Algorithm           - Estimation algorithm to be used
%   FrequencyResolution - Desired frequency resolution of estimate (Hz)
%   MaximumOffset       - Maximum measurable frequency offset (Hz)
%   SampleRate          - Sample rate (Hz)
%   
%   % Example:
%   %   Correct for a -150 Hz frequency offset in a QPSK signal
% 
%   % Create QPSK modulator
%   hMod = comm.QPSKModulator;
%   % Create a square root raised cosine transmit filter
%   hTxFilter = comm.RaisedCosineTransmitFilter(...
%       'RolloffFactor',          0.2, ...
%       'FilterSpanInSymbols',    8,   ...
%       'OutputSamplesPerSymbol', 4);
%   % Create a frequency offset object to create the offset
%   hPFOError = comm.PhaseFrequencyOffset(...
%       'FrequencyOffset', -150, ...
%       'SampleRate',      4000);
%   % Create an AWGN channel
%   hAWGN = comm.AWGNChannel(...
%       'NoiseMethod', 'Signal to noise ratio (SNR)', ...
%       'SNR', 10);
%   % Create a square root raised cosine receive filter
%   hRxFilter = comm.RaisedCosineReceiveFilter(...
%       'RolloffFactor',         0.5, ...
%       'FilterSpanInSymbols',   8,   ...
%       'InputSamplesPerSymbol', 4,   ...
%       'DecimationFactor',      2);
%   % Create a coarse frequency estimator
%   hFreqEst = comm.PSKCoarseFrequencyEstimator(...
%       'SampleRate',          4000/2, ...
%       'FrequencyResolution', 1);
%   % Create a frequency offset object to correct the offset
%   hPFOCorrect = comm.PhaseFrequencyOffset(...
%       'FrequencyOffsetSource', 'Input port', ...
%       'SampleRate',            4000/2);
%  
%   modData    = step(hMod, randi([0 3], 2048, 1));  % generate QPSK signal
%   txFiltData = step(hTxFilter, modData);           % tx filter
%   noisyData  = step(hAWGN, txFiltData);            % add noise
%   offsetData = step(hPFOError, noisyData);         % generate offset
%   rxFiltData = step(hRxFilter, offsetData);        % rx filter
%   % Plot received spectrum
%   FFTRxData  = fftshift(10*log10(abs(fft(rxFiltData))));
%   df = 2000/4096;  freqRangeRx = (-1000:df:1000-df)';
%   figure; plot(freqRangeRx, FFTRxData);
%   title('Received Data'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
%   pos = get(gcf, 'Position');
%
%   estFreqOffset   = step(hFreqEst, rxFiltData)     % estimate offset
%   compensatedData = step(hPFOCorrect, rxFiltData, ...
%       -estFreqOffset);                             % compensate offset
%   % Plot compensated spectrum
%   FFTCompData     = fftshift(10*log10(abs(fft(compensatedData))));
%   figure; plot(freqRangeRx, FFTCompData);
%   title('Frequency Compensated Data')
%   xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
%   set(gcf, 'Position', pos+[30 -30 0 0]);
%  
%   See also dsp.FFT, comm.PhaseFrequencyOffset.

 
%   Copyright 2013 The MathWorks, Inc.

    methods
        function out=PSKCoarseFrequencyEstimator
            %PSKCoarseFrequencyEstimator Estimate frequency offset for a PSK signal
            %   H = comm.PSKCoarseFrequencyEstimator creates a PSK coarse frequency
            %   offset estimator object, H.  This object uses an open-loop technique to
            %   estimate the carrier frequency offset in a received PSK signal.
            %
            %   H = comm.PSKCoarseFrequencyEstimator(Name,Value) creates a PSK coarse
            %   frequency offset estimator object, H, with the specified property Name
            %   set to the specified Value. You can specify additional name-value pair
            %   arguments in any order as (Name1,Value1,...,NameN,ValueN).
            %
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) estimates the carrier frequency offset of the input X and
            %   returns the result in Y.  X must be a complex column vector of data
            %   type double.  The step method outputs the estimate Y as a scalar of
            %   type double.
            %
            %   PSKCoarseFrequencyEstimator methods:
            %
            %   step      - Estimate the carrier frequency offset of input signal
            %   release   - Allow property value and input characteristics changes
            %   clone     - Create offset estimator object with same property values
            %   isLocked  - Locked status (logical)
            %   reset     - Reset states of PSKCoarseFrequencyEstimator object
            %
            %   PSKCoarseFrequencyEstimator properties:
            %
            %   ModulationOrder     - Modulation order
            %   Algorithm           - Estimation algorithm to be used
            %   FrequencyResolution - Desired frequency resolution of estimate (Hz)
            %   MaximumOffset       - Maximum measurable frequency offset (Hz)
            %   SampleRate          - Sample rate (Hz)
            %   
            %   % Example:
            %   %   Correct for a -150 Hz frequency offset in a QPSK signal
            % 
            %   % Create QPSK modulator
            %   hMod = comm.QPSKModulator;
            %   % Create a square root raised cosine transmit filter
            %   hTxFilter = comm.RaisedCosineTransmitFilter(...
            %       'RolloffFactor',          0.2, ...
            %       'FilterSpanInSymbols',    8,   ...
            %       'OutputSamplesPerSymbol', 4);
            %   % Create a frequency offset object to create the offset
            %   hPFOError = comm.PhaseFrequencyOffset(...
            %       'FrequencyOffset', -150, ...
            %       'SampleRate',      4000);
            %   % Create an AWGN channel
            %   hAWGN = comm.AWGNChannel(...
            %       'NoiseMethod', 'Signal to noise ratio (SNR)', ...
            %       'SNR', 10);
            %   % Create a square root raised cosine receive filter
            %   hRxFilter = comm.RaisedCosineReceiveFilter(...
            %       'RolloffFactor',         0.5, ...
            %       'FilterSpanInSymbols',   8,   ...
            %       'InputSamplesPerSymbol', 4,   ...
            %       'DecimationFactor',      2);
            %   % Create a coarse frequency estimator
            %   hFreqEst = comm.PSKCoarseFrequencyEstimator(...
            %       'SampleRate',          4000/2, ...
            %       'FrequencyResolution', 1);
            %   % Create a frequency offset object to correct the offset
            %   hPFOCorrect = comm.PhaseFrequencyOffset(...
            %       'FrequencyOffsetSource', 'Input port', ...
            %       'SampleRate',            4000/2);
            %  
            %   modData    = step(hMod, randi([0 3], 2048, 1));  % generate QPSK signal
            %   txFiltData = step(hTxFilter, modData);           % tx filter
            %   noisyData  = step(hAWGN, txFiltData);            % add noise
            %   offsetData = step(hPFOError, noisyData);         % generate offset
            %   rxFiltData = step(hRxFilter, offsetData);        % rx filter
            %   % Plot received spectrum
            %   FFTRxData  = fftshift(10*log10(abs(fft(rxFiltData))));
            %   df = 2000/4096;  freqRangeRx = (-1000:df:1000-df)';
            %   figure; plot(freqRangeRx, FFTRxData);
            %   title('Received Data'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
            %   pos = get(gcf, 'Position');
            %
            %   estFreqOffset   = step(hFreqEst, rxFiltData)     % estimate offset
            %   compensatedData = step(hPFOCorrect, rxFiltData, ...
            %       -estFreqOffset);                             % compensate offset
            %   % Plot compensated spectrum
            %   FFTCompData     = fftshift(10*log10(abs(fft(compensatedData))));
            %   figure; plot(freqRangeRx, FFTCompData);
            %   title('Frequency Compensated Data')
            %   xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
            %   set(gcf, 'Position', pos+[30 -30 0 0]);
            %  
            %   See also dsp.FFT, comm.PhaseFrequencyOffset.
        end

        function isInactivePropertyImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

        function validatePropertiesImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %Algorithm Estimation algorithm to be used
        %   Specify the estimation algorithm as one of 'FFT-based' or
        %   'Correlation-based'. The default is 'FFT-based'.
        Algorithm;

        %MaximumOffset Maximum measurable frequency offset (Hz)
        %   Specify the maximum measurable frequency offset as a positive, real
        %   scalar of data type double.  This property is active only if the
        %   'Algorithm' property is set to 'Correlation-based'.  This value must
        %   be less than SampleRate / ModulationOrder.  It is
        %   recommended that MaximumOffset be less than or equal to
        %   SampleRate/(4*ModulationOrder).  The default is 0.05.
        MaximumOffset;

        %ModulationOrder Modulation order
        %   Specify the modulation order of the PSK signal as a positive, real
        %   scalar of data type double.  This value must be a positive power of
        %   2.  The default is 4.
        ModulationOrder;

    end
end
