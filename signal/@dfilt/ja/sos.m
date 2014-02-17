%SOS  2 次型に変換 (IIR フィルタのみ)
%
%   Hsos = SOS(Hd) は、IIR の離散時間フィルタ Hd を 2 次型に変換します。
%   Hd は、dfilt.df1, dfilt.df1t, dfilt.df2, dfilt.df2t のいずれかの
%   クラスになります。
%
%   SOS(Hd,DIR_FLAG) は、2 次型の次数セクションの並びを指定します。
%   DIR_FLAG ='UP' の場合、最初の行は、原点に最も近い極を含み、最後の
%   行は、単位円に最も近い極を含みます。DIR_FLAG = 'DOWN' の場合、その
%   順番は、'UP' の逆になります。零点は常にそれらに最も近い極の組み合わせ
%   になります。DIR_FLAG のデフォルトは 'UP' です。
%
%   % 例:
%     [b,a] = butter(8,.5);
%     Hd = dfilt.df2(b,a);
%     Hsos = sos(Hd,'up',inf)
%
%   % 例 2:Filter Design Toolbox が利用可能な場合、伝達関数を作成する
%   % よりも SOS 形式に直接設計する方が好ましく、変換は丸め誤差を発生
%   % します。
%     f = fdesign.lowpass('N,F3db',8,0.5);
%     Hsos = design(f,'butter','FilterStructure','df1sos');
%
%   参考 Filter Design Toolbox の DFILT/SCALE


%   Copyright 1988-2007 The MathWorks, Inc.
