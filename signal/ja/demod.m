%DEMOD  �ʐM�V�~�����[�V�����̂��߂̕���
%
%   X = DEMOD(Y,Fc,Fs,METHOD,OPT) �́A�����g�̎��g�� Fc�A�T���v�����O
%   ���g�� Fs ���������g�M�� Y ���A���Ɏ��� METHOD �̃I�v�V�����̂����ꂩ 
%   1 ���g���ĕ������܂��BOPT �́A�I�v�V�����ŁA���[�U���I�����镜�����@
%   �ɂ���ĕK�v�ɂȂ�܂��B
%
%   Fs �́AFs > 2*Fc + BW �𖞑�����K�v������܂��B�����ŁABW �͕ϒ�
%   ���ꂽ�M���̑ш敝�ł��B
%
%    METHOD            �������@�̊T�v
%    'am',       �U�������A�����g�сA�}�������g�B
%    'amdsb-sc'  OPT �͐ݒ�ł��܂���B
%    'amdsb-tc'  �U�������A�����g�сA�`�������g�B
%                OPT ��ݒ肵���ꍇ�A�������ꂽ�M�� X ����X�J�� OPT �l��
%                �����܂��BOPT �̃f�t�H���g�l�� 0 �ł��B
%    'amssb'     �U�������A�Б��g�сBOPT ���g�p���܂���B
%    'fm'        ���g������
%                OPT ��ݒ肵���ꍇ�A���̎��g������ (kf) �Ŏ��s����܂��B
%                OPT �̃f�t�H���g�l�� 1 �ł��B
%    'pm'        �ʑ�����
%                OPT ��ݒ肵���ꍇ�A���̈ʑ����� (kp) �Ŏ��s����܂��B
%                OPT �̃f�t�H���g�l�� 1 �ł��B
%    'pwm'       �p���X������
%                OPT �� 'centered' �ɐݒ肷��ƁA���[�ɗ����オ���Ă���
%                �p���X�͊e�����g�����̒��S�ɐݒ肳��܂��B
%    'ppm'       �p���X�ʒu�����B
%                OPT ���g�p���܂���B
%    'qam'       ����U������
%                QAM �M���ɑ΂��āA[X1,X2] = DEMOD(Y,Fc,Fs,'qam') ���g���܂��B
%
%   Y ���s��̏ꍇ�A���̊e��𕜒����܂��B
%
%   �Q�l Signal Processing Toolbox �� MODULATE, Communications Toolbox �� 
%        PAMDEMOD, QAMDEMOD, GENQAMDEMOD, FSKDEMOD, PSMDEMOD, MSKDEMOD.


%   Copyright 1988-2007 The MathWorks, Inc.
