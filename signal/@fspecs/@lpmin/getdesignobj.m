function designobj = getdesignobj(this, str)
%GETDESIGNOBJ   Get the designobj.

%   Author(s): J. Schickler
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $  $Date: 2012/01/06 22:58:28 $

%#function fmethod.butterlpmin
%#function fmethod.cheby1lpmin
%#function fmethod.cheby2lpmin
%#function fmethod.elliplpmin
designobj.butter     = 'fmethod.butterlpmin';
designobj.cheby1     = 'fmethod.cheby1lpmin';
designobj.cheby2     = 'fmethod.cheby2lpmin';
designobj.ellip      = 'fmethod.elliplpmin';

if isfdtbxinstalled
    %#function fdfmethod.eqriplpmin
    %#function fdfmethod.ifirlpmin
    %#function fdfmethod.multistage
    designobj.equiripple = 'fdfmethod.eqriplpmin';
    designobj.ifir       = 'fdfmethod.ifirlpmin';
    designobj.multistage = 'fdfmethod.multistage';
else
    %#function fmethod.eqriplpmin
    designobj.equiripple = 'fmethod.eqriplpmin';
end
%#function fmethod.kaiserlpmin
designobj.kaiserwin  = 'fmethod.kaiserlpmin';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
