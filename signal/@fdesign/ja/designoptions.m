%DESIGNOPTIONS  特定の設計に対するすべての利用可能な設計オプションを表示
%
%   DESIGNOPTIONS(D, METHOD) は、特定の設計メソッド METHOD を使って、
%   オブジェクト D に対するすべての利用可能な設計オプションを返します。
%
%   % 例
%   h = fdesign.lowpass;
%   designoptions(h, 'equiripple')
%
%   参考 FDESIGN/DESIGNMETHODS, FDESIGN/VALIDSTRUCTURES.


%   Copyright 2006-2007 The MathWorks, Inc.
