function [out coeffnames variables] = mapcoeffstoports(this,varargin)
%MAPCOEFFSTOPORTS 

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:05:04 $

out = parse_mapcoeffstoports(this,varargin{:});

coeffnames = {'K1','K2','B'};
idx = find(strcmpi(varargin,'CoeffNames'));
if ~isempty(idx),
    userdefinednames = varargin{idx+1}; 
    % if user-defined coefficient names are empty, return the default names.
    if ~isempty(userdefinednames)
        coeffnames = userdefinednames;
    end
end

if length(coeffnames)~=3,
    error(message('signal:dfilt:calattice:mapcoeffstoports:InvalidValue'));
end

variables = coefficients(this);


% [EOF]
