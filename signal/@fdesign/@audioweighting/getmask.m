function [F, A] = getmask(this, fcns, ~, ~)
%GETMASK   Get the mask.

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/10/16 06:41:25 $

units = feval(fcns.getunits);
setmaskspecs(this.CurrentSpecs);  
if ~isequal(units,'zerophase')
    
        if this.NormalizedFrequency
            Fs = this.CurrentSpecs.DefaultFs;
        else
            Fs = this.Fs;
        end
   
    F = this.CurrentSpecs.Fmask/(Fs/2);
    A = this.CurrentSpecs.Amask;
    
    %scale frequency and amplitudes if necessary
    F = F*(fcns.getfs()/2);
    
    if isequal(units,'linear')
        A = 10.^(A/20);
    end
    if isequal(units,'squared')
        A = 10.^(A/10);
    end
else %zero phase response
    F=[];
    A=[];
end

% [EOF]
