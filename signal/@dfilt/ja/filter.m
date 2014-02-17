%FILTER  離散時間フィルタの実行 ("run")
%
%   Y = FILTER(Hd,X) は、フィルタリングされたデータ Y を作成するために、
%   離散時間フィルタオブジェクト Hd を使って、データ X をフィルタリングします。
%   最終条件は Hd.States に格納されます。
%
%   Hd.PersistentMemory が false (デフォルト) の場合、初期条件は、フィルタリング
%   の前に 0 に設定されます。
%
%   Hd.PersistentMemory が偽 (デフォルト) の場合、初期条件はフィルタリングの
%   前に 0 に設定されます。スカラが指定された場合、正しい長さのベクトルに
%   拡張されます。
%
%   X が行列の場合、各列は、独立なチャネルとしてフィルタリングされます。
%   この場合、初期条件は、Hd.States を NSTATES(Hd) 行と SIZE(X,2) 列の行列に
%   設定することで、各チャネルに対して個々に最適に指定されます。X が多次元
%   配列の場合、フィルタは 1 番目の非シングルトン次元で処理を行ないます。
%
%   FILTER(Hd,X,DIM) は、次元 DIM に沿って演算を行ないます。X がベクトル、
%   または行列で、DIM が 1 の場合、X の各列は、チャネルとして扱われます。
%   DIM が 2 の場合、各行はチャネルを表します。
%
%   例:
%   x = randn(100,1);       % オリジナル信号
%   b = fir1(50,.4);        % 50 次の線形位相 FIR フィルタ
%   Hd = dfilt.dffir(b);    % 直接型 FIR を実行
%
%   % 初期条件なし
%   y1 = filter(Hd,x);      % PersistentMemory を false (デフォルト)
%   zf = Hd.States;         % 最終条件
%
%   % 非零の初期条件
%     Hd.PersistentMemory = true;
%   Hd.States = 1;          % スカラ拡張を利用
%     y2 = filter(Hd,x);
%   stem([y1 y2])           % 初めの異なる列
%
%   % データのストリーミング
%   reset(Hd);              % フィルタ履歴のクリア
%   y3 = filter(Hd,x);      % 1 つのブロックで入力信号のフィルタリング
%   reset(Hd);              % フィルタ履歴のクリア
%     yloop = [];
%     xblock = reshape(x,[20 5]);
%   % セクション毎の信号をフィルタリングは、全体の信号を一度にフィルタリング
%   % することと等価です。
%     for i=1:5,
%       yloop = [yloop; filter(Hd,xblock(:,i))];
%     end
%
%   参考 DFILT/NSTATES


%   Copyright 1988-2007 The MathWorks, Inc.
