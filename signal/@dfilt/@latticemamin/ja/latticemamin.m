%LATTICEMAMIN   �ŏ��ʑ��ɑ΂��郉�e�B�X�ړ�����
%
%   Hd = DFILT.LATTICEMAMIN(K) �́A���e�B�X�W�� K �����ŏ��ʑ��̗��U����
%   �t�B���^�I�u�W�F�N�g Hd �ɑ΂��郉�e�B�X�ړ����� (MA) ���쐬���܂��B
%   K ���ݒ肳��Ă��Ȃ��ꍇ�A�f�t�H���g�� [] �ł��B���̏ꍇ�A�t�B���^��
%   �o�͂�ύX�����ɓ��͂�ʂ��܂��B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   �W�� k ���ŏ��ʑ��t�B���^���`���Ă���ꍇ�A���̍\���̂̌`�œ�����
%   �t�B���^�͍ŏ��ʑ��t�B���^�ɂȂ邱�Ƃɒ��ӂ��Ă��������B�W�����ŏ��ʑ�
%   �t�B���^���`���Ă��Ȃ��ꍇ�́A���̍\���̂̌`�ɂ��Ă��ŏ��ʑ��t�B���^�ɂ�
%   �Ȃ�܂���B
%
%   ����ɁAFilter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x����
%   �����_�ƌŒ菬���_�̃T�|�[�g��L���ɂ��܂��B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �f�����Q�Ƃ��Ă��������B
%
%   % ��:
%   k = [.66 .7 0.44];
%   Hd = dfilt.latticemamin(k)
%   ismin = isminphase(Hd)
%   realizemdl(Hd);    % Simulink ���K�v
%
%   �Q�l DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
