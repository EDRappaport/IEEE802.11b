function [out coeffnames variables] = mapcoeffstoports(this,varargin)
%MAPCOEFFSTOPORTS 

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2010/12/06 00:05:59 $

out = parse_mapcoeffstoports(this,varargin{:});

coeffnames = {'C'};
idx = find(strcmpi(varargin,'CoeffNames'));
if ~isempty(idx),
    userdefinednames = varargin{idx+1}; 
    % if user-defined coefficient names are empty, return the default names.
    if ~isempty(userdefinednames)
        coeffnames = userdefinednames;
    end
end

if length(coeffnames)~=1,
    error(message('signal:dfilt:farrowfd:mapcoeffstoports:InvalidValue'));
end

variables{1} = this.privcoeffs;

% [EOF]
