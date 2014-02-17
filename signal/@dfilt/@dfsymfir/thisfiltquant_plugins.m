function constr = thisfiltquant_plugins(h,arith)
%FILTQUANT_PLUGINS Table of filterquantizer plugins

%   Author(s): R. Losada
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.9 $  $Date: 2012/10/29 19:32:56 $

switch arith
    case 'fixed',
        [wstr wid] = lastwarn;
        w = warning('off');
        constr = 'quantum.fixeddfsymfirfilterq';
        lastwarn(wstr, wid)
        warning(w);
end
