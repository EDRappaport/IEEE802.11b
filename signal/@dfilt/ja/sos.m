%SOS  2 ���^�ɕϊ� (IIR �t�B���^�̂�)
%
%   Hsos = SOS(Hd) �́AIIR �̗��U���ԃt�B���^ Hd �� 2 ���^�ɕϊ����܂��B
%   Hd �́Adfilt.df1, dfilt.df1t, dfilt.df2, dfilt.df2t �̂����ꂩ��
%   �N���X�ɂȂ�܂��B
%
%   SOS(Hd,DIR_FLAG) �́A2 ���^�̎����Z�N�V�����̕��т��w�肵�܂��B
%   DIR_FLAG ='UP' �̏ꍇ�A�ŏ��̍s�́A���_�ɍł��߂��ɂ��܂݁A�Ō��
%   �s�́A�P�ʉ~�ɍł��߂��ɂ��܂݂܂��BDIR_FLAG = 'DOWN' �̏ꍇ�A����
%   ���Ԃ́A'UP' �̋t�ɂȂ�܂��B��_�͏�ɂ����ɍł��߂��ɂ̑g�ݍ��킹
%   �ɂȂ�܂��BDIR_FLAG �̃f�t�H���g�� 'UP' �ł��B
%
%   % ��:
%     [b,a] = butter(8,.5);
%     Hd = dfilt.df2(b,a);
%     Hsos = sos(Hd,'up',inf)
%
%   % �� 2:Filter Design Toolbox �����p�\�ȏꍇ�A�`�B�֐����쐬����
%   % ���� SOS �`���ɒ��ڐ݌v��������D�܂����A�ϊ��͊ۂߌ덷�𔭐�
%   % ���܂��B
%     f = fdesign.lowpass('N,F3db',8,0.5);
%     Hsos = design(f,'butter','FilterStructure','df1sos');
%
%   �Q�l Filter Design Toolbox �� DFILT/SCALE


%   Copyright 1988-2007 The MathWorks, Inc.
