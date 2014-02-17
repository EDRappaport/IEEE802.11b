%CASCADE  離散時間フィルタのカスケードを作成
%
%   Hd = CASCADE(Hd1, Hd2, etc) は、複数の dfilt フィルタHd1,Hd2,... が
%   直列接続された cascade タイプの離散時間フィルタHd を返します。
%   フィルタオブジェクトの詳細は、<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> デモを
%   参照してください。このカスケードのブロック線図は、以下のような形になります。
%
%      x ---> Hd1 ---> Hd2 ---> etc. ---> y
%
%   Filter Design Toolbox がインストールされている場合、通常は、明確に 
%   CASCADE フィルタを作成しないことに注意してください。代わりに、<a href="matlab:help fdesign">FDESIGN</a> 
%   を使用した設計の結果としてこれらのフィルタを得ます。
%
%   % 例 #1:直接インスタンス化
%   Hd = dfilt.dffir([0.05 0.9 0.05]);
%   Hgain = dfilt.scalar(2);
%   Hcas = dfilt.cascade(Hgain,Hd)
%   realizemdl(Hcas)    % Simulink が必要
%
%   % 例 #2:補間 FIR ローパスフィルタを設計
%   Hcas = design(fdesign.lowpass('Fp,Fst,Ap,Ast',.1, .12, 1, 60), 'ifir')
%   fvtool(Hcas)        % フィルタの解析
%   x = randn(100,1);   % 入力信号
%   y = filter(Hcas,x); % フィルタを入力信号に適用
%
%   参考 DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
