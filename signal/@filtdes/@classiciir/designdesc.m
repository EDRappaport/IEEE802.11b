function str = designdesc(d)
%DESIGNDESC   Returns the design comment.

%   Author(s): J. Schickler
%   Copyright 1988-2009 The MathWorks, Inc.
%   $Revision: 1.2.4.4 $  $Date: 2011/10/31 06:34:07 $

str = sprintf('%% Construct an FDESIGN object and call its %s method.', ...
    upper(designfunction(d)));

% [EOF]
