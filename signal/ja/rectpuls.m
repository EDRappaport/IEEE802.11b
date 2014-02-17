%RECTPULS  サンプリングされた周期性をもたない矩形パルスを発生
%
%   RECTPULS(T) は、配列 T に示されるサンプル点で、連続で非周期的な単位
%   高さの矩形パルスを生成し、T = 0 を中心とします。デフォルトで、矩形の
%   幅は1です。0 でない振幅の間隔は、右側が開くように設定します。すなわち、
%   RECTPULS(-0.5) = 1, RECTPULS(0.5) = 0 になります。
%
%   RECTPULS(T,W) は、幅 W の矩形パルスを生成します。
%
%   参考 GAUSPULS, TRIPULS, PULSTRAN.


%   Copyright 1988-2007 The MathWorks, Inc.
