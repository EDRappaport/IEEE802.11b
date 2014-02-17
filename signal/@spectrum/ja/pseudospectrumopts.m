%PSEUDOSPECTRUMOPTS  �[���X�y�N�g���I�v�V�����̃I�u�W�F�N�g
%
%   Hopts = PSEUDOSPECTRUMOPTS(Hs) �́AHs �Ɏw�肳�ꂽ�[���X�y�N�g������
%   �΂��� Hopts �ɋ[���X�y�N�g���I�v�V�����̃I�u�W�F�N�g��Ԃ��܂��B
%
%   �L���ȋ[���X�y�N�g�������:
%           <a href="matlab:help spectrum.eigenvector">eigenvector</a>
%           <a href="matlab:help spectrum.music">music</a>
%
%   Hopts �́A���̃v���p�e�B���܂݂܂�:
%
%   �v���p�e�B            �L���Ȓl�Ɛ���
%   ---------           ----------------------------
%   FreqPoints          [ {All} | ���[�U��` ]
%                       Full �́A���ׂẴi�C�L�X�g�͈͂������A���I�� 
%                       NFFT �v���p�e�B���쐬���܂��B���[�U��`�́A���I�� 
%                       FrequencyVector �v���p�e�B���쐬���A���[�U�����̓_��
%                       �[���X�y�N�g����]�����邽�߂̎��g�����w�肷�邱�Ƃ�
%                       �����܂��B
%
%   NFFT                [ Auto | {Nextpow2} �܂��͐��̐���]
%                       FFT �_���BAuto �́A�ő�� 256�A�܂��͓��� (�܂��� 
%                       Welch �̃Z�O�����g) �̒������g�p���܂��B
%                       Nextpow2 �� Auto �Ɠ����ł����A���� 2 �ׂ̂����
%                       �g�p���܂��B
%
%   FrequencyVector     [ Fs ��菬���������̐��l�� double �̃x�N�g�� ]
%                       �[���X�y�N�g����]�����邽�߂̓_�ɂ�������g��
%                       �x�N�g�����w�肵�܂��B
%
%   NormalizedFrequency [ {true} | false ]
%                       false �́A���g���P�ʂ��w���c�ł��邱�Ƃ��w�肵�܂��B
%
%   Fs                  [ {Normalized} �܂��͐��� double ]
%                       'NormalizedFrequency' �� false �ɐݒ肳��Ă���ꍇ�̂�
%                       �w��\�ȃT���v�����O���g���ł��B
%
%   SpectrumRange        [ {Half} | Whole ]
%                       Half �́A�i�C�L�X�g�͈͂̔����݂̂��g�p���邱�Ƃ������܂��B
%
%   Hopts �I�u�W�F�N�g�́A<a href="matlab:help spectrum/pseudospectrum">pseudospectrum</a> ���\�b�h�ւ�
%   ���͈����Ƃ��ēn�����Ƃ��\�ł��B
%
%   Hopts = PSEUDOSPECTRUMOPTS(Hs,X) �́AHopts �Ƀf�[�^���L�̃f�t�H���g�I�v�V������
%   �Ԃ����߂� X �Ɏw�肳�ꂽ�f�[�^���g�p���܂��B
%
%   �Q�l SPECTRUM/PSDOPTS, SPECTRUM/MSSPECTRUMOPTS, SPECTRUM, DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
