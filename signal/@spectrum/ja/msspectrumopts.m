%MSSPECTRUMOPTS  ���ϓ��X�y�N�g�� (MSS) �I�v�V�����̃I�u�W�F�N�g
%
%   Hopts = MSSPECTRUMOPTS(Hs) �́AHs �Ɏw�肳�ꂽ MSS �����ɑ΂��� 
%   Hopts �� MSS �I�v�V�����̃I�u�W�F�N�g��Ԃ��܂��B
%
%   �L���� MSS �����:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%
%   Hopts �́A���̃v���p�e�B���܂݂܂�:
%
%   �v���p�e�B            �L���Ȓl�Ɛ���
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ���[�U��` ]
%                       Full �́A���ׂẴi�C�L�X�g�͈͂������A���I�� NFFT 
%                       �v���p�e�B���쐬���܂��B���[�U��`�́A���I�� 
%                       FrequencyVector �v���p�e�B���쐬���A���[�U�����̓_��
%                       ���ϓ��X�y�N�g����]��������g���̂��w�肷�邱�Ƃ�
%                       �����܂��B
%
%   NFFT                [ Auto | {Nextpow2} �܂��͐��̐���]
%                       FFT �_���BAuto �́A�ő�� 256�A�܂��͓��� (�܂��� 
%                       Welch �̃Z�O�����g) �̒������g�p���܂��B
%                       Nextpow2 �� Auto �Ɠ����ł����A���� 2 �ׂ̂����
%                       �g�p���܂��B
%
%   FrequencyVector     [ Fs ��菬���������̐��l�� double �̃x�N�g�� ]
%                       ���ϓ��X�y�N�g����]��������g���̃x�N�g����
%                       �w�肵�܂��B
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
%   Hopts �I�u�W�F�N�g�́A<a href="matlab:help spectrum/msspectrum">msspectrum</a> 
%   ���\�b�h�ւ̓��͈����Ƃ��ēn�����Ƃ��\�ł��B
%
%   Hopts = MSSPECTRUMOPTS(Hs,X) �́AHopts �Ƀf�[�^���L�̃f�t�H���g�I�v�V������
%   �Ԃ����߂� X �Ɏw�肳�ꂽ�f�[�^���g�p���܂��B
%
%   �Q�l SPECTRUM/PSDOPTS, SPECTRUM/PSEUDOSPECTRUMOPTS, SPECTRUM, DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
