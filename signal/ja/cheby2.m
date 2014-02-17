%CHEBY2  �`�F�r�V�F�t II �^�f�W�^������уA�i���O�t�B���^�̐݌v
%
%   [B,A] = CHEBY2(N,R,Wst) �́A�Ւf�ш惊�b�v���� R �f�V�x���̌����� 
%   �Ւf�ш�G�b�W���g�� Wst ������ N ���̃��[�p�X�f�W�^���`�F�r�V�F�t
%   �t�B���^��݌v���܂��BCHEBY2 �́A���� N+1 �̃x�N�g�� B (���q) ����� 
%   A (����) �Ƀt�B���^�W����Ԃ��܂��B�Ւf�ш�G�b�W���g�� Wst �́A
%   1.0 ���T���v�����[�g�̔����ɑΉ�������̂Ƃ��āA0.0 < Wst < 1.0 ��
%   �Ȃ���΂Ȃ�܂���BR ���I������Ă��Ȃ��ꍇ�A�J�n�_�Ƃ��āAR = 20 
%   ���g�p���܂��B
%
%   Wst �� 2 �v�f�x�N�g�� Wst  = [W1 W2] �̏ꍇ�ACHEBY2 �́A�ʉߑш� 
%   W1 < W < W2 ������ 2*N ���̃o���h�p�X�t�B���^��Ԃ��܂��B
%   [B,A] = CHEBY2(N,R,Wst,'high') �́A�n�C�p�X�t�B���^��݌v���܂��B
%   [B,A] = CHEBY2(N,R,Wst,'low') �́A���[�p�X�t�B���^��݌v���܂��B
%   Wst = [W1 W2] �̏ꍇ�A[B,A] = CHEBY2(N,R,Wst,'stop') �́A�o���h�X�g�b�v
%   �t�B���^��݌v���܂��B
%
%   [Z,P,K] = CHEBY2(...) �̂悤�ɁA���ӂ� 3 �̏o�͈������g�p����ꍇ�A
%   ��_�Ƌɂ𒷂� N �̗�x�N�g�� Z �� P �ɁA�܂��Q�C�����X�J�� K �ɕԂ��܂��B
%
%   [A,B,C,D] = CHEBY2(...) �̂悤�ɁA���ӂ� 4 �̏o�͈������g�p����ꍇ�A
%   ��ԋ�ԍs���Ԃ��܂��B
%
%   CHEBY2(N,R,Wst,'s'), CHEBY2(N,R,Wst,'high','s'), CHEBY2(N,R,Wst,'stop','s') 
%   �́A�A�i���O�`�F�r�V�F�t II �^�t�B���^��݌v���܂��B�܂��AWst �́A[rad/s] 
%   �̒P�ʂ������A1 ���傫���ݒ肷�邱�Ƃ��ł��܂��B
%
%   �Q�l CHEB2ORD, CHEBY1, BUTTER, ELLIP, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
