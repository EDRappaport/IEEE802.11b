function sysObjFlag = validatedesignoptionssysobjinput(~, varargin)
%VALIDATEDESIGNOPTIONSSYSOBJINPUT

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/11/17 21:22:41 $

sysObjFlag = false;

if ~isempty(varargin)
  if ~isfdtbxinstalled
    error(message('signal:fdesign:basecatalog:InvalidSystemObjectInput','''SystemObject''','designoptions'))
  end    
  if ~strcmpi(varargin{1},'SystemObject')
    error(message('signal:fdesign:abstracttypewspecs:designoptions:InvalidInput','''SystemObject'''))
  end    
  if length(varargin) < 2 || (length(varargin{2}) > 1 || (~islogical(varargin{2}) && ~isnumeric(varargin{2})))
    error(message('signal:fdesign:basecatalog:IncompleteInput','''SystemObject''','designoptions'))    
  end 
  sysObjFlag = varargin{2};
end