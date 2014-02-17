function s = blockparams(Hd, mapstates, varargin)
%BLOCKPARAMS Returns the parameters for BLOCK

% Copyright 1988-2012 The MathWorks, Inc.
% $Revision: 1.1.4.10 $ $Date: 2012/10/29 19:32:49 $

s = super_blockparams(Hd);
s.IIRFiltStruct = 'Direct form II transposed';

% IC
if strcmpi(mapstates, 'on'),
    ic    = getinitialconditions(Hd);
    s.IC  = mat2str(ic);
end
