%ELLIP  �ȉ~�܂��̓J�E�A�[�f�W�^������уA�i���O�t�B���^�̐݌v
%
%   [B,A] = ELLIP(N,Rp,Rs,Wp) �́ARp �f�V�x���̃s�[�N�ԃ��b�v���� Rs 
%   �f�V�x���̒Ⴂ�Ւf�ш挸�������� N ���̃��[�p�X�f�W�^���ȉ~�t�B���^��
%   �݌v���܂��BELLIP �́A�t�B���^�W�����A���� N+1 �̃x�N�g�� B (���q) 
%   ����� A (����) �ɕԂ��܂��B�ʉߑш�̃G�b�W���g�� Wp �́A�T���v��
%   ���[�g�̔����� 1.0 �ɑΉ�������̂Ƃ��āA0.0 < Wp < 1.0 �łȂ����
%   �Ȃ�܂���B����炪�I������Ă��Ȃ��ꍇ�A�J�n�_�Ƃ��āARp = 0.5 �� 
%   Rs = 20 ���g�p���܂��B
%
%   Wp �� 2 �v�f�x�N�g�� Wp = [W1 W2] �̏ꍇ�AELLIP �͒ʉߑш� W1< W <W2 
%   ������ 2N ���̃o���h�p�X�t�B���^��Ԃ��܂��B
%   [B,A] = ELLIP(N,Rp,Rs,Wp,'high') �́A�n�C�p�X�t�B���^��݌v���܂��B
%   [B,A] = ELLIP(N,Rp,Rs,Wp,'low') �́A��-�p�X�t�B���^��݌v���܂��B
%   Wp = [W1 W2] �̏ꍇ�A[B,A] = ELLIP(N,Rp,Rs,Wp,'stop') �́A�o���h
%   �X�g�b�v�t�B���^��݌v���܂��B
%
%   [Z,P,K] = ELLIP(...) �̂悤�ɁA���ӂ� 3 �̏o�͈������g�p����ꍇ�A
%   ��_�Ƌɂ𒷂� N �̗�x�N�g�� Z �� P �ɁA�܂��Q�C�����X�J�� K ��
%   �Ԃ��܂��B
%
%   [A,B,C,D] = ELLIP(...) �̂悤�ɁA���ӂ� 4 �̏o�͈������g�p����ꍇ�A
%   ��ԋ�ԍs���Ԃ��܂��B
%
%   ELLIP(N,Rp,Rs,Wp,'s'), ELLIP(N,Rp,Rs,Wp,'high','s'), 
%   ELLIP(N,Rp,Rs,Wp,'stop','s') �́A�A�i���O�ȉ~�t�B���^��݌v���܂��B
%   ���̏ꍇ�AWp �́A[rad/s] �� �P�ʂ������A1 ���傫���ݒ�ł��܂��B
%
%   �Q�l ELLIPORD, CHEBY1, CHEBY2, BUTTER, BESSELF, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
