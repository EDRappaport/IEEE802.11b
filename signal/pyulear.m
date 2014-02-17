function varargout = pyulear(x,p,varargin)
%PYULEAR   Power Spectral Density (PSD) estimate via Yule-Walker's method.
%   Pxx = PYULEAR(X,ORDER) returns the PSD of a discrete-time signal vector
%   X in the vector Pxx.  Pxx is the distribution of power per unit frequency.
%   The frequency is expressed in units of radians/sample.  ORDER is the
%   order of the autoregressive (AR) model used to produce the PSD.  PYULEAR 
%   uses a default FFT length of 256 which determines the length of Pxx.
%
%   For real signals, PYULEAR returns the one-sided PSD by default; for 
%   complex signals, it returns the two-sided PSD.  Note that a one-sided 
%   PSD contains the total power of the input signal.
%
%   Pxx = PYULEAR(X,ORDER,NFFT) specifies the FFT length used to calculate 
%   the PSD estimates.  For real X, Pxx has length (NFFT/2+1) if NFFT is 
%   even, and (NFFT+1)/2 if NFFT is odd.  For complex X, Pxx always has 
%   length NFFT.  If empty, the default NFFT is 256.
%
%   [Pxx,W] = PYULEAR(...) returns the vector of normalized angular 
%   frequencies, W, at which the PSD is estimated.  W has units of 
%   radians/sample.  For real signals, W spans the interval [0,Pi] when 
%   NFFT is even and [0,Pi) when NFFT is odd.  For complex signals, W 
%   always spans the interval [0,2*Pi).  
%
%   [Pxx,W] = PYULEAR(X,ORDER,W) where W is a vector of normalized
%   frequencies (with 2 or more elements) computes the PSD at 
%   those frequencies.  In this case a two sided PSD is returned. 
%
%   [Pxx,F] = PYULEAR(...,Fs) specifies a sampling frequency Fs in Hz and
%   returns the power spectral density in units of power per Hz.  F is a
%   vector of frequencies, in Hz, at which the PSD is estimated.  For real 
%   signals, F spans the interval [0,Fs/2] when NFFT is even and [0,Fs/2)
%   when NFFT is odd.  For complex signals, F always spans the interval 
%   [0,Fs).  If Fs is empty, [], the sampling frequency defaults to 1 Hz.  
%
%   [Pxx,F] = PYULEAR(X,ORDER,F,Fs) where F is a vector of 
%   frequencies in Hz (with 2 or more elements) computes the PSD at 
%   those frequencies. In this case a two sided PSD is returned. 
%
%   [...] = PYULEAR(...,FREQRANGE)  returns the PSD over the specified
%   range of frequencies based upon the value of FREQRANGE:
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
%      after ORDER.  The default value of FREQRANGE is 'onesided' when X
%      is real and 'twosided' when X is complex.
%
%   [Pxx,F,Pxxc] = PYULEAR(...,'ConfidenceLevel',P) returns the P*100%
%   confidence interval for Pxx, where P is a scalar between 0 and 1.
%   Confidence intervals are computed using a Gaussian PDF.  Pxxc(:,1) is
%   the lower bound of the confidence interval, Pxxc(:,2) is the upper
%   bound.  The default value for P is .95
%
%   PYULEAR(...) with no output arguments plots the PSD estimate in dB per 
%   unit frequency in the current figure window.
%
%   EXAMPLE:
%      x = randn(100,1);
%      y = filter(1,[1 1/2 1/3 1/4 1/5],x);
%      pyulear(y,4,[],1000);          % Uses the default NFFT of 256.
%
%   See also PBURG, PCOV, PMCOV, PMTM, PMUSIC, PWELCH, PERIODOGRAM, PEIG, 
%   ARYULE, PRONY.

%   Author(s): R. Losada and P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.


narginchk(2,8)

method = @aryule;
[Pxx,freq,msg,units,~,options,msgobj] = arspectra(method,x,p,varargin{:});
if ~isempty(msg), error(msgobj); end

% compute confidence intervals if needed.
if ~strcmp(options.conflevel,'omitted')
  Pxxc = arconfinterval(options.conflevel, p, Pxx, x);
elseif nargout>2
  Pxxc = arconfinterval(0.95, p, Pxx, x);
else
  Pxxc = [];
end

if nargout==0,
   % If no output arguments are specified plot the PSD.
   freq = {freq};
   if strcmpi(units,'Hz'), freq = [freq {'Fs',options.Fs}]; end
   hpsd = dspdata.psd(Pxx,freq{:},'SpectrumType',options.range);

   % Create a spectrum object to store in the PSD object's metadata.
   hspec = spectrum.yulear(p);
   hpsd.Metadata.setsourcespectrum(hspec);
   
   % plot the confidence levels if conflevel is specified.
   if ~isempty(Pxxc)
       hpsd.ConfLevel = options.conflevel;
       hpsd.ConfInterval = Pxxc;
   end
   
   % center dc if needed
   if options.centerdc
     centerdc(hpsd);
   end
   
   plot(hpsd);

else
   % center dc if needed
   if options.centerdc
     [Pxx, freq, Pxxc] = psdcenterdc(Pxx, freq, Pxxc, options);
   end

   % Assign output arguments.
   varargout = {Pxx,freq,Pxxc};  % Pxx=PSD, Sxx=PS
end

% [EOF] pyulear.m
