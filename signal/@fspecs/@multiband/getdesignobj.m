function designobj = getdesignobj(this, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/02/21 07:09:21 $

%#function fmethod.firlsmultiband
designobj.firls = 'fmethod.firlsmultiband';

if isfdtbxinstalled
    
    %#function fdfmethod.eqripmultiband
    designobj.equiripple = 'fdfmethod.eqripmultiband';
    [F, ~] = getmask(this);
    if all(F>=0),
        %#function fdfmethod.lpnormmultiband1
        designobj.iirlpnorm = 'fdfmethod.lpnormmultiband1';
    end
else    
    %#function fmethod.eqripmultiband
    designobj.equiripple = 'fmethod.eqripmultiband';
end

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
