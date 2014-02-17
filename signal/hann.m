function w = hann(varargin)
%HANN   Hann window.
%   HANN(N) returns the N-point symmetric Hann window in a column vector.
% 
%   HANN(N,SFLAG) generates the N-point Hann window using SFLAG window sampling.
%   SFLAG may be either 'symmetric' or 'periodic'. By default, a symmetric
%   window is returned. 
%
%   % Example:
%   %   Create a 64-point Hann window and display the result in WVTool.
%
%   L=64;
%   wvtool(hann(L))
%
%   See also BLACKMAN, HAMMING, WINDOW.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.10.4.4 $  $Date: 2012/10/29 19:31:17 $ 

% Check number of inputs
error(nargchk(1,2,nargin,'struct'));

[w,msg,msgobj] = gencoswin('hann',varargin{:});
if ~isempty(msg), error(msgobj); end

    
% [EOF] hann.m
