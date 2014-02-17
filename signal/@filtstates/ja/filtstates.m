%FILTSTATES  フィルタの状態オブジェクト
%
%   H = FILTSTATES.DFIIR(NUMSTATES,DENSTATES) は、オブジェクトを作成し、
%   'Numerator' と 'Denominator' プロパティをそれぞれ NUMSTATES と 
%   DENSTATES に設定します。
%
%   Filter Design Toolbox は、Fixed-Point Designer と共に、Numerator と 
%   Denominatorの状態の単精度浮動小数点と固定小数点のサポートを有効にすることに
%   注意してください。
%
%   次のメソッドは、DFIIR オブジェクトに対して利用可能です (特定のメソッドに
%   ついてのヘルプを得るには、help filtstates/METHOD とタイプしてください。
%   例. help filtstates/double):
%
%   filtstates/double - FILTSTATES オブジェクトを double のベクトルに変換 
%   filtstates/single - FILTSTATES オブジェクトを single のベクトルに変換
%
%   より詳しい情報については、MATLAB コマンドラインで doc filtstates と
%   入力してください。


%   Copyright 1988-2007 The MathWorks, Inc.
