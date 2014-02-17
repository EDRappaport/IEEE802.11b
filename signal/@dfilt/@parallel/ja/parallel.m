%PARALLEL  ���U���ԃt�B���^�I�u�W�F�N�g�̕���ȃV�X�e�����쐬
%
%   Hd = PARALLEL(Hd1, Hd2, etc) �́A�t�B���^�I�u�W�F�N�g Hd1, Hd2, ... ��
%   ����ȃV�X�e�����쐬���܂��B�u���b�N���}�͈ȉ��̂悤�ɂȂ�܂��B
%
%           |->  Hd1 ->|
%           |          |
%      x ---|->  Hd2 ->|--> y
%           |          |
%           |-> etc. ->|
%
%   �t�B���^ Hd1, Hd2, ... �́A�{���x���������_���P���x���������_�̂����ꂩ��
%   �Ȃ���΂Ȃ�܂��� (Filter Design Toolbox ���K�v�ł�)�B
%
%   Hd1, Hd2, ... �́A�V���O�����[�g���}���`���[�g�̂����ꂩ�łȂ���΂Ȃ�
%   ���A���̏ꍇ�A����\���̊e�X�e�[�W�̃��[�g�ύX�͓����łȂ���΂Ȃ�܂���B
%   �}���`���[�g�t�B���^�� Filter Design Toolbox ���K�v�ł��邱�Ƃɒ��ӂ���
%   ���������B
%
%   Hd1, Hd2, ... �́A����܂��͒���t�B���^�ɂ��邱�Ƃ��ł��܂��B
%
%   % ��:
%   k1 = [-0.0154    0.9846   -0.3048    0.5601];
%   Hd1 = dfilt.latticeallpass(k1);
%   k2 = [-0.1294    0.8341   -0.4165];
%   Hd2 = dfilt.latticeallpass(k2);
%   Hpar = parallel(Hd1 ,Hd2);
%   x = randn(100,1); % �����̓��͐M�����쐬
%   y = filter(Hpar,x);
%   realizemdl(Hpar)    % Simulink ���K�v
%
%   �Q�l DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
