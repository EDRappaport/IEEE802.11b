%STATESPACE  ���U���ԏ�ԋ�ԃt�B���^
%
%   Hd = DFILT.STATESPACE(A, B, C, D) �́A�����`�z�� A, B, C, D ������
%   ���U���Ԃ̏�ԋ�ԃt�B���^ Hd ���쐬���܂��BA�AB�AC�AD�́A�s��`��
%   �܂��͏��-��Ԍ`���̃t�B���^�̍������������瓾��ꂽ���̂ł��B
%
%   x(n+1) = A*x(n) + B*u(n)
%   y(n)   = C*x(n) + D*u(n)
%
%   �����ŁAx(n) �́A���� n �ɂ�����x�N�g���̏�Ԃł��B
%         u(n) �͎��� n �ɂ�������͂ł��B
%         y �́A���� n �ɂ�����o�͂ł��B
%         A �́A��ԑJ�ڍs��ł��B
%         B �́A���͂����Ԃւ̓`���s��ł��B
%         C �́A��Ԃ���o�͂ւ̓`���s��ł��B
%         D �́A���͂���o�͂ւ̓`���s��ł��B
%
%   A, B, C, D ���w�肳��Ȃ��ꍇ�A�f�t�H���g�� [], [], [], 1 �ł��B
%
%   % ��:
%   [A,B,C,D] = butter(2,.5);
%   Hd = dfilt.statespace(A,B,C,D)
%
%   �Q�l DFILT/STRUCTURES, TF2SS, ZP2SS


%   Copyright 1988-2008 The MathWorks, Inc.
