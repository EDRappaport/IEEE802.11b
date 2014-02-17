function [out coeffnames variables] = base_mapcoeffstoports(this,varargin)
%BASE_MAPCOEFFSTOPORTS 

%   Copyright 2008 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:04:32 $

coeffnames = [];
variables = [];
[out idx] = parse_mapcoeffstoports(this,varargin{:});

if ~isempty(idx), 
    error(message('signal:dfilt:basefilter:base_mapcoeffstoports:InvalidParameter', class( this )));
end

% [EOF]
