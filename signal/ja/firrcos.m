%FIRRCOS  レイズドコサイン FIR フィルタの設計
%
%   B = FIRRCOS(N,Fc,DF,Fs) は、レイズドコサイン遷移帯域をもつ N 次の
%   ローパス線形位相 FIR フィルタを返します。このフィルタは、カットオフ
%   周波数 Fc、サンプリング周波数 Fs、遷移幅 DF で、単位は Hz です。
%   フィルタ次数 N は偶数でなければなりません。
%
%   Fc +/- DF/2 は、[0 Fs/2] の範囲になければなりません。
%
%   B の係数は、ノミナルな通過帯域のゲインが常に 1 になるように正規化されます。
%
%   FIRRCOS(N,Fc,DF) は、デフォルトのサンプリング周波数として、Fs = 2 を使います。
%
%   B = FIRRCOS(N,Fc,R,Fs,'rolloff') は、3 番目の引数を与えることで、遷移幅 
%   DF の代わりにロールオフファクタを指定することができます。あるいは、
%   B=FIRRCOS(N,Fc,DF,Fs) と等価な B=FIRRCOS(N,Fc,DF,Fs,'bandwidth') を
%   指定することができます。
%
%   R は、[0 1] でなければなりません。
%
%   B=FIRRCOS(N,Fc,DF,Fs,DESIGNTYPE) または
%   B=FIRRCOS(N,Fc,R,Fs,'rolloff',DESIGNTYPE)
%、 引数 DESIGNTYPE に空行列を指定するか 'normal' を指定すると、正規の
%   レイズドコサイン FIR フィルタを設計します。また、引数 DESIGNTYPE に 
%   'sqrt' を与えると二乗根レイズドコサイン FIR フィルタを設計します。
%
%   B=FIRRCOS(...,DESIGNTYPE,DELAY) は、整数遅延を指定できます。DELAY 
%   引数を省略するか、空の場合は、N が偶数か奇数かによって、デフォルト値は 
%   N/2 か (N+1)/2 になります。
%
%   DELAY は、[0,N+1] の範囲の整数でなければなりません。
%
%   B = FIRRCOS(...,DELAY,WINDOW) は、 長さ N+1 のウィンドウを設計した
%   フィルタに適用して、周波数応答におけるリップルを減少させることが可能です。
%   WINDOW は長さ N+1 の列ベクトルでなければなりません。WINDOW を指定
%   しない場合は、箱形ウィンドウが使われます。
%
%   警告:デフォルト値以外の遅延をもったウィンドウを使う場合は注意してください。
%
%   [B,A] = FIRRCOS(...)は、常に A = 1 を返します。
%
%   参考 FIRLS, FIR1, FIR2.


%   Copyright 1988-2007 The MathWorks, Inc.
