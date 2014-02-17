function checkvalidparallel(this)
%CHECKVALIDPARALLEL   Check if parallel is valid and error if not.

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:06:32 $

if ~isvalidparallel(this),
    error(message('signal:dfilt:parallel:checkvalidparallel:invalidParallel'));
end

% [EOF]
