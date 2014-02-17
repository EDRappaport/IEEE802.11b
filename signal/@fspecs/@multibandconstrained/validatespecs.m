function [N,F,E,A,nfpts,Fs,normFreqFlag] = validatespecs(this)
%VALIDATESPECS Validate the specs

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:32 $

% Get filter order, amplitudes and frequencies 
N = this.FilterOrder;
[F,E,A,nfpts,Fs,normFreqFlag] = super_validatespecs(this);

% [EOF]
