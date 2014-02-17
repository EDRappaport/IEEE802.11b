function disp(this)
%DISP   Display this object.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2005/10/14 16:27:33 $

disp(this.tostring);
if strcmpi(get(0, 'FormatSpacing'), 'loose')
    disp(' ');
end

% s = get(this);
% 
% if s.NormalizedFrequency
%     s = rmfield(s, 'Fs');
% end
% 
% % Remove empty fields
% fn = fieldnames(s);
% for i=1:length(fn),
%     if isempty(s.(fn{i})) || all(isnan(s.(fn{i}))),
%         s = rmfield(s, fn{i});
%     end
% end
% 
% siguddutils('dispstr', s);

% [EOF]
