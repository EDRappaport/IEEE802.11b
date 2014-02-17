function [at,bt,ct,dt] = lp2bs(a,b,c,d,wo,bw)
%LP2BS Lowpass to bandstop analog filter transformation.
%   [NUMT,DENT] = LP2BS(NUM,DEN,Wo,Bw) transforms the lowpass filter
%   prototype NUM(s)/DEN(s) with unity cutoff frequency to a
%   bandstop filter with center frequency Wo and bandwidth Bw.
%   [AT,BT,CT,DT] = LP2BS(A,B,C,D,Wo,Bw) does the same when the
%   filter is described in state-space form.
%
%   % Example:
%   %   Design a Elliptic analog lowpass filter with 5dB of ripple in the 
%   %   passband and a stopband 90 decibels down. Transform this filter to 
%   %   a bandstop filter with center frequency 24Hz and Bandwidth of 10Hz.
%   
%   Wo= 24; Bw=10                   % Define Center frequency and Bandwidth
%   [z,p,k]=ellipap(6,5,90);        % Lowpass filter prototype
%   [b,a]=zp2tf(z,p,k);             % Specify filter in polynomial form
%   [num,den]=lp2bs(b,a,Wo,Bw);     % Convert LPF to BSF
%   freqs(num,den)                  % Frequency response of analog filter
%
%   See also BILINEAR, IMPINVAR, LP2BP, LP2LP and LP2HP

%   Author(s): J.N. Little and G.F. Franklin, 8-4-87
%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.7.4.4 $  $Date: 2012/10/29 19:31:35 $

if nargin == 4		% Transfer function case
        % handle column vector inputs: convert to rows
        if size(a,2) == 1
            a = a(:).';
        end
        if size(b,2) == 1
            b = b(:).';
        end
	% Transform to state-space
	wo = c;
	bw = d;
	[a,b,c,d] = tf2ss(a,b);
end

error(abcdchk(a,b,c,d));
nb = size(b, 2);
[mc,ma] = size(c);

% Transform lowpass to bandstop
q = wo/bw;
at =  [wo/q*inv(a) wo*eye(ma); -wo*eye(ma) zeros(ma)]; %#ok<MINV>
bt = -[wo/q*(a\b); zeros(ma,nb)];
ct = [c/a zeros(mc,ma)];
dt = d - c/a*b;

if nargin == 4		% Transfer function case
    % Transform back to transfer function
    zinf = ltipack.getTolerance('infzero',true);    
    [z,k] = ltipack.sszero(at,bt,ct,dt,[],zinf);    
    num = k * poly(z);
    den = poly(at);
    at = num;
    bt = den;
end
