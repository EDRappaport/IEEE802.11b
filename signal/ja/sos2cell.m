%SOS2CELL  2 ���^�s����Z���z��ɕϊ�
%
%   C = SOS2CELL(S) �́A���̃t�H�[���� L�~6 �� 2 ���^�s���ϊ����܂��B
%
%        S =   [B1 A1
%               B2 A2
%                ...
%               BL AL]
%
%   ���ʂ͂��̃t�H�[���ŃZ���z�� C �ɂȂ�܂��B
%
%     C = { {B1,A1}, {B2,A2}, ... {BL,AL} }
%
%   �����ŁA�X�̕��q�x�N�g�� Bi �ƕ���x�N�g�� Ai �́A���`�܂��� 2 ����
%   �������̌W����\���܂��B
%
%   �ǉ��̃Q�C���������� C = SOS2CELL(S,G) �́A���̃t�H�[���̂悤�� C ��
%   �萔����ǉ����܂��B
%
%     C = { {G,1}, {B1,A1}, {B2,A2}, ... {BL,AL} }
%
%   ��F
%     [b,a] = butter(4,.5);
%     [s,g] = tf2sos(b,a);
%     c = sos2cell(s,g)
%
%   �Q�l CELL2SOS, TF2SOS, SOS2TF, ZP2SOS, SOS2ZP, SOS2SS, SS2SOS.


%   Copyright 1988-2007 The MathWorks, Inc.
