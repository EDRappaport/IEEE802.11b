function sosreorder(this,Hd)
%SOSREORDER   Reorder SOS filter.

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/12/04 23:21:09 $

if islphpreorder(this.CurrentSpecs),
    lphpreorder(this,Hd);
else
    bpbsreorder(this,Hd);
end

% [EOF]
