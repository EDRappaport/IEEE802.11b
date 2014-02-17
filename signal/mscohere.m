function varargout = mscohere(x,y,varargin)
%MSCOHERE   Magnitude Squared Coherence Estimate.
%   Cxy = MSCOHERE(X,Y) estimates the magnitude squared coherence estimate
%   of the  system with input X and output Y using Welch's averaged
%   periodogram  method. Coherence is a function of frequency with values
%   between 0 and 1 that indicate how well the input X corresponds to the
%   output Y at each frequency.
%
%   The magnitude squared coherence Cxy is given by Cxy =
%   (abs(Pxy).^2)./(Pxx.*Pyy) where Pxx, the power spectral density (PSD)
%   estimate of X, and Pxy, the Cross-PSD (CPSD) estimate of X and Y, are
%   computed using Welch's averaged, modified periodogram method. See "help
%   pwelch" and "help cpsd" for complete details.
%
%   Cxy = MSCOHERE(X,Y,WINDOW), when WINDOW is a vector, divides X and Y
%   into overlapping sections of length equal to the length of WINDOW, and
%   then windows each section with the vector specified in WINDOW. If
%   WINDOW is an integer, X and Y are divided into sections of length equal
%   to that integer value, and a Hamming window of equal length is used.
%    
%   Cxy = MSCOHERE(X,Y,WINDOW,NOVERLAP) uses NOVERLAP samples of overlap
%   from section to section. NOVERLAP must be an integer smaller than the
%   WINDOW if WINDOW is an integer. NOVERLAP must be an integer smaller
%   than the length of WINDOW if WINDOW is a vector. If NOVERLAP is omitted
%   or specified as empty, the default value is used to obtain a 50%
%   overlap.
%
%   When WINDOW and NOVERLAP are not specified, X is divided into eight
%   sections with 50% overlap. A Hamming window is used to compute and
%   average eight modified periodograms.
%
%   [Cxy,W] = MSCOHERE(X,Y,WINDOW,NOVERLAP,NFFT) specifies the number of
%   FFT points, NFFT, used to calculate the PSD and CPSD estimates. For
%   real X and Y, Cxy has length (NFFT/2+1) if NFFT is even, and (NFFT+1)/2
%   if NFFT is odd. For complex X or Y, Cxy always has length NFFT. If NFFT
%   is not specified or set to empty, it defaults to the maximum of 256 or
%   the next power of two greater than the length of each section of X (or
%   Y).
%
%   [Cxy,W] = MSCOHERE(X,Y,WINDOW,NOVERLAP,W), where input W is a vector of
%   normalized frequencies (with 2 or more elements), computes the
%   coherence estimate at those frequencies using the Goertzel algorithm.
%
%   [Cxy,F] = MSCOHERE(X,Y,WINDOW,NOVERLAP,NFFT,Fs) returns the magnitude
%   squared coherence estimate computed as a function of physical frequency
%   in Hz. Fs is the sampling frequency specified in Hz. If Fs is not
%   specified or is set to empty, it defaults to 1 Hz. Output F is the
%   vector of frequencies at which Cxy is estimated and has units of Hz.
%   For real signals, F spans the interval [0,Fs/2] when NFFT is even and
%   [0,Fs/2) when NFFT is odd. For complex signals, F always spans the
%   interval [0,Fs).
%
%   [Cxy,F] = MSCOHERE(X,Y,WINDOW,NOVERLAP,F,Fs), where input F is a vector
%   of frequencies in Hz (with 2 or more elements), computes the coherence
%   estimate at those frequencies using the Goertzel algorithm.
%
%   [...] = mscohere(x,y,...,'twosided') returns a coherence estimate with
%   frequencies that range over the whole Nyquist interval. Specifying
%   'onesided' uses half the Nyquist interval. The strings 'twosided' or
%   'onesided' may be placed in any position in the input argument list
%   after NOVERLAP.
%
%   MSCOHERE(...) with no output arguments plots the magnitude squared
%   coherence estimate in the current figure window.
%
%   % Example:
%   %   Compute and plot the coherence estimate between two colored noise 
%   %   sequences x and y.
%
%   h = fir1(30,0.2,rectwin(31));   % Window-based FIR filter design
%   h1 = ones(1,10)/sqrt(10);       
%   r = randn(16384,1);             
%   x = filter(h1,1,r);             % Filter the data sequence
%   y = filter(h,1,x);              % Filter the data sequence  
%   noverlap = 512; nfft = 1024;
%   mscohere(x,y,hanning(nfft),noverlap,nfft); % Plot estimate
% 
%   See also TFESTIMATE, CPSD, PWELCH, PERIODOGRAM. 

%   Copyright 1988-2012 The MathWorks, Inc.


narginchk(2,7)

esttype = 'mscohere';
% Possible outputs are:
%       Plot
%       Cxy
%       Cxy, freq
[varargout{1:nargout}] = welch({x,y},esttype,varargin{:});

if nargout == 0, 
    title('Coherence Estimate via Welch');
end

% [EOF]
