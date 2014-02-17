function fs_out = get_fs_out(this, fs_out)
%GET_FS_OUT   PreGet function for the 'fs_out' property.

%   Author(s): J. Schickler
%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/06/16 08:24:33 $

if this.NormalizedFrequency
    fs_out = [];
else
    fs_out = this.Fs;
end

% [EOF]
