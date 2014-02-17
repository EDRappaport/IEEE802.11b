%   DFILT.<STRUCTURE> は、以下のいずれかになります (特定の構造体のヘルプを
%   得るには、help dfilt.<STRUCTURE> と入力してください - 例. help dfilt.df1):
%
%   Filter Design Toolbox がインストールされている場合、通常は、明確に DFILT 
%   フィルタを作成しないことに注意してください。代わりに、FDESIGN を使った設計の
%   結果としてこれらのフィルタが得られます。
%
%   -----------------------------------------------------------------------
%             FIR
%   -----------------------------------------------------------------------
%   <a href="matlab:help dfilt.dffir">dffir</a>             - 直接型 FIR
%   <a href="matlab:help dfilt.dffirt">dffirt</a>            - 直接型 FIR 転置
%   <a href="matlab:help dfilt.dfsymfir">dfsymfir</a>          - 直接型対称 FIR
%   <a href="matlab:help dfilt.dfasymfir">dfasymfir</a>         - 直接型非対称 FIR
%   <a href="matlab:help dfilt.fftfir">fftfir</a>            -オーバラップ加算法 FIR
%   <a href="matlab:help dfilt.latticemamax">latticemamax</a>      - 最大位相に対するラティス移動平均 (MA)
%   <a href="matlab:help dfilt.latticemamin">latticemamin</a>      - 最小位相に対するラティス移動平均 (MA)
%   <a href="matlab:help dfilt.farrowlinearfd">farrowlinearfd</a>    - Fallow 構造の線形的な小数部の遅延 (*)
%   <a href="matlab:help dfilt.farrowfd">farrowfd</a>          - Farrow 構造の小数部の遅延(*)
%
%   -----------------------------------------------------------------------
%             IIR
%   -----------------------------------------------------------------------
%   <a href="matlab:help dfilt.allpass">allpass</a>           - 最小の乗算のオールパスフィルタ (*)
%   <a href="matlab:help dfilt.wdfallpass">wdfallpass</a>        - 波形のデジタルオールパスフィルタ (*)
%   <a href="matlab:help dfilt.df1">df1</a>               - 直接型 I
%   <a href="matlab:help dfilt.df1sos">df1sos</a>            - 直接型 I、2 次型
%   <a href="matlab:help dfilt.df1t">df1t</a>              - 直接型 I 転置
%   <a href="matlab:help dfilt.df1tsos">df1tsos</a>           - 直接型 I 転置、2 次型
%   <a href="matlab:help dfilt.df2">df2</a>               - 直接型 II
%   <a href="matlab:help dfilt.df2sos">df2sos</a>            - 直接型 II、2 次型
%   <a href="matlab:help dfilt.df2t">df2t</a>              - 直接型 II 転置
%   <a href="matlab:help dfilt.df2tsos">df2tsos</a>           - 直接型 II 転置、2 次型
%   <a href="matlab:help dfilt.latticeallpass">latticeallpass</a>    - ラティスオールパス
%   <a href="matlab:help dfilt.latticear">latticear</a>         - ラティス自己回帰 (AR)
%   <a href="matlab:help dfilt.latticearma">latticearma</a>       - ラティス自己回帰移動平均 (ARMA)
%   <a href="matlab:help dfilt.statespace">statespace</a>        - 状態空間
%
%   -----------------------------------------------------------------------
%             多段
%   -----------------------------------------------------------------------
%   <a href="matlab:help dfilt.delay">delay</a>             - 整数の遅延
%   <a href="matlab:help dfilt.scalar">scalar</a>            - スカラ
%   <a href="matlab:help dfilt.cascade">cascade</a>           - カスケード (フィルタを直列に配置)
%   <a href="matlab:help dfilt.parallel">parallel</a>          - 並列 (フィルタを並列に配置)
%   <a href="matlab:help dfilt.cascadeallpass">cascadeallpass</a>    - 最小の乗算のオールパスフィルタのカスケード (*)
%   <a href="matlab:help dfilt.cascadewdfallpass">cascadewdfallpass</a> - 波形のデジタルオールパスフィルタのカスケード (*)
%   <a href="matlab:help dfilt.calattice">calattice</a>         - 干渉付きオールパス (CA) ラティス (*)
%   <a href="matlab:help dfilt.calatticepc">calatticepc</a>       - パワーコンプリメンタリー (PC) 出力を持つ干渉付きオールパス (CA) ラティス (*)
%
%   (*) Filter Design Toolbox が必要
%
%   参考 DFILT


%   Copyright 2005-2008 The MathWorks, Inc.
