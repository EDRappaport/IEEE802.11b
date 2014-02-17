function [lib, srcblk,hasInputProcessing,hasRateOptions] = blocklib(~,~)
%BLOCKPARAMS Returns the library and source block for BLOCKPARAMS

% Copyright 2006-2012 The MathWorks, Inc.
% $Revision: 1.1.6.3 $ $Date: 2012/10/29 19:33:21 $

lib = 'built-in';
srcblk = 'Gain';

hasInputProcessing = false;
hasRateOptions = false;
