%REALIZEMDL  フィルタ実現 (Simulink ダイアグラム)
%
%     REALIZEMDL(Hd) は、ユーザ定義の仕様に従い、個々の sum, gain, delay ブロック
%     を使って、Simulink サブシステムブロックにフィルタ Hd のアーキテクチャモデル
%     を自動的に生成します。
%
%     REALIZEMDL(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) は、パラメータ/値
%     の組み合わせでモデルを生成します。realizemdl に対する有効なプロパティと値と、
%     そのデフォルト値、そのプロパティが何を行なうかの説明がこの表にリストされています。
%
%     -------------       ---------------      ----------------------------
%     プロパティ名        プロパティ値         説明
%     -------------       ---------------      ----------------------------
%     Destination         [{'current'}         ブロックを現在の Simulink モデルに
%                          'new'               追加する、ブロックを含む新規モデルを
%                          <user defined>]     作成する、または、ターゲットの
%                                              サブシステムの名前を指定するか
%                                              どうかを指定
%
%     Blockname           {'filter'}           新規サブシステムブロックに対する
%                                              名前を与える。デフォルトでは、
%                                              ブロックは 'filter' という名前が
%                                              付きます。
%
%     OverwriteBlock      ['on' {'off'}]       Blockname プロパティで指定された
%                                              ものと同じ名前で既存のブロックを
%                                              上書きするか、新規ブロックを作成
%                                              するかを指定
%
%     OptimizeZeros       [{'on'} 'off']       零点-ゲインブロックを削除するか
%                                              どうかを指定
%
%     OptimizeOnes        [{'on'} 'off']       直接接続をもつ単一ゲインブロックを
%                                              置き換えるかどうかを指定
%
%     OptimizeNegOnes     [{'on'} 'off']       最も近い Sum ブロックでの符号の
%                                              変更をもつ負の単一ゲインブロックを
%                                              置き換えるかどうかを指定
%
%     OptimizeDelayChains [{'on'} 'off']       等価な遅延を与えるために、カスケード
%                                              に繋がれた Delay ブロックを単一の 
%                                              Integer Delay ブロックに置き換えるか
%                                              どうかを指定
%
%    例:
%    [b,a] = butter(4,.4);
%    Hd = dfilt.df1(b,a);
%
%    %#1 デフォルトのシンタックス:
%    realizemdl(Hd);
%
%    %#2 パラメータ/値の組み合わせを使用:
%    realizemdl(Hd, 'OverwriteBlock', 'on');


%    Copyright 1988-2007 The MathWorks, Inc.
