%SCALE  2 次型スケーリング
%
%   SCALE(Hd) は、Hd が固定小数点演算モードの場合、オーバーフローの可能性を
%   減らすために、ピークの振幅応答のスケーリング (L-∞) を使って 2 次型フィルタ 
%   Hd をスケーリングします。
%
%   HNEW = SCALE(Hd,Pnorm) は、出力が要求された場合、新規フィルタはスケーリング
%   された 2 次型で生成され、オリジナルのフィルタは変更されません。
%
%   SCALE(Hd,Pnorm) は、フィルタをスケーリングするために使われるノルムを指定
%   します。Pnorm は、離散時間領域、または周波数領域のノルムのいずれかです。
%   有効な時間領域のノルムは、'l1','l2', 'linf' です。有効な周波数領域のノルム
%   は、'L1','L2', 'Linf' です。L2-ノルムは、l2-ノルムと等しいです (パーセバル
%   の定理) が、同じことは、他のノルムに対しては正しくないことに注意してください。
%
%   異なるノルムは、つぎのようにどのくらい厳密であるかの項で順番付けられます:
%   'l1' >= 'Linf' >= 'L2' = 'l2' >= 'L1' >= 'linf'
%   最も厳密なスケーリング 'l1' を使用すると、フィルタは、オーバーフローを
%   最小にしようとしますが、最悪の信号-雑音 (SN) 比にもなります。
%   Linf スケーリングは、実際に最も一般的に使われるスケーリングです。
%
%   SCALE(Hd,Pnorm,P1,V1,P2,V2,...) は、パラメータ-値の組み合わせにより、
%   オプションのスケーリングパラメータを指定します。有効な組み合わせは
%   つぎの通りです:
%   パラメータ              デフォルト  説明/有効な値
%   ---------               -------     ------------------------
%   'sosReorder'            'auto'      スケーリングの前にセクションを
%                                       並び替える。
%                                       {'auto','none','up','down','lowpass',
%                                       'highpass','bandpass','bandstop'}
%   'MaxNumerator'          2           分子係数の最大値
%   'NumeratorConstraint'   'none'      {'none', 'unit', 'normalize','po2'}
%   'OverflowMode'          'wrap'      {'wrap','saturate'}
%   'ScaleValueConstraint'  'unit'      {'unit','none','po2'}
%   'MaxScaleValue'         'Not used'  スケール値の最大値
%
%   自動的な並び替えは、Hd が FDESIGN を使って設計された結果から得られた場合
%   のみ有効になります。セクションは、設計の応答タイプ (ローパス、ハイパス等) 
%   に依存して自動的に並び替えられます。
%
%   'MaxScaleValue' は、'ScaleValueConstraint' が 'unit' 以外の何かに設定
%   されている場合にのみ使われます。'MaxScaleValue' が数字に設定される場合、
%   'ScaleValueConstraint' は 'none' に変更されます。
%
%   Hd の 'Arithmetic' プロパティが 'double' または 'single' に設定される場合、
%   示されるデフォルト値は、指定されないすべてのオプションに対して使われます。
%   'Arithmetic' プロパティが 'fixed' に設定される場合、スケーリングオプション
%   に対して使われる値は、Hd の設定に従って設定されます。しかし、スケーリング
%   オプションが Hd の設定と違って指定された場合、このオプションはスケーリングの
%   目的のために使われますが、Hd の設定は変更されません。
%
%   SCALE(Hd,Pnorm,OPTS) は、指定するパラメータ-値の組み合わせの lieu 内の
%   オプションのスケーリングパラメータを指定するために、オプションのオブジェクト
%   を使用します。OPTS オブジェクトは、OPTS = SCALEOPTS(Hd) で作成できます。
%
%     % 例:ローパスの楕円フィルタの Linf ノルムのスケーリング:
%     Hs = fdesign.lowpass; % フィルタ設計仕様のオブジェクトを作成
%     Hd = design(Hs,'ellip');       % 楕円 SOS フィルタを設計
%     scale(Hd,'Linf','ScaleValueConstraint','none','MaxScaleValue',1);
%
%   参考 DFILT/SCALEOPTS, DFILT/SCALECHECK, DFILT/REORDER, 
%        DFILT/CUMSEC, DFILT/NORM, FDESIGN.


%   Copyright 1988-2007 The MathWorks, Inc.
