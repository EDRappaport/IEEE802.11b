function fvtoolopts = spectrumopts2fvtool(~,opts)
%SPECTRUMOPTS2FVTOOL   Convert options for NOISEPSD and FREQRESPEST to
%   FVTool options.

%   Author(s): R. Losada
%   Copyright 2006-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/11/08 02:33:42 $

npts = opts.NFFT;
CenterDC = opts.CenterDC;

fvtoolopts = {};
spectrumprop = get(findprop(opts,'spectrum'),'Name');

if opts.NormalizedFrequency,
    nf = 'on';
    if any(strcmpi(get(opts,spectrumprop),{'whole','twosided'})) && CenterDC,
        fr = '[-pi, pi)';
    elseif any(strcmpi(get(opts,spectrumprop),{'whole','twosided'})) && ~CenterDC,
        fr = '[0, 2pi)';
    else
        % get(opts,spectrumprop) = {'half','Onesided'}
        fr = '[0, pi)';
    end
else
    fvtoolopts = {'Fs',opts.Fs};
    nf = 'off';
    if any(strcmpi(get(opts,spectrumprop),{'whole','twosided'})) && CenterDC,
        fr = '[-Fs/2, Fs/2)';
    elseif any(strcmpi(get(opts,spectrumprop),{'whole','twosided'})) && ~CenterDC,
        fr = '[0, Fs)';
    else
        % get(opts,spectrumprop) = {'half','Onesided'}
        fr = '[0, Fs/2)';
    end
end

fvtoolopts = [fvtoolopts {'NumberofPoints',npts,...
    'NormalizedFrequency',nf,'FrequencyRange',fr}];
  
% [EOF]
