function [N,F,Gd,nfpts] = validatespecs(this)
%VALIDATESPECS   Validate the specs

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:20 $

% Get filter order, amplitudes and frequencies 
N = this.FilterOrder;

% Get amplitudes and frequencies 
F = this.Frequencies;
Gd = this.GroupDelay;
nfpts = length(F);

if nfpts~=length(Gd)
  error(message('signal:fspecs:sbarbgrpdelay:validatespecs:InvalidSpecifications')); 
end

% Force row vectors
F = F(:).';
Gd = Gd(:).';

% [EOF]
