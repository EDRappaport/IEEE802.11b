%NORMALIZEFREQ  周波数仕様の正規化
%
%   NORMALIZEFREQ(D) は、D 内の周波数の仕様を正規化します。
%   'NormalizedFrequency' プロパティを true に設定します。
%   さらに、すべての周波数の仕様が 0 と 1 の間になるように、Fs/2 で正規化します。
%
%   NORMALIZEFREQ(D,BFL) は、BFL が true または false として、
%   'NormalizedFrequency' プロパティを true か false のいずれかに指定します。
%   指定されない場合、BFL はデフォルトで true です。BFL が false に設定
%   される場合、周波数の仕様は Fs/2 を乗算します。
%
%   NORMALIZEFREQ(D,false,Fs) は、'NormalizedFrequency' プロパティが false に
%   設定される場合、新規のサンプリング周波数 Fs の設定を受け入れます。
%
%   参考 FDESIGN, FDESIGN/SETSPECS.


%   Copyright 2003-2007 The MathWorks, Inc.
