%DFFIR  ���ڌ^ FIR
%
%   Hd = DFILT.DFFIR(NUM) �́A���q�W�� NUM �������U���Ԃ̒��ڌ^�Ώ� FIR 
%   �t�B���^�I�u�W�F�N�g Hd ���쐬���܂��B�t�B���^�I�u�W�F�N�g�̏ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   Filter Design Toolbox ���C���X�g�[������Ă���ꍇ�A�ʏ�́A���m�� DFILT 
%   �t�B���^���쐬���Ȃ����Ƃɒ��ӂ��Ă��������B����ɁA<a href="matlab:help fdesign">FDESIGN</a> ��
%   �g�p�����݌v�̌��ʂƂ��Ă����̃t�B���^�𓾂܂��B
%
%   ����ɁAFilter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x
%   ���������_�ƌŒ菬���_�̃T�|�[�g��L���ɂ��܂��B�ڍׂ́A
%   <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �� <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\dffirfxptdemo.html'])">Working with Fixed-Point Direct-Form FIR Filters</a> 
%   �f�����Q�Ƃ��Ă��������B
%
%   % �� #1: ���ڃC���X�^���X��
%   b = [0.05 0.9 0.05];
%   Hd = dfilt.dffir(b)
%   realizemdl(Hd)    % Simulink ���K�v
%
%   % �� #2: �f�t�H���g�̎d�l�œ����b�v�����[�p�X�t�B���^��݌v
%   Hd = design(fdesign.lowpass, 'equiripple', 'Filterstructure', 'dffir');
%   fvtool(Hd)                % �t�B���^�̉��
%   x = randn(100,1);   % ���͐M��
%   y = filter(Hd,x); % �t�B���^����͐M���ɓK�p
%
%   �Q�l DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
