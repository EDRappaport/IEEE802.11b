%PHASEDELAY  デジタルフィルタの位相遅延
%
%   [PHI,W] = PHASEDELAY(B,A,N) は、N-点位相遅延応答のベクトル PHI と
%   フィルタのラジアン/サンプルでの N-点周波数ベクトル W を返します:
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%   は、ベクトル B と A に、分子と分母の係数を設定します。位相応答は単位円の
%   約上半分の N 点の等間隔な空間で評価されます。N を指定しない場合、デフォルトは 
%   512 です。
%
%   [PHI,W] = PHASEDELAY(B,A,N,'whole') は、単位円全体の周の N 点を使用します。
%
%   PHI = PHASEDELAY(B,A,W) は、ベクトル W で示されるラジアン/サンプル (通常、0 
%   と π の間) の、周波数での位相遅延の応答を返します。
%
%   [PHI,F] = PHASEDELAY(B,A,N,Fs) と [PHI,F] = PHASEDELAY(B,A,N,'whole',Fs) 
%   は、 Fs (Hz) をサンプリング周波数として、位相遅延ベクトル F を返します。
%
%   PHI = PHASEDELAY(B,A,F,Fs) は Fs (Hz) をサンプリング周波数として、指定された
%   ベクトル F (Hz) での周波数の位相遅延を返します。
%
%   PHASEDELAY(B,A,...) が、出力引数を持たない場合、現在の Figure ウィンドウに
%   フィルタの位相遅延の応答をプロットします。
%
%   例 #1:
%     b=fircls1(54,.3,.02,.008);
%     phasedelay(b)
%
%   例 #2:
%     [b,a] = ellip(10,.5,20,.4);
%     phasedelay(b,a,512,'whole')
%
%   参考 FREQZ, PHASEZ, ZEROPHASE, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
