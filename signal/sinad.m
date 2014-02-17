function [r, totDistPow] = sinad(varargin)
%SINAD  Signal to Noise and Distortion ratio
%   R = SINAD(X) computes the signal to noise and distortion ratio (SINAD),
%   in dBc, of the real sinusoidal input signal X.  The computation is
%   performed over a periodogram of the same length as the input using a
%   Kaiser window.  
%
%   R = SINAD(X, Fs) specifies the sampling rate, Fs.  The
%   default value of Fs is 1.  
%
%   R = SINAD(Pxx, F, 'psd') specifies the input as a one-sided
%   PSD estimate, Pxx, of a real signal.  F is a vector of frequencies
%   that correspond to the PSD estimates.
% 
%   R = SINAD(Sxx, F, RBW, 'power') specifies the input as a one-sided
%   power spectrum, Sxx, of a real signal.  RBW is the resolution bandwidth
%   over which each power estimate is integrated.
%
%   [R, TOTDISTPOW] = SINAD(...) also returns the total noise and harmonic
%   distortion power of the signal.
%
%   % Example 1:
%   %   Compute the SINAD ratio of a 2.5 kHz distorted sinusoid sampled
%   %   at 48 kHz
%   load('sineex.mat','x','Fs');
%   sineSINAD = sinad(x,Fs)
%
%   % Example 2:
%   %   Generate the periodogram of a 2.5 kHz distorted sinusoid sampled
%   %   at 48 kHz and compute SINAD
%
%   % Create the sinusoid and compute the power spectrum
%   load('sineex.mat','x','Fs');
%   w = kaiser(numel(x),38);
%   [Sxx, F] = periodogram(x,w,numel(x),Fs,'power');
% 
%   % compute SINAD
%   rbw = enbw(w,Fs);
%   [sineSINAD, distPower] = sinad(Sxx, F, rbw, 'power')
% 
%   See also THD SFDR SNR TOI.

%   Copyright 2013 The MathWorks, Inc.

narginchk(1,4);

% look for psd or power window compensation flags
[esttype, varargin] = psdesttype({'psd','power','time'},'time',varargin);

switch esttype
  case 'psd'
    [r, totDistPow] = psdSINAD(varargin{:});
  case 'power'
    [r, totDistPow] = powerSINAD(varargin{:});
  case 'time'
    [r, totDistPow] = timeSINAD(varargin{:});
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, totDistPow] = timeSINAD(x, fs)

% force column vector before checking attributes
if max(size(x)) == numel(x)
  x = x(:);
end
  
validateattributes(x,{'numeric'},{'real','finite','vector'}, ...
  'sinad','x',1);

if nargin > 1
  validateattributes(fs, {'numeric'},{'real','finite','scalar','positive'}, ...
    'sinad','Fs',2);
else
  fs = 1;
end

% remove DC component
x = x - mean(x);

n = length(x);

% use Kaiser window to reduce effects of leakage
w = kaiser(n,38);
rbw = enbw(w,fs);
[Pxx, F] = periodogram(x,w,n,fs,'psd');
[r, totDistPow] = computeSINAD(Pxx, F, rbw);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, totDistPow] = powerSINAD(Sxx, F, rbw)

if F(1)~=0
  error(message('signal:sinad:MustBeOneSidedSxx'));
end

% use the average bin width
df = mean(diff(F));

validateattributes(rbw,{'numeric'},{'real','finite','positive','scalar','>=',df}, ...
    'sinad','RBW',3);

[r, totDistPow] = computeSINAD(Sxx/rbw, F, rbw);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, totDistPow] = psdSINAD(Pxx, F)

if F(1)~=0
  error(message('signal:sinad:MustBeOneSidedPxx'));
end

% ensure specified RBW is larger than a bin width
df = mean(diff(F));

[r, totDistPow] = computeSINAD(Pxx, F, df);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, noisePow] = computeSINAD(Pxx, F, rbw)
% bump DC component by 3dB and remove it.
Pxx(1) = 2*Pxx(1);
[~, ~, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw, 0);
Pxx(iLeft:iRight) = 0;

% get an estimate of the actual frequency / amplitude, then remove it.
[Pfund, ~, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw);
Pxx(iLeft:iRight) = 0;
numCleared = iRight - iLeft + 1;

% compute the remaining harmonic and noise distortion.
remainingDistortion = bandpower(Pxx, F, 'psd');

% get an estimate of the noise floor by computing the median
% noise power of the non-harmonic region
estimatedNoiseDensity = median(Pxx(Pxx>0));
df = mean(diff(Pxx));

% extrapolate the noisefloor into the removed dc/harmonic content
totalNoise = remainingDistortion + numCleared * df * estimatedNoiseDensity;

r = 10*log10(Pfund / totalNoise);
noisePow = 10*log10(totalNoise);