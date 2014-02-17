%FINDPEAKS  データ内の局所的なピークを検出
%
%   PKS = FINDPEAKS(X) は、ベクトルのデータセット X 内の局所的なピークを
%   見つけます。
%
%   [PKS,LOCS]= FINDPEAKS(X) は、さらにピークの発生する箇所のインデックス 
%   LOCS も返します。
%
%   [...] = FINDPEAKS(X,'MINPEAKHEIGHT',MPH) は、MINPEAKHEIGHT MPH より大きい
%   これらのピークのみを見つけます。最小のピークの高さを指定すると、処理時間の
%   減少に役立ちます。MPH は、実数値のスカラです。MPH のデフォルト値は -Inf です。
%
%   [...] = FINDPEAKS(X,'MINPEAKDISTANCE',MPD) は、少なくとも 
%   MINPEAKDISTANCE MPD で分けられたピークを見つけます。MPD は、正の整数値の
%   スカラです。このパラメータは、局所的な最大ピークに近いところで発生する
%   可能性のある小さいピークを無視するために指定されることがあります。
%   たとえば、局所的な最大ピークがインデックス N で発生する場合、範囲 
%   (N-MPD, N+MPD) 内のすべての小さいピークは無視されます。指定されない場合、
%   MPD は、1 の値に割り当てられます。
%
%   [...] = FINDPEAKS(X,'THRESHOLD',TH) は、少なくとも THRESHOLD TH による
%   周辺のピークよりも大きいピークを見つけます。TH は、0 以上の実数値の
%   スカラです。TH のデフォルト値は 0 です。
%
%   [...] = FINDPEAKS(X,'NPEAKS',NP) は、見つけるピーク数を指定します。
%   NP は、0 より大きい整数です。指定された場合、NP 個のピークを見つけて 
%   NP 個のピークが返されると、処理を終了します。指定されない場合、すべての
%   ピークを返します。
%
%   [...] = FINDPEAKS(X,'SORTSTR',STR) は、ピークの並べ替えの方向を指定
%   します。STR は、'ascend','descend', 'none' のいずれかの値を取ります。
%   指定されない場合、STR は 'none' の値を取り、ピークはそれらの発生する
%   順に返されます。
%
%   参考 DSPDATA/FINDPEAKS


%   Copyright 2007-2008 The MathWorks, Inc.
