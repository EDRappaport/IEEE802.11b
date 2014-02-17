%DPSS  離散扁長回転楕円体列 (Slepian 列)
%
%   [E,V] = DPSS(N,NW) は、長さ N の最初の 2*NW の離散扁長回転楕円体列 
%   (DPSS) を生成し、E の列方向に出力します。そして、対応する集中度を
%   ベクトル V にそれぞれ生成します。ここで、周波数帯域は |w|< = (2*pi*W) 
%   で、W = NW/N は帯域幅の半分で、W はラジアン単位です。E(:,1) は、
%   周波数帯域ラジアン (|w|< =(2*pi*W)) に集中する長さ N の信号で、
%   E(:,2) は、E(:,1) に直交する信号で、この帯域に集中しています。
%   そして、E(:,3) は、E(:,1) と E(:,2) に共に直交するもので、これもこの
%   帯域に集中しているものです。
%
%   Multiple Taper スペクトル解析法に対して、NW の取り得る値は、
%   2,5/2,3,7/2,4 のいずれかです。
%
%   [E,V] = DPSS(N,NW,K) は、計算する 2*NW の離散扁長回転楕円体列の 
%   K 個の帯域制限数列です。[E,V] = DPSS(N,NW,[K1 K2]) は、計算された 
%   2*NW の離散扁長回転楕円体列の K1 番目から K2 番目までの数列を返します。
%
%   [E,V] = DPSS(N,NW,'spline') は、スプライン補間を使って、DPSS.mat 内で 
%   N に、最も近い長さをもつデータ列から E と V を計算します。
%   [E,V] = DPSS(N,NW,'spline', Ni) は、既存の長さ Ni のデータ列から補間します。
%   DPSS(N,NW,'linear') および、DPSS(N,NW,'linear',Ni) は、線形補間を
%   使用します。これは、スプライン補間よりはるかに高速ですが、精度が劣ります。
%   'linear' は、Ni>N であることが必要です。[E, V] = DPSS(N,NW,'calc') は、
%   直接アルゴリズム (デフォルト) を使います。
%
%   DPSS(N,NW,'trace') は、引数 'trace' を使って、DPSS が使用する方法を
%   探します。
%
%   参考 PMTM, DPSSLOAD, DPSSDIR, DPSSSAVE, DPSSCLEAR.


%   Copyright 1988-2007 The MathWorks, Inc.
