function varargout = welch(x,esttype,varargin)
%WELCH Welch spectral estimation method.
%   [Pxx,F] = WELCH(X,WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,ESTTYPE)
%   [Pxx,F] = WELCH({X},WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,'psd')
%   [Pxx,F] = WELCH({X},WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,'ms')
%   [Pxy,F] = WELCH({X,Y},WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,'cpsd')
%   [Txy,F] = WELCH({X,Y},WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,'tfe')
%   [Cxy,F] = WELCH({X,Y},WINDOW,NOVERLAP,NFFT,Fs,SPECTRUMTYPE,'mscohere')
%   [Pxx,F,Pxxc] = WELCH(...)
%   [Pxx,F,Pxxc] = WELCH(...,'ConfidenceLevel',P)
%
%   Inputs:
%      see "help pwelch" for complete description of all input arguments.
%      ESTTYPE - is a string specifying the type of estimate to return, the
%                choices are: psd, cpsd, tfe, and mscohere.
%
%   Outputs:
%      Depends on the input string ESTTYPE:
%      Pxx - Power Spectral Density (PSD) estimate, or
%      MS  - Mean-square spectrum, or
%      Pxy - Cross Power Spectral Density (CPSD) estimate, or
%      Txy - Transfer Function Estimate (TFE), or
%      Cxy - Magnitude Squared Coherence.
%      F   - frequency vector, in Hz if Fs is specified, otherwise it has
%            units of rad/sample

%   Author(s): P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.


%   References:
%     [1] Petre Stoica and Randolph Moses, Introduction To Spectral
%         Analysis, Prentice-Hall, 1997, pg. 15
%     [2] Monson Hayes, Statistical Digital Signal Processing and
%         Modeling, John Wiley & Sons, 1996.

narginchk(2,10);
nargoutchk(0,3);

% Parse input arguments.
[x,~,~,y,~,win,winName,winParam,noverlap,k,L,options] = ...
    welchparse(x,esttype,varargin{:});

% Frequency vector was specified, return and plot two-sided PSD
freqVectorSpecified = false; nrow = 1;
if length(options.nfft) > 1, 
    freqVectorSpecified = true; 
    [~,nrow] = size(options.nfft); 
end

% Compute the periodogram power spectrum of each segment and average always
% compute the whole power spectrum, we force Fs = 1 to get a PS not a PSD.

% Initialize
if freqVectorSpecified, 
    Sxx = zeros(length(options.nfft),1);   
else
    Sxx = zeros(options.nfft,1); 
end

LminusOverlap = L-noverlap;
xStart = 1:LminusOverlap:k*LminusOverlap;
xEnd   = xStart+L-1;
switch esttype,
    case {'ms','power','psd'}
        for i = 1:k,
            [Sxxk,w] = computeperiodogram(x(xStart(i):xEnd(i)),win,...
                options.nfft,esttype,options.Fs);
            Sxx  = Sxx + Sxxk;
        end

    case 'cpsd'
        for i = 1:k,
            [Sxxk,w] =  computeperiodogram({x(xStart(i):xEnd(i)),...
                y(xStart(i):xEnd(i))},win,options.nfft,esttype,options.Fs);
            Sxx  = Sxx + Sxxk;
        end

    case 'tfe'
        Sxy = zeros(options.nfft,1); % Initialize
        for i = 1:k,
            Sxxk = computeperiodogram(x(xStart(i):xEnd(i)),...
                win,options.nfft,esttype,options.Fs);
            [Syxk,w] = computeperiodogram({y(xStart(i):xEnd(i)),...
                x(xStart(i):xEnd(i))},win,options.nfft,esttype,options.Fs);
            Sxx  = Sxx + Sxxk;          
            Sxy  = Sxy + Syxk;
        end

    case 'mscohere'
        % Note: (Sxy1+Sxy2)/(Sxx1+Sxx2) != (Sxy1/Sxy2) + (Sxx1/Sxx2)
        % ie, we can't push the computation of Cxy into computeperiodogram.
        if length(options.nfft) == 1
          Sxy = zeros(options.nfft,1); % Initialize
          Syy = zeros(options.nfft,1); % Initialize
        else % Freq vect has been specified
          Sxy = zeros(length(options.nfft),1); % Initialize
          Syy = zeros(length(options.nfft),1); % Initialize
        end
        
        for i = 1:k,
            Sxxk = computeperiodogram(x(xStart(i):xEnd(i)),...
                win,options.nfft,esttype,options.Fs);
            Syyk = computeperiodogram(y(xStart(i):xEnd(i)),...
                win,options.nfft,esttype,options.Fs);
            [Sxyk,w] = computeperiodogram({x(xStart(i):xEnd(i)),...
                y(xStart(i):xEnd(i))},win,options.nfft,esttype,options.Fs);
            Sxx  = Sxx + Sxxk;
            Syy  = Syy + Syyk;
            Sxy  = Sxy + Sxyk;
        end
end
Sxx = Sxx./k; % Average the sum of the periodograms

if any(strcmpi(esttype,{'tfe','mscohere'})),
    Sxy = Sxy./k; % Average the sum of the periodograms

    if strcmpi(esttype,'mscohere'),
        Syy = Syy./k; % Average the sum of the periodograms
    end
end

% Generate the freq vector directly in Hz to avoid roundoff errors due to
% conversions later.
if ~freqVectorSpecified, 
    w = psdfreqvec('npts',options.nfft, 'Fs',options.Fs);
else
    if strcmpi(options.range,'onesided')
        warning(message('signal:welch:InconsistentRangeOption'));
    end
    options.range = 'twosided';
end


% Compute the 1-sided or 2-sided PSD [Power/freq] or mean-square [Power].
% Also, corresponding freq vector and freq units.
[Pxx,w,units] = computepsd(Sxx,w,options.range,options.nfft,options.Fs,esttype);

if any(strcmpi(esttype,{'tfe','mscohere'})),
    % Cross PSD.  The frequency vector and xunits are not used.
    Pxy = computepsd(Sxy,w,options.range,options.nfft,options.Fs,esttype);

    % Transfer function estimate.
    if strcmpi(esttype,'tfe'),
        Pxx = Pxy ./ Pxx; % Txy
    end

    % Magnitude Square Coherence estimate.
    if strcmpi(esttype,'mscohere'),
        % Auto PSD for 2nd input vector. The freq vector & xunits are not
        % used.
        Pyy = computepsd(Syy,w,options.range,options.nfft,options.Fs,esttype);
        Pxx = (abs(Pxy).^2)./(Pxx.*Pyy); % Cxy
    end
end

% compute confidence intervals if needed.
if ~strcmp(options.conflevel,'omitted')
  Pxxc = confInterval(options.conflevel, Pxx, x, w, options.Fs, k);
elseif nargout>2
  Pxxc = confInterval(0.95, Pxx, x, w, options.Fs, k);
else
  Pxxc = [];
end

if nargout==0
    w = {w};
    if strcmpi(units,'Hz'), w = [w,{'Fs',options.Fs}];  end
    % Create a spectrum object to store in the Data object's metadata.
    percOverlap = (noverlap/L)*100;
    hspec = spectrum.welch({winName,winParam},L,percOverlap);

    switch lower(esttype)
        case 'tfe'
            if strcmpi(options.range,'onesided'), range='half'; else range='whole'; end
            h = dspdata.freqz(Pxx,w{:},'SpectrumRange',range);
        case 'mscohere'
            if strcmpi(options.range,'onesided'), range='half'; else range='whole'; end
            h = dspdata.magnitude(Pxx,w{:},'SpectrumRange',range);
        case 'cpsd'
            h = dspdata.cpsd(Pxx,w{:},'SpectrumType',options.range);
        case {'ms','power'}
            h = dspdata.msspectrum(Pxx,w{:},'SpectrumType',options.range);
        otherwise
            h = dspdata.psd(Pxx,w{:},'SpectrumType',options.range);
    end
    h.Metadata.setsourcespectrum(hspec);
    
    % plot the confidence levels if conflevel is specified.
    if ~isempty(Pxxc)
        h.ConfLevel = options.conflevel;
        h.ConfInterval = Pxxc;
    end
    % center dc component if specified
    if options.centerdc
      centerdc(h);
    end
    plot(h);
    if strcmp(esttype,'power')
      title(getString(message('signal:welch:WelchPowerSpectrumEstimate')));
    end
else
   if options.centerdc
     [Pxx, w, Pxxc] = psdcenterdc(Pxx, w, Pxxc, options);
   end
   % If the frequency vector was specified as a row vector, return outputs 
   % the correct dimensions
   if nrow > 1,  
       Pxx = Pxx.'; w = w.'; 
   end
   if isempty(Pxxc)
     varargout = {Pxx,w}; % Pxx=PSD, MEANSQUARE, CPSD, or TFE
   else
     varargout = {Pxx,w,Pxxc};
   end
end

function Pxxc = confInterval(CL, Pxx, x, w, fs, k)
%   Reference: D.G. Manolakis, V.K. Ingle and S.M. Kagon,
%   Statistical and Adaptive Signal Processing,
%   McGraw-Hill, 2000, Chapter 5
k = fix(k);
c = privatechi2conf(CL,k);
Pxxc = Pxx*c;

% DC and Nyquist bins have only one degree of freedom for real signals
if isreal(x)
  realConf = chi2conf(CL,k/2);
  Pxxc(w == 0,:) = Pxx(w == 0) * realConf;
  if isempty(fs)
    Pxxc(w==pi,:) = Pxx(w==pi) * realConf;
  else
    Pxxc(w==fs/2,:) = Pxx(w==fs/2) * realConf;
  end
end

% [EOF]
