function w = nuttallwin(N,sflag)
%NUTTALLWIN Nuttall defined minimum 4-term Blackman-Harris window.
%   NUTTALLWIN(N) returns an N-point modified minimum 4-term 
%   Blackman-Harris window with coefficients according to 
%   Albert H. Nuttall's paper. 
%   NUTTALLWIN(N,SFLAG) generates the N-point modified minimum 4-term
%   Blackman-Harris window using SFLAG window sampling. SFLAG may be either
%   'symmetric' or 'periodic'. By default, a symmetric window is returned.
%
%   EXAMPLE:
%      N = 32; 
%      w = nuttallwin(N); 
%      plot(w); title('32-point Nuttall window');
%
%   See also BARTHANNWIN, BARTLETT, BLACKMANHARRIS, BOHMANWIN, 
%            FLATTOPWIN, PARZENWIN, RECTWIN, TRIANG, WINDOW.

%   Reference:
%     [1] Albert H. Nuttall, Some Windows with Very Good Sidelobe
%         Behavior, IEEE Transactions on Acoustics, Speech, and 
%         Signal Processing, Vol. ASSP-29, No.1, February 1981

%   Author(s): P. Costa
%   Copyright 1988-2010 The MathWorks, Inc.
%   $Revision: 1.8.4.2 $  $Date: 2010/07/06 17:14:00 $

error(nargchk(1,2,nargin,'struct'));

if nargin < 2
    sflag = 'symmetric';
end

sflag = validatestring(sflag,{'symmetric','periodic'},'NUTTALLWIN','SFLAG');

% Check for valid window length (i.e., N < 0)
[N,w,trivialwin] = check_order(N);
if trivialwin, return, end;

% Coefficients obtained from page 89 of [1]
a = [0.3635819 0.4891775 0.1365995 0.0106411];
if strncmp(sflag,'p',1)
    x = (0:N-1)' * 2.0*pi/N;
else
    x = (0:N-1)'*2*pi/(N-1);
end
w = min4termwin(a,x);
    

% [EOF]
