%HANNING  Hanning ウィンドウ
%
%   HANNING(N) は、N 点の対称な Hanning ウィンドウを列ベクトルとして返します。
%   ウィンドウサンプルの最初と最後に 0 が重み付けされているものは含まれないこと
%   に注意してください。
%
%   HANNING(N,'symmetric') は、HANNING(N) と同じ結果を返します。
%
%   HANNING(N,'periodic') は、周期的なN点のHanningウィンドウを返し、最初に 
%   0 が重み付けされているウィンドウサンプルを含みます。
%
%   注意:最初と最後の点が重み 0 の Hanning ウインドウを得るには、関数 HANN を
%        使用してください。
%
%   参考 BARTLETT, BLACKMAN, BOXCAR, CHEBWIN, HAMMING, HANN, KAISER, TRIANG.


%   Copyright 1988-2007 The MathWorks, Inc.
