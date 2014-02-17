function disp(this)
%DISP Object display.
  
%   Author: V. Pellissier
%   Copyright 1999-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.8 $  $Date: 2005/06/30 17:33:24 $

if length(this) > 1
    vectordisp(this);
    return;
end

fn = fieldnames(this);
N = length(fn);
% Reorder the fields. NumSamplesProcessed, ResetStates and States in
% the end.
if N>8, N=8; end
nidx = [3, 5:N, 1];

if this.PersistentMemory,
    % display states
    nidx = [nidx, 4];
end
fn = fn(nidx);

siguddutils('dispstr', this, fn);

disp(this.filterquantizer)

% [EOF]
