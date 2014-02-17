function Hd = dispatch(this)
%DISPATCH   

%   Author(s): V. Pellissier
%   Copyright 2005-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2008/12/04 23:21:02 $

d = this.FracDelay;
refd = this.reffracdelay;
c = this.Coefficients;
refc = this.refcoeffs;
m = size(c,2);
for i=1:length(d),
    for j=1:m,
        Hp(j) = dfilt.dffir(d(i)^(m-j)*c(:,j));
        Href(j) = dfilt.dffir(refd(i)^(m-j)*refc(:,j));
    end
    Hd(i) = lwdfilt.tf(tf(parallel(Hp(:))));
    Hd(i).refNum = tf(parallel(Href(:)));
end



% [EOF]
