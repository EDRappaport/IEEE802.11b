%DFILT  離散時間フィルタオブジェクト
%
%   Hd = DFILT.<STRUCTURE>(COEFF,...) は、特定のフィルタ STRUCTURE をもつ
%   係数 COEFFS に関連する離散時間フィルタ Hd を返します。係数は、構造に
%   依存する複数の入力で指定されます。
%   <a href="matlab:help dfilt/structures">構造</a> のすべてのリストを
%   見るには、" help dfilt/structures" とタイプしてください。
%
%   デジタルフィルタは、<a href="matlab:help dfilt/freqtransform">周波数変換</a>、
%   <a href="matlab:help dfilt/analysis">解析</a>、<a href="matlab:help dfilt/simulation">シミュレーション</a>、
%   <a href="matlab:help dfilt/codegeneration">コード生成</a> のカテゴリで
%   様々な関数を備えています。(詳細については、help dfilt/<function category> とタイプしてください。
%   例. help dfilt/analysis )
%
%   関数は、デジタルフィルタに関して最も一般的に使われます:
%   <a href="matlab:help dfilt/filter">filter</a>      - 離散時間フィルタを実行 ("run")
%   <a href="matlab:help dfilt/freqz">freqz</a>       - 離散時間フィルタの周波数応答を計算
%   <a href="matlab:help dfilt/realizemdl">realizemdl</a>  - Simulink サブシステムを生成 (Simulink が必要)
%   <a href="matlab:help dfilt/block">block</a>       - Digital Filter ブロックを生成 (DSP System Toolbox が必要)
%   <a href="matlab:help dfilt/generatehdl">generatehdl</a> - HDL コードを生成 (Filter Design HDL Coder が必要)
%
%   Filter Design Toolbox は、Fixed-Point Designer と共に、多くの DFILT 構造の
%   単精度浮動小数点と固定小数点のサポートを有効にすることに注意してください。
%
%   % 例:直接型 FIR ローパスフィルタを設計して構築し、種々の応答を解析します。
%   b = firls(80,[0 .4 .5 1],[1 1 0 0],[1 10]);
%   Hd = dfilt.dffir(b)
%   fvtool(Hd) % フィルタの解析
%
%   より詳しい情報については、<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started Demo</a> 
%   を参照するか、または、MATLAB コマンドラインで "doc dfilt" と入力してください。
%
%   <a href="matlab:help signal">Signal Processing Toolbox の目次</a>
%   <a href="matlab:help filterdesign">Filter Design Toolbox の目次</a>
%
%   参考 Filter Design Toolbox の FDESIGN, MFILT, ADAPTFILT.


%   Copyright 1988-2011 The MathWorks, Inc.
