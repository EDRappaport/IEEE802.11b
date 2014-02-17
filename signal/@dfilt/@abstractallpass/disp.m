function disp(this)
%DISP   Display this object.

%   Author(s): R. Losada
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/12/22 18:56:25 $

if length(this) > 1
    vectordisp(this);
    return;
end

fn = fieldnames(this);
N = length(fn);

% Reorder the fields. NumSamplesProcessed, ResetStates and States in
% the end.
nidx = [3, 5, 1];
if this.PersistentMemory,
    nidx = [nidx, 4];
end
fn = fn(nidx);

siguddutils('dispstr', this, fn);

% [EOF]
