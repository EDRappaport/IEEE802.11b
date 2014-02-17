function Hd = design(h,d)
%DESIGN  Method to design the filter given the specs.

%   Author(s): R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.5.4.2 $  $Date: 2010/12/06 00:09:56 $

[Fpass, Dpass] = getdesignspecs(h, d);

if Fpass <= 0.5,
    error(message('signal:filtdes:remezhphalfmin:design:InvalidRange'));
end

b = firhalfband('minorder',1-Fpass,Dpass,'high');

% Construct object
Hd = dfilt.dffir(b);



