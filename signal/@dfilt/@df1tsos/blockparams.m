function s = blockparams(Hd, mapstates, varargin)
%BLOCKPARAMS Returns the parameters for BLOCK

% Copyright 1988-2012 The MathWorks, Inc.
% $Revision: 1.1.6.10 $ $Date: 2012/10/29 19:32:45 $

s = super_blockparams(Hd);
s.IIRFiltStruct = 'Direct form I transposed';

% IC
if strcmpi(mapstates, 'on'),
   
    ic  = getinitialconditions(Hd);    
    s.ICNum = mat2str(ic.Num);
    s.ICDen = mat2str(ic.Den);
    
end
