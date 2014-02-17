%MODULATE  �ʐM�V�~�����[�V�����̂��߂̐M���̕ϒ�
%
%   Y = MODULATE(X,Fc,Fs,METHOD,OPT) �́A���� METHOD �̃I�v�V�����ł���
%   �ϒ����@�����ꂩ 1 ���g���āA�����g���g�� Fc �ƃT���v�����O���g�� 
%   Fs �������b�Z�[�W�M�� X ��ϒ����܂��BOPT �́A�I������ϒ������Ɉˑ����A
%   �ꍇ�ɂ���Ă͗]���ȃp�����[�^�ł��B
%
%   Fs �́AFs > 2*Fc + BW �𖞑�����K�v������܂��B�����ŁABW �͕ϒ����ꂽ
%   �M���̑ш敝�ł��B
%
%    METHOD              �ϒ����@
%    'am'         �U���ϒ��A�����g�сA�}�������g�B
%    'amdsb-sc'   OPT ���g�p���܂���B
%    'amdsb-tc'   �U���ϒ��A�����g�сA�`�������g�B
%                 OPT �́A�����R�T�C���g���悶��O�� X ���猸�Z����X�J���l�ł��B
%                 �f�t�H���g�́Amin(min(x)) �ł��B���̂��߁A�I�t�Z�b�g���b�Z�[�W
%                 �M�������ŁA���A�ŏ��l�� 0 �ɂȂ�܂��B
%    'amssb'      �U���ϒ��A�Б��g�сB
%                 OPT ���g�p���܂���B
%    'fm'         ���g���ϒ��B
%                 OPT �́A���g���ϒ� kf �̒萔���w�肷��X�J���ł��BFc Hz ��
%                 �ő���g���ɑ΂���f�t�H���g�l�́A
%                 kf = (Fc/Fs)*2*pi/max(max(abs(X))) �ɂȂ�܂��B
%    'pm'         �ʑ��ϒ��B
%                 OPT �́A�ʑ��ϒ� kp �̒萔���w�肷��X�J���ł��B�ő�ʑ� 
%                 �}�΃��W�A���ɑ΂���f�t�H���g�l�́A
%                 kp = pi/max(max(abs(x))) �ɂȂ�܂��B
%    'pwm'        �p���X���ϒ��B
%                 OPT �� 'centered' �ɐݒ肷��ƁA���[�ɗ����オ���Ă���
%                 �p���X�͊e���������̒��S�ɐݒ肳��܂��B
%    'ppm'        �p���X�ʒu�ϒ��B
%                 OPT �́A0 ���� 1 �̊ԂŁA�����g�̎�����P�ʂɕ������ꂽ
%                 �e�X�̃p���X�̕����w�肵�Ă��܂��BOPT �̃f�t�H���g�l�� 0.1 �ł��B
%    'qam'        ����U���ϒ��B
%                 OPT �́AX �𒼌�U���ϒ��������̂Ɠ����T�C�Y�̍s��ł��B
%
%   X ���z��̏ꍇ�AMODULATE �́A�e���ϒ����܂��B
%
%   [Y,T] = MODULATE(...) �́AY �Ɠ��������̎��ԃx�N�g����Ԃ��܂��B
%
%   �Q�l Signal Processing Toolbox �� DEMOD, VCO, Communications Toolbox �� 
%        PAMDEMOD, QAMDEMOD, GENQAMDEMOD, FSKDEMOD, PSMDEMOD, MSKDEMOD.


%   Copyright 1988-2007 The MathWorks, Inc.
