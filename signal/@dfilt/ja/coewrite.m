%COEWRITE  XILINX CORE Generator(tm) �W�� (.COE) �t�@�C������������
%
%   COEWRITE(Hd) �́AXILINX CORE Generator �ɓǂݍ��ނ��Ƃ̂ł��� XILINX 
%   Distributed Arithmetic FIR �t�B���^�W���� .COE �t�@�C�����������݂܂��B
%   �W���́A�Œ菬���_ DFILT �t�B���^�I�u�W�F�N�g Hd ���璊�o����܂��B
%   �_�C�A���O�{�b�N�X���t�@�C��������͂��邽�߂ɕ\������܂��B�f�t�H���g��
%   �t�@�C�����́A'untitled.coe' �ł��B
%
%   COEWRITE(Hd,RADIX) �́AFIR �t�B���^�W�����w�肷�邽�߂Ɏg���� 
%   (���x�[�X) �������܂��B�L���� RADIX �l�́A2, 10, 16 (�f�t�H���g) �ł��B
%
%   COEWRITE(...,FILENAME) �́AXILINX .COE �t�@�C���� FILENAME ���Ăяo��
%   �f�B�X�N�t�@�C���ɏ������݂܂��B
%
%   �܂��g���q���Ȃ��ꍇ�A�g���q '.coe' �� FILENAME �ɒǉ�����܂��B
%
%   ��:
%   b = firceqrip(30,0.4,[0.05 0.03]);
%   Hd = dfilt.dffir(b);
%   Hd.arithmetic = 'fixed'; % Fixed-Point Designer ���K�v
%   coewrite(Hd,10,'mycoefile');
%
%   �Q�l COEREAD.


%   Copyright 1988-2007 The MathWorks, Inc.
