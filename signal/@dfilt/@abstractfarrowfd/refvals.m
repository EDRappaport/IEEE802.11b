function rcvals = refvals(this)
%REFVALS   Reference coefficient values.
%This should be a private method.
%   The values are returned in a cell array.

%   Author(s): R. Losada
%   Copyright 2003-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2007/05/23 19:12:19 $

rcnames = refcoefficientnames(this);

rcvals = get(this,rcnames);

% [EOF]
