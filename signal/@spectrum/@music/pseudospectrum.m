function varargout = pseudospectrum(this,x,varargin)
%PSEUDOSPECTRUM  Pseudospectrum estimate via MUSIC.
%   Type help spectrum/pseudospectrum for help.

%   Author(s): P. Pacheco
%   Copyright 1988-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.10 $Date: 2011/05/13 18:13:53 $

error(nargchk(2,10,nargin,'struct'));
[x,lenX,nchans] = checkinputsigdim(x); % Column'izes x if it's a row vector.

validatesegmentlength(this,nchans);

hopts = uddpvparse('dspopts.pseudospectrum',...
                         {'pseudospectrumopts',this,x},varargin{:});

% Call pseudospectrum of concrete class.
[hopts,opts,P] = setupinputs(this,lenX,hopts);
[Sxx W] = thispseudospectrum(this,x,opts,P);

% This is necessary because I can't call pmusic without specifying Fs -
% which would result in the freq with the desired normalized units.
if hopts.NormalizedFrequency,  % Use normalized frequency.
    W = psdfreqvec('npts',opts{1},'Fs',[],'Range',hopts.SpectrumRange);
end

%
% Create a dspdata object and center-DC if necessary.
%
% p* fcns return spectrums w/ pos freq only, so call centerDC if requested.
centerDCcache = hopts.CenterDC;
hopts.CenterDC=false;

% Define valid options for dspdata object.
propName = getrangepropname(hopts);
propValue= get(hopts,propName);
dspdataOpts = {'CenterDC',hopts.CenterDC,'Fs',hopts.Fs,propName,propValue};

hps = dspdata.pseudospectrum(Sxx,W,dspdataOpts{:});
if centerDCcache, 
    centerdc(hps);
end
hopts.CenterDC = centerDCcache;

% Store a spectrum object in the data obj's metadata property.
hps.Metadata.setsourcespectrum(this);

if nargout == 0,
    plot(hps);
else
    varargout{1} = hps;
end

%--------------------------------------------------------------------------
function [hopts,opts,P] = setupinputs(this,lenX,hopts)
% Set up the input arguments to the pmusic and peig functions.

% Generate window; by default it's a rectangular window.
this.Window.length = this.SegmentLength;  % Window is a private property
win = generate(this.Window);

% Number of overlap samples.
NOverlap = overlapsamples(this);

% Setup options for pmusic and peig.
if hopts.NormalizedFrequency,    Fs = []; 
else                             Fs = hopts.Fs;
end

% Determine numeric value of NFFT if it's set to a string.
nfft = calcnfft(hopts,lenX);

% Create cell array of options for the command-line function.
opts = {nfft,Fs,hopts.SpectrumRange,win,NOverlap};

% Complex sinusoids and threshold.
P = [this.NSinusoids, this.SubspaceThreshold];

%--------------------------------------------------------------------------
function validatesegmentlength(this,nchans)
% Verify that the segment (window) length equals the number of columns in
% the data matrix.

if strcmpi(this.InputType,'DataMatrix'),
    if this.SegmentLength ~= nchans,
        error(message('signal:spectrum:music:pseudospectrum:invalidSegmentLength', 'SegmentLength'));
    end
end


% [EOF]
