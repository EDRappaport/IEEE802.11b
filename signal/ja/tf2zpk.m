%TF2ZPK  ���U���ԓ`�B�֐����_�]�ɂɕϊ�
%
%   [Z,P,K] = TF2ZPK(NUM,DEN) �́A��_�A�ɁA�Q�C�������߂܂�:
%
%                 (z-Z(1))(z-Z(2))...(z-Z(n))
%       H(z) =  K ---------------------------
%                 (z-P(1))(z-P(2))...(z-P(n))
%
%   NUM, DEN �́A���̂悤�ȑ������̌^�̒P���́A�P�o�͂̓`�B�֐��ł��B
%
%               NUM(z)
%       H(z) = --------
%               DEN(z)
%
%   ��:
%     [b,a] = butter(3,.4);
%     [z,p,k] = tf2zpk(b,a)


%   Copyright 1988-2007 The MathWorks, Inc.
