%MEDFILT1  1 �������f�B�A���t�B���^�����O
%
%   Y = MEDFILT1(X,N) �́A���� N �� 1 �������f�B�A���t�B���^�����O���� 
%   X �̏o�͂�Ԃ��܂��BY �́AX �Ɠ��������ł��B���̊֐��́A�x�N�g�� X ��
%   �͈͊O�ł� 0 �Ɖ��肵�܂��BX ���s��̏ꍇ�AMEDFILT1 �́AX �̗�ɉ�����
%   �������܂��B
%
%   N ���w�肵�Ȃ��ꍇ�AMEDFILT1 �́A�f�t�H���g�� N = 3 ���g���܂��BN ��
%   ��̏ꍇ�AY(k) �� X( k-(N-1)/2 : k+(N-1)/2) �̒����l�ł��BN ��������
%   �ꍇ�AY(k) �́AX( k-N/2 : k+N/2-1) �̒����l�ł��B
%
%   MEDFILT1(X,N,BLKSZ) �́Afor ���[�v���g���āA������ BLKSZ ("�u���b�N�T�C�Y") 
%   �̏o�̓T���v�����v�Z���܂��BMEDFILT1 �́AN �s BLKSZ ��̍�Ɨp�s���
%   �g�p���邽�߁A�v�Z�@�̃����������Ȃ��ꍇ�ɂ́ABLKSZ << LENGTH(X) ���g�p
%   ���Ă��������B�f�t�H���g�ł́ABLKSZ == LENGTH(X)�ł��B����́A��������
%   �\���ɂ���ꍇ�Ɏ��s���Ԃ��ł������Ȃ�ݒ�ł��B
%
%   N �����̍s��̏ꍇ�AY = MEDFILT1(X,N,[],DIM)�A���邢�́A
%   Y = MEDFILT(X,N,BLKSZ,DIM) �́A���� DIM �ɉ����ď������܂��B
%
%   �Q�l Image Processing Toolbox �� MEDIAN, FILTER, SGOLAYFILT, MEDFILT2


%   Copyright 1988-2007 The MathWorks, Inc.
