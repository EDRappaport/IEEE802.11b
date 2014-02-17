%REFFILTER  倍精度浮動小数点フィルタの参照
%
%   Href = REFFILTER(Hd) は、Hd と同じ構造体をもつ新規フィルタ Href を
%   返しますが、参照係数を使用し、その演算プロパティは 'double' に設定
%   されています。
%
%   REFFILTER(Hd) は、返されたフィルタが、実際の (量子化された) 係数では
%   なく、Hd の参照係数をもつ点で、DOUBLE(Hd) とは異なります。
%
%   REFFILTER(Hd) は、比較目的のために機能するフィルタの参照バーションを
%   すぐに得るために有効です。
%
%   % 例:様々な固定小数点フィルタと倍精度浮動小数点フィルタを比較します。
%   f = fdesign.lowpass('N,Fc,Ap,Ast',87,.5,1e-3,1e-6,'linear');
%   H = design(f,'FilterStructure','dffir');
%   H1 = copy(H); H2 = copy(H); % 同じフィルタの 2 つのコピーを生成 
%   H.Arithmetic = 'fixed'; % 固定小数点演算を使って H をフィルタに設定
%   H1.Arithmetic = 'fixed'; % H1 と同じ
%   H2.Arithmetic = 'fixed'; % H2 と同じ
%   H.CoeffWordLength  = 16;  % 係数を表すために 16 ビットを使用 
%   H1.CoeffWordLength = 12;  % 係数を表すために 12 ビットを使用 
%   H2.CoeffWordLength =  8;  % 係数を表すために 8 ビットを使用
%   Href = reffilter(H);
%   Hfvt = fvtool(Href,H,H1,H2);
%   set(Hfvt,'ShowReference','off'); % 参照は既に表示 (一度) 
%   legend(Hfvt,'Reference filter','16-bits','12-bits','8-bits');
%
%   参考 dfilt/double.


%   Copyright 2003-2007 The MathWorks, Inc.
