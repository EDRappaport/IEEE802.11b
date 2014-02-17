%GMONOPULS  Gaussian モノパルス発生器
%
%   Y = GMONOPULS(T,FC) は、配列 T に示された時間における中心周波数 FC 
%   (ヘルツ) をもつ単位振幅の Gaussian モノパルスのサンプルを返します。
%   デフォルトでは、FC=1000 Hz です。
%
%   TC = GMONOPULS('cutoff',FC) は、パルスの最大振幅と最小振幅の間の時間分を
%   返します。
%
%   デフォルト値は、空または入力引数を省略することにより使用できます。
%
%   例 1:100 GHz のレートでサンプリングされた 2 GHz の Gaussian モノパルスを
%      プロットします。
%       fc = 2E9;  fs=100E9;
%       tc = gmonopuls('cutoff', fc);
%       t  = -2*tc : 1/fs : 2*tc;
%       y = gmonopuls(t,fc); plot(t,y)
%
%   例 2:例 1 から 7.5nS の間隔でモノパルス列を生成します。
%       fc = 2E9;  fs=100E9;           % 中心周波数、サンプル周波数
%       D = [2.5 10 17.5]' * 1e-9;     % パルス遅れ時間
%       tc = gmonopuls('cutoff', fc);  % 各パルス間の幅
%       t  = 0 : 1/fs : 150*tc;        % 信号を計算する時間
%      yp = pulstran(t,D,@gmonopuls,fc);
%      plot(t,yp)
%
%   参考 GAUSPULS, TRIPULS, PULSTRAN, CHIRP.


%   Copyright 1988-2007 The MathWorks, Inc.
