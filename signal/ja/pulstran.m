%PULSTRAN  �p���X�񔭐���
%
%   PULSTRAN �́A�A���֐��܂��̓T���v�����O���ꂽ�v���g�^�C�v�p���X����
%   �p���X��𐶐����܂��B
%
%   �A���֐�
%   Y = PULSTRAN(T,D,'func') �́A�A���֐� 'func' �̃T���v���Ɋ�Â���
%   �p���X��𐶐����܂��B�֐��́A�x�N�g�� D �Œ�`�����X�J�������I�t�Z�b�g
%   ����菜������A�z�� T �ɐݒ肳�ꂽ�����͈̔͑S�̂ɂ��Čv�Z���܂��B
%   ���̌��ʁA�֐��� length(D) ��v�Z���A���̌��ʂ̘a 
%   Y = func(t-D(1)) + func(t-D(2))+ ... 
%   ���Ԃ���܂��B'func' �́A�z�� T �������Ƃ��Ď󂯎�邱�Ƃ��ł���
%   �x�N�g���֐��łȂ���΂Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   Y=PULSTRAN(T,D,@func) �́A������̊֐����̑���Ɋ֐��n���h�����w��
%   ���邽�߂ɁAPULSTRAN(T,D,'func') �̑���Ɏg�p����ꍇ������܂��B
%
%   �I�v�V�����̃Q�C���t�@�N�^�́AD �̗� 1 �Œ�`���ꂽ�I�t�Z�b�g�Ɨ� 2 ��
%   �Q�C���Ɋ֘A���� 2 ��̍s��Ƃ��� D ���w�肷�邱�ƂŊe�X�̒x��ɓK�p
%   �ł��܂��B�s�x�N�g���́A�x���ݒ肷����̂Ƃ��Ă̂݉��߂���邱�Ƃ�
%   ���ӂ��Ă��������B
%
%   PULSTRAN(T,D,'func',P1,P2,...) �́A�K�v�ɉ����Ēǉ��p�����[�^�� 
%   'func' �ɓn�����Ƃ��ł��܂��B���Ƃ��΁Afunc( T-D(1), P1, P2, ... ) 
%   �̂悤�ɐݒ肵�܂��B
%
%   �T���v�������ꂽ�v���g�^�C�v�p���X
%   PULSTRAN(T,D,P,FS) �́A���[�g FS �ŃT���v���������x�N�g�� P �ɁA�ݒ肵��
%   �v���g�^�C�v�p���X�Ɋe�X�̒x���K�p���A��������ׂĉ��Z���邱�ƂŁA
%   �p���X��𐶐����܂��BT �� D �́A��̒�`�ɏ]���܂��B�����ŁAP �́A
%   [0,(length(P)-1)/Fs] �̎��Ԕ͈͂ŁA���͈̔͊O�ł̓T���v���͊��S�� 
%   0 �Ƃ��܂��B�f�t�H���g�ł́A���`��Ԃ��g���Ēx��𐶐����܂��B
%
%   PULSTRAN(T,D,P) �́AFs = 1 �Ɖ��肵�APULSTRAN(..., 'method') �́A�ʂ�
%   ��Ԗ@��ݒ肵�܂��B���p�\�ȕ��@�ɂ��ẮAinterp1 ���Q�Ƃ��Ă��������B
%
%   ��
%   �� 1: 3 Hz �̔������g���� 0.1 �b�̃m�R�M����������Ώ̃m�R�M���g��
%   �������܂��B�����āA1 �b�̐M���̒����� 1 kHz �̃T���v�����O���[�g��
%   �l���܂��B
%
%              T = 0 : 1/1E3 : 1;  % 1 �b�Ԃ� 1 kHz �T���v���̎��g��
%              D = 0 : 1/3 : 1;    % 3 Hz �̔������g��
%              Y = pulstran(T,D,'tripuls',0.1,-1); plot(T,Y)
%
%   �� 2: 10 kHz �� 50% �̑ш敝�����������K�E�X�p���X�𐶐����܂��B
%   ���g���� 1 kHz�A�T���v�����O���g���� 50 kHz�A�܂��p���X��̒����� 
%   10 �~���p���X�̔����b�ł��B�����ɂ��U���𖈉� 0.8 �����������܂��B
%   �����֐����Q�Ƃ��邽�߂Ɋ֐��n���h����p���܂��B
%
%               T = 0 : 1/50E3 : 10E-3;
%               D = [0 : 1/1E3 : 10E-3 ; 0.8.^(0:10)]';
%               Y = pulstran(T,D,@gauspuls,10E3,.5); plot(T,Y)
%
%   �� 3: 10 �� ���C���[�p���X��𐶐����܂�:
%         (Statistics Toolbox ���K�v)
%
%               P = raylpdf((0:31)/5,1.5);  % ALT: P=hamming(32)
%               T = 0:320;
%               D = (0:9)'*32;
%               Y = pulstran(T,D,P); plot(T,Y)
%
%   �Q�l GAUSPULS, RECTPULS, TRIPULS, SINC.


%   Copyright 1988-2007 The MathWorks, Inc.