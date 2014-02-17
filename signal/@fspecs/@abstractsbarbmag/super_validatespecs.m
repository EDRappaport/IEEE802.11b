function [F,A,P,nfpts] = super_validatespecs(this)
%SUPER_VALIDATESPECS   Validate the specs

%   Author(s): V. Pellissier
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:10:51 $

% Get filter order, amplitudes and frequencies 
F = this.Frequencies;
A = this.Amplitudes;
nfpts = length(F);

if nfpts~=length(A),
    error(message('signal:fspecs:abstractsbarbmag:super_validatespecs:InvalidSpecifications'))
end

% Phases
P = get_phases(this);

% Force row vectors
F = F(:).';
A = A(:).';
P = P(:).';

% [EOF]
