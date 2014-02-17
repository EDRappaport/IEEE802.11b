%CUMSEC  累積のセクションに対するフィルタのベクトルを出力
%
%   H = CUMSEC(Hd) は、累積のセクションで SOS フィルタオブジェクトのベクトルを
%   返します。
%
%   H = CUMSEC(Hd, INDICES) は、オリジナルのフィルタへのインデックスが 
%   INDICES にある SOS フィルタオブジェクトのベクトルを返します。
%
%   H = CUMSEC(Hd, INDICES, SECONDARY) は、SECONDARY が true の場合にどの
%   セクションを分離する必要があるかを特定する 2 番目のスケーリングポイントを
%   指定します。SECONDARY はデフォルトでは false です。このオプションは、
%   DF2SOS と DF1TSOS フィルタオブジェクトでのみ効果があります。これらの
%   構造体に対して、2 番目のスケーリングポイントは、再帰と非再帰部の間 
%   (すなわち、セクションの "真ん中") の位置を参照します。
%
%   出力引数をもたない CUMSEC(Hd,...) は、FVTOOL を使って累積のセクションの
%   振幅応答をプロットします。
%
%   % 例: 6 次の sos フィルタの累積のセクションの応答をプロットします。
%   Hs = fdesign.lowpass('N,F3db',6,.4);
%   Hd = design(Hs,'butter');
%   H = cumsec(Hd);
%   Hfvt = fvtool(H);
%   legend(Hfvt,'First section','First two sections','Overall filter');
%
%   参考 DFILT/SCALE, DFILT/SCALECHECK.


%   Copyright 2003-2007 The MathWorks, Inc.
