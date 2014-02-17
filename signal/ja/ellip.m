%ELLIP  楕円またはカウアーデジタルおよびアナログフィルタの設計
%
%   [B,A] = ELLIP(N,Rp,Rs,Wp) は、Rp デシベルのピーク間リップルと Rs 
%   デシベルの低い遮断帯域減衰をもつ N 次のローパスデジタル楕円フィルタを
%   設計します。ELLIP は、フィルタ係数を、長さ N+1 のベクトル B (分子) 
%   および A (分母) に返します。通過帯域のエッジ周波数 Wp は、サンプル
%   レートの半分が 1.0 に対応するものとして、0.0 < Wp < 1.0 でなければ
%   なりません。これらが選択されていない場合、開始点として、Rp = 0.5 と 
%   Rs = 20 を使用します。
%
%   Wp が 2 要素ベクトル Wp = [W1 W2] の場合、ELLIP は通過帯域 W1< W <W2 
%   をもつ 2N 次のバンドパスフィルタを返します。
%   [B,A] = ELLIP(N,Rp,Rs,Wp,'high') は、ハイパスフィルタを設計します。
%   [B,A] = ELLIP(N,Rp,Rs,Wp,'low') は、ロ-パスフィルタを設計します。
%   Wp = [W1 W2] の場合、[B,A] = ELLIP(N,Rp,Rs,Wp,'stop') は、バンド
%   ストップフィルタを設計します。
%
%   [Z,P,K] = ELLIP(...) のように、左辺に 3 つの出力引数を使用する場合、
%   零点と極を長さ N の列ベクトル Z と P に、またゲインをスカラ K に
%   返します。
%
%   [A,B,C,D] = ELLIP(...) のように、左辺に 4 つの出力引数を使用する場合、
%   状態空間行列を返します。
%
%   ELLIP(N,Rp,Rs,Wp,'s'), ELLIP(N,Rp,Rs,Wp,'high','s'), 
%   ELLIP(N,Rp,Rs,Wp,'stop','s') は、アナログ楕円フィルタを設計します。
%   この場合、Wp は、[rad/s] の 単位をもち、1 より大きく設定できます。
%
%   参考 ELLIPORD, CHEBY1, CHEBY2, BUTTER, BESSELF, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
