function sc = df1df2tscalecheck(Hd,pnorm)
%DF1DF2TSCALECHECK   

%   Author(s): R. Losada
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2004/04/12 23:52:13 $

if nargin < 2,
    pnorm = 'Linf';
end

sc = cumnorm(Hd,pnorm,true);


% [EOF]
