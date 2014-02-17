%POLYSCALE  多項式の根のスケーリング
%
%   POLYSCALE(A,SCALE) は、Z 平面内で、SCALE によって、多項式 A の根を
%   スケーリングします。ここで、A は、多項式係数のベクトルです。SCALE が
%   実数で、0 <= SCALE <= 1 の場合、A の根は、Z 平面の中で原点方向に放射状に
%   スケーリングされます。複素 SCALE は、任意の変更を根の位置に与えます。
%
%   自己回帰多項式の中で根の半径を短くすることにより、周波数応答の中の
%   スペクトルピークのバンド幅は、(平坦に) 広がります。この演算は、しばしば、
%   "帯域拡張" と呼ばれます。
%
%   例:LPC 音声スペクトルの帯域拡張
%      load mtlb;                    % 音声信号
%      Ao = lpc(mtlb(1000:1100),12); % 12 次の AR 多項式
%      Ax = polyscale(Ao,.85);       % 帯域拡張
%      subplot(2,2,1); zplane(1,Ao); title('Original');
%      subplot(2,2,3); zplane(1,Ax); title('Flattened');
%      [ho,w]=freqz(1,Ao);  [hx,w]=freqz(1,Ax);
%      subplot(1,2,2); plot(w,abs(ho), w,abs(hx));
%      legend('Original','Flattened');
%
%   参考 POLYSTAB.


% Copyright 1988-2007 The MathWorks, Inc.
