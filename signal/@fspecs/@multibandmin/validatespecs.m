function R = validatespecs(this)
%VALIDATESPECS Validate the specs

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/21 07:09:41 $

super_validatespecs(this);

for idx = 1:this.Nbands
  R(1,idx) = this.(sprintf('%s%d%s','B',idx,'Ripple')); %#ok<AGROW>
end

% [EOF]
