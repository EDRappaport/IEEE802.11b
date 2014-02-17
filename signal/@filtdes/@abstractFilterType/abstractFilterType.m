function varargout = abstractFilterType
%ABSTRACTFILTERTYPES  Constructor for the filter type object.


%   Author(s): R. Losada
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.2.4.5 $  $Date: 2010/12/06 00:08:59 $

error(nargchk(0,0,nargin,'struct'));

% This class is abstract, for now error in the constructor
error(message('signal:filtdes:abstractFilterType:abstractFilterType:AbstractClass'));







