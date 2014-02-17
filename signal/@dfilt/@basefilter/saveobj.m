function s = saveobj(this)
%SAVEOBJ   Save this object.

%   Copyright 1988-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/01/23 20:56:18 $

s.class   = class(this);
s.version = get(this, 'version');

% Save all of the public properties.
s = setstructfields(s, ...
    savepublicinterface(this));

% Save the reference coefficients.
s = setstructfields(s, ...
    savereferencecoefficients(this));

% Save the metadata.
s = setstructfields(s, ...
    savemetadata(this));

% Save the arithmetic information.
s = setstructfields(s, ...
    savearithmetic(this));

% Save any private data we might need to reproduce the filter.
s = setstructfields(s, ...
    saveprivatedata(this));
  
% Properties added in R2012a and R2012b -----------------------------------
if isprop(this,'FromSysObjFlag') 
  s.FromSysObjFlag = this.FromSysObjFlag;
end

if isprop(this,'FromFilterBuilderFlag') 
  s.FromFilterBuilderFlag = this.FromFilterBuilderFlag;
end

if isprop(this,'ContainedSysObj') && ~isempty(this.ContainedSysObj)
  s.ContainedSysObj = clone(this.ContainedSysObj);
  release(s.ContainedSysObj);
end

if isprop(this,'SupportsNLMethods') 
  s.SupportsNLMethods = this.SupportsNLMethods;
end

% [EOF]
