function h = bsfir1
%BSFIR1  Constructor for this object.
%
%   Outputs:
%       h - Handle to this object

%   Author(s): R. Losada
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.4 $  $Date: 2002/04/15 00:25:13 $


h = filtdes.bsfir1;

% Call the super's constructor
filterType_construct(h);

