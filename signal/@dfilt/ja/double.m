%DOUBLE  フィルタを能精度演算バージョンにキャスト
%
%   Hd = DOUBLE(H) は、H と同じ構造と係数をもちますが、その演算が 'double' 
%   に設定された新規のフィルタ Hd を返します。
%
%   DOUBLE(H) は、参照係数の代りに H の実 (量子化) 係数をもつフィルタが
%   返されている REFFILTER(H) とは異なります。
%
%   DOUBLE(H) は、フィルタ係数の量子化の影響を隔離したい場合に役立ちます。
%
%   % 例:同じ係数を使って、固定小数点フィルタリングと倍精度浮動小数点
%   % フィルタリングを比較します。
%   f = fdesign.lowpass('N,Fp,Fst',27,0.4,0.6);
%   H = design(f,'FilterStructure','dffir');
%   H.Arithmetic = 'fixed'; % 固定小数点演算を使って H をフィルタに設定
%   Hd = double(H);         % 倍精度浮動小数点にキャスト
%   n = 0:99; x = sin(0.7*pi*n(:)); % 入力信号の設定
%   y = filter(H,x);   % 固定小数点の出力
%   yd = filter(Hd,x); % 浮動小数点の出力
%   norm(yd-double(y),inf)
%
%   参考 DFILT/REFFILTER.


%   Copyright 2003-2007 The MathWorks, Inc.
