%NORM  �t�B���^�̃m����
%
%   NORM(H) �́A�f�W�^���t�B���^ (DFILT) H �� L2-�m������Ԃ��܂��B
%
%   NORM(H,PNORM) �́A�t�B���^�� p-�m������Ԃ��܂��BPNORM �́A���g���̈��
%   �m�����̂����ꂩ�ɂȂ�܂�:'L1', 'L2', 'Linf'�A�܂��͗��U���ԗ̈�̃m����: 
%   'l1', 'l2', 'linf'
%   �t�B���^�� L2-�m�����́Al2-�m�����Ɠ������ł� (�p�[�Z�o���̒藝) ���A
%   ����́A���̃m�����ɑ΂��Ă͂��Ă͂Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   IIR �t�B���^�� l1-, l2-, linf-, L1-, L2-�m�������v�Z����ꍇ�ANORM(...,TOL) 
%   �́A���傫�ȁA���邢�͂�菬���Ȑ��x�ɑ΂��鋖�e�덷���w�肵�܂��B
%   �f�t�H���g�ł́ATOL = 1e-8 �ł��B
%
%   ��:
%   % IIR �t�B���^�ɑ΂��� 1e-10 �̋��e�덷������ L2-�m�����̌v�Z
%   Hs = fdesign.lowpass; % �t�B���^�݌v�d�l�̃I�u�W�F�N�g���쐬
%   Hd = design(Hs,'butter'); % �o�^���[�X SOS�t�B���^��݌v
%   L2 = norm(Hd,'L2',1e-10); % L2-�m�������v�Z
%
%   �Q�l DFILT/SCALE, DFILT/SCALECHECK, NORM.


%   Copyright 2003-2007 The MathWorks, Inc.
