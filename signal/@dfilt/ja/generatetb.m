%GENERATETB  HDL �e�X�g�x���`�𐶐�
%
%   GENERATETB(Hb, TBTYPE) �́A�t�B���^�ɑ΂�����͂̎h���M���Ƃ��āA�C���p���X�A
%   �X�e�b�v�A�����v�Achirp�A�܂��̓m�C�Y�g�`�̂����ꂩ�A�܂��͂��ׂĂ��g���āA
%   GENERATEHDL(Hb) �Ő������ꂽ�t�B���^���@�\�I�Ɍ��؂��� VHDL �R�[�h�AVerilog 
%   �R�[�h�A�܂��� ModelSim �� .do �t�@�C���������I�ɐ������܂��BTBTYPE �́A
%   'VHDL', 'Verilog', 'ModelSim' �̂����ꂩ�A�܂��́A�����̂����ꂩ�A���邢��
%   ���ׂĂ��܂ރZ���z��ł��B�f�t�H���g�̃t�@�C�����́A�ǉ����ꂽ '_tb' ��
%   ���t�B���^�ϐ��̖��O�ł��B���Ƃ��΁A�I�������e�X�g�x���`�Ɉˑ����AVHDL ��
%   �΂��� Hb_tb.vhd�AVerilog �ɑ΂��� Hb_tb.v�AModelSim �ɑ΂��� Hb_tb.do 
%   �t�@�C���ł��B�t�@�C���́AHDL �̃^�[�Q�b�g�f�B���N�g���A�f�t�H���g�ł́A
%   �J�����g�f�B���N�g���̉��� 'hdlsrc'�ɏ������܂�܂��B���̃f�B���N�g����
%   ���݂��Ȃ��ꍇ�A�쐬����܂��B
%
%   GENERATETB(Hb, TBTYPE, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) �́A
%   �p�����[�^/�l�̑g�ݍ��킹�Ńe�X�g�x���`�𐶐����܂��BGENERATETB �ɑ΂���
%   �L���ȃv���p�e�B�ƒl�́AFilter Design HDL Coder �̃h�L�������e�[�V������ 
%   "Property Reference" �̐߂Ƀ��X�g����Ă��܂��B
%
%   ��:
%   % �t�B���^�̃Z�b�g�A�b�v
%   h = firceqrip(30,0.4,[0.05 0.03]);
%   Hb = dfilt.dffir(h);
%   Hb.arithmetic = 'fixed';
%   generatehdl(Hb);
%
%   % �e�X�g�x���`�̗�
%   generatetb(Hb, 'ModelSim');
%   generatetb(Hb,'VHDL','TestBenchName','MyTestBench');
%   generatetb(Hb,{'ModelSim','VHDL'}, 'TestBenchStimulus',{'impulse','chirp'});
%   generatetb(Hb,'VHDL','TestBenchUserStimulus', sin(2*pi*[0:0.01:1]));
%
%   �Q�l GENERATEHDL, GENERATETBSTIMULUS, FDHDLTOOL


%   Copyright 2003-2007 The MathWorks, Inc.
