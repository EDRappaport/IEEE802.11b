function specifyall(this,flag)
%SPECIFYALL   

%   Author(s): R. Losada
%   Copyright 2003-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2006/06/27 23:33:19 $

if nargin < 2,
    flag = true;
end

% Call specifyall on filterquantizer
specifyall(this.filterquantizer,flag);

% [EOF]
