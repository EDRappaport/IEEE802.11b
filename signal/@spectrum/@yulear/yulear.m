function this = yulear(varargin)
%YULEAR   Yule-Walker power spectral density (PSD) estimator.
% 
%   SPECTRUM.YULEAR is not recommended.  Use <a href="matlab:help pyulear">pyulear</a> instead.
%
%   H = SPECTRUM.YULEAR returns a Yule-Walker (yulear) PSD estimator.
%
%   H = SPECTRUM.YULEAR(ORDER) returns a Yule-Walker spectral estimator
%   with the order of the autoregressive (AR) model set to the numeric
%   value specified by ORDER.
%
%   YULEAR PSD estimators can be passed to the following functions along
%   with the data to perform that function:
%       <a href="matlab:help spectrum/psd">psd</a>     - calculates the PSD
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - returns options to calculate the PSD
%
%   EXAMPLE: Spectral analysis of a 4th order autoregressive (AR) process.
%      x = randn(100,1);
%      y = filter(1,[1 1/2 1/3 1/4 1/5],x); 
%      h = spectrum.yulear(4);              % Instantiate a yulear object.
%      psd(h,y,'Fs',1000);                  % Plot the PSD.

%   Author(s): P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.

narginchk(0,2);

% Set the properties of the object.
this = spectrum.yulear;
set(this, 'EstimationMethod', 'Yule-Walker');
initialize(this,varargin{:});  % Set Nfft and Order

% [EOF]
