function r = getrealizemdlraterestrictions(~,~)
% GETREALIZEMDLRATERESTRICTIONS Get rate restrictions for the realizemdl
% method.

%   Copyright 2012 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2012/05/15 14:28:51 $

% Single rate filters do not support any type of rate options
r = {'enforcesinglerate', 'allowmultirate'};