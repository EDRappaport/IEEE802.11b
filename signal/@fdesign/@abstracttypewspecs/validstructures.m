function v = validstructures(this, varargin)
%VALIDSTRUCTURES   Return the valid structures
%   VALIDSTRUCTURES(D) returns the valid structures for the object D and
%   all the available design methods.
%
%   VALIDSTRUCTURES(D, METHOD) returns the valid structures for the object
%   D and the design method, METHOD, in a cell array of strings.
%
%   VALIDSTRUCTURES(D, ..., 'SystemObject', FLAG) limits the list of
%   structures to those that are supported by System objects when FLAG is
%   set to true. Lists all the structures supported by DFILT/MFILT objects
%   when FLAG is set to false. Omitting the 'SystemObject', FLAG input pair
%   is equivalent to setting the FLAG to false (DSP System Toolbox
%   required).

%   Copyright 1999-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/01 21:29:12 $

% Parse the SystemObject input
[varargin sysObjFlag] = parsesysobj(this, 'validstructures', varargin{:});

v_tmp = validstructures(this.CurrentSpecs, varargin{:});

% If SystemObject has been passed as an input and its value is true, then
% remove structures that are not supported by System objects.
if sysObjFlag
  desObjs = fieldnames(getdesignobj(getcurrentspecs(this)));
  hf = feval(getdesignobj(getcurrentspecs(this),desObjs{1}));
  sysObjSupportedStructs = getsysobjsupportedstructs(hf);
  
  if isstruct(v_tmp)
    v = struct;
    methodNames = fieldnames(v_tmp);    
    for idx = 1:length(methodNames)
      hf = feval(getdesignobj(getcurrentspecs(this),methodNames{idx}));
      s = [];
      if ~ismultistage(hf)        
        [s k ~] = intersect(v_tmp.(methodNames{idx}),sysObjSupportedStructs);
      end
      if ~isempty(s)              
        v.(methodNames{idx}) = v_tmp.(methodNames{idx})(sort(k));
      end
    end
  else
    % If v_tmp is not a structure, then it means that a method name was
    % passed as an input.
    hf = feval(getdesignobj(getcurrentspecs(this),varargin{1}));
    if ismultistage(hf)
      v = cell(1,0);
    else
      [s k ~] = intersect(v_tmp,sysObjSupportedStructs); %#ok
      v = v_tmp(sort(k));
    end
  end
else
  v = v_tmp;
end

% [EOF]
