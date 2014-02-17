%DECIMATE  ローパスフィルタを適用した後のサンプリングレートの低減 (間引き)
%
%   Y = DECIMATE(X,R) は、オリジナルのサンプルレートの 1/R 倍でベクトル 
%   X の列をリサンプルします。結果のリサンプルされたベクトル Y は、R 倍
%   短くなります。すなわち、LENGTH(Y) = CEIL(LENGTH(X)/R)。デフォルトでは、
%   DECIMATE は、リサンプリングの前に、カットオフ周波数 0.8*(Fs/2)/R の 
%   8 次のローパスチェビシェフ I 型フィルタでデータをフィルタリングします。
%
%   Y = DECIMATE(X,R,N) は、N 次のチェビシェフフィルタを使用します。13 次
%   より大きい N に対して、DECIMATE は結果の信頼性の欠如に関する警告を
%   生成します。以下の注意を参照してください。
%
%   Y = DECIMATE(X,R,'FIR') は、FIR1(30,1/R) で生成される 30 次の FIR 
%   フィルタを使用します。
%
%   Y = DECIMATE(X,R,N,'FIR') は、長さ N の FIR フィルタを使用します。
%
%   注意:R が大きくなると (すなわち R > 13)、R を各要素に分割して DECIMATE 
%   を何回か実行する方法を勧めます。
%
%   例: 4 の要素で信号を間引きします。
%   t = 0:.00025:1;  % 時間ベクトル
%   x = sin(2*pi*30*t) + sin(2*pi*60*t);
%   y = decimate(x,4);
%   subplot(1,2,1);
%   stem(x(1:120)), axis([0 120 -2 2])   % オリジナルの信号
%   title('Original Signal')
%   subplot(1,2,2);
%   stem(y(1:30)))                        % 間引き後の信号
%   title('Decimated Signal')
%
%   参考 DOWNSAMPLE, INTERP, RESAMPLE, FILTFILT, FIR1, CHEBY1, 
%        Filter Design Toolbox の MFILT/FIRDECIM, MFILT.


%   Copyright 1988-2007 The MathWorks, Inc.
