function s = obj2struct(this)
%OBJ2STRUCT <short description>

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/11/17 12:41:23 $

s = get(this);
if ~isempty(this.inport)
    for I = 1:length(this.inport)
        X(I) = obj2struct(this.inport(I));
    end
    s.inport = X;
end

clear X;

if ~isempty(this.outport)
    for I = 1:length(this.outport)
        X(I) = obj2struct(this.outport(I));
    end
    s.outport = X;
end

