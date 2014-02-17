function varargout = pwelch(x,varargin)
%PWELCH Power Spectral Density estimate via Welch's method.
%   Pxx = PWELCH(X) returns the Power Spectral Density (PSD) estimate, Pxx,
%   of a discrete-time signal vector X using Welch's averaged, modified
%   periodogram method. By default, X is divided into the longest possible
%   sections, to get as close to but not exceeding 8 segments with 50%
%   overlap. A modified periodogram is computed for each segment using a
%   Hamming window and all the resulting periodograms are averaged to
%   compute the final spectral estimate. X will be truncated if it cannot
%   be divided into an integer number of segments.
%
%   Pxx is the distribution of power per unit frequency. For real signals,
%   PWELCH returns the one-sided PSD by default; for complex signals, it
%   returns the two-sided PSD.  Note that a one-sided PSD contains the
%   total power of the input signal.
%
%   Note also that the default window (Hamming) has a 42.5 dB sidelobe
%   attenuation. This may mask spectral content below this value (relative
%   to the peak spectral content). Choosing different windows will enable
%   you to make tradeoffs between resolution (e.g., using a rectangular
%   window) and sidelobe attenuation (e.g., using a Hann window). See
%   WinTool for more details.
%
%   Pxx = PWELCH(X,WINDOW), when WINDOW is a vector, divides X into
%   overlapping sections of length equal to the length of WINDOW, and then
%   windows each section with the vector specified in WINDOW. If WINDOW is
%   an integer, X is divided into sections of length equal to that integer
%   value, and a Hamming window of equal length is used. If the length of X
%   is such that it cannot be divided exactly into integer number of
%   sections with 50% overlap, X will be truncated accordingly. A Hamming
%   window is used if WINDOW is omitted or specified as empty.
%
%   Pxx = PWELCH(X,WINDOW,...,SPECTRUMTYPE) uses the window scaling
%   algorithm specified by SPECTRUMTYPE when computing the power spectrum.
%   SPECTRUMTYPE can be set to 'psd' or 'power':
%     'psd'   - returns the power spectral density
%     'power' - scales each estimate of the PSD by the equivalent noise
%               bandwidth (in Hz) of the window.  Use this option to
%               obtain an estimate of the power at each frequency.
%   The default value for SPECTRUMTYPE is 'psd'.
%
%   Pxx = PWELCH(X,WINDOW,NOVERLAP) uses NOVERLAP samples of overlap from
%   section to section.  NOVERLAP must be an integer smaller than the
%   WINDOW if WINDOW is an integer.  NOVERLAP must be an integer smaller
%   than the length of WINDOW if WINDOW is a vector. If NOVERLAP is omitted
%   or specified as empty, the default value is used to obtain a 50%
%   overlap.
%
%   [Pxx,W] = PWELCH(X,WINDOW,NOVERLAP,NFFT) specifies the number of FFT
%   points used to calculate the PSD estimate.  For real X, Pxx has length
%   (NFFT/2+1) if NFFT is even, and (NFFT+1)/2 if NFFT is odd. For complex
%   X, Pxx always has length NFFT.  If NFFT is specified as empty, the 
%   default NFFT -the maximum of 256 or the next power of two
%   greater than the length of each section of X- is used.
%
%   Note that if NFFT is greater than the segment the data is zero-padded.
%   If NFFT is less than the segment, the segment is "wrapped" (using
%   DATAWRAP) to make the length equal to NFFT. This produces the correct
%   FFT when NFFT < L, L being signal or segment length.                       
%
%   W is the vector of normalized frequencies at which the PSD is
%   estimated.  W has units of rad/sample.  For real signals, W spans the
%   interval [0,Pi] when NFFT is even and [0,Pi) when NFFT is odd.  For
%   complex signals, W always spans the interval [0,2*Pi).
%
%   [Pxx,W] = PWELCH(X,WINDOW,NOVERLAP,W) where W is a vector of normalized
%   frequencies (with 2 or more elements) computes the PSD at those
%   frequencies using the Goertzel algorithm. In this case a two sided PSD
%   is returned. The specified frequencies in W are rounded to the nearest
%   DFT bin commensurate with the signal's resolution.
%
%   [Pxx,F] = PWELCH(X,WINDOW,NOVERLAP,NFFT,Fs) returns a PSD computed as
%   a function of physical frequency (Hz).  Fs is the sampling frequency
%   specified in Hz.  If Fs is empty, it defaults to 1 Hz.
%
%   F is the vector of frequencies at which the PSD is estimated and has
%   units of Hz.  For real signals, F spans the interval [0,Fs/2] when NFFT
%   is even and [0,Fs/2) when NFFT is odd.  For complex signals, F always
%   spans the interval [0,Fs).
%
%   [Pxx,F] = PWELCH(X,WINDOW,NOVERLAP,F,Fs) where F is a vector of
%   frequencies in Hz (with 2 or more elements)  computes the PSD at those
%   frequencies using the Goertzel algorithm. In this case a two sided PSD
%   is returned.  The specified frequencies in F are rounded to the nearest
%   DFT bin commensurate with the signal's resolution.
%
%   [Pxx,F,Pxxc] = PWELCH(...,'ConfidenceLevel',P) returns the P*100%
%   confidence interval for Pxx, where P is a scalar between 0 and 1.
%   Confidence intervals are computed using a chi-squared approach.
%   Pxxc(:,1) is the lower bound of the confidence interval, Pxxc(:,2) is
%   the upper bound.  The default value for P is .95
%
%   [...] = PWELCH(...,FREQRANGE)  returns the PSD over the specified range
%   of frequencies based upon the value of FREQRANGE:
%
%      'onesided' - returns the one-sided PSD of a real input signal X.
%         If NFFT is even, Pxx will have length NFFT/2+1 and will be
%         computed over the interval [0,Pi].  If NFFT is odd, the length
%         of Pxx becomes (NFFT+1)/2 and the interval becomes [0,Pi).
%         When Fs is optionally specified, the intervals become
%         [0,Fs/2) and [0,Fs/2] for even and odd length NFFT, respectively.
%
%      'twosided' - returns the two-sided PSD for either real or complex
%         input X.  In this case, Pxx will have length NFFT and will be
%         computed over the interval [0,2*Pi).
%         When Fs is optionally specified, the interval becomes [0,Fs).
%
%      'centered' - returns the centered two-sided PSD for either real or
%         complex input X.  In this case, Pxx will have length NFFT and will
%         be computed over the interval (-Pi, Pi] and for even length NFFT 
%         and (-Pi, Pi) for odd length NFFT.  When Fs is optionally 
%         specified, the intervals become (-Fs/2, Fs/2] and (-Fs/2, Fs/2)
%         for even and odd length NFFT, respectively.
%
%      FREQRANGE may be placed in any position in the input argument list
%      after NOVERLAP.  The default value of FREQRANGE is 'onesided' when X
%      is real and 'twosided' when X is complex.
%
%   PWELCH(...) with no output arguments by default plots the PSD
%   estimate in dB per unit frequency in the current figure window.
%
%   EXAMPLE:
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));  % A cosine of 200Hz plus noise
%      pwelch(x,[],[],[],Fs,'twosided'); % Uses default window, overlap & NFFT. 
% 
%   See also PERIODOGRAM, PCOV, PMCOV, PBURG, PYULEAR, PEIG, PMTM, PMUSIC.

%   Author(s): R. Losada
%   Copyright 1988-2013 The MathWorks, Inc.

%   References:
%     [1] Petre Stoica and Randolph Moses, Introduction To Spectral
%         Analysis, Prentice-Hall, 1997, pg. 15
%     [2] Monson Hayes, Statistical Digital Signal Processing and 
%         Modeling, John Wiley & Sons, 1996.

narginchk(1,9);
nargoutchk(0,3);

% look for psd, power, and ms window compensation flags
[esttype, varargin] = psdesttype({'psd','power','ms'},'psd',varargin);

% Possible outputs are:
%       Plot
%       Pxx
%       Pxx, freq
%       Pxx, freq, Pxxc
[varargout{1:nargout}] = welch(x,esttype,varargin{:});

% [EOF]
