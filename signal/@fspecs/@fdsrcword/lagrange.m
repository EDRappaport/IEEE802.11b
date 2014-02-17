function Hd = lagrange(this, varargin)
%LAGRANGE   

%   Copyright 2007-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/01 21:29:25 $

h = feval(getdesignobj(this, 'lagrange'));

supportedStructs = addsysobjdesignopt(h);

method = 'lagrange';

% Set any p-v pairs specified
for indx = 1:2:length(varargin)
  if isprop(h, varargin{indx})
    set(h, varargin{indx:indx+1});
  else
    error(message('signal:fspecs:abstractspec:design:invalidOption', varargin{ indx }, upper( method )));
  end
end

% Error out before designing the filter if a System object has been
% requested with a structure that is not supported.
if isprop(h,'SystemObject') && h.SystemObject && ...
    ~any(strcmp(d.FilterStructure,supportedStructs))
    error(message('signal:fspecs:basecatalog:SysObjNotSupported',...
      d.FilterStructure,method,'SystemObject',method,'SystemObject'))
end

Hd = design(h,this);


% [EOF]
