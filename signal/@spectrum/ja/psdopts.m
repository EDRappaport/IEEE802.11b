%PSDOPTS  �p���[�X�y�N�g�����x (PSD) �I�v�V�����̃I�u�W�F�N�g
%
%   Hopts = PSDOPTS(Hs) �́AHs �Ɏw�肳�ꂽ PSD �����ɑ΂��� Hopts �� 
%   PSD �I�v�V�����̃I�u�W�F�N�g��Ԃ��܂��B
%
%   �L���� PSD �����:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.mcov">mcov</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%           <a href="matlab:help spectrum.mtm">mtm</a>
%           <a href="matlab:help spectrum.burg">burg</a>
%           <a href="matlab:help spectrum.yulear">yulear</a>
%           <a href="matlab:help spectrum.cov">cov</a>
%
%   Hopts �́A���̃v���p�e�B���܂݂܂�:
%
%   �v���p�e�B            �L���Ȓl�Ɛ���
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ���[�U��` ]
%                       Full �́A���ׂẴi�C�L�X�g�͈͂������A���I�� 
%                       NFFT �v���p�e�B���쐬���܂��B���[�U��`�́A
%                       ���I�� FrequencyVector �v���p�e�B���쐬���A
%                       ���[�U�����̓_�� psd ��]�����邽�߂̎��g����
%                       �w�肷�邱�Ƃ������܂��B
%
%   NFFT                [ Auto | {Nextpow2} �܂��͐��̐���]
%                       FFT �_���BAuto �́A256 �̍ő�A�܂��͓��� (�܂��� 
%                       Welch �̃Z�O�����g) �̒������g�p���܂��B
%                       Nextpow2 �� Auto �Ɠ����ł����A���� 2 �ׂ̂����
%                       �g�p���܂��B
%
%   FrequencyVector     [ Fs ��菬���������̐��l�� double �̃x�N�g�� ]
%                       psd ��]��������g���̃x�N�g�����w�肵�܂��B
%
%   NormalizedFrequency [ {true} | false ]
%                       false �́A���g���P�ʂ��w���c�ł��邱�Ƃ��w�肵�܂��B
%
%   Fs                  [ {Normalized} �܂��͐��� double ]
%                       'NormalizedFrequency' �� false �ɐݒ肳��Ă���
%                       �ꍇ�̂ݎw��\�ȃT���v�����O���g���ł��B
%
%   SpectrumType        [ {Onesided} | Twosided ]
%                       Onesided �́A���ׂĂ̐M���p���[���i�C�L�X�g�͈͂�
%                       �����Ɋ܂܂�邱�Ƃ������܂��B
%
%   Hopts �I�u�W�F�N�g�́A<a href="matlab:help spectrum/psd">psd</a> ���\�b�h�ւ�
%   ���͈����Ƃ��ēn�����Ƃ��\�ł��B
%
%   Hopts = PSDOPTS(Hs,X) �́AHopts �Ƀf�[�^���L�̃f�t�H���g�I�v�V������Ԃ����߂� 
%   X �Ɏw�肳�ꂽ�f�[�^���g�p���܂��B
%
%   �Q�l SPECTRUM/MSSPECTRUMOPTS, SPECTRUM/PSEUDOSPECTRUMOPTS, SPECTRUM, 
%        DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
