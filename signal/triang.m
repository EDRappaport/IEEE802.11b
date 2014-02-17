function w = triang(n_est)
%TRIANG Triangular window.
%   W = TRIANG(N) returns the N-point triangular window.
%
%   % Example:
%   %   Create a 200-point triangular window and plot the result using 
%   %   WVTool.
%
%   L=200;
%   wvtool(triang(L)) 
%
%   See also BARTHANNWIN, BARTLETT, BLACKMANHARRIS, BOHMANWIN, 
%            FLATTOPWIN, NUTTALLWIN, PARZENWIN, RECTWIN, WINDOW.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.13.4.2 $  $Date: 2012/10/29 19:32:13 $

error(nargchk(1,1,nargin,'struct'));
[n,w,trivialwin] = check_order(n_est);
if trivialwin, return, end;

if rem(n,2)
    % It's an odd length sequence
    w = 2*(1:(n+1)/2)/(n+1);
    w = [w w((n-1)/2:-1:1)]';
else
    % It's even
    w = (2*(1:(n+1)/2)-1)/n;
    w = [w w(n/2:-1:1)]';
end

    
% [EOF] triang.m
