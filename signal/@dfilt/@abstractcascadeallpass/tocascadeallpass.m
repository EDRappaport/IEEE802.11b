function h = tocascadeallpass(this)
%TOCASCADEALLPASS   

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 18:56:35 $

c = coefficients(this);

h = dfilt.cascadeallpass(c{:});

% [EOF]
