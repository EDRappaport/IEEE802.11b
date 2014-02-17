%SIGWIN  ウィンドウオブジェクト
%
%   HWIN = SIGWIN.WINDOW(input1,...) は、タイプ WINDOW のウィンドウオブジェクト 
%   HWIN を返します。SIGWIN でウィンドウタイプを指定しなければなりません。
%   各ウィンドウは、複数の入力を取ります。入力引数なしで SIGWIN.WINDOW を指定する
%   場合、デフォルトのプロパティ値をもつウィンドウが作成されます (デフォルトは
%   個々のウィンドウに依存します)。プロパティは、SET(H,PARAMNAME,PARAMVAL) で
%   変更します。
%
%   SIGWIN.WINDOW は、つぎのいずれかになります:
%
%   <a href="matlab:help sigwin.bartlett">bartlett</a>       - Bartlett ウィンドウ
%   <a href="matlab:help sigwin.barthannwin">barthannwin</a>    - 修正 Bartlett-Hanning ウィンドウ
%   <a href="matlab:help sigwin.blackman">blackman</a>       - Blackman ウィンドウ
%   <a href="matlab:help sigwin.blackmanharris"> - 最小 4-項 Blackman-Harris ウィンドウ
%   <a href="matlab:help sigwin.bohmanwin">bohmanwin</a>      - Bohman ウィンドウ
%   <a href="matlab:help sigwin.chebwin">chebwin</a>        - チェビシェフウィンドウ
%   <a href="matlab:help sigwin.flattopwin">flattopwin</a>     - Flat Top ウィンドウ
%   <a href="matlab:help sigwin.gausswin">gausswin</a>       - Gaussian ウィンドウ
%   <a href="matlab:help sigwin.hamming">hamming</a>        - Hamming ウィンドウ
%   <a href="matlab:help sigwin.hann">hann</a>           - Hann ウィンドウ
%   <a href="matlab:help sigwin.kaiser">kaiser</a>         - Kaiser ウィンドウ
%   <a href="matlab:help sigwin.nuttallwin">nuttallwin</a>     - Nuttall の定義の最小 4-項 Blackman-Harris ウィンドウ
%   <a href="matlab:help sigwin.parzenwin">parzenwin</a>      - Parzen (de la Valle-Poussin) ウィンドウ
%   <a href="matlab:help sigwin.rectwin">rectwin</a>        - 長方形ウィンドウ
%   <a href="matlab:help sigwin.triang">triang</a>        - 長方形ウィンドウ
%   <a href="matlab:help sigwin.tukeywin">tukeywin</a>       - Tukey ウィンドウ
%
%   ウィンドウオブジェクトメソッド
%   sigwin/generate - ウィンドウベクトルの生成
%
%   % 例:128 点のチェビシェフウィンドウを生成
%   Hwin = sigwin.chebwin(128,100);
%   w = generate(Hwin) % ウィンドウを表す値を返す
%   wvtool(Hwin)       % Window Visualization ツール
%
%   より詳しい情報については、MATLAB のコマンドラインで
%       doc sigwin
%   とタイプインしてください。


%   Copyright 1988-2007 The MathWorks, Inc.
