%RESAMPLE  �M���̃T���v�����O���[�g�̕ύX
%
%   Y = RESAMPLE(X,P,Q) �́A�|���t�F�[�Y�������g���āA�I���W�i���̃T���v�����O
%   ���[�g�� P/Q �{�ŁA�x�N�g�� X �̃f�[�^������T���v�����O���܂��BY �́A
%   X �̒����� P/Q �{�ɂȂ�܂� (���邢�́AP/Q �������łȂ��ꍇ�AP/Q �̐���
%   ����������ւ̊ۂ� (ceil(P/Q)) ���s���܂�)�BP �� Q �́A���̐����łȂ����
%   �Ȃ�܂���B
%
%   RESAMPLE �́A���T���v�����O�ߒ��ŁAX �ɃA���`�G�C���A�X (���[�p�X) FIR 
%   �t�B���^��K�p���A�t�B���^�̒x����⏞���܂��B�t�B���^�́AFIRLS ���g����
%   �݌v����܂��BRESAMPLE �́AUPFIRDN �����ȒP�Ɏg�����Ƃ��ł��A�t�B���^
%   �����O�ɂ��M���x���̕⏞��t�B���^��v�����܂���B
%
%   �t�B���^�����O�ߒ��ŁARESAMPLE �� X �̂���T���v���̑O���邢�͌�̂��鎞�_��
%   �̃T���v�����O�� 0 �Ɠ������Ɖ��肵�܂��B���̂��߈�A�� X �̏I�_�ł� 0 ����
%   �̕΍����傫���ƁA�I�_�ł� Y ���s���m�ɂ���ꍇ������܂��B
%
%   Y = RESAMPLE(X,P,Q,N) �́AX �� 2*N*max(1,Q/P) �̃T���v���ɏd�ݕt���a��
%   �g���āAY �����߂܂��B�֐� RESAMPLE ���g�p���� FIR �t�B���^�̒����� N ��
%   ��Ⴕ�AN �̒l��傫������Ɛ��x�͍����Ȃ�܂����A�v�Z���Ԃ��K�v�ɂȂ�܂��B
%   N ���w�肵�Ȃ��ꍇ�ARESAMPLE �́A�f�t�H���g�� N =10 ���g�p���܂��BN = 0 ��
%   �����ꍇ�ARESAMPLE �� Y(n) �� X(round((n-1)*Q/P)+1) �ƂȂ�悤�ɁA�ŋߖT��
%   ��Ԃ��s���܂� (round((n-1)*Q/P)+1 > length(X) �̏ꍇ�AY(n) = 0 �ɂȂ�܂�)�B
%
%   Y = RESAMPLE(X,P,Q,N,BTA) �́ARESAMPLE �����[�p�X�t�B���^��݌v����̂�
%   �g�p���� Kaiser �E�B���h�E�� BETA �݌v�p�����[�^�Ƃ��� BTA ���g�p���܂��B
%   �l���w�肵�Ȃ��ꍇ�́ARESAMPLE �� BTA = 5 ��p���܂��B
%
%   Y = RESAMPLE(X,P,Q,B) �́A�t�B���^�W���x�N�g�� B �� X �� (�A�b�v�T���v����
%   ���) �t�B���^�������܂��BRESAMPLE �́A�t�B���^�̒x����⏞���鎞�ɁA
%   ���`�ʑ��Ŋ�̒��������W���x�N�g�� B �����肵�܂��B�t�B���^�̒�����
%   �����̏ꍇ�A1/2 �T���v���Œx�����ߏ�⏞���܂��B�܂��A����`�ʑ��̃t�B���^�́A
%   UPFIRDN ���g���܂��B
%
%   [Y,B] = RESAMPLE(X,P,Q,...) �́A���T���v�����O�ߒ��� (�A�b�v�T���v���̌��) 
%   X �ɓK�p�����t�B���^�̌W�����x�N�g�� B �ɕԂ��܂��B
%
%   X ���s��̏ꍇ�ARESAMPLE �́AX �̊e��ɑ΂��ă��T���v�����O���s���܂��B
%
%   �Q�l UPFIRDN, INTERP, DECIMATE, FIRLS, KAISER, INTFILT, 
%        Filter Design Toolbox �� MFILT/FIRSRC.


%   Copyright 1988-2007 The MathWorks, Inc.
