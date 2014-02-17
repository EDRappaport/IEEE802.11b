function h = tocascadewdfallpass(this)
%TOCASCADEWDFALLPASS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 18:56:36 $

c = coefficients(this);

h = dfilt.cascadewdfallpass(c{:});

% [EOF]
