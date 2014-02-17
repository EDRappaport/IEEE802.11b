classdef (Hidden) CoarseFrequencyEstimatorBase < matlab.System
%CoarseFrequencyEstimatorBase Base class for
%PSKCoarseFrequencyEstimator and QAMCoarseFrequencyEstimator
%
%   See also dsp.FFT, comm.PhaseFrequencyOffset.

%   Copyright 2013 The MathWorks, Inc.

%#codegen
%#ok<*EMCLS>

properties (Nontunable)
  %FrequencyResolution Desired frequency resolution (Hz)
  %   Specify the desired frequency resolution for offset frequency
  %   estimation as a positive, real scalar of data type double.  This
  %   property establishes the FFT length used to perform spectral
  %   analysis, and must be less than or equal to half the SampleRate
  %   property.  The default is 0.001.
  FrequencyResolution = 0.001
  %SampleRate Sample rate (Hz)
  %   Specify the sample rate in samples per second as a positive, real
  %   scalar of data type double.  The default is 1.
  SampleRate = 1
end

properties(Access = protected, Nontunable)
    pFFTLength   % FFT length
    pFFT         % FFT calculation object
end

methods
  % CONSTRUCTOR
  function obj = CoarseFrequencyEstimatorBase(varargin)
    setProperties(obj, nargin, varargin{:});
  end
  
  % Set properties validation
  function set.SampleRate(obj, value)      
    validateattributes( value, { 'double' }, ...
      { 'real', 'positive', 'scalar', 'finite', 'nonnan', 'nonempty'}, ...
      '', 'SampleRate');%#ok<EMCA>
    obj.SampleRate = value;
  end
  
  function set.FrequencyResolution(obj, value)
    validateattributes( value, { 'double' }, ...
      { 'real', 'positive', 'scalar', 'finite', 'nonnan', 'nonempty'}, ...
      '', 'FrequencyResolution');%#ok<EMCA>
    obj.FrequencyResolution = value;
  end
  
end

methods(Access = protected)
  function validatePropertiesImpl(obj)    
    coder.internal.errorIf ...
      (obj.SampleRate < 2*obj.FrequencyResolution, ...
      ('comm:CoarseFrequencyEstimatorBase:SampleRateTooSmall'))
  end
  
  function validateInputsImpl(~,x)    
    % Input must be complex
    if isempty(coder.target)
      coder.internal.errorIf(isreal(x), ...
        'comm:CoarseFrequencyEstimatorBase:invalidComplexity');
    end
    coder.internal.errorIf(~isfloat(x), ...
      'MATLAB:system:invalidInputDataType','X','floating-point');
        
    % Must be a single channel column vector
    coder.internal.errorIf(~iscolumn(x) || isscalar(x) || isempty(x), ...
      'MATLAB:system:inputMustBeColVector','X');
  end
  
  function flag = isInputSizeLockedImpl(~,~)
    flag = true;
  end
  
  function flag = isInputComplexityLockedImpl(~,~)
    flag = true;
  end
  
  function flag = isOutputComplexityLockedImpl(~,~)
    flag = true;
  end
    
  function setupImpl(obj, ~)
    % Calculate FFT length.  Use a power of 2.
    obj.pFFTLength = 2 ^ nextpow2(obj.SampleRate / obj.FrequencyResolution);
    
    % Create FFT System object
    obj.pFFT = dsp.FFT(...
        'FFTLengthSource', 'Property', ...
        'FFTLength', obj.pFFTLength);
  end
  
  function estFreqOffset = FFTEstimateOffset(obj, x, exponent)
    % Raise the input signal to the appropriate exponent
    raisedSignal = x .^ exponent;
    
    % Correctly set the length of the exponentiated signal for the FFT by
    % either zero padding or averaging over multiple FFT lengths.
    
    % Calculate FFT vector, which may be averaged
    sigLength = size(raisedSignal,1);
    numAvgs = floor(sigLength/obj.pFFTLength);
    if (floor(sigLength/obj.pFFTLength) ~= (sigLength/obj.pFFTLength))
      numAvgs = numAvgs + 1;
    end
    FFTSig = complex(zeros(obj.pFFTLength,1));
    for idxAvgs = 0 : numAvgs-1
      if sigLength < obj.pFFTLength
        newRaisedSignal = complex(zeros(obj.pFFTLength,1));
        newRaisedSignal(1:sigLength) = ...
          raisedSignal((idxAvgs*obj.pFFTLength)+1 : end);
      else
        newRaisedSignal = ...
          raisedSignal((idxAvgs*obj.pFFTLength) + (1:obj.pFFTLength));
        sigLength       = sigLength - obj.pFFTLength;
      end
      FFTSig = (idxAvgs*FFTSig + step(obj.pFFT,newRaisedSignal));
    end
    FFTSig = FFTSig / numAvgs;
    
    % Find offset index
    [~, maxIdx] = max(fftshift(abs(FFTSig)));
    offsetIdx = maxIdx - obj.pFFTLength/2;  % translate to -Fs/2 : Fs/2
      
    % Map offset index to a frequency value.
    actDeltaFreq  = obj.SampleRate / obj.pFFTLength;
    estFreqOffset = actDeltaFreq * offsetIdx / exponent;
  end
  
  function resetImpl(obj)
    reset(obj.pFFT);
  end
  
  function releaseImpl(obj)
    release(obj.pFFT);
  end
  
  function s = saveObjectImpl(obj)
    s = saveObjectImpl@matlab.System(obj);
    if isLocked(obj)
      % Public properties handled automatically
      s.pFFT       = matlab.System.saveObject(obj.pFFT);
      s.pFFTLength = obj.pFFTLength;
    end
  end

  function loadObjectImpl(obj, s, wasLocked)
    if wasLocked
      % Public properties handled automatically
      obj.pFFT       = matlab.System.loadObject(s.pFFT);
      obj.pFFTLength = s.pFFTLength;
    end
    % Call the base class method
    loadObjectImpl@matlab.System(obj, s);
  end
  
end

end

% EOF

