%GENERATETBSTIMULUS  HDL テストベンチの刺激信号を生成して出力
%
%   GENERATETBSTIMULUS(Hd) は、現在のフィルタに対する設定に基づき、フィルタの
%   入力の刺激信号を生成します。刺激信号は、インパルス、ステップ、ランプ、chirp、
%   ノイズ、またはユーザ定義の刺激信号のいずれか、あるいはすべてを含んでいます。
%   結果は、Hd の入力の量子化の設定を使って量子化されることに注意してください。
%   フィルタ Hd の演算プロパティが 'double' に設定されている場合、倍精度の
%   刺激信号が返されます。演算プロパティが 'fixed' に設定されている場合、
%   刺激信号は固定小数点オブジェクトとして返されます。
%
%   GENERATETBSTIMULUS(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) は、
%   パラメータ/値の組み合わせでテストベンチを生成します。GENERATETBSTIMULUS に
%   対する有効なプロパティと値は、Filter Design HDL Coder のドキュメンテーションの 
%   "Property Reference" の節にリストされています。
%
%   Y = GENERATETBSTIMULUS(Hd,...) は、MATLAB 変数 Y への刺激信号を返します。
%
%   出力引数をもたない GENERATETBSTIMULUS(Hd,...) は、現在の Figure ウィンドウに
%   刺激信号をプロットします。
%
%   例:
%   % フィルタのセットアップ
%   h = firceqrip(30,0.4,[0.05 0.03]);
%   Hb = dfilt.dffir(h);
%   Hb.arithmetic = 'fixed';
%
%   % 刺激信号の生成、またはプロット
%   % ランプと Chirp の刺激信号を生成し、変数 y に返します。
%   y = generatetbstimulus(Hb, 'TestBenchStimulus',{'ramp','chirp'});
%
%   % ノイズの刺激信号を生成し、現在の Figure ウィンドウにプロットします。
%   generatetbstimulus(Hb, 'TestBenchStimulus','noise');
%
%   参考 GENERATEHDL, GENERATETB, FDHDLTOOL


%   Copyright 2003-2007 The MathWorks, Inc.
