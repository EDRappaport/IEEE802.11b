%COEFFS  構造体内のフィルタ係数を出力
%
%   S = COEFFS(Hd) は、オブジェクト Hd のフィルタ係数を構造体 S に返します。
%   構造体は、オブジェクト Hd 内のプロパティ名と一致するフィールドを持ちます。
%
%   Hd が多段オブジェクト (カスケード、または並列) の場合、返される構造体は、
%   多段フィルタの各段のフィールドを含みます。
%
%   % 例:
%   b  = fir1(25,.5);
%   Hd = dfilt.dffir(b);
%   c  = coeffs(Hd)
%   b2 = firpm(20,[0 0.4 0.5 1],[1 1 0 0]);
%   Hc = cascade(Hd, dfilt.dffir(b2));
%   c2 = coeffs(Hc)


%   Copyright 1988-2007 The MathWorks, Inc.
