function str = gettitlestr(this)
%GETTITLESTR   PreGet function for the 'titlestr' property.

%   Author(s): J. Schickler
%   Copyright 1988-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/31 06:34:08 $

str = sprintf('%% %s %s filter designed using FDESIGN.%s.', ...
    get(this, 'Tag'), ...
    get(this, 'ResponseType'), ...
    upper(get(this, 'ResponseType')));

% [EOF]
