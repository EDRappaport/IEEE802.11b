function s = exportinfo(Hwin)
%EXPORTINFO Export information for SIGWIN objects.

%   This should be a private method.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/04/14 04:34:16 $

% Both coefficientnames & coefficientvariables return cell arrays.
s.variablelabel = sigwinname(Hwin); 
s.variablename =  coefficientvariables(Hwin);

% SIGWINs can be exported as both objects and arrays. Filters can also be
% exported as System objects so we need to add this option to the popup
% strings.
s.exportas.tags = {'Coefficients','Objects','System Objects'};

% SIGWIN object specific labels and names
s.exportas.objectvariablelabel = sigwinname(Hwin);
s.exportas.objectvariablename  = sigwinvariable(Hwin);

% Optional fields (destinations & constructors) if exporting to destinations other 
% than the built-in 'Workspace','Text-file', or, 'MAT-file';
s.destinations  = {'Workspace','Text-File','MAT-File'};
s.constructors  = {'','sigio.xp2winfile',''};



% [EOF]
