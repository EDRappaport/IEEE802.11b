function [y,zf] = secfilter(Hd,x,zi)
%SECFILTER Filter this section.
%   [Y,Zf] = SECFILTER(Hd,X,ZI) filters this section.
%
%   See also DFILT.    

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:24:38 $

  
q = Hd.filterquantizer;
a = Hd.privallpasscoeffs;
c = wdfcoefficients(Hd);
[y,zf] = wdfallpassfilter(q,c.Section1,x,zi);



% [EOF]
