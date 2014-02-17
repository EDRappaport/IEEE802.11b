function [lib, srcblk,hasInputProcessing,hasRateOptions] = blocklib(~,~)
%BLOCKPARAMS Returns the library and source block for BLOCKPARAMS

% Copyright 2006-2012 The MathWorks, Inc.
% $Revision: 1.1.6.4 $ $Date: 2012/10/29 19:32:40 $

b = isspblksinstalled;
if b,
    lib = 'dspsigops';
    srcblk = 'Delay';
else
    lib = 'simulink';
    srcblk = 'Discrete/Integer Delay';
end

hasInputProcessing = true;
hasRateOptions = false;
