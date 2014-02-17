%DF1  ���ڌ^ I
%
%   Hd = DFILT.DF1(NUM, DEN) �́A���q�W�� NUM �ƕ���W�� DEN �������U���Ԃ�
%   ���ڌ^ I �t�B���^�I�u�W�F�N�g Hd ���쐬���܂��B���� DEN(1) �̍ŏ��̌W���́A
%   0 �ɂ͂Ȃ�܂���B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   Filter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x���������_��
%   �Œ菬���_�̃T�|�[�g��L���ɂ��邱�Ƃɒ��ӂ��Ă��������B�t�B���^�I�u�W�F�N�g
%   �̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �f�����Q�Ƃ��Ă��������B
%
%   ����ɁAIIR �t�B���^�̒��ڌ^�̍\���́A���l�I�Ȗ����N�����\��������
%   ���Ƃɒ��ӂ��Ă��������B�����̏ꍇ�A�`�B�֐��̍쐬������A<a href="matlab:help dfilt.df1sos">2 ���^</a> 
%   ���g�p���邱�ƂŁA�ǂ����ʂ𓾂邱�Ƃ��ł��܂��B
%
%   % �� #1:���ڃC���X�^���X��
%   [b,a] = butter(4,.5);
%   Hd = dfilt.df1(b,a)
%
%   % �� #2:2 ���^�� 10 ���̃��[�p�X�t�B���^��݌v
%   f = fdesign.lowpass('N,F3dB',10,.5);  % �d�l
%   Hd = design(f, 'butter', 'Filterstructure', 'df1sos')
%
%   �Q�l DFILT/STRUCTURES.


%   Copyright 1988-2008 The MathWorks, Inc.
