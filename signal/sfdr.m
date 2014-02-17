function [r, spurPow, spurFreq] = sfdr(varargin)
%SFDR   Spurious Free Dynamic Range
%   R = SFDR(X) computes the spurious free dynamic range, in dB, of the
%   real sinusoidal input signal X.  The computation is performed over a
%   periodogram of the same length as the input using a Hamming window.
%
%   R = SFDR(X, Fs, MSD) considers only spurs that are separated from the
%   carrier frequency by the minimum spur distance, MSD, to compute
%   spurious free dynamic range. MSD is a real valued positive scalar
%   specified in frequency units. This parameter may be specified to ignore
%   spurs or sidelobes that may occur in close proximity to the carrier.
%   For example, if the carrier frequency is Fc, then all spurs in the
%   range (Fc-MSD, Fc+MSD) are ignored. If not specified, then MSD defaults
%   to zero.  Fs is the sampling rate of the input signal.  If not
%   specified Fs defaults to 1 (Hz).
% 
%   R = SFDR(Sxx, F, 'power') computes the spurious free dynamic range, in
%   dB, of a one-sided power spectrum, Sxx, of a real signal.   F is a
%   vector of frequencies that corresponds to the vector of Sxx estimates.
%
%   R = SFDR(Sxx, F, MSD, 'power') considers spurs separated from the
%   carrier frequency identified in Sxx by the minimum spur distance, MSD.
%
%   [R, SPURPOW, SPURFREQ] = SFDR(...) also returns the power,
%   SPURPOW, and frequency, SPURFREQ, of the largest spur.
%
%   % Example 1:
%   %   Obtain the SFDR of a 9.8kHz tone with a spur 80 dBc at 14.7kHz
%   Fs = 44.1e3; f1 = 9.8e3; f2 = 14.7e3; N = 900;
%   nT = (1:N)/Fs;
%   x = sin(2*pi*f1*nT) + 100e-6*sin(2*pi*f2*nT) + 1e-8*randn(1,N);
%   [sfd, spur, frq] = sfdr(x, Fs)
%   periodogram(x,[],length(x),Fs,'power');
%
%   See also THD SINAD SNR TOI.

%   Copyright 2012-2013 The MathWorks, Inc.

narginchk(1,4);

matches = find(strcmpi('power',varargin));
varargin(matches) = [];

if any(matches)
  [r, spurPow, spurFreq] = psfdr(varargin{:});
else
  [r, spurPow, spurFreq] = tsfdr(varargin{:});
end


function [r, spurPow, spurFreq] = tsfdr(x, fs, msd)

% force column vector before checking attributes
if max(size(x)) == numel(x)
  x = x(:);
end
  
validateattributes(x,{'numeric'},{'real','finite','vector'}, ...
  'sfdr','x',1);

if nargin > 1
  validateattributes(fs, {'numeric'},{'real','finite','scalar','positive'}, ...
    'sfdr','Fs',2);
else
  fs = 1;
end

if nargin > 2
  validateattributes(msd,{'numeric'},{'real','finite','positive','scalar'}, ...
    'sfdr','MSD',3);
else
  msd = 0;
end

% remove DC component
x = x - mean(x);

n = length(x);

% get baseline estimate of fundamental power and frequency
% use flattop win for a good power estimate
Sxx = periodogram(x,flattopwin(n),n,fs,'power');

% get fundamental power
fundPow = max(Sxx);

% use Hamming window to reduce effects of leakage
[Sxx, F] = periodogram(x,hamming(n),n,fs,'power');
[~, fundBin] = max(Sxx);
fundFreq = F(fundBin);

% remove peak
[leftBin, rightBin] = getPeakBorder(Sxx, F, fundFreq, fundBin, msd);
Sxx(leftBin:rightBin) = 0;

% get the maximum spur from the remaining bins
[spurPow, spurBin] = max(Sxx);

r = 10*log10(fundPow / spurPow);
spurPow = 10*log10(spurPow);
spurFreq = F(spurBin);


function [leftBin, rightBin] = getPeakBorder(Sxx, F, fundFreq, fundBin, msd)
% find the borders of the fundamental peak
leftBin = find(Sxx(2:fundBin) < Sxx(1:fundBin-1),1,'last');
rightBin = fundBin + find(Sxx(fundBin+1:end) > Sxx(fundBin:end-1),1,'first');

% ensure against edge cases
if isempty(leftBin)
  leftBin = 1;
end

if isempty(rightBin)
  rightBin = numel(Sxx);
end

% increase peak width if necessary
leftBinG  = find(F <= fundFreq - msd, 1, 'last');
rightBinG = find(fundFreq + msd < F, 1, 'first');
if ~isempty(leftBinG) && leftBinG < leftBin
  leftBin = leftBinG;
end
if ~isempty(rightBinG) && rightBinG > rightBin
  rightBin = rightBinG;
end  


function [r, spurPow, spurFreq] = psfdr(Sxx, F, msd)
validateattributes(Sxx,{'numeric'},{'real','finite','vector','positive'}, '','Sxx');
validateattributes(F,  {'numeric'},{'real','finite','vector'}, '','F');

if F(1)~=0
  error(message('signal:sfdr:MustBeOneSided'));
end

if nargin>2
  validateattributes(msd,{'numeric'},{'real','finite','positive','scalar'}, '','MSD');
else
  msd = 0;
end

% ignore DC
Sxx(1) = 0;
[fundPow, fundBin] = max(Sxx);
fundFreq = F(fundBin);

% remove peak
[leftBin, rightBin] = getPeakBorder(Sxx, F, fundFreq, fundBin, msd);
Sxx(leftBin:rightBin) = 0;

% get the maximum spur from the remaining bins
[spurPow, spurBin] = max(Sxx);

r = 10*log10(fundPow / spurPow);
spurPow = 10*log10(spurPow);
spurFreq = F(spurBin);


