%INVFREQS  ���g�������f�[�^�ɍŏ����I�ɋߎ������A�i���O�t�B���^
%
%   [B,A] = INVFREQS(H,W,nb,na) �́A�ݒ肵������ nb �� na �����`�B�֐���
%   �����̕��q B �ƕ��� A ��^���܂��B�����ŁAH �́A���g���_ W �ɂ�����
%   �V�X�e���̊�]���镡�f���g�������ŁAW �̓��W�A��/�b�P�ʂ̎��g���l��
%   �܂݂܂��BINVFREQS �́A�����̌W�������t�B���^��݌v���܂��B���̂��Ƃ́A
%   ���̎��g���݂̂��w�肷��Ώ\���ł��邱�Ƃ������Ă��܂��B�t�B���^�́A
%   �����̃t�B���^�ɑ΂��āA�K�؂Ȏ��g���̈�ł̑Ώ̐���ۏ؂��邽�߁A
%   -W �Ńf�[�^ conj(H) ��K�����܂��B
%
%   [B,A] = INVFREQS(H,W,nb,na,Wt) �́A���g���ɑ΂���ߎ��덷�ɏd�݂�
%   �t���܂��BLENGTH(Wt)=LENGTH(W)=LENGTH(H).
%   W �̎��g���S�̂ŁA�덷�̓��a |B-H*A|^2*Wt ���ŏ��ɂȂ�悤�ɒ�`���܂��B
%
%   [B,A] = INVFREQS(H,W,nb,na,Wt,ITER) �́A�ʂ̓K���^�C�v���s���܂��B
%   ���� ITER �Őݒ肵�Ă���J��Ԃ��̒��ŁA���l�I�ȒT���ɂ��A�덷��
%   ���a |B-H*A|^2*Wt �� B �� A �̌W���Ɋւ��čŏ��ɂ���悤�ɂ��܂��B
%   A-�������͈���ɂȂ�悤���񂳂�܂��B
%   [B,A] = INVFREQS(H,W,nb,na,Wt,ITER,TOL) �́A���z�x�N�g���̃m������ 
%   TOL �����ɂȂ������A�������I�������܂��B�f�t�H���g�� TOL �� 0.01 �ł��B
%   Wt �̃f�t�H���g�l�͂��ׂ� 1 �ł��B�f�t�H���g�̒l�́AWt = [] �ł������܂��B
%
%   [B,A] = INVFREQS(H,W,nb,na,Wt,ITER,TOL,'trace') �́A�����̐i�s�󋵂�
%   �����ŕ\�����܂��B
%
%   [B,A] = INVFREQS(H,W,'complex',NB,NA,...) �́A���f���t�B���^��݌v���܂��B
%   ���̏ꍇ�A�t�B���^�W���̑Ώ̐��͕ۏ؂���܂���B
%
%   �Q�l FREQZ, FREQS, INVFREQZ.


%   Copyright 1988-2007 The MathWorks, Inc.
