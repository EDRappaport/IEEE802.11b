%LATTICEARMA  ���e�B�X���ȉ�A�ړ�����
%
%   Hd = DFILT.LATTICEARMA(K, V) �́A���e�B�X�W�� K �ƃ��_�[�W�� V ������
%   ���e�B�X���ȉ�A�ړ����� (ARMA) ���U���ԃt�B���^�I�u�W�F�N�g Hd ���쐬���܂��B
%   K �܂��� V ���w�肳��Ȃ��ꍇ�A�f�t�H���g�� [] �� 1 �ł��B���̏ꍇ�A�t�B���^
%   �͏o�͂�ύX�����ɓ��͂�ʂ��܂��B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   Filter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x���������_��
%   �Œ菬���_�̃T�|�[�g��L���ɂ��邱�Ƃɒ��ӂ��Ă��������B�t�B���^�I�u�W�F�N�g
%   �̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �f�����Q�Ƃ��Ă��������B
%
%   % ��:
%   [b,a] = butter(3,.5);
%   [k,v] = tf2latc(b,a);
%   Hd = dfilt.latticearma(k,v)
%   realizemdl(Hd);    % Simulink ���K�v
%
%   �Q�l DFILT/STRUCTURES, TF2LATC


%   Copyright 1988-2008 The MathWorks, Inc.
