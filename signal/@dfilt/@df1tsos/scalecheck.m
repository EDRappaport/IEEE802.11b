function sc = scalecheck(Hd,pnorm)
%SCALECHECK   

%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/10/01 21:28:52 $

if nargin < 2,
    pnorm = 'Linf';
end
sc = df2df1tscalecheck(Hd,pnorm);

% [EOF]
