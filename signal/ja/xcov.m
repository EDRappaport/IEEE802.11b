%XCOV  ���݋����U�֐��̐���
%
%   XCOV(A,B) �́A���� 2*M-1 �̑��݋����U������x�N�g���ɕԂ��܂��B�����ŁAA 
%�� B �́A���� M �̃x�N�g���ł��B
%
%   XCOV(A) �́AA ���x�N�g���̏ꍇ�A���݋����U��ɂȂ�܂��BXCOV(A) �́AA �� 
%M�~N �̍s��̏ꍇ�AN^2 �� A �̗�̂��ׂĂ̑g�����ɑ΂��鑊�݋����U����܂� 
%2M-1 �s�̑傫�ȍs��ɂȂ�܂��B�o�͂� 0 �̃��O�ɑΉ�������̂́A�e�v�f�܂�
%�́AM �s�ɑ΂��ďo�͗�̒����ɂȂ�܂��B
%
%   ���݋����U�́A2 �̐��񂩂炨�݂��ɕ��ϒl�������������ʂ̑��ݑ��֊֐��ł��B
%        C(m) = E[(A(n+m)-MA)*conj(B(n)-MB)]
%   �����ŁAMA �� MB �́A���ꂼ�� A �� B �̕��ςł��B
%
%   XCOV(...,MAXLAG) �́A���O�� [-MAXLAG:MAXLAG] �͈̔͂ɂ��āA�����U���v�Z
%���A�o�� C �̒����́A2*MAXLAG+1 �ɂȂ�܂��B�w�肵�Ȃ��ꍇ�A�f�t�H���g�ŁA
%   MAXLAG = M-1 �ɂȂ�܂��B
%
%   [C,LAGS] = XCOV(...) �́A���O�̃C���f�b�N�X�x�N�g�� (LAGS) ���Ԃ��܂��B
%
%   XCOV(...,SCALEOPT) �́ASCALEOPT �ɏ]���āA�����U�𐳋K�����܂��B
%       biased   - 1/M �ő��݋����U���X�P�[�����O
%       unbiased - 1/(M-abs(k)) �ŋ����U���X�P�[�����O�B������ k �͌��ʂ̃C���f�b�N�X�ł��B
%       coeff    - 0 �̃��O�ł̋����U�����S�� 1.0 �ƂȂ�悤�ɗ�𐳋K�����܂��B
%       none     - �X�P�[�����O�Ȃ� (���ꂪ�f�t�H���g�ł�)
%
%   �Q�l XCORR, CORRCOEF, CONV, COV, XCORR2.


%   Copyright 1988-2007 The MathWorks, Inc.
