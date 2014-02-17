function flag = passbandspecmet(Hf,Hd,ng)
%PASSBANDSPECMET Check whether passband response is within spec.
%   This should be a private method.

%   Author(s): R. Losada
%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/04/21 04:35:43 $

fd = get(Hf, 'CurrentFDesign');

flag = passbandspecmet(fd,Hd,ng);


% [EOF]
