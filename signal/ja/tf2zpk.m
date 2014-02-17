%TF2ZPK  離散時間伝達関数を零点‐極に変換
%
%   [Z,P,K] = TF2ZPK(NUM,DEN) は、零点、極、ゲインを求めます:
%
%                 (z-Z(1))(z-Z(2))...(z-Z(n))
%       H(z) =  K ---------------------------
%                 (z-P(1))(z-P(2))...(z-P(n))
%
%   NUM, DEN は、つぎのような多項式の型の単入力、単出力の伝達関数です。
%
%               NUM(z)
%       H(z) = --------
%               DEN(z)
%
%   例:
%     [b,a] = butter(3,.4);
%     [z,p,k] = tf2zpk(b,a)


%   Copyright 1988-2007 The MathWorks, Inc.
