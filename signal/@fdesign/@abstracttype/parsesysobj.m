function [outputCell sysObjFlag] = parsesysobj(~, callingMethod, varargin)
%PARSESYSOBJ Parse SystemObject input design option

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/11/17 21:22:40 $

outputCell = varargin;

sysObjFlag = false;

% Parse the SystemObject input and remove it from the varargin structure or
% cell array.
if ~isempty(varargin) && isstruct(varargin{1})
  fieldNames = fieldnames(varargin{1});
  idx = find(strcmpi(fieldNames,'systemobject'),1);
  if ~isempty(idx)
    if ~isfdtbxinstalled
      error(message('signal:fdesign:basecatalog:InvalidSystemObjectInput','''SystemObject''',callingMethod))
    end    
    sysObjFlag = varargin{1}.(fieldNames{idx(1)});
    outputCell{1} = rmfield(varargin{1},'SystemObject');
  end
else  
  idx = find(strcmpi(varargin,'systemobject'), 1);
  if ~isempty(idx)
    if ~isfdtbxinstalled
      error(message('signal:fdesign:basecatalog:InvalidSystemObjectInput','''SystemObject''',callingMethod))
    end
    if (length(varargin) < idx+1) || (~islogical(varargin{idx+1}) ...
        && ~isnumeric(varargin{idx+1})) || ~isscalar(varargin{idx+1})
      error(message('signal:fdesign:basecatalog:IncompleteInput','''SystemObject''',callingMethod))
    end
    sysObjFlag = varargin{idx+1};
    outputCell([idx idx+1]) = [];
  end
end