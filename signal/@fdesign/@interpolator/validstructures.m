function vs = validstructures(this, varargin)
%VALIDSTRUCTURES Return the valid structures for the design method.

%   Copyright 2005-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/10/01 21:29:17 $

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
      % Add a special case for multistage.
      if strcmpi(dm, 'multistage')
        vs = {'firinterp'};
      else
        vs = {'firinterp', 'fftfirinterp'};
      end
    elseif any(strcmpi(iirmethods, dm))
      vs = {'iirinterp', 'iirwdfinterp'};
    else
      error(message('signal:fdesign:interpolator:validstructures:InvalidMethod', dm));
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
