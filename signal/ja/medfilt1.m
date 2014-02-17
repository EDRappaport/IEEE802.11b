%MEDFILT1  1 次元メディアンフィルタリング
%
%   Y = MEDFILT1(X,N) は、次数 N の 1 次元メディアンフィルタリングした 
%   X の出力を返します。Y は、X と同じ長さです。この関数は、ベクトル X の
%   範囲外では 0 と仮定します。X が行列の場合、MEDFILT1 は、X の列に沿って
%   処理します。
%
%   N を指定しない場合、MEDFILT1 は、デフォルトで N = 3 を使います。N が
%   奇数の場合、Y(k) は X( k-(N-1)/2 : k+(N-1)/2) の中央値です。N が偶数の
%   場合、Y(k) は、X( k-N/2 : k+N/2-1) の中央値です。
%
%   MEDFILT1(X,N,BLKSZ) は、for ループを使って、同時に BLKSZ ("ブロックサイズ") 
%   個の出力サンプルを計算します。MEDFILT1 は、N 行 BLKSZ 列の作業用行列を
%   使用するため、計算機のメモリが少ない場合には、BLKSZ << LENGTH(X) を使用
%   してください。デフォルトでは、BLKSZ == LENGTH(X)です。これは、メモリが
%   十分にある場合に実行時間が最も速くなる設定です。
%
%   N 次元の行列の場合、Y = MEDFILT1(X,N,[],DIM)、あるいは、
%   Y = MEDFILT(X,N,BLKSZ,DIM) は、次元 DIM に沿って処理します。
%
%   参考 Image Processing Toolbox の MEDIAN, FILTER, SGOLAYFILT, MEDFILT2


%   Copyright 1988-2007 The MathWorks, Inc.
