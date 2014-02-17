function s = saveobj(this)
%SAVEOBJ   Save this object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.8.1 $  $Date: 2005/08/04 18:03:30 $

s.class      = class(this);
s.AllFDesign = get(this, 'AllFDesign');
s.Response   = get(this, 'Response');
s.ratechangefactors = getratechangefactors(this);

% [EOF]
