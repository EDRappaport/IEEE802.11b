%SINC  Sin(pi*x)/(pi*x) �֐�
%
%   SINC(X) �́A���̗v�f�� X �̗v�f�� sinc �ƂȂ�s���Ԃ��܂��B���Ȃ킿�A
%   sinc �֐��́A���̂悤�ɕ\����܂��B
%        y = sin(pi*x)/(pi*x)    x ~= 0 �̏ꍇ
%          = 1                   x == 0 �̏ꍇ
%   ������ x �͓��͍s��̗v�f�ŁAy �͌��ʂ̏o�͗v�f�ł��B
%
%   % ���`�Ԋu�̃x�N�g���ɑ΂��� sinc �֐��̗�:
%   t = linspace(-5,5);
%   y = sinc(t);
%   plot(t,y);
%   xlabel('Time (sec)');ylabel('Amplitude'); title('Sinc Function')
%
%   �Q�l SQUARE, SIN, COS, CHIRP, DIRIC, GAUSPULS, PULSTRAN, RECTPULS, TRIPULS.


%   Copyright 1988-2007 The MathWorks, Inc.
