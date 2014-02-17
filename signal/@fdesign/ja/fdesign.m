%FDESIGN  デジタルフィルタ設計
%
%   D = FDESIGN.<RESPONSE> は、ローパス、ハイパス、その他多くのフィルタタイプ
%   のような RESPONSE で指定されたフィルタを設計するために使うことのできる仕様の
%   セットを返します。サポートされる <a href="matlab:help fdesign/responses">responses</a> のリストを
%   得るには、"help fdesign/responses" とタイプしてください。
%
%   設計過程は、フィルタ係数を作成し、特定のフィルタの構造をこれらの係数に
%   関連付けます。フィルタを設計するために、次のコマンドを使用します。
%   <a href="matlab:help fdesign/design">design</a>          -  仕様からの設計
%
%   他の関数は設計過程を助けます:
%   <a href="matlab:help fdesign/designmethods">designmethods</a>   -  与えられた仕様に対して利用可能な設計メソッド
%   <a href="matlab:help fdesign/help">help</a>            -  特定の設計メソッドに対するヘルプを表示
%   <a href="matlab:help fdesign/designopts">designopts</a>      -  <a href="matlab:help fdesign/design">design</a> で使うための設計オプションの構造体を返す
%   <a href="matlab:help fdesign/designoptions">designoptions</a>   -  特定の設計に対するすべての利用可能な設計オプションを表示
%   <a href="matlab:help fdesign/validstructures">validstructures</a> -  特定の設計に対して有効なフィルタ構造を表示
%
%   フィルタを通してデータを処理するには、<a href="matlab:help dfilt/filter">dfilt/filter</a> と <a href="matlab:help mfilt/filter">mfilt/filter</a> を参照してください。
%
%   % 例 - 0.2 の正規化された通過帯域周波数、0.22 の遮断帯域周波数、1 dB の
%   %      通過帯域リップル、60 dB の遮断帯域の減衰を持つ最小次数のローパス
%   %      フィルタを設計します。
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.2, 0.22, 1, 60);
%   f = design(d, 'equiripple');      % FIR 等リップルフィルタを設計
%   info(f)                           % フィルタに関する情報を表示
%
%   % 他の設計を同じ仕様で実行することが可能です
%   designmethods(d,'iir');     % 利用可能な IIR 設計メソッドのリスト
%   f = design(d, 'ellip')      % 楕円 IIR フィルタ (SOS) を設計
%   fvtool(f)                   % 様々なフィルタ応答の可視化
%   input = randn(100,1);
%   output = filter(f,input);   % 楕円フィルタを通してデータを処理
%
%   等リップルのような多くの設計は、設計で指定される様々なオプションを
%   許可します。詳細は、<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\fdesigngettingstarteddemo.html'])">Getting Started Demo</a> を参照するか、または、
%   MATLAB コマンドラインで "doc fdesign" と入力してください。
%
%   <a href="matlab:help filterdesign">Filter Design Toolbox の目次</a>
%
%   参考 FDESIGN/SETSPECS, FDESIGN/NORMALIZEFREQ.


%   Copyright 1999-2007 The MathWorks, Inc.
