function g = thisnormalize(Hd)
%THISNORMALIZE   

%   Author(s): V. Pellissier
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/04/12 23:53:30 $

lat1 = Hd.refAllpass1;
lat2 = Hd.refAllpass2;
g = [max(abs(lat1)) max(abs(lat2))];
Hd.refAllpass1 = lat1/g(1);
Hd.refAllpass2 = lat2/g(2);


% [EOF]
