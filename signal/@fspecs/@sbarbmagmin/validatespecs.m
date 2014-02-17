function [F,A,R] = validatespecs(this)
%VALIDATESPECS Validate the specs

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:49 $

% Get amplitudes, frequencies, and ripple
F = this.Frequencies;
A = this.Amplitudes;
R = this.Ripple;

if length(F)~=length(A),
    error(message('signal:fspecs:sbarbmagmin:validatespecs:InvalidSpecifications'))
end

% Force row vectors
F = F(:).';
A = A(:).';


% [EOF]
