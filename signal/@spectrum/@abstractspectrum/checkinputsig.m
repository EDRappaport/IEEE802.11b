function [x,nchans,msg] = checkinputsig(this,x)
%CHECKINPUTSIG   Return the input vector column'ized & number of channels.
%
% This is a private method.

%   Author(s): P. Pacheco
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2011/10/31 06:34:12 $

% If its a matrix error out.
msg = '';
[lenX,nchans] = size(x);
xIsMatrix = ~any([lenX,nchans]==1);

if xIsMatrix, 
    msg = getString(message('signal:spectrum:MultichannelDatamatricesIsNotSupported'));
    return;
else
    x = x(:);
    [lenX,nchans] = size(x);
end 

% [EOF]
