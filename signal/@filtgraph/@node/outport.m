function outp = outport(Node,index)

%   Author(s): Roshan R Rammohan
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2010/12/06 00:10:05 $

error(nargchk(1,2,nargin,'struct'));

N = Node;

if nargin > 1
    outp = N.block.outport(index);
else
    if length(N.block.outport) > 0
        outp = N.block.outport;
    else
        error(message('signal:filtgraph:node:outport:InternalError'));
    end
end
