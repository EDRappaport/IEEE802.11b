function varargout = stepz(b,varargin)
%STEPZ  Step response of digital filter
%   [H,T] = STEPZ(B,A) computes the step response of the filter:
%
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%
%   given numerator and denominator coefficients in vectors B and A.
%
%   [H,T] = STEPZ(SOS) computes the step response of the filter specified
%   using the second order sections matrix SOS. SOS is a Kx6 matrix, where
%   the number of sections, K, must be greater than or equal to 2. Each row
%   of SOS corresponds to the coefficients of a second order filter. From
%   the transfer function displayed above, the ith row of the SOS matrix
%   corresponds to [bi(1) bi(2) bi(3) ai(1) ai(2) ai(3)].
%
%   In all cases the number of samples is chosen internally, and STEPZ
%   returns the response in column vector H and a vector of times (or
%   sample intervals) in T (T = [0 1 2 ...]').
%
%   [H,T] = STEPZ(...,N) computes the first N samples of the step response.
%   If N is a vector of integers, the step response is computed only at
%   those integer values (0 is the origin).
%
%   [H,T] = STEPZ(...,N,Fs) separates the time samples by T = 1/Fs seconds.
%   Fs is assumed to be in Hz.
%
%   STEPZ(...) with no output arguments plots the step response.
%
%   % Example 1:
%   %   Design a lowpass FIR filter with normalized cut-off frequency at 
%   %   0.3 and show its step response.
%
%   b=fircls1(54,0.3,0.02,0.008);
%   stepz(b)            
%
%   % Example 2:
%   %   Display the step response of a 3rd order Butterworth IIR filter.
%
%   [b,a] = butter(3,0.4);
%   stepz(b,a)             
%
%   % Example 3:
%   %   Design a Butterworth highpass IIR filter, represent its coefficients
%   %   using second order sections, and display its step response.
%
%   [z,p,k] = butter(6,0.7,'high');
%   SOS = zp2sos(z,p,k);    
%   stepz(SOS)          
%
%   See also IMPZ, FREQZ, ZPLANE, GRPDELAY, FVTOOL.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.6.4.7 $ $Date: 2012/12/25 21:35:09 $

narginchk(1,4)

isTF = true; % True if dealing with a transfer function

if all(size(b)>[1 1])
  % Input is a matrix, check if it is a valid SOS matrix
  if size(b,2) ~= 6
    error(message('signal:signalanalysisbase:invalidinputsosmatrix'));
  end
  isTF = false; % SOS instead of transfer function  
  
  if nargin > 1
    N = varargin{1};
  else
    N = [];
  end
  if nargin > 2
    Fs = varargin{2};
  else
    Fs = 1;
  end
end

% If input is a transfer function b,a -----
if isTF
  if nargin > 1
    a = varargin{1};
    if all(size(a)>[1 1])
      error(message('signal:signalanalysisbase:inputnotsupported'));
    end
  else
    a = 1;
  end
  
  if nargin > 2
    N = varargin{2};
  else
    N = [];
  end
  
  if nargin > 3
    Fs = varargin{3};
  else
    Fs = 1;
  end
end

% Compute time vector
M = 0;  NN = [];
if isempty(N)
  % if not specified, determine the length
  if isTF
    N = impzlength(b,a);
  else
    N  = impzlength(b);
  end
elseif length(N)>1  % vector of indices
  
  NN = round(N);
  N = max(NN)+1;
  M = min(min(NN),0);
end

t = (M:(N-1))'/Fs;

% Form input vector
x = ones(size(t));

if isTF
  s = filter(b,a,x);
else
  s = sosfilt(b,x);
end
  
if ~isempty(NN),
  s = s(NN-M+1);
  t = t(NN-M+1);
end

if nargout,
    varargout = {s,t};
else
    timezplot(t,s,Fs,getString(message('signal:stepz:Step')));
end

