function B = setoutport(Bi,N,inport)
%SETOUTPORT Connect this block outport to another block inport

%   Author(s): Roshan R Rammohan
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/05/13 18:13:01 $

error(nargchk(3,3,nargin,'struct'));
B=Bi;

if length(B.outport) >= N
    if ~isa(inport,'filtgraph.inport')
        error(message('signal:filtgraph:block:setoutport:InternalError'));
    end
    B.outport(N).setto(...
        filtgraph.nodeport(inport.nodeIndex,inport.selfindex));
else
    error(message('signal:filtgraph:block:setoutport:SigErr', N));
end
