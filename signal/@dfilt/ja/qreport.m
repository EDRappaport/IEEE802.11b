%QREPORT  量子化レポート
%
%   R = QREPORT(Hd) は、フィルタオブジェクト Hd に格納されたログレポート 
%   R を返します。ロギングの性能は、'Arithmetic' プロパティを 'fixed' に
%   設定した 'filter' メソッドに組み込まれています。'Logging' FI 設定が 
%   'on' の場合、トリガされます。格納されたレポートは、最後のシミュレーション
%   に対応しています。フィルタコマンドが実行される度に上書きされます。
%
%   QREPORT は、固定小数点フィルタを扱う手段と、フィルタがどのように
%   与えられた刺激信号に応答するかを洞察する方法を与えます。レポートオブジェクト 
%   R は、フィルタの内部信号の構造体指向のリストを含んでいます。それぞれの
%   信号はつぎのものを含みます:
%   - 最後のシミュレーションの間に記録された (量子化する前にログを取った値の) 
%     最小と最大値
%   - 信号の範囲
%   - オーバーフローの数
%
%   このメソッドは、Fixed-Point Designer が必要であることに注意してください。
%
%   % 例 #1:直接型 FIR フィルタの量子化レポート。
%   fipref('LoggingMode', 'on');
%   Hd = design(fdesign.lowpass, 'equiripple');
%   Hd. arithmetic = 'fixed';
%   rand('state', 0);
%   y = filter(Hd, rand(100,1));
%   R = qreport(Hd)
%
%   % 例 #2:直接型 II の 2 次型 IIR フィルタの量子化レポート。
%   fipref('LoggingMode', 'on');
%   Hd = design(fdesign.lowpass, 'ellip');
%   Hd. arithmetic = 'fixed';
%   rand('state', 0);
%   y = filter(Hd, rand(100,1));
%   R = qreport(Hd)
%
%   参考 DFILT/FUNCTIONS


%   Copyright 2005-2007 The MathWorks, Inc.
