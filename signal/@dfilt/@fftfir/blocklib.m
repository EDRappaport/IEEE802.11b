function [lib, srcblk,hasInputProcessing,hasRateOptions] = blocklib(~,~)
%BLOCKPARAMS Returns the library and source block for BLOCKPARAMS

% Copyright 1988-2012 The MathWorks, Inc.
% $Revision: 1.1.6.4 $ $Date: 2012/10/29 19:33:04 $

% Library, block
lib = 'dsparch4';
srcblk = 'Overlap-Add FFT Filter';

hasInputProcessing = false;
hasRateOptions = false;
