function [Nb,Na,F,A,P,nfpts] = validatespecs(this, ~)
%VALIDATESPECS Validate the specs

%   Copyright 2005-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/27 01:21:29 $

% Get filter order, amplitudes and frequencies 
Nb = this.NumOrder;
Na = this.DenOrder;
[F,A,P,nfpts] = super_validatespecs(this);

% [EOF]
