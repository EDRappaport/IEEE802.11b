function r = getblockraterestrictions(~,inputProcessing)  %#ok<INUSD>
% GETBLOCKRATERESTRICTIONS Get rate restrictions for the block method.

%   Copyright 2012 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2012/05/15 14:28:50 $

% Single rate filters do not support any type of rate options
r = {'enforcesinglerate', 'allowmultirate'};
