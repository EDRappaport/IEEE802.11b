%COST  コスト推定
%
%   C = COST(Hd) は、フィルタ Hd に対するコスト推定 C を返します。
%   コスト推定は、つぎのフィールドを含みます:
%     NMULT              :乗算器の数*
%                         (* 0,1,-1 での乗算を除く)
%     NADD               :加算器の数
%     NSTATES            :状態数
%     MULTPERINPUTSAMPLE :入力サンプル単位の乗算数
%     ADDPERINPUTSAMPLE  :入力サンプル単位の加算数
%
%   例:
%   Hd = design(fdesign.lowpass);
%   c = cost(Hd)


%   Copyright 2005-2007 The MathWorks, Inc.
