%BLOCK  フィルタオブジェクトと等価な DSP System Toolbox のブロックを生成
%
%   BLOCK(Hd) は、Hd と等価な DSP System Toolbox のブロックを生成します。
%
%   BLOCK(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) は、パラメータ/値の組
%   み合わせで指定されたオプションを使って DSP System Toolbox のブロック
%   を生成します。利用可能なパラメータは次のとおりです:
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
%     Blockname           {'filter'}           新規サブシステムブロックに対する名前
%                                              を与える。デフォルトでは、ブロックは 
%                                              'filter' という名前が付きます。
%
%     OverwriteBlock      ['on' {'off'}]       Blockname プロパティで指定された
%                                              ものと同じ名前で既存のブロックを
%                                              上書きするか、新規ブロックを作成
%                                              するかを指定
%
%     MapStates           ['on' {'off'}]       ブロックの初期条件としてフィルタの
%                                              状態をマップするかどうかを指定
%
%     Link2Obj            ['on' {'off'}]       係数値を設定するよりブロックの
%                                              マスク内のフィルタ変数を設定するか
%                                              どうかを指定
%
%    例:
%    [b,a] = butter(5,.5);
%    Hd = dfilt.df1(b,a);
%
%    %#1 デフォルトのシンタックス:
%    block(Hd);
%
%    %#2 パラメータ/値の組み合わせを使用:
%    block(Hd, 'Blockname', 'DF1');


% Copyright 1988-2011 The MathWorks, Inc.
