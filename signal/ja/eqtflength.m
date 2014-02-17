%EQTFLENGTH  離散時間伝達関数の長さを等しくする
%
%   [B,A] = EQTFLENGTH(NUM,DEN) は、伝達関数 NUM と DEN に対して、必要な場合、
%   どちらかに 0 を付加して同じ長さにします。NUM と DEN が、共通する 0 を
%   各係数の後半にもっている場合、それらをお互いから取り去ります。
%
%   EQTFLENGTH は、Z の負のべき乗項で表わされる離散時間伝達関数のみで使用する
%   目的で作られています。
%
%   [B,A,N,M] = EQTFLENGTH(NUM,DEN) は、0 を後ろに付加せず、分子次数 N と
%   分母次数 M を返します。


%   Copyright 1988-2007 The MathWorks, Inc.
