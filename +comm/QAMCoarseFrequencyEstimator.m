classdef QAMCoarseFrequencyEstimator < comm.internal.CoarseFrequencyEstimatorBase
%QAMCoarseFrequencyEstimator Estimate frequency offset for a QAM signal
%   H = comm.QAMCoarseFrequencyEstimator creates a rectangular QAM coarse
%   frequency offset estimator object, H.  This object uses an open-loop,
%   FFT-based technique to estimate the carrier frequency offset in a
%   received rectangular QAM signal.
%
%   H = comm.QAMCoarseFrequencyEstimator(Name,Value) creates a rectangular
%   QAM coarse frequency offset estimator object, H, with the specified
%   property Name set to the specified Value. You can specify additional
%   name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%
%   Step method syntax:
%
%   Y = step(H,X) estimates the carrier frequency offset of the input X and
%   returns the result in Y.  X must be a complex column vector of data
%   type double.  The step method outputs the estimate Y as a scalar of
%   type double.
%
%
%   QAMCoarseFrequencyEstimator methods:
%
%   step     - Estimate the carrier frequency offset of input signal
%   release  - Allow property value and input characteristics changes
%   clone    - Create offset estimator object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of QAMCoarseFrequencyEstimator object
%
%   QAMCoarseFrequencyEstimator properties:
%
%   FrequencyResolution - Desired frequency resolution of estimate (Hz)
%   SampleRate          - Sample rate (Hz)
%   
%   % Example:
%   %   Correct for a -150 Hz frequency offset in a 16QAM signal
% 
%   % Create 16QAM modulator
%   hMod = comm.RectangularQAMModulator(16);
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
%   hFreqEst = comm.QAMCoarseFrequencyEstimator(...
%       'SampleRate',          4000/2, ...
%       'FrequencyResolution', 1);
%   % Create a frequency offset object to correct the offset
%   hPFOCorrect = comm.PhaseFrequencyOffset(...
%       'FrequencyOffsetSource', 'Input port', ...
%       'SampleRate',            4000/2);
%  
%   modData    = step(hMod, randi([0 15], 2048, 1));  % generate 16QAM signal
%   txFiltData = step(hTxFilter, modData);            % tx filter
%   noisyData  = step(hAWGN, txFiltData);             % add noise
%   offsetData = step(hPFOError, noisyData);          % generate offset
%   rxFiltData = step(hRxFilter, offsetData);         % rx filter
%   % Plot received spectrum
%   FFTRxData  = fftshift(10*log10(abs(fft(rxFiltData))));
%   df = 2000/4096;  freqRangeRx = (-1000:df:1000-df)';
%   figure; plot(freqRangeRx, FFTRxData);
%   title('Received Data'); xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
%   pos = get(gcf, 'Position');
%
%   estFreqOffset   = step(hFreqEst, rxFiltData)      % estimate offset
%   compensatedData = step(hPFOCorrect, rxFiltData, ...
%       -estFreqOffset);                              % compensate offset
%   % Plot compensated spectrum
%   FFTCompData     = fftshift(10*log10(abs(fft(compensatedData))));
%   figure; plot(freqRangeRx, FFTCompData);
%   title('Frequency Compensated Data'); 
%   xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
%   set(gcf, 'Position', pos+[30 -30 0 0]);
%  
%   See also dsp.FFT, comm.PhaseFrequencyOffset.

%   Copyright 2013 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

methods
  % CONSTRUCTOR
  function obj = QAMCoarseFrequencyEstimator(varargin)
    obj@comm.internal.CoarseFrequencyEstimatorBase;
    setProperties(obj, nargin, varargin{:});
  end
  
end

methods(Access = protected)
  
  function estFreqOffset = stepImpl(obj, x)
    % Raise the input signal to the fourth power by setting the exponent
    % and calling the base class method.
    exponent  = 4;
    
    estFreqOffset = FFTEstimateOffset(obj, x, exponent);
  end
  
end

end

% EOF