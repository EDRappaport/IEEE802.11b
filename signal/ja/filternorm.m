%FILTERNORM  �f�W�^���t�B���^�̃m�����̌v�Z
%
%   FILTERNORM(B,A) �́A�x�N�g��B ����� A �ɂ����镪�q�̌W���ƕ����
%   �W���ɂ��^������A�f�W�^���t�B���^�� L2-�m������Ԃ��܂��B
%
%   FILTERNORM(B,A,PNORM) �́A�t�B���^�� L2-�m������Ԃ��܂��BPNORM �́A
%   2�A���邢�́Ainf �̂����ꂩ�ƂȂ�܂��B�f�t�H���g�ł́AL2-�m������
%   �Ԃ���܂��BIIR �t�B���^�� L2-�m�������v�Z����ꍇ�AFILTERNORM(...,TOL) 
%   �́A��荂���A���邢�́A���Ⴂ���x�̋��e�덷���w�肵�܂��B
%   �f�t�H���g�ł́ATOL = 1e-8 �ł��B
%
%   ��:
%   % IIR �t�B���^�ɑ΂��� 1e-10 �̋��e�덷������ L2-�m�����̌v�Z
%   [b,a] = butter(5,.5);
%   L2 = filternorm(b,a,2,1e-10);
%
%   % FIR �t�B���^�ɑ΂��閳���m�����̌v�Z
%   b = firpm(30,[.1 .9],[1 1],'Hilbert');
%   Linf = filternorm(b,1,inf); 
%
%   �Q�l ZP2SOS, NORM.


%   Copyright 1988-2008 The MathWorks, Inc.
