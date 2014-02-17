function vs = validstructures(this, varargin)
%VALIDSTRUCTURES Returns the valid structures for the design method.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/01 21:29:15 $

% Parse the SystemObject input
[varargin, sysObjFlag] = parsesysobj(this, 'validstructures', varargin{:}); 

% If we are not given a design method, return a structure.
if isempty(varargin)    
    % Loop over all the design methods and call VALIDSTRUCTURES.
    d = designmethods(this);
    for indx = 1:length(d)
        vs.(d{indx}) = validstructures(this, d{indx},'SystemObject',sysObjFlag);
        if isempty(vs.(d{indx}))
          vs = rmfield(vs,d{indx});
        end
    end    
else
    dm = varargin{1};
    firmethods = designmethods(this, 'fir');
    iirmethods = designmethods(this, 'iir');

    if any(strcmpi(firmethods, dm))
      vs = {'firdecim', 'firtdecim'};
    elseif any(strcmpi(iirmethods, dm))
      vs = {'iirdecim', 'iirwdfdecim'};
    else
      error(message('signal:fdesign:decimator:validstructures:InvalidMethod', dm));
    end
    
    if sysObjFlag
      hf = feval(getdesignobj(getcurrentspecs(this),dm));
      if ismultistage(hf)
        vs = cell(1,0);
      else
        sysObjSupportedStructs = getsysobjsupportedstructs(hf);
        [s k ~] = intersect(vs,sysObjSupportedStructs); %#ok
        vs = vs(sort(k));
      end
    end
end

% [EOF]
