%DEMOD  通信シミュレーションのための復調
%
%   X = DEMOD(Y,Fc,Fs,METHOD,OPT) は、搬送波の周波数 Fc、サンプリング
%   周波数 Fs をもつ搬送波信号 Y を、次に示す METHOD のオプションのいずれか 
%   1 つを使って復調します。OPT は、オプションで、ユーザが選択する復調方法
%   によって必要になります。
%
%   Fs は、Fs > 2*Fc + BW を満足する必要があります。ここで、BW は変調
%   された信号の帯域幅です。
%
%    METHOD            復調方法の概要
%    'am',       振幅復調、両側波帯、抑圧搬送波。
%    'amdsb-sc'  OPT は設定できません。
%    'amdsb-tc'  振幅復調、両側波帯、伝送搬送波。
%                OPT を設定した場合、復調された信号 X からスカラ OPT 値を
%                引きます。OPT のデフォルト値は 0 です。
%    'amssb'     振幅復調、片側波帯。OPT を使用しません。
%    'fm'        周波数復調
%                OPT を設定した場合、一定の周波数復調 (kf) で実行されます。
%                OPT のデフォルト値は 1 です。
%    'pm'        位相復調
%                OPT を設定した場合、一定の位相復調 (kp) で実行されます。
%                OPT のデフォルト値は 1 です。
%    'pwm'       パルス幅復調
%                OPT を 'centered' に設定すると、左端に立ち上がっている
%                パルスは各搬送波周期の中心に設定されます。
%    'ppm'       パルス位置復調。
%                OPT を使用しません。
%    'qam'       直交振幅復調
%                QAM 信号に対して、[X1,X2] = DEMOD(Y,Fc,Fs,'qam') を使います。
%
%   Y が行列の場合、その各列を復調します。
%
%   参考 Signal Processing Toolbox の MODULATE, Communications Toolbox の 
%        PAMDEMOD, QAMDEMOD, GENQAMDEMOD, FSKDEMOD, PSMDEMOD, MSKDEMOD.


%   Copyright 1988-2007 The MathWorks, Inc.
