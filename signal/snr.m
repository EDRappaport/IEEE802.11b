function [r, noisePow] = snr(varargin)
%SNR    Signal to Noise Ratio
%   R = SNR(X, Y) computes the signal to noise ratio (SNR) in dB, by
%   computing the ratio of the summed squared magnitude of the signal, X,
%   to the summed squared magnitude of the noise, Y, where Y has the same
%   dimensions as X.  Use this form of SNR when your input signal is not
%   sinusoidal and you have an estimate of the noise.
%
%   R = SNR(X) computes the signal to noise ratio (SNR), in dBc, of
%   the real sinusoidal input signal X.  The computation is performed over
%   a periodogram of the same length as the input using a Kaiser window
%   and excludes the power of first six harmonics (including the
%   fundamental).
%
%   R = SNR(X, Fs, N) computes the signal to noise ratio (SNR) in dBc, of
%   the real sinusoidal input signal, X, with sampling rate, Fs, and number
%   of harmonics, N, to exclude from computation when computing SNR.  The
%   default value of Fs is 1.  The default value of N is 6 and includes the
%   fundamental frequency.
% 
%   R = SNR(Pxx, F, 'psd') specifies the input as a one-sided PSD estimate,
%   Pxx, of a real signal.   F is a vector of frequencies that corresponds
%   to the vector of Pxx estimates.  The computation of noise excludes the
%   first six harmonics (including the fundamental).
% 
%   R = SNR(Pxx, F, N, 'psd') specifies the number of harmonics, N, to
%   exclude when computing SNR.  The default value of N is 6 and includes
%   the fundamental frequency.
%
%   R = SNR(Sxx, F, RBW, 'power') specifies the input as a one-sided power
%   spectrum, Sxx, of a real signal.  RBW is the resolution bandwidth over
%   which each power estimate is integrated.
% 
%   R = SNR(Sxx, F, RBW, N, 'power') specifies the number of harmonics, N,
%   to exclude when computing SNR.  The default value of N is 6 and
%   includes the fundamental frequency.
% 
%   [R, NOISEPOW] = SNR(...) also returns the total noise power of the non-
%   harmonic components of the signal.
%
%   % Example 1:
%   %   Compute the SNR of a 2 second 20ms rectangular pulse sampled at
%   %   10 kHz in the presence of gaussian noise
%
%   Tpulse = 20e-3; Fs = 10e3;
%   x = rectpuls((-1:1/Fs:1),Tpulse);
%   y = 0.00001*randn(size(x));
%   s = x + y;
%   pulseSNR = snr(x,s-x)
%
%   % Example 2:
%   %   Compute the SNR of a 2.5 kHz distorted sinusoid sampled at 48 kHz
%   load('sineex.mat','x','Fs');
%   sineSNR = snr(x,Fs)
%
%   % Example 3:
%   %   Generate the periodogram of a 2.5 kHz distorted sinusoid sampled
%   %   at 48 kHz and measure the SNR (in dB)
%   load('sineex.mat','x','Fs');
%   w = kaiser(numel(x),38);
%   [Sxx, F] = periodogram(x,w,numel(x),Fs,'power');
%
%   % Measure SNR on the power spectrum
%   rbw = enbw(w,Fs);
%   sineSNR = snr(Sxx,F,rbw,'power')
%
%   See also SINAD THD SFDR TOI.

%   Copyright 2013 The MathWorks, Inc.
narginchk(1,5);


% handle canonical definition of SNR
if nargin == 2 && isequal(size(varargin{1}), size(varargin{2}))
  [r, noisePow] = sampleSNR(varargin{1}, varargin{2});
  return
end

% look for psd or power window compensation flags
[esttype, varargin] = psdesttype({'psd','power','time'},'time',varargin);

switch esttype
  case 'psd'
    [r, noisePow] = psdSNR(varargin{:});
  case 'power'
    [r, noisePow] = powerSNR(varargin{:});
  case 'time'
    [r, noisePow] = timeSNR(varargin{:});
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = sampleSNR(x, y)
signalPow = rssq(x(:)).^2;
noisePow  = rssq(y(:)).^2;
r = 10 * log10(signalPow / noisePow);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = timeSNR(x, fs, nHarm)

% force column vector before checking attributes
if max(size(x)) == numel(x)
  x = x(:);
end
  
validateattributes(x,{'numeric'},{'real','finite','vector'}, ...
  'snr','x',1);

if nargin > 1
  validateattributes(fs, {'numeric'},{'real','finite','scalar','positive'}, ...
    'snr','Fs',2);
else
  fs = 1;
end

if nargin > 2
  validateattributes(nHarm,{'numeric'},{'integer','finite','positive','scalar','>',1}, ...
    'snr','N',3);
else
  nHarm = 6;
end

% remove DC component
x = x - mean(x);

n = length(x);

% use Kaiser window to reduce effects of leakage
w = kaiser(n,38);
rbw = enbw(w,fs);
[Pxx, F] = periodogram(x,w,n,fs,'psd');
[r, noisePow] = computeSNR(Pxx, F, rbw, nHarm);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = powerSNR(Sxx, F, rbw, nHarm)

if F(1)~=0
  error(message('signal:snr:MustBeOneSidedSxx'));
end

% ensure specified RBW is larger than a bin width
df = mean(diff(F));

validateattributes(rbw,{'double'},{'real','finite','positive','scalar','>=',df}, ...
    'snr','RBW',3);

if nargin > 3
  validateattributes(nHarm,{'double'},{'integer','finite','positive','scalar','>',1}, ...
    'snr','N',4);
else
  nHarm = 6;
end

[r, noisePow] = computeSNR(Sxx/rbw, F, rbw, nHarm);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = psdSNR(Pxx, F, nHarm)

if F(1)~=0
  error(message('signal:snr:MustBeOneSidedPxx'));
end

% use the average bin width
df = mean(diff(F));

if nargin > 2
  validateattributes(nHarm,{'double'},{'integer','finite','positive','scalar','>',1}, ...
    'snr','N',4);
else
  nHarm = 6;
end

[r, noisePow] = computeSNR(Pxx, F, df, nHarm);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = computeSNR(Pxx, F, rbw, nHarm)
% bump DC component by 3dB and remove it.
Pxx(1) = 2*Pxx(1);
[~, ~, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw, 0);
Pxx(iLeft:iRight) = 0;

% get an estimate of the actual frequency / amplitude, then remove it.
[Pfund, Ffund, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw);
Pxx(iLeft:iRight) = 0;
numCleared = iRight - iLeft + 1;

% remove harmonic content
for i=2:nHarm
  [Pharm, ~, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw, i*Ffund);
  % obtain local maximum value in neighborhood of bin        
  if ~isnan(Pharm)
    % remove the power of this tone
    Pxx(iLeft:iRight) = 0;
    numCleared = numCleared + iRight - iLeft + 1;
  end
end

% compute the total non-harmonic (noise) distortion (including spurs).
remainingDistortion = bandpower(Pxx, F, 'psd');

% get an estimate of the noise floor by computing the median
% noise power of the non-harmonic region
estimatedNoiseDensity = median(Pxx(Pxx>0));
df = mean(diff(Pxx));

% extrapolate the noisefloor into the removed dc/harmonic content
totalNoise = remainingDistortion + numCleared * df * estimatedNoiseDensity;

r = 10*log10(Pfund / totalNoise);
noisePow = 10*log10(totalNoise);