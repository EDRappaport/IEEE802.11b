%DF1SOS  ���ڌ^ I, 2 ���^
%
%   Hd = DFILT.DF1SOS(SOS) �́A<a href="matlab: help zp2sos">zp2sos</a> �Œ�`����� SOS �s���
%   �^����ꂽ�W�����g���ė��U���Ԃ� 2 ���^�̒��ڌ^ I �t�B���^�I�u�W�F�N�g 
%   Hd ��Ԃ��܂��B
%
%   Hd = DFILT.DF1SOS(b1,a1,b2,a2,...) �́Ab1 �� a1 �x�N�g���ɗ^����ꂽ 
%   1 �Ԗڂ̃Z�N�V�����Ab2 �� a2�x�N�g���ɗ^����ꂽ 2 �Ԗڂ̃Z�N�V�����A... ��
%   �΂���W�����g���ė��U���Ԃ� 2 ���^�̒��ڌ^ I �t�B���^�I�u�W�F�N�g Hd ��
%   �Ԃ��܂��B
%
%   Hd = DFILT.DF1SOS(...,g) �́A�Q�C���x�N�g�� g ���܂݂܂��Bg �̗v�f��
%   �e�Z�N�V�����̃Q�C���ł��Bg �̍ő咷�́A�Z�N�V�����̐��� 1 ���������l�ł��B
%   g ���w�肵�Ȃ��ꍇ�A���ׂẴQ�C�����f�t�H���g�l 1 �ɂȂ�܂��B�t�B���^
%   �I�u�W�F�N�g�̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> �f��
%   ���Q�Ƃ��Ă��������B
%
%   Filter Design Toolbox ���C���X�g�[������Ă���ꍇ�A�ʏ�́A���m�� DFILT 
%   �t�B���^���쐬���Ȃ����Ƃɒ��ӂ��Ă��������B����ɁA<a href="matlab:help fdesign">FDESIGN</a> ��
%   �g�p�����݌v�̌��ʂƂ��Ă����̃t�B���^�𓾂܂��B
%
%   ����ɁAFilter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA�P���x
%   ���������_�ƌŒ菬���_�̃T�|�[�g��L���ɂ��܂��B�t�B���^�I�u�W�F�N�g��
%   �ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\gsfixedptdemo.html'])">Getting Started with Fixed-Point Filters</a> �f�����Q�Ƃ��Ă��������B
%
%   % �� #1:���ڃC���X�^���X��
%   [z,p,k] = ellip(4,1,60,.4);
%   [s,g] = zp2sos(z,p,k);
%   Hd = dfilt.df1sos(s,g)
%   realizemdl(Hd)    % Simulink ���K�v
%
%   % �� #2:�f�t�H���g�̎d�l�őȉ~���[�p�X�t�B���^��݌v
%   Hd = design(fdesign.lowpass, 'ellip', 'FilterStructure', 'df1sos');
%   fvtool(Hd)                % �t�B���^�̉��
%   input = randn(100,1);
%   output = filter(Hd,input); % �ȉ~�t�B���^��ʂ��ăf�[�^������
%
%   �Q�l DFILT/STRUCTURES.


%   Copyright 1988-2008 The MathWorks, Inc.
