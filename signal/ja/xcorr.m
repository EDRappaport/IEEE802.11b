%XCORR  ���ݑ��֊֐��̐���
%
%   C = XCORR(A,B) �́A���� 2M-1(M>1) �̑��ݑ��֗� C ���x�N�g���ɕԂ��܂��B
%   �����ŁAA �� B �́A���� M �̃x�N�g���ł��BA �� B �����������łȂ��ꍇ�A
%   �Z�����̃x�N�g���� 0 ��t�����A�������̃x�N�g���Ɠ��������ɂ��܂��B
%   A ���s�x�N�g���̏ꍇ�AC �͍s�x�N�g���ɂȂ�܂��B�܂��AA ����x�N�g����
%   �ꍇ�AC �͗�x�N�g���ɂȂ�܂��B
%
%   XCORR �́A2 �� (���ɒ���) �����_���Ȑ���Ԃ̑��ւ̐���𐶐����܂�:
%          C(m) = E[A(n+m)*conj(B(n))] = E[A(n)*conj(B(n-m))]
%   ����́A2 �̊m��I�ȐM���Ԃ̊m��I���ւł�����܂��B
%
%   XCORR(A) �́AA ���x�N�g���̏ꍇ�A���ȑ��֗�ɂȂ�܂��BXCORR(A) �́A
%   A �� M�~N �̍s��̏ꍇ�AN^2 �� A �̗�̂��ׂĂ̑g�����ɑ΂��鑊�ݑ��֗�
%   ���܂� 2M-1 �s�̑傫�ȍs��ɂȂ�܂��B�o�͂� 0 �̃��O�ɑΉ�������̂́A
%   �e�v�f�܂��́AM �s�ɑ΂��ďo�͗�̒����ɂȂ�܂��B
%
%   XCORR(...,MAXLAG) �́A���O�� [-MAXLAG:MAXLAG] �͈̔͂ɂ��āA���ݑ��֗��
%   �v�Z���A�o�� C �̒����́A2*MAXLAG+1 �ɂȂ�܂��B�w�肵�Ȃ��ꍇ�A�f�t�H���g�ŁA
%   MAXLAG = M-1 �ɂȂ�܂��B
%
%   [C,LAGS] = XCORR(...) �́A���O�̃C���f�b�N�X�x�N�g�� (LAGS) ���Ԃ��܂��B
%
%   XCORR(...,SCALEOPT) �́ASCALEOPT �ɏ]���āA���ւ𐳋K�����܂��B
%     'biased'   - 1/M �ő��ݑ��֊֐����X�P�[�����O
%     'unbiased' - 1/(M-abs(lags)) �ő��ݑ��֊֐����X�P�[�����O
%     'coeff'    - 0 �̃��O�ł̎��ȑ��ւ����S�� 1.0 �ƂȂ�悤�ɗ�𐳋K�����܂��B
%     'none'     - �X�P�[�����O�Ȃ� (���ꂪ�f�t�H���g�ł�)
%
%   �Q�l XCOV, CORRCOEF, CONV, CCONV, COV, XCORR2.


%   Copyright 1988-2007 The MathWorks, Inc.
