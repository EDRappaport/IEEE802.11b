function r = getblockinputprocessingrestrictions(~)
% GETBLOCKINPUTPROCESSINGRESTRICTIONS Get input processing restrictions for
% the block method.

%   Copyright 2012 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2012/05/15 14:29:00 $

% Does not support elements as channels
r = 'elementsaschannels';