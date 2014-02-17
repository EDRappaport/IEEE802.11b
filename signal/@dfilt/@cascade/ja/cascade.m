%CASCADE  ���U���ԃt�B���^�̃J�X�P�[�h���쐬
%
%   Hd = CASCADE(Hd1, Hd2, etc) �́A������ dfilt �t�B���^Hd1,Hd2,... ��
%   ����ڑ����ꂽ cascade �^�C�v�̗��U���ԃt�B���^Hd ��Ԃ��܂��B
%   �t�B���^�I�u�W�F�N�g�̏ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started with Discrete-Time Filters</a> �f����
%   �Q�Ƃ��Ă��������B���̃J�X�P�[�h�̃u���b�N���}�́A�ȉ��̂悤�Ȍ`�ɂȂ�܂��B
%
%      x ---> Hd1 ---> Hd2 ---> etc. ---> y
%
%   Filter Design Toolbox ���C���X�g�[������Ă���ꍇ�A�ʏ�́A���m�� 
%   CASCADE �t�B���^���쐬���Ȃ����Ƃɒ��ӂ��Ă��������B����ɁA<a href="matlab:help fdesign">FDESIGN</a> 
%   ���g�p�����݌v�̌��ʂƂ��Ă����̃t�B���^�𓾂܂��B
%
%   % �� #1:���ڃC���X�^���X��
%   Hd = dfilt.dffir([0.05 0.9 0.05]);
%   Hgain = dfilt.scalar(2);
%   Hcas = dfilt.cascade(Hgain,Hd)
%   realizemdl(Hcas)    % Simulink ���K�v
%
%   % �� #2:��� FIR ���[�p�X�t�B���^��݌v
%   Hcas = design(fdesign.lowpass('Fp,Fst,Ap,Ast',.1, .12, 1, 60), 'ifir')
%   fvtool(Hcas)        % �t�B���^�̉��
%   x = randn(100,1);   % ���͐M��
%   y = filter(Hcas,x); % �t�B���^����͐M���ɓK�p
%
%   �Q�l DFILT/STRUCTURES


%   Copyright 1988-2008 The MathWorks, Inc.
