%INVFREQZ  ���g�������f�[�^�ɍŏ����I�ɋߎ��������U���ԃt�B���^
%
%   [B,A] = INVFREQZ(H,W,NB,NA) �́A�ݒ肵������ NB �� NA �����`�B�֐���
%   ���� ���q B �ƕ��� A ���o�͂��܂��B�����ŁAH �́A���W�A���P�ʂŐݒ肵��
%   ���g���x�N�g�� W �̊e�v�f�ł̊�]���镡�f���g�������ł��BW �́A
%   (�P�ʃ��W�A��/�T���v����) ��� [0, ��] �̒l���Ƃ鐳�K�����ꂽ���g���l�ł��B
%
%   INVFREQZ �́A�����̌W�������t�B���^��݌v���܂��B���̂��Ƃ́A����
%   ���g���݂̂��w�肷��Ώ\���ł��邱�Ƃ������Ă��܂��B�t�B���^�́A������
%   �t�B���^�ɑ΂��āA�K�؂Ȏ��g���̈�ł̑Ώ̐���ۏ؂��邽�߁A-W ��
%   �f�[�^ conj(H) ��K�����܂��B
%
%   [B,A] = INVFREQZ(H,W,NB,NA,Wt) �́A���g���ɑ΂���ߎ��덷�ɏd�݂�
%   �t���܂��BLENGTH(Wt)=LENGTH(W)=LENGTH(H).
%   W �̎��g���S�̂ŁA�덷�̓��a |B-H*A|^2*Wt ���ŏ��ɂȂ�悤�ɒ�`���܂��B
%
%   [B,A] = INVFREQZ(H,W,NB,NA,Wt,ITER) �́A���̋ߎ��@���s���܂��B���� 
%   ITER �Őݒ肵�Ă���J��Ԃ��̒��ŁA���l�I�ȒT���ɂ��A�덷�̓��a 
%   |B-H*A|^2*Wt �� B �� A �̌W���Ɋւ��čŏ��ɂ���悤�ɂ��܂��BA-��������
%   ����ɂȂ�悤���񂳂�܂��B
%   [B,A] = INVFREQZ(H,W,NB,NA,Wt,ITER,TOL) �́A���z�x�N�g���̃m������ 
%   TOL �����ɂȂ������A�������I�������܂��B�f�t�H���g�� TOL �� 0.01 �ł��B
%   Wt �̃f�t�H���g�l�͂��ׂ� 1 �ł��B�f�t�H���g�̒l�́AWt = [] �ł������܂��B
%
%   [B,A] = INVFREQZ(H,W,NB,NA,Wt,ITER,TOL,'trace') �́A�����̐i�s�󋵂�
%   �����ŕ\�����܂��B
%
%   [B,A] = INVFREQZ(H,W,'complex',NB,NA,...) �́A���f���t�B���^��݌v���܂��B
%   ���̏ꍇ�A�t�B���^�W���̑Ώ̐��͕ۏ؂���܂���BW �́A��� [-Pi, Pi] ����
%   ���K�����ꂽ���g���l���܂݂܂��B
%
%   �Q�l FREQZ, FREQS, INVFREQS.


%   Copyright 1988-2007 The MathWorks, Inc.
