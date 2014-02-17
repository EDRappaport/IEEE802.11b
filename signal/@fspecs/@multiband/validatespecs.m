function [N,F,E,A,nfpts,Fs,NormFreqFlag] = validatespecs(this)
%VALIDATESPECS Validate the specs

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/02/21 07:09:24 $

% Get filter order, amplitudes and frequencies 
N = this.FilterOrder;
[F,E,A,nfpts,Fs,NormFreqFlag] = super_validatespecs(this);

% [EOF]
