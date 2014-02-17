function this = music(varargin)
%MUSIC   Multiple signal classification (MUSIC) spectral estimator.
%
%   SPECTRUM.MUSIC is not recommended.  Use <a href="matlab:help pmusic">pmusic</a> and <a href="matlab:help rootmusic">rootmusic</a> instead.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS) returns a MUSIC pseudospectrum estimator
%   in H with the number of complex sinusoids set to the numeric value
%   specified in NSINUSOIDS.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH) returns a MUSIC
%   pseudospectrum estimator with the number of samples in each segment set
%   to the numeric value specified by SEGMENTLENGTH.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH,OVERLAPPERCENT) returns a
%   MUSIC spectral estimator with the numeric value specified by
%   OVERLAPPERCENT as the percentage of overlap between segments.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH,OVERLAPPERCENT,WINNAME)
%   specifies the window as a string. Use set(H,'WindowName') to get a list
%   of valid <a href="matlab:set(spectrum.music,'WindowName')">windows</a>. 
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH,OVERLAPPERCENT,...
%   {WINNAME,WINPARAMETER}) specifies the window in WINNAME and the
%   parameter value in WINPARAMETER both in a cell array.
%
%   NOTE: Depending on the window specified by WINNAME a window parameter
%   property will be dynamically added to the MUSIC spectral estimator H.
%   Type "help <WINNAME>" for more details.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH,OVERLAPPERCENT,WINNAME,...
%   THRESHOLD) specifies the cutoff in THRESHOLD for the signal and noise
%   subspace separation.
%
%   H = SPECTRUM.MUSIC(NSINUSOIDS,SEGMENTLENGTH,OVERLAPPERCENT,WINNAME,...
%   THRESHOLD,INPUTTYPE) specifies the type of input the MUSIC spectral
%   estimator accepts. INPUTTYPE can be one of the following strings:
%       'Vector'  (default)
%       'DataMatrix'
%       'CorrelationMatrix'
%
%   MUSIC pseudospectrum estimators can be passed to the following
%   functions along with the data to perform that function:
%       <a href="matlab:help spectrum/powerest">powerest</a>           - computes the powers and frequencies of sinusoids
%       <a href="matlab:help spectrum/pseudospectrum">pseudospectrum</a>     - calculates the pseudospectrum
%       <a href="matlab:help spectrum/pseudospectrumopts">pseudospectrumopts</a> - returns options to calculate the pseudospectrum
%
%   EXAMPLE: Spectral analysis of a signal containing complex sinusoids
%            % and noise.
%            n = 0:99;   
%            s = exp(1i*pi/2*n)+2*exp(1i*pi/4*n)+exp(1i*pi/3*n)+randn(1,100);  
%            h = spectrum.music(3,20);        % Create a MUSIC spectral estimator.
%            pseudospectrum(h,s);             % Calculate and plot the pseudospectrum.

%   Author(s): P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.

narginchk(0,7);

% Set the properties of the object.
this = spectrum.music;
set(this, 'EstimationMethod', 'Multiple Signal Classification (MUSIC)');
initialize(this,varargin{:});


% [EOF]
