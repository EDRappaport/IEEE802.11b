%GENERATEHDL  HDL �𐶐�
%
%   GENERATEHDL(Hb) �́A�ʎq�����ꂽ�t�B���^ Hb �ɑ΂��� VHDL �܂��� Verilog 
%   �R�[�h�������I�ɐ������܂��B�f�t�H���g����� VHDL �ŁAVerilog �𐶐�����
%   �ɂ́A�v���p�e�B/�l�̑g�ݍ��킹 'TargetLanguage','Verilog' ��^���܂��B
%   �f�t�H���g�̃t�@�C�����́A�t�B���^�̕ϐ����A���Ƃ��΁AVHDL �ɑ΂��� Hb.vhd�A
%   Verilog �ɑ΂��� Hb.v �ł��B�t�@�C���́AHDL �̃\�[�X�f�B���N�g���A�f�t�H���g
%   �ł́A�J�����g�f�B���N�g���̉��� 'hdlsrc'�ɏ������܂�܂��B���̃f�B���N�g��
%   �́A�K�v�ɉ����č쐬����܂��B
%
%   GENERATEHDL(Hb, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) �́A
%   �p�����[�^/�l�̑g�ݍ��킹�� HDL �R�[�h�𐶐����܂��BGENERATEHDL �ɑ΂���
%   �L���ȃv���p�e�B�ƒl�́AFilter Design HDL Coder �̃h�L�������e�[�V������ 
%   "Property Reference" �̐߂Ƀ��X�g����Ă��܂��B
%
%   ��:
%   filtdes = fdesign.lowpass('N,Fc,Ap,Ast',30,0.4,0.05,0.03,'linear');
%   Hb = design(filtdes,'filterstructure','dffir');
%   Hb.arithmetic = 'fixed';
%   generatehdl(Hb);
%   generatehdl(Hb,'TargetLanguage','Verilog');
%   generatehdl(Hb,'Name','myfiltername','TargetDirectory','mysrcdir');
%   generatehdl(Hb,'InputPort','adc_data','OutputPort','dac_data');
%   generatehdl(Hb,'AddInputRegister','on','AddOutputRegister','off');
%   generatehdl(Hb,'OptimizeForHDL','on','CoeffMultipliers','csd');
%   generatehdl(Hb,'SerialPartition', 31);
%   generatehdl(Hb,'SerialPartition', [12 11 8], 'ReuseAccum', 'on');
%
%   �Q�l GENERATEHDLGUI, GENERATETB, GENERATETBSTIMULUS.


%   Copyright 2003-2007 The MathWorks, Inc.
