function [lib, srcblk,hasInputProcessing,hasRateOptions] = blocklib(Hd,~)
%BLOCKPARAMS Returns the library and source block for BLOCKPARAMS

%   Copyright 2008-2012 The MathWorks, Inc.
%   $Revision: 1.1.8.3 $  $Date: 2012/10/29 19:32:32 $

% Library, block

lib = 'dsparch4';

checksv(Hd)
srcblk = 'Biquad Filter';

hasInputProcessing = true;
hasRateOptions = false;
