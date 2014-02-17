%RESIDUEZ  Z �ϊ��ł̕��������W�J
%
%   [R,P,K] = RESIDUEZ(B,A) �́A2 �̑����� B(z) �� A(z) �̔䂩�畔������
%   �W�J�̏�]�A�ɁA���ڍ������߂܂��B
%
%      B(z)       r(1)               r(n)
%      ---- = ------------ +...  ------------ + k(1) + k(2)z^(-1) ...
%      A(z)   1-p(1)z^(-1)       1-p(n)z^(-1)
%
%   �x�N�g�� B ����� A �́A���U���ԃV�X�e�� B(z)/A(z) �̕��q�ƕ���̑�������
%   �W���� Z^(-1) �̎����̍~���ɐݒ肵�܂��B�o�͂�����x�N�g�� R �͏�]�A
%   ��x�N�g�� P �͋ɁA�s�x�N�g�� K �͒��ڍ������ꂼ��܂݂܂��BK �́A�s�x�N�g��
%   �ɒ��B�����܂݂܂��B�ɂ̐��́A���̂悤�ɕ\����܂��B
%      n = length(A)-1 = length(R) = length(P)
%   length(B) < length(A) �̏ꍇ�A���B���̌W���x�N�g���͋�ɂȂ�܂��B
%   �����łȂ��ꍇ�A���̂悤�ɂȂ�܂��B
%      length(K) = length(B)-length(A)+1
%
%   P(j) = ... P(j) = P(j+m-1) ���A�d���x m �̋ɂ̏ꍇ�A�W�J�͂��̌^�̍���
%   �܂݂܂��B
%           R(j)              R(j+1)                      R(j+m-1)
%      -------------- + ------------------   + ... + ------------------
%      1 - P(j)z^(-1)   (1 - P(j)z^(-1))^2           (1 - P(j)z^(-1))^m
%
%   [B,A] = RESIDUEZ(R,P,K) �́A���������W�J�� B/A �̌^�ɕϊ����܂��B
%
%   �Q�l RESIDUE, PRONY, POLY, ROOTS, SS2TF, TF2SS, TF2ZP, ZP2SS.


%   Copyright 1988-2007 The MathWorks, Inc.
