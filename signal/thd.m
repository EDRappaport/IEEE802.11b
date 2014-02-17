function [r, harmPow, harmFreq] = thd(varargin)
%THD    Total Harmonic Distortion
%   R = THD(X) computes the total harmonic distortion (THD), in dBc, of the
%   real sinusoidal input signal X.  The computation is performed over a
%   periodogram of the same length as the input using a Kaiser window and 
%   includes the first six harmonics (including the fundamental).  
%
%   R = THD(X, Fs, N) specifies the sampling rate, Fs, and number of
%   harmonics, N, to consider when computing THD.  The default value
%   of Fs is 1.  The default value of N is 6 and includes the fundamental
%   frequency.
% 
%   R = THD(Pxx, F, 'psd') specifies the input as a one-sided PSD estimate,
%   Pxx, of a real signal.   F is a vector of frequencies that corresponds
%   to the vector of Sxx estimates.
% 
%   R = THD(Pxx, F, N, 'psd') specifies the number of harmonics, N,
%   to include when computing THD.  The default value of N is 6 and
%   includes the fundamental frequency.
%
%   R = THD(Sxx, F, RBW, 'power') specifies the input as a one-sided power
%   spectrum, Sxx, of a real signal.  RBW is the resolution bandwidth over
%   which each power estimate is integrated.  
% 
%   R = THD(Sxx, F, RBW, N, 'power') specifies the number of harmonics, N,
%   to include when computing THD.  The default value of N is 6 and
%   includes the fundamental frequency.
% 
%   [R, HARMPOW, HARMFREQ] = THD(...) also returns the power, HARMPOW,
%   and frequencies, HARMFREQ, of all harmonics (including the fundamental).  
%
%   % Example 1:
%   %   Compute the THD of a 2.5 kHz distorted sinusoid sampled at 48 kHz
%   load('sineex.mat','x','Fs');
%   sineTHD = thd(x,Fs)
%
%   % Example 2:
%   %   Generate the periodogram of a 2.5 kHz distorted sinusoid sampled
%   %   at 48 kHz and compute the THD
%
%   load('sineex.mat','x','Fs');
%   w = kaiser(numel(x),38);
%   [Sxx, F] = periodogram(x,w,numel(x),Fs,'power');
% 
%   % compute THD via a power spectrum
%   rbw = enbw(w,Fs);
%   [sineTHD, hPower, hFreq] = thd(Sxx,F,rbw,'power')
% 
%   % plot and annotate the spectrum
%   periodogram(x,w,numel(x),Fs,'power');
%   for i=1:6
%     text(hFreq(i)/1e3,hPower(i),num2str(i))
%   end
%
%   See also SFDR SINAD SNR TOI.

%   Copyright 2013 The MathWorks, Inc.

narginchk(1,5);

% look for psd or power window compensation flags
[esttype, varargin] = psdesttype({'psd','power','time'},'time',varargin);

switch esttype
  case 'psd'
    [r, harmPow, harmFreq] = psdTHD(varargin{:});
  case 'power'
    [r, harmPow, harmFreq] = powerTHD(varargin{:});
  case 'time'
    [r, harmPow, harmFreq] = timeTHD(varargin{:});
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, harmPow, harmFreq] = timeTHD(x, fs, nHarm)

% force column vector before checking attributes
if max(size(x)) == numel(x)
  x = x(:);
end
  
validateattributes(x,{'numeric'},{'real','finite','vector'}, ...
  'thd','x',1);

if nargin > 1
  validateattributes(fs, {'numeric'},{'real','finite','scalar','positive'}, ...
    'thd','Fs',2);
else
  fs = 1;
end

if nargin > 2
  validateattributes(nHarm,{'numeric'},{'integer','finite','positive','scalar','>',1}, ...
    'thd','N',3);
else
  nHarm = 6;
end


% remove DC component
x = x - mean(x);

n = length(x);

% use Kaiser window to reduce effects of leakage
w = kaiser(n,38);
rbw = enbw(w, fs);
[Pxx, F] = periodogram(x,w,n,fs,'psd');
[r, harmPow, harmFreq] = computeTHD(Pxx, F, rbw, nHarm);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, harmPow, harmFreq] = powerTHD(Sxx, F, rbw, nHarm)

if F(1)~=0
  error(message('signal:thd:MustBeOneSidedSxx'));
end

% ensure specified RBW is larger than a bin width
df = mean(diff(F));

validateattributes(rbw,{'numeric'},{'real','finite','positive','scalar','>=',df}, ...
    'thd','RBW',3);

if nargin > 3
  validateattributes(nHarm,{'numeric'},{'integer','finite','positive','scalar','>',1}, ...
    'thd','N',4);
else
  nHarm = 6;
end

[r, harmPow, harmFreq] = computeTHD(Sxx/rbw, F, rbw, nHarm);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, harmPow, harmFreq] = psdTHD(Pxx, F, nHarm)

if F(1)~=0
  error(message('signal:thd:MustBeOneSidedPxx'));
end

if nargin > 2
  validateattributes(nHarm,{'numeric'},{'integer','finite','positive','scalar','>',1}, ...
    'thd','N',3);
else
  nHarm = 6;
end

[r, harmPow, harmFreq] = computeTHD(Pxx, F, mean(diff(F)), nHarm);


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [r, harmPow, harmFreq] = computeTHD(Pxx, F, rbw, nHarm)
% pre-allocate harmonic table
harmPow = NaN(nHarm,1);
harmFreq = NaN(nHarm,1);

% bump DC component by 3dB and remove it.
Pxx(1) = 2*Pxx(1);
[~, ~, ~, iLeft, iRight] = signal.internal.getToneFromPSD(Pxx, F, rbw, 0);
Pxx(iLeft:iRight) = 0;

% get an estimate of the actual frequency / amplitude
[Pfund, Ffund] = signal.internal.getToneFromPSD(Pxx, F, rbw);
harmPow(1) = Pfund;
harmFreq(1) = Ffund;

harmSum = 0;
for i=2:nHarm
  [harmPow(i), harmFreq(i)] = signal.internal.getToneFromPSD(Pxx, F, rbw, i*Ffund);
  % obtain local maximum value in neighborhood of bin        
  if ~isnan(harmPow(i))
    harmSum = harmSum + harmPow(i);
  end
end

r = 10*log10(harmSum / harmPow(1));
harmPow = 10*log10(harmPow);

