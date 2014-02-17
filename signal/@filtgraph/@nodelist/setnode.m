function NL = setnode(NLi,Ni,index)
%SETNODE method to add a node into a particular index

%   Author(s): Roshan R Rammohan
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2010/12/06 00:10:09 $

error(nargchk(3,3,nargin,'struct'));
NL = NLi;

if index > NL.nodeCount + 1
    error(message('signal:filtgraph:nodelist:setnode:InternalError'));
end

Ni = Ni.setindex(index);
X = NL.nodes;  

if ~isempty(X)
    X(index) = Ni;
else
    X = Ni;
end
    
NL.nodes = X;

NL.nodeCount = length(NL.nodes);
