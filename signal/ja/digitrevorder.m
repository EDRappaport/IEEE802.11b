%DIGITREVORDER  ���͂������]���ɕ��בւ�
%
%   Y = DIGITREVORDER(X, R) �́A�����]���ɕ��בւ���ꂽ�ŏ��̔�V���O���g��
%   �����ŁAX �Ɠ����T�C�Y�̔z�� Y ��Ԃ��܂��B���בւ���ꂽ�����̒����́A
%   ��x�[�X�ŁAR �̗ݏ�Ɖ��肳��܂��B� 2 �̓��͂ɑ΂��āA���̗�́A
%   ���͗v�f�̃r�b�g���]�ɂȂ�܂��B
%
%   [Y,I] = DIGITREVORDER(X, R) �́A�x�N�g�� Y �ɑ΂��� Y=X(I) �ƂȂ�悤�A
%   �����]�����C���f�b�N�X�x�N�g�� I ��Ԃ��܂��B
%
%   ���̑���́AFFT ����� IFFT �ϊ��ŁA���s���̌��������ǂ��邽�߂ɁA
%   �����]���̕��ёւ��������Ɍv�Z���ꂽ���g���̈�̃t�B���^�����O
%   �A���S���Y���̎g�p�ɑ΂��āA�t�B���^�W���̃x�N�g����O�����ĕ��ׂ�ۂ�
%   �L���ł��B
%
%   ��:
%       x  = [0:15].';
%       y2 = digitrevorder(x, 2); % � 2 (�r�b�g���]) �ł� x �̕��בւ�
%       y4 = digitrevorder(x, 4); % � 4 (�����]) �ł� x �̕��בւ�
%       [x y2 y4]
%
%   �Q�l BITREVORDER, FFT, IFFT.


% Copyright 1988-2007 The MathWorks, Inc.
