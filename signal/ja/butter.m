%BUTTER  �o�^���[�X�A�i���O����уf�W�^���t�B���^�̐݌v
%
%   [B,A] = BUTTER(N,Wn) �́AN ���̃��[�p�X�f�W�^���o�^���[�X�t�B���^��
%   �݌v���A�t�B���^�W���𒷂� N+1 �̃x�N�g�� B ����� A �ɕԂ��܂��B
%   �W���́Az �̍~���ɕ��ׂ��܂��B�J�b�g�I�t���g�� Wn �́A0 �� 1 �̊Ԃ�
%   ���łȂ���΂Ȃ�܂���B�����ŁA1 �̓T���v�����[�g�̔����ɑΉ����܂��B
%
%   Wn �� Wn = [W1 W2] �� 2 �v�f�x�N�g���̏ꍇ�ABUTTER �͒ʉߑш� W1 < W < W2 
%   ������ 2*N ���̃o���h�p�X�t�B���^��Ԃ��܂��B
%   [B,A] = BUTTER(N, Wn,'high') �́A�n�C�p�X�t�B���^��݌v���܂��B
%   [B,A] = BUTTER(N,Wn,'low') �́A���[�p�X�t�B���^��݌v���܂��B
%   [B,A] = BUTTER(N,Wn,'stop') �́A�o���h�X�g�b�v�t�B���^��݌v���܂��B
%
%   [Z,P,K] = BUTTER(...) �̂悤�ɁA3 �̏o�͈�����^����ƁA��_�Ƌɂ�
%   ���� N �̗�x�N�g�� Z �� P �ɁA�܂��Q�C�����X�J�� K �ɂ��ꂼ��Ԃ��܂��B
%
%   [A,B,C,D] = BUTTER(...) �̂悤�ɁA4 �̏o�͈�����^����ƁA��ԋ��
%   �s���Ԃ��܂��B
%
%   BUTTER(N,Wn,'s'), BUTTER(N,Wn,'high','s'), BUTTER(N,Wn,'stop','s') �́A
%   �A�i���O�o�^���[�X�t�B���^��݌v���܂��B�܂��AWn �́A[rad/s] �̒P�ʂ�
%   �����A1 ���傫���ݒ肷�邱�Ƃ��ł��܂��B
%
%   �Q�l BUTTORD, BESSELF, CHEBY1, CHEBY2, ELLIP, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
