%MEASURE  フィルタの周波数応答特性の測定
%
%   MEASURE(H) は、フィルタの周波数応答からの様々な量の測定値を表示します。
%   測定された値は、ノミナルな通過帯域のゲインが 3 dB 減衰するフィルタの
%   ゲインにおける、実際の通過帯域のリップル、最小の通過帯域の減衰、
%   周波数点を含めることができます。MEASURE が動作するには、フィルタ H は、
%   Filter Design Toolbox から FDESIGN を使って設計される必要があります。
%   下記の例を参照してください。
%
%   M = MEASURE(H) は、測定値をプログラム的に調べられるように返します。
%   たとえば、3 dB の点を調べるには、M.F3dB とタイプします。調べることの
%   できるすべてのプロパティリストを参照するには、GET(M) とタイプして
%   ください。異なるフィルタ応答は、異なる測定値を生成することに注意して
%   ください。
%
%   周波数の制約のいくつかを指定できない設計については、対応する振幅の
%   測定値を特定できない可能性があります。これらの場合、そのような値に
%   対応する振幅の測定値を特定するために、周波数値を MEASURE に渡すことが
%   できます。このことを示すために、下記の例 #3 を参照してください。
%
%   % 例 #1:バンドパスフィルタの等リップル FIR 設計を測定
%   f = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',0.3,0.4,0.6,0.7,80,1,75);
%   H = design(f,'equiripple');
%   measure(H)
%
%   % 例 #2:多段間引きフィルタの最小遮断帯域の減衰を特定
%   f = fdesign.decimator(4,'lowpass','Fp,Fst,Ap,Ast',0.2,0.22,1,75);
%   H = design(f,'multistage');
%   M = measure(H); M.Astop
%
%   % 例 #3:
%   f = fdesign.lowpass('N,F3dB,Ast',8,0.5,80);
%   h = design(f,'cheby2');
%   measure(h,'Fpass',0.4)
%
%   参考 DFILT/INFO, DFILT/COST.


%   Copyright 2006-2007 The MathWorks, Inc.
