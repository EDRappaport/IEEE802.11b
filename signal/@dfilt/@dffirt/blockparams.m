function s = blockparams(Hd, mapstates, forceDigitalFilterBlock)
%BLOCKPARAMS Returns the parameters for BLOCK

% Copyright 1988-2012 The MathWorks, Inc.
% $Revision: 1.1.4.6 $ $Date: 2012/10/29 19:32:53 $

if nargin < 3
  forceDigitalFilterBlock = false;
end

s = fir_blockparams(Hd, mapstates,forceDigitalFilterBlock);

if ~forceDigitalFilterBlock
  s.FilterStructure = 'Direct form transposed';
else
  s.FIRFiltStruct = 'Direct form transposed';
end

