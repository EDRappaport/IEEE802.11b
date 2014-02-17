%LEVINSON  Levinson-Durbin �A�[�@
%
%   A = LEVINSON(R,N) �́A���̕������̃G���~�[�g Toeplitz �V�X�e�������߂܂��B
%
%       [  R(1)   R(2)* ...  R(N)* ] [  A(2)  ]  = [  -R(2)  ]
%       [  R(2)   R(1)  ... R(N-1)*] [  A(3)  ]  = [  -R(3)  ]
%       [   .        .         .   ] [   .    ]  = [    .    ]
%       [ R(N-1) R(N-2) ...  R(2)* ] [  A(N)  ]  = [  -R(N)  ]
%       [  R(N)  R(N-1) ...  R(1)  ] [ A(N+1) ]  = [ -R(N+1) ]
%
%   ����́ALevinson- Durbin �A�[�@���g�p���܂� (Yule-Walker AR �������Ƃ��Ă�
%   �m���Ă��܂�)�B���� R �́A���O 0 ���ŏ��̗v�f�Ƃ��Ă����ȉ�A�W����
%   �x�N�g���ł��B
%
%   N �́A���ȉ�A���`�ߒ��̌W���ł��BN ���ȗ�����ƁAN �́AN = LENGTH(R)-1 
%   �ł��BA �́AA(1) = 1.0 �������� N+1 �̍s�x�N�g���ł��B
%
%   [A,E] = LEVINSON(...) �́A���� N �̗\���덷 E ��Ԃ��܂��B
%
%   [A,E,K] = LEVINSON(...) �́A���� N �̗�x�N�g���������ˌW�� K ��Ԃ��܂��B
%   K �́A�W�� A ���v�Z����Ԃɓ����I�Ɍv�Z����邽�߁A�����ɕԂ���� K �́A
%   TF2LATC �ɂ��AA �� K �ɕϊ�������������I�Ɍv�Z����܂��B
%
%   R ���s��̏ꍇ�ALEVINSON �́AR �̊e��ɑ΂��ČW�������߁AA �̍s�x�N�g����
%   �Ԃ��܂��B
%
%   �Q�l LPC, PRONY, STMCB.


%   Copyright 1988-2007 The MathWorks, Inc.
