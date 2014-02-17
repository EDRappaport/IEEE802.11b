%   つぎの関数は、離散時間フィルタ解析に対して利用可能です (特定のメソッドのヘル
%   プを得るには、help dfilt/<FUNCTION> とタイプしてください。例. help 
%   dfilt/freqz):
%
%   -----------------------------------------------------------------------
%   解析
%   -----------------------------------------------------------------------
%   <a href="matlab:help dfilt/info">info</a>         - フィルタ情報
%   <a href="matlab:help dfilt/freqz">freqz</a>        - 離散時間フィルタの周波数応答
%   <a href="matlab:help dfilt/phasez">phasez</a>       - 離散時間フィルタの位相応答
%   <a href="matlab:help dfilt/zerophase">zerophase</a>    - 離散時間フィルタのゼロ位相応答
%   <a href="matlab:help dfilt/grpdelay">grpdelay</a>     - 離散時間フィルタの群遅延
%   <a href="matlab:help dfilt/phasedelay">phasedelay</a>   - 離散時間フィルタの位相遅延
%   <a href="matlab:help dfilt/impz">impz</a>         - 離散時間フィルタのインパルス応答
%   <a href="matlab:help dfilt/impzlength">impzlength</a>   - 離散時間フィルタのインパルス応答の長さ
%   <a href="matlab:help dfilt/stepz">stepz</a>        - 離散時間フィルタのステップ応答
%   <a href="matlab:help dfilt/zplane">zplane</a>       - 極/零点プロット
%   <a href="matlab:help dfilt/cost">cost</a>         - コスト推定(Filter Design Toolbox が必要)
%   <a href="matlab:help dfilt/measure">measure</a>      - 周波数応答の測定の特性(Filter Design Toolbox が必要)
%
%   <a href="matlab:help dfilt/order">order</a>        - フィルタ次数
%   <a href="matlab:help dfilt/coeffs">coeffs</a>       - フィルタ係数
%   <a href="matlab:help dfilt/fftcoeffs">fftcoeffs</a>    - FFT 係数 (DFILT.FFTFIR でのみ利用可能)
%   <a href="matlab:help dfilt/firtype">firtype</a>      - 線形位相 FIR フィルタのタイプ (1-4) を決定
%   <a href="matlab:help dfilt/tf">tf</a>           - 伝達関数に変換
%   <a href="matlab:help dfilt/zpk">zpk</a>          - 離散時間フィルタの零点-極-ゲイン変換
%   <a href="matlab:help dfilt/ss">ss</a>           - 離散時間フィルタを状態空間に変換
%   <a href="matlab:help dfilt/nsections">nsections</a>    - 離散時間フィルタのセクション数
%
%   <a href="matlab:help dfilt/isallpass">isallpass</a>    - オールパス離散時間フィルタに対して真
%   <a href="matlab:help dfilt/iscascade">iscascade</a>    - カスケード離散時間フィルタに対して真
%   <a href="matlab:help dfilt/isfir">isfir</a>        - FIR 離散時間フィルタに対して真
%   <a href="matlab:help dfilt/islinphase">islinphase</a>   - 線形離散時間フィルタに対して真
%   <a href="matlab:help dfilt/ismaxphase">ismaxphase</a>   - 最大位相の場合、真
%   <a href="matlab:help dfilt/isminphase">isminphase</a>   - 最小位相の場合、真
%   <a href="matlab:help dfilt/isparallel">isparallel</a>   - 並列セクションをもつ離散時間フィルタに対して真
%   <a href="matlab:help dfilt/isreal">isreal</a>       - 実数係数をもつ離散時間フィルタに対して真
%   <a href="matlab:help dfilt/isscalar">isscalar</a>     - 離散時間フィルタがスカラの場合、真
%   <a href="matlab:help dfilt/issos">issos</a>        - 離散時間フィルタが 2 次型の形式の場合、真
%   <a href="matlab:help dfilt/isstable">isstable</a>     - フィルタが安定の場合、真
%
%   2 次型 (Filter Design Toolbox が必要)
%   <a href="matlab:help dfilt/scale">scale</a>        - 2 次型のスケーリング
%   <a href="matlab:help dfilt/scalecheck">scalecheck</a>   - 2 次型のスケールをチェック
%   <a href="matlab:help dfilt/scaleopts">scaleopts</a>    - sos のスケーリングに対するオプションのオブジェクトを作成
%   <a href="matlab:help dfilt/specifyall">specifyall</a>   - 固定小数点フィルタの設定をすべて指定
%   <a href="matlab:help dfilt/cumsec">cumsec</a>       - 累積の 2 次型フィルタのベクトル
%   <a href="matlab:help dfilt/reorder">reorder</a>      - 2 次型の並び替え
%
%   固定小数点 (Filter Design Toolbox と Fixed-Point Designer が必要)
%   <a href="matlab:help dfilt/qreport">qreport</a>      - 量子化レポート
%   <a href="matlab:help dfilt/autoscale">autoscale</a>    - ダイナミックレンジのスケーリング
%   <a href="matlab:help dfilt/set2int">set2int</a>      - 係数を整数にスケーリング
%   <a href="matlab:help dfilt/norm">norm</a>         - フィルタのノルム
%   <a href="matlab:help dfilt/normalize">normalize</a>    - フィルタ係数の正規化
%   <a href="matlab:help dfilt/denormalize">denormalize</a>  - NORMALIZE から係数に戻す
%   <a href="matlab:help dfilt/double">double</a>       - フィルタを倍精度浮動小数点演算にキャスト
%   <a href="matlab:help dfilt/reffilter">reffilter</a>    - 倍精度浮動小数点フィルタを参照
%   <a href="matlab:help dfilt/noisepsd">noisepsd</a>     -丸め雑音によるフィルタの出力のパワースペクトル密度
%   <a href="matlab:help dfilt/noisepsdopts">noisepsdopts</a> - noisepsd の計算に対するオプションのオブジェクトを作成
%   <a href="matlab:help dfilt/freqrespest">freqrespest</a>  - フィルタリングによる周波数応答の推定
%   <a href="matlab:help dfilt/freqrespopts">freqrespopts</a> - 周波数応答の推定に対するオプションのオブジェクトを作成
%
%   多段
%   <a href="matlab:help dfilt/cascade">cascade</a>      - カスケードフィルタオブジェクト
%   <a href="matlab:help dfilt/parallel">parallel</a>     - 並列のフィルタの接続
%   <a href="matlab:help dfilt/nstages">nstages</a>      - カスケード、または並列フィルタの段数
%   <a href="matlab:help dfilt/addstage">addstage</a>     - カスケード、または並列フィルタに段を追加
%   <a href="matlab:help dfilt/removestage">removestage</a>  - カスケード、または並列フィルタの段を削除
%   <a href="matlab:help dfilt/setstage">setstage</a>     - カスケード、または並列フィルタの段を設定

%   Copyright 2006-2010 The MathWorks, Inc.
%   $Revision: 1.1.8.3 $  $Date: 2012/09/25 22:24:29 $