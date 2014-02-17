%CELL2SOS  �Z���z��� 2 ���^�̍s��ɕϊ�
%
%   SOS = CELL2SOS(C) �́A�Z���z�� C �����̌^�ɕϊ����܂��B
%
%     C = { {B1,A1}, {B2,A2}, ... {BL,AL} },
%
%   �����ŁA�X�̕��q�x�N�g�� Bi �ƕ���x�N�g�� Ai �́A���`�A�܂��́A
%   �񎟑������̌W����\���A���̌^�� L �s 6 ��̓񎟌^�s�� SOS ��
%   �ϊ����܂��B
%
%        S = [B1 A1
%             B2 A2
%              ...
%             BL AL]
%
%   ���`�f�ʂ́A�E���� 0 ��t�����܂��B
%
%   [S,G] = CELL2SOS(C) �́AC �̍ŏ��̗v�f���X�J���̑g�ł���Ƃ��A���̑g��
%   ���X�J���Q�C�� G ���쐬���AC �̎c��̗v�f���g���� S �s����쐬���܂��B
%
%   ��F
%   % �Q�C���́Aleading first-order section �ɑg�ݍ��܂�܂��B
%     c = {{[0.0181 0.0181],[1.0000 -0.5095]},{[1 2 1],[1 -1.2505  0.5457]}};
%     s = cell2sos(c)
%
%   % �Q�C���́Aleading zeroth-order (�X�J��) section �ɑg�ݍ��܂�܂��B
%     c = {{0.0181,1},{[1 1],[1.0000 -0.5095]},{[1 2 1],[1 -1.2505  
%     0.5457]}};
%     [s,g] = cell2sos(c)
%
%   �Q�l SOS2CELL, TF2SOS, SOS2TF, ZP2SOS, SOS2ZP, SOS2SS, SS2SOS.


%   Copyright 1988-2007 The MathWorks, Inc.
