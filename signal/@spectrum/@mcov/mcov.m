function this = mcov(varargin)
%MCOV   Modified covariance power spectral density (PSD) estimator.
%
%   SPECTRUM.MCOV is not recommended.  Use <a href="matlab:help pmcov">pmcov</a> instead.
%
%   H = SPECTRUM.MCOV returns a modified covariance (mcov) PSD estimator in
%   H.
%
%   H = SPECTRUM.MCOV(ORDER) returns a modified covariance spectral
%   estimator with the order of the autoregressive (AR) model set to the
%   numeric value specified by ORDER.
%
%   MCOV PSD estimators can be passed to the following functions along with
%   the data to perform that function:
%       <a href="matlab:help spectrum/psd">psd</a>     - calculates the PSD
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - returns options to calculate the PSD
%
%   EXAMPLE: Spectral analysis of a 4th order autoregressive (AR) process.
%      x = randn(100,1);
%      y = filter(1,[1 1/2 1/3 1/4 1/5],x);  
%      h = spectrum.mcov(4);                 % Create an mcov estimator.
%      psd(h,y,'Fs',1000);                   % Calculate and plot the PSD.

%   Author(s): P. Pacheco
%   Copyright 1988-2012 The MathWorks, Inc.

narginchk(0,2);

% Set the properties of the object.
this = spectrum.mcov;
set(this, 'EstimationMethod', 'Modified Covariance');
initialize(this,varargin{:});  % Set Nfft and Order

% [EOF]