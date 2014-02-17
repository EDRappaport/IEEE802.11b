%BILINEAR  オプションの周波数のプリワーピング付き双一次変換
%
%   [Zd,Pd,Kd] = BILINEAR(Z,P,K,Fs) は、零点 Z, 極 P, およびゲイン K で
%   設定される s 領域の伝達関数を、双一次変換から得られる等価な z 領域の
%   関数に変換します。
%
%      H(z) = H(s) |
%                  | s = 2*Fs*(z-1)/(z+1)
%
%   ここで、零点 Z, 極 P は列ベクトルで、ゲイン K はスカラです。また、
%   Fs は、Hz 単位のサンプリング周波数を表しています。
%
%   [NUMd,DENd] = BILINEAR(NUM,DEN,Fs) は、s 領域で降べきの順に設定された
%   伝達関数 NUM(s)/DEN(s) の係数を入力引数として、z 領域に変換し、
%   降べきの順に並べた伝達関数 NUM(z)/DEN(z) の係数を返します。
%
%   [Ad,Bd,Cd,Dd] = BILINEAR(A,B,C,D,Fs) は、状態空間バージョンです。
%
%   関数 BILINEAR の上記の 3 つの形式は、オプションで追加する入力引数を
%   与えることで、プリワーピングに関する設定を行なうことができます。
%
%   たとえば、[Zd,Pd,Kd] = BILINEAR(Z,P,K,Fs,Fp) は、双一次変換の前に、
%   プリワーピングを適用するので、マッピング処理の前後で周波数応答は、
%   周波数 Fp で正確に一致します (一致する周波数 Fp を Hz 単位で示します)。
%
%   参考 IMPINVAR.


%   Copyright 1988-2007 The MathWorks, Inc.
