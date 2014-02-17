%PARALLEL  離散時間フィルタオブジェクトの並列なシステムを作成
%
%   Hd = PARALLEL(Hd1, Hd2, etc) は、フィルタオブジェクト Hd1, Hd2, ... の
%   並列なシステムを作成します。ブロック線図は以下のようになります。
%
%           |->  Hd1 ->|
%           |          |
%      x ---|->  Hd2 ->|--> y
%           |          |
%           |-> etc. ->|
%
%   フィルタ Hd1, Hd2, ... は、倍精度浮動小数点か単精度浮動小数点のいずれかで
%   なければなりません (Filter Design Toolbox が必要です)。
%
%   Hd1, Hd2, ... は、シングルレートかマルチレートのいずれかでなければなら
%   ず、この場合、並列構造の各ステージのレート変更は同じでなければなりません。
%   マルチレートフィルタは Filter Design Toolbox が必要であることに注意して
%   ください。
%
%   Hd1, Hd2, ... は、並列または直列フィルタにすることもできます。
%
%   % 例:
%   k1 = [-0.0154    0.9846   -0.3048    0.5601];
%   Hd1 = dfilt.latticeallpass(k1);
%   k2 = [-0.1294    0.8341   -0.4165];
%   Hd2 = dfilt.latticeallpass(k2);
%   Hpar = parallel(Hd1 ,Hd2);
%   x = randn(100,1); % 乱数の入力信号を作成
%   y = filter(Hpar,x);
%   realizemdl(Hpar)    % Simulink が必要
%
%   参考 DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
