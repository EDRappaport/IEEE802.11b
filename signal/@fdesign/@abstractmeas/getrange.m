function Frange = getrange(this,H,w,minfo)
%GETRANGE   Get the range.

%   Author(s): R. Losada
%   Copyright 2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2006/10/18 03:24:17 $


dl = diff(abs(H(w<minfo.Flow)));
dh = diff(abs(H(w>minfo.Fhigh)));
wl = find(sign(dl(1:end-1)) ~= sign(dl(2:end)),1,'last');
if isempty(wl),
    wl = 1;
end
wh = find(sign(dh(1:end-1)) ~= sign(dh(2:end)),1,'first');
offset = find(w>minfo.Fhigh,1,'first');
if isempty(offset),
    offset = 0;
end
if isempty(wh),
    wh = length(w)-offset;
end
Frange = [w(wl),w(offset+wh)];

% [EOF]
