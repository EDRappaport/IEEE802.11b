function chkinputdatatype(varargin)
%CHKINPUTDATATYPE Check that all inputs are double

%   Copyright 2009-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2010/12/06 00:12:09 $


for n = 1:nargin
    if ~isa(varargin{n},'double')
        error(message('signal:chkinputdatatype:NotSupported'));
    end
end



% [EOF]
