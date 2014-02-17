function setdesignmethod(this, designmethod)
%SETDESIGNMETHOD   Set the designmethod.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:04:54 $

if ~ischar(designmethod),
    error(message('signal:dfilt:basefilter:setdesignmethod:MustBeAString'));
end

set(this, 'privdesignmethod', designmethod);

% [EOF]
