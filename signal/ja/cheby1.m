%CHEBY1  �`�F�r�V�F�t I �^�f�W�^������уA�i���O�t�B���^�̐݌v
%
%   [B,A] = CHEBY1(N,R,Wp) �́A�ʉߑш�� R �f�V�x���̃s�[�N�ԃ��b�v����
%   ���� N ���̃��[�p�X�f�W�^���`�F�r�V�F�t�t�B���^��݌v���܂��BCHEBY1 �́A
%   ���� N+1 �̃x�N�g�� B (���q) ����� A (����) �Ƀt�B���^�W����Ԃ��܂��B
%   �ʉߑш�̃G�b�W���g�� Wp �́A�T���v�����[�g�̔����� 1.0 �ɑΉ�����
%   ���̂Ƃ��āA0.0 < Wp < 1.0 �łȂ���΂Ȃ�܂���BR ���I������Ă��Ȃ�
%   �ꍇ�A�J�n�_�Ƃ��āAR=0.5 ���g�p���܂��B
%
%   Wp �� 2 �v�f�x�N�g�� Wp  = [W1 W2] �̏ꍇ�ACHEBY1 �́A�ʉߑш� W1 < W <W2 
%   ������ 2*N ���̃o���h�p�X�t�B���^��Ԃ��܂��B
%   [B,A] = CHEBY1(N,R,Wp,'high') �́A�n�C�p�X�t�B���^��݌v���܂��B
%   [B,A] = CHEBY1(N,R,Wp,'low') �́A���[�p�X�t�B���^��݌v���܂��B
%   [B,A] = CHEBY1(N,R,Wp,'stop') �́A�o���h�X�g�b�v�t�B���^��݌v���܂��B
%
%   [Z,P,K] = CHEBY1(...) �̂悤�ɁA���ӂ� 3 �̏o�͈������g�p����ꍇ�A
%   ��_�Ƌɂ𒷂� N �̗�x�N�g�� Z �� P �ɁA�܂��Q�C�����X�J�� K �ɕԂ��܂��B
%
%   [A,B,C,D] = CHEBY1(...) �̂悤�ɁA���ӂ� 4 �̏o�͈������g�p����ꍇ�A
%   ��ԋ�ԍs���Ԃ��܂��B
%
%   CHEBY1(N,R,Wp,'s'), CHEBY1(N,R,Wp,'high','s'), CHEBY1(N,R,Wp,'stop','s') 
%   �́A�A�i���O�`�F�r�V�F�t I �^�t�B���^��݌v���܂��B���̏ꍇ�AWp �́A
%   [rad/s] �̒P�ʂ������A1 ���傫���ݒ�ł��܂��B
%
%   �Q�l CHEB1ORD, CHEBY2, BUTTER, ELLIP, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
