function [result, errstr, errorObj] = ishdlable(Hb)
%ISHDLABLE True if HDL can be generated for the filter object.
%   ISHDLABLE(Hd) determines if HDL code generation is supported for the
%   filter object Hd and returns true or false.
%
%   The determination is based on the filter structure and the 
%   arithmetic property of the filter.
%
%   The optional second return value is a string that specifies why HDL
%   could not be generated for the filter object Hd.
%
%   See also DFILT, GENERATEHDL.

%   Copyright 2003-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/05/13 18:10:38 $ 

  switch lower(Hb.arithmetic)
   case {'double', 'fixed'}
    result = true;
    errstr = '';
    errorObj = [];
   otherwise
    result = false;
    errorObj = message('signal:dfilt:dtffir:ishdlable:HdlNotSupportedArith',Hb.arithmetic);    
    errstr = getString(errorObj); 
  end
  firlen = length(Hb.numerator);
  if firlen == 1                        % zero order case
     result = false;
     errorObj = message('signal:dfilt:dtffir:ishdlable:HdlNotSupportedZeroOrder');
     errstr = getString(errorObj); 
  end
    
% [EOF]
