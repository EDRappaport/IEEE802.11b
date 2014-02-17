% CSD 2つの信号の相互スペクトル密度(CSD)の推定
%
% Pxy = CSD(X,Y,NFFT,Fs,WINDOW)は、Welchの平均化ピリオドグラム法を用いて、
% 信号ベクトルXとYのクロススペクトル密度を推定します。入力XとYはオーバラ
% ップしたセクションに分割され、各々のセクションについて、トレンドが除去
% されます。そして、WINDOWパラメータによって、ウインドウが適用され、長さ
% NFFTに満たない部分にはゼロが付加されます。XとYのセクションで、長さNFFT
% のDFTの積を平均化して、クロススペクトル密度 Pxyが推定されます。ここで、
% Pxyは、NFFTが偶数の場合、長さ(NFFT/2 +1)の列ベクトル、Nが奇数の場合、
% 長さ(NFFT +1)/2の列ベクトルとなります。XまたはYのどちらかが複素数の場
% 合も同様です。WINDOWにスカラを指定すれば、指定した長さのHannウィンドウ
% が適用されます。Fsはサンプリング周波数で、クロススペクトルには影響あり
% ませんが、プロットのスケーリングに使われます。
%
% [Pxy,F] = CSD(X,Y,NFFT,Fs,WINDOW,NOVERLAP)は、CSDを評価するPxyと同じサ
% イズの周波数ベクトルFを出力します。また、NOVERLAPサンプルで、分割した
% X,Yを重ね合わせます。
%
% [Pxy, Pxyc, F] = CSD(X,Y,NFFT,Fs,WINDOW,NOVERLAP,P)は、PxyのP*100パー
% セントの信頼区間の推定値を含んだベクトルPxycを出力します。ここで、Pは0
% と1の間の正のスカラです。
%
% CSD(X,Y,...,DFLAG)は、X,Yのプリウィンドウセクションとして、トレンド除
% 去オプションを設定することができます。ここで、DFLAGには、'linear', 
% 'mean' , 'none'のいずれかの文字列を設定できます。 
% 
% 引数DFLAGは、入力引数のリストの最後に付けなければなりません。 
%
% 例題：  CSD(X,Y,'mean')
% 
% CSDは、出力引数を設定しないと、パラメータ P によって設定された信頼区間
% で、CSDをカレントのFigureウィンドウにプロットします。
%
% デフォルトのパラメータの値は、つぎのように設定されています。NFFT = 256
% (または、LENGTH(X)の小さい値)、NOVERLAP = 0、WINDOW = HANNING(NFFT)、
% Fs = 2、P = .95、DFLAG = 'none'、設定パラメータに空行列[]を使って、デ
% フォルト値を設定することができます。
% 
% 例題：  CSD(X,Y,[],10000).
% 
% 参考：   PSD, COHERE, TFE
%          ETFE, SPA, ARX(System Identification Toolbox)



%   Copyright 1988-2003 The MathWorks, Inc.
