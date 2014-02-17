function pv = blockparams(this, mapstates, varargin)
%BLOCKPARAMS   Return the block parameters.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $  $Date: 2012/10/29 19:32:41 $

b = isspblksinstalled;
if b,
    % Use DSP System Toolbox block
    pv.delay = sprintf('%d',this.Latency);
else
    pv.NumDelays = sprintf('%d',this.Latency);
end

% IC
if strcmpi(mapstates, 'on'),
    pv.IC = mat2str(getinitialconditions(this));
end

