%SETSPECS  フィルタデザイナの設計仕様を設定
%
%   SETSPECS(D, S1, S2, etc.) は、D のコンストラクタ内で指定されたものと
%   同じ方法で、フィルタデザイナ D 内の仕様を設定します。S1, S2 等の説明に
%   ついては、GET(D, 'DESCRIPTION') を使用してください。
%
%   SETSPECS(D,...,Fs) は、Hz 単位のサンプリング周波数を指定します。
%   この場合、他のすべての周波数の仕様も Hz 単位になります。
%
%   SETSPECS(D,...,MAGUNITS) は、与えられた任意の振幅の仕様に対する単位を
%   指定します。MAGUNITS は、つぎのいずれかです:'linear', 'dB', 'squared'
%   この引数が省略された場合、'dB' と仮定されます。振幅の仕様は、それらが
%   どのように指定されるかに関わらず、常に変換され、dB 単位で格納される
%   ことに注意してください。
%
%   デフォルトでは、すべての周波数の仕様は、正規化された周波数単位である
%   ものと仮定されます。さらに、すべての振幅の仕様は、dB 単位であるものと
%   仮定されます。
%
%   フィルタデザイナ D に対するすべての利用可能な仕様のタイプのリストを
%   得るには、SET(D, 'SPECIFICATION') を使用してください。
%
%   % 例 #1 - ローパスフィルタに対する仕様のタイプのリストを取得します。
%   d = fdesign.lowpass;
%   set(d, 'Specification')
%
%   % 例 #2 - 正規化周波数を指定します。
%   d = fdesign.lowpass('N,Fc');
%   setspecs(d, 20, .4);
%   d
%
%   % 例 #3 - Hz 単位でサンプリング周波数を指定します。
%   d = fdesign.lowpass('N,Fc');
%   setspecs(d, 20, 4, 20);
%   d
%
%   % 例 #4 - 振幅の単位を指定します。
%   d = fdesign.lowpass;
%   setspecs(d, .4, .5, .1, .05, 'linear');
%   d
%
%   参考 FDESIGN, FDESIGN/NORMALIZEFREQ.


%   Copyright 1999-2007 The MathWorks, Inc.
