% REMEZ   Parks-McClellan最適等リップルFIRフィルタを設計
%
% REMEZ は古い関数です。REMEZ はまだ動作しますが、将来削除されるかも
% しれません。
% 代わりに FIRPM を使用してください。
%
% 参考 FIRPM.


%   Author(s): L. Shure, 3-27-87
%          L. Shure, 6-8-88, revised
%          T. Krauss, 3-17-93, fixed hilbert bug in m-file version
%          T. Krauss, 3-2-97, consolidated grid generation, function-function

%        D. Shpak, 7-15-99, incorporated C-mex firpm function
%   Copyright 1988-2004 The MathWorks, Inc.
