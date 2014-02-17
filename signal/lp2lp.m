function [at,bt,ct,dt] = lp2lp(a,b,c,d,wo)
%LP2LP Lowpass to lowpass analog filter transformation.
%   [NUMT,DENT] = LP2LP(NUM,DEN,Wo) transforms the lowpass filter
%   prototype NUM(s)/DEN(s) with unity cutoff frequency of 1 rad/sec 
%   to a lowpass filter with cutoff frequency Wo (rad/sec).
%   [AT,BT,CT,DT] = LP2LP(A,B,C,D,Wo) does the same when the
%   filter is described in state-space form.
%
%   % Example:
%   %   Design a Elliptic analog lowpass filter with 5dB of ripple in the 
%   %   passband and a stopband 90 decibels down. Change the cutoff 
%   %   frequency of this lowpass filter to 24Hz.
%   
%   Wo= 24;                         % Cutoff frequency
%   [z,p,k]=ellipap(6,5,90);        % Lowpass filter prototype
%   [b,a]=zp2tf(z,p,k);             % Specify filter in polynomial form
%   [num,den]=lp2lp(b,a,Wo);        % Change cutoff frequency
%   freqs(num,den)                  % Frequency response of analog filter
%
%   See also BILINEAR, IMPINVAR, LP2BP, LP2BS and LP2HP

%   Author(s): J.N. Little and G.F. Franklin, 8-4-87
%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.8.4.4 $  $Date: 2012/10/29 19:31:37 $

if nargin == 3		% Transfer function case
        % handle column vector inputs: convert to rows
        if size(a,2) == 1
            a = a(:).';
        end
        if size(b,2) == 1
            b = b(:).';
        end
	% Transform to state-space
	wo = c;
	[a,b,c,d] = tf2ss(a,b);
end

error(abcdchk(a,b,c,d));

% Transform lowpass to lowpass
at = wo*a;
bt = wo*b;
ct = c;
dt = d;

if nargin == 3		% Transfer function case
    % Transform back to transfer function
    zinf = ltipack.getTolerance('infzero',true);    
    [z,k] = ltipack.sszero(at,bt,ct,dt,[],zinf);    
    num = k * poly(z);
    den = poly(at);
    at = num;
    bt = den;
end
