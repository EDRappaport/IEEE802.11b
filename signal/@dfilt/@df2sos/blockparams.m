function s = blockparams(Hd, mapstates, varargin)
%BLOCKPARAMS   Return the block parameters.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $  $Date: 2012/10/29 19:32:47 $

s = super_blockparams(Hd);
s.IIRFiltStruct = 'Direct form II';

% IC
if strcmpi(mapstates, 'on'),
    ic = getinitialconditions(Hd);
    s.IC  = mat2str(ic);
end
