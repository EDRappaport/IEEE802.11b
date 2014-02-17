function s = designopts(this, dmethod)
%DESIGNOPTS Display the design options.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:56:30 $

hmethod = feval(getdesignobj(this, dmethod));

% Need to pass hspecs so that the design object can know if a band is
% constrained or not and add or remove the weight design options for that
% band accordingly.
s = designopts(hmethod, this);

% [EOF]
