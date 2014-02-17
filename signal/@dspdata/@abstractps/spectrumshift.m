function [H,W] = spectrumshift(this,H,W)
%SPECTRUMSHIFT   Shift zero-frequency component to center of spectrum.

%   Copyright 1988-2012 The MathWorks, Inc.

if nargin == 1,
    H = this.Data;
    W = this.Frequencies;
    CI = this.ConfInterval;
else
    CI = [];
end

% Convert to plot + and - frequencies.
H = fftshift(H);  % Places the Nyquist freq on the negative side.

if ~isempty(CI)
    CI = [fftshift(CI(:,1)) fftshift(CI(:,2))];
end

[nfft,~] = size(H);

% Determine half the number of FFT points.
if rem(nfft,2),
    halfNfft = (nfft+1)/2;  % ODD
    negEndPt = halfNfft;

else
    halfNfft = (nfft/2)+1;  % EVEN
    negEndPt = halfNfft-1;
    
    % Move the Nyquist point to the right-hand side (pos freq) to be
    % consistent with plot when looking at the positive half only.
    H = [H(2:end,:); H(1,:)];
    if ~isempty(CI)
        CI = [CI(2:end,:); CI(1,:)];
    end
end

W = [-flipud(W(2:negEndPt)); W(1:halfNfft)]; % -Nyquist:Nyquist

if nargout == 0,
    this.Data = H;
    this.Frequencies = W;
    if ~isempty(CI);
        this.ConfInterval = CI;
    end
end

% [EOF]
