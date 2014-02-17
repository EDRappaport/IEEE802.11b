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

%   Author(s): M. Chugh
%   Copyright 2004-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2011/05/13 18:10:06 $ 

  switch lower(Hb.arithmetic)
   case {'double', 'fixed'}
    result = true;
    errstr = '';
    errorObj = [];
   otherwise
    result = false;
    errorObj = message('signal:dfilt:delay:ishdlable:HdlNotSupported',Hb.arithmetic);
    errstr = getString(errorObj);    
  end