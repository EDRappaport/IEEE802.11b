%LATTICEALLPASS  ���e�B�X�I�[���p�X
%
%   Hd = DFILT.LATTICEALLPASS(LATTICE) �́A���e�B�X�W�� K �������U���Ԃ�
%   ���e�B�X�I�[���p�X�t�B���^�I�u�W�F�N�g Hd ���쐬���܂��BK ���ݒ肳���
%   ���Ȃ��ꍇ�A�f�t�H���g�� [] �ł��B���̏ꍇ�A�t�B���^�͏o�͂�ύX������
%   ���͂�ʂ��܂��B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   Filter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x���������_��
%   �Œ菬���_�̃T�|�[�g��L���ɂ��邱�Ƃɒ��ӂ��Ă��������B�t�B���^�I�u�W�F�N�g
%   �̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �f����
%   �Q�Ƃ��Ă��������B
%
%   % ��:
%   k = [.66 .7 .44];
%   Hd = dfilt.latticeallpass(k)
%   realizemdl(Hd);    % Simulink ���K�v
%
%   �Q�l DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
