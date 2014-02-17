%ZEROPHASE  実数フィルタのゼロ位相応答
%
%   [Hr,W] = ZEROPHASE(B,A) は、ゼロ位相応答 Hr と、Hr を計算した点における
%   周波数ベクトル W (rad/sample 単位) を返します。ゼロ位相応答は、単位円の
%   上半分に等間隔に配置された 512 点で評価されます。
%
%   ゼロ位相応答 Hr(w) は、周波数応答 H(w) とつぎの関係があります。
%                                       jPhiz(w)
%                          H(w) = Hr(w)e
%
%   ゼロ位相応答は常に実数ですが、振幅応答と等価ではないことに注意してください。
%   特に、前者は負になりますが、後者は負にできません。
%
%   [Hr,W] = ZEROPHASE(B,A, NFFT) は、ゼロ位相応答を計算する場合、単位円の
%   上半分の NFFT 周波数点を使用します。
%
%   [Hr,W] = ZEROPHASE(B,A,NFFT,'whole') は、単位円の全周の NFFT 個の周波数点を
%   使用します。
%
%   [Hr,W] = ZEROPHASE(B,A,W) は、ベクトル W で示されるラジアン/サンプル (通常、
%   0 と π の間) の、周波数での零点‐位相応答を返します。
%
%   [Hr,F] = ZEROPHASE(...,Fs) は、Hz で表されるサンプリング周波数を使用して、
%   Hr が計算される、周波数ベクトル F (Hz 単位) を決定します。
%
%   [Hr,W,Phi] = ZEROPHASE(...) は、連続的な位相 Phi を返します。ゼロ位相応答が
%   負の場合、この値はフィルタの位相応答と等しくならないことに注意してください。
%
%   ZEROPHASE(...) が、出力引数を持たない場合、周波数に対するゼロ位相応答を
%   プロットします。
%
%   例 #1:
%     b=fircls1(54,.3,.02,.008);
%     zerophase(b)
%
%   例 #2:
%     [b,a] = ellip(10,.5,20,.4);
%     zerophase(b,a,512,'whole')
%
%   参考 FREQZ, INVFREQZ, PHASEZ, FREQS, PHASEDELAY, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
