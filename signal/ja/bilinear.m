%BILINEAR  �I�v�V�����̎��g���̃v�����[�s���O�t���o�ꎟ�ϊ�
%
%   [Zd,Pd,Kd] = BILINEAR(Z,P,K,Fs) �́A��_ Z, �� P, ����уQ�C�� K ��
%   �ݒ肳��� s �̈�̓`�B�֐����A�o�ꎟ�ϊ����瓾���铙���� z �̈��
%   �֐��ɕϊ����܂��B
%
%      H(z) = H(s) |
%                  | s = 2*Fs*(z-1)/(z+1)
%
%   �����ŁA��_ Z, �� P �͗�x�N�g���ŁA�Q�C�� K �̓X�J���ł��B�܂��A
%   Fs �́AHz �P�ʂ̃T���v�����O���g����\���Ă��܂��B
%
%   [NUMd,DENd] = BILINEAR(NUM,DEN,Fs) �́As �̈�ō~�ׂ��̏��ɐݒ肳�ꂽ
%   �`�B�֐� NUM(s)/DEN(s) �̌W������͈����Ƃ��āAz �̈�ɕϊ����A
%   �~�ׂ��̏��ɕ��ׂ��`�B�֐� NUM(z)/DEN(z) �̌W����Ԃ��܂��B
%
%   [Ad,Bd,Cd,Dd] = BILINEAR(A,B,C,D,Fs) �́A��ԋ�ԃo�[�W�����ł��B
%
%   �֐� BILINEAR �̏�L�� 3 �̌`���́A�I�v�V�����Œǉ�������͈�����
%   �^���邱�ƂŁA�v�����[�s���O�Ɋւ���ݒ���s�Ȃ����Ƃ��ł��܂��B
%
%   ���Ƃ��΁A[Zd,Pd,Kd] = BILINEAR(Z,P,K,Fs,Fp) �́A�o�ꎟ�ϊ��̑O�ɁA
%   �v�����[�s���O��K�p����̂ŁA�}�b�s���O�����̑O��Ŏ��g�������́A
%   ���g�� Fp �Ő��m�Ɉ�v���܂� (��v������g�� Fp �� Hz �P�ʂŎ����܂�)�B
%
%   �Q�l IMPINVAR.


%   Copyright 1988-2007 The MathWorks, Inc.
