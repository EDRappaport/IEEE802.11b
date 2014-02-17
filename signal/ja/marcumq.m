% MARCUMQ   一般化 Marcum Q 関数
%
% MARCUMQ(A,B,M) は、つぎのように定義される一般化 Marcum Q 関数です。
%
%      Q_m(a,b) = 1/a^(m-1) * integral from b to inf of
%                 [x^m * exp(-(x^2+a^2)/2) * I_(m-1)(ax)] dx,
%
% ここで、I_(m-1)() は、次数 m-1 の第1種の修正ベッセル関数です。
%
% a と b は、実数の非負でなければなりません。m は正の整数でなければなりません。
% 入力のいずれかがスカラの場合、他の入力のサイズに拡張されます。
%
% MARCUMQ(A,B) は、もともと、Marcum により一覧にされたもので、M = 1 に
% 対して特別なものです。そして、しばしば、サブスクリプトなしに Q(a,b) と
% 記述されることもあります。
%
% 参考 BESSELI.


%   Copyright 1996-2006 The MathWorks, Inc.
