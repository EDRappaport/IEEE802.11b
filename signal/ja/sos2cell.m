%SOS2CELL  2 次型行列をセル配列に変換
%
%   C = SOS2CELL(S) は、つぎのフォームの L×6 の 2 次型行列を変換します。
%
%        S =   [B1 A1
%               B2 A2
%                ...
%               BL AL]
%
%   結果はつぎのフォームでセル配列 C になります。
%
%     C = { {B1,A1}, {B2,A2}, ... {BL,AL} }
%
%   ここで、個々の分子ベクトル Bi と分母ベクトル Ai は、線形または 2 次の
%   多項式の係数を表します。
%
%   追加のゲイン項をもつ C = SOS2CELL(S,G) は、つぎのフォームのように C に
%   定数項を追加します。
%
%     C = { {G,1}, {B1,A1}, {B2,A2}, ... {BL,AL} }
%
%   例：
%     [b,a] = butter(4,.5);
%     [s,g] = tf2sos(b,a);
%     c = sos2cell(s,g)
%
%   参考 CELL2SOS, TF2SOS, SOS2TF, ZP2SOS, SOS2ZP, SOS2SS, SS2SOS.


%   Copyright 1988-2007 The MathWorks, Inc.
