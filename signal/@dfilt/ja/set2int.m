%SET2INT  係数を整数にスケーリング
%
%   SET2INT(Hd) は、係数を整数にスケーリングし、係数と入力の小数部の
%   長さを 0 に設定します。
%
%   SET2INT(Hd, COEFFWL) は、係数を表すために COEFFWL で定義されたビット数を
%   使用します。
%
%   SET2INT(Hd, COEFFWL, INWL) は、係数を表すために COEFFWL で定義された
%   ビット数を使用し、ビット数は、入力を表すために INWL で定義されます。
%
%   G = SET2INT(...) は、係数を整数にスケーリングすることでフィルタに
%   導入されるゲイン G を返します。G は常に 2 のべき乗です。
%
%   例：
%
%   パート 1:小数と整数のモードにおけるフィルタのステップ応答を比較
%   ---------------------------------------------------------------
%   f = fdesign.lowpass('N,Fc',100,.25);
%   h = design(f);
%   h.Arithmetic = 'fixed';
%   h.InputFracLength = 0; % 整数の入力
%   x = ones(100,1);
%   yfrac = filter(h,x); % 小数モード
%
%   g = set2int(h);
%   yint = filter(h,x);  % 整数モード
%   % 整数の出力を再スケーリング
%   ysint1 = double(yint)/g;
%   % スケーリングされた出力が小数の出力と等しいかを検証
%   max(abs(ysint1-double(yfrac)))
%
%   パート 2:出力のバイナリを再解釈
%   -------------------------------
%   % 同じスケールで入力と出力を入れる別の方法で MSB を同じように重み
%   % 付けします。
%   WL = yint.WordLength;
%   FL = yint.Fractionlength + log2(g);
%   ysint2 = fi(zeros(size(yint)),true,WL,FL);
%   ysint2.bin = yint.bin;
%   max(abs(double(ysint2)-double(yfrac)))


%   Copyright 2004-2007 The MathWorks, Inc.
