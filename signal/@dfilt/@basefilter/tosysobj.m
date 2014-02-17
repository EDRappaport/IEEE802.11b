function Hs = tosysobj(this,returnSysObj)
%TOSYSOBJ Convert to a System object

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2011/10/31 06:33:07 $

if ~returnSysObj
  % If returnSysObj is false, then it means that we want to know if the
  % System object conversion is supported for the class at hand. Return a
  % flag as an output instead of throwing an error.
  Hs = false;
  return;
end  

error(message('signal:dfilt:basecatalog:SysobjNotSupported','sysobj',class(this)))
