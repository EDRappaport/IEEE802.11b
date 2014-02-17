%REORDER  セクションの並び替え
%
%   REORDER(HD, ORDER) は、ORDER 内のインデックスのベクトルを使って、
%   フィルタのセクションを並び替えます。ORDER は、フィルタのインデックスの
%   すべてを含む必要はありません。これは、フィルタから見つからないインデックス
%   を削除します。論理配列は、フィルタからのセクションを削除するために使用
%   することもできますが、並び替えを行ないません。
%
%   HNEW = REORDER(HD, ORDER) は、出力が要求された場合、新規フィルタは
%   新規セクションの並びで生成され、オリジナルのフィルタは変更されません。
%
%   REORDER(HD, NUMORDER, DENORDER) は、NUMORDER と DENORDER のそれぞれの
%   インデックスのベクトルを使って、別々に分子係数と分母係数を並び替えます。
%   これらのベクトルは同じ長さでなければなりません。
%
%   REORDER(HD, NUMORDER, DENORDER, SVORDER) は、ScaleValues を独立に並び
%   替えることができます。SVORDER が指定されていない場合、ScaleValues は
%   分子係数で並び替えられます。出力のスケール値は、NUMORDER がスケール値を
%   並び替えるために使われる場合、常に最後の値が残ります。
%
%   REORDER(HD, FILTER_TYPE) の FILTER_TYPE はつぎのいずれかです: 
%   'auto','lowpass', 'highpass', 'bandpass', 'bandstop'。与えられた
%   フィルタタイプに適した方法で HD を並び替えます。このモードは、固定
%   小数点の実装を意図しており、セクションの並び替えは、フィルタの実行に
%   おいて大きな影響をもちます。
%
%   自動的な並び替えは、Hd が FDESIGN を使って設計された結果から得られた
%   場合のみ有効になります。セクションは、設計の応答タイプ (ローパス、
%   ハイパス等) に依存して自動的に並び替えられます。
%
%   REORDER(HD, DIR_FLAG) は、DIR_FLAG ='UP' の場合、1 番目のセクションは、
%   原点に最も近い極を含み、最後の行は、単位円に最も近い極を含みます。
%   DIR_FLAG = 'DOWN' の場合、その順番は、'UP' の逆になります。零点は常に
%   それらに最も近い極との組み合わせになります。
%
%   REORDER(HD, DIR_FLAG, SV) の SV は、ScaleValues をどのように並び替える
%   必要があるかを示す文字列 'poles' または 'zeros' のいずれかになります。
%   デフォルトでは、スケール値は、DIR_FLAG オプションを使用する場合は並び
%   替えられません。
%
%   % 例
%   % 自動的な並び替えを使用します。
%   Hs = fdesign.lowpass('N,F3db',15, .5);
%   Hd = design(Hs,'butter');
%   reorder(Hd,'auto');
%
%   % 2 番目のセクションを 7 番目と 8 番目のセクション間に移動することで
%   % セクションの並び替えを行ないます。
%   reorder(Hd, [1 3:7 2 8]);
%   hfvt = fvtool(Hd, 'Analysis', 'coefficients');
%
%   % 3 番目と 4 番目と 7 番目のセクションを削除します。
%   Hd1 = reorder(Hd, logical([1 1 0 0 1 1 0 1]));
%   setfilter(hfvt, Hd1);
%
%   % 1 番目のセクションを最後に移動し、8 番目のセクションを削除します。
%   Hd2 = reorder(Hd, [2:7 1]);
%   setfilter(hfvt, Hd2);
%
%   % 分子係数と分母係数を独立に移動します。
%   Hd3 = reorder(Hd, [1 3:8 2], [1:8]);
%   setfilter(hfvt, Hd3);
%
%   参考 DFILT/CUMSEC, DFILT/SCALE, DFILT/SCALECHECK, FDESIGN.


%   Copyright 1988-2007 The MathWorks, Inc.
