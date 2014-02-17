function [lib, srcblk,hasInputProcessing,hasRateOptions] = blocklib(~,link2obj,forceDigitalFilterBlock)
%BLOCKPARAMS Returns the library and source block for BLOCKPARAMS

% Copyright 2012 The MathWorks, Inc.
% $Revision: 1.1.6.1 $ $Date: 2012/10/29 19:33:01 $

narginchk(1, 3)

if nargin == 1
  link2obj = 'off';
  forceDigitalFilterBlock = false;
end
if nargin > 1
  if isempty(link2obj)
    link2obj = 'off';
  end
  if nargin == 2
    forceDigitalFilterBlock = false;
  end  
end

if strcmp(link2obj,'on') || forceDigitalFilterBlock
  lib = 'dsparch4';
  srcblk = 'Digital Filter';
else
  lib = 'simulink/Discrete';
  srcblk = 'Discrete Filter';
end

hasInputProcessing = true;
hasRateOptions = false;
