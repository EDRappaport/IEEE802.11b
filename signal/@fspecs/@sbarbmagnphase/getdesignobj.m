function designobj = getdesignobj(~, str)
%GETDESIGNOBJ Get the design object.

%   Copyright 2005-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/01/06 22:58:41 $

%#function fmethod.freqsamparbmagnphase
designobj.freqsamp = 'fmethod.freqsamparbmagnphase';
%#function fmethod.invfreqz
designobj.iirls = 'fmethod.invfreqz';
%#function fmethod.firlssbarbmagnphase
designobj.firls = 'fmethod.firlssbarbmagnphase';
%#function fmethod.eqripsbarbmagnphase
designobj.equiripple = 'fmethod.eqripsbarbmagnphase';

if nargin > 1
    designobj = designobj.(str);
end

% [EOF]
