function pv = blockparams(this, mapstates, varargin) %#ok<INUSD>
%BLOCKPARAMS   Return the block parameters.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2012/10/29 19:33:22 $

% MAPSTATES is ignored because a gain doesn't have states.

pv  = scalarblockparams(this.filterquantizer);

pv.Gain = num2str(get(reffilter(this), 'Gain'));
