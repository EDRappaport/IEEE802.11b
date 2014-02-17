function [x,nchans,msg] = checkinputsig(this,x)
%CHECKINPUTSIG   Return the input vector column'ized & number of channels.
%
% This is a private method.

%   Author(s): P. Pacheco
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/31 06:34:14 $

msg = '';
[lenX,nchans] = size(x);
xIsMatrix = ~any([lenX,nchans]==1);

if strcmpi(this.InputType, 'Vector') & xIsMatrix, 
    msg = getString(message('signal:spectrum:MultichannelDatamatricesIsNotSupportedWhenTheInputTy'));
    return;
    
elseif ~xIsMatrix,
    x = x(:);   % Column'ize it.
    [lenX,nchans] = size(x);
end 

% [EOF]
