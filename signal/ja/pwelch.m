%PWELCH  Welch �@���g���āA�p���[�X�y�N�g�����x���v�Z
%
%   Pxx = PWELCH(X) �́AWelch �̕��ω��A�C���s���I�h�O�����@���g���āA
%   ���U���ԐM���x�N�g�� X �̃p���[�X�y�N�g�����x (PSD) �̐����Ԃ��܂��B
%   �f�t�H���g�ŁAX �� 50% �̃I�[�o���b�v������ 8 �̃O���[�v�ɕ������A
%   �e�O���[�v�� Hamming �E�B���h�E��K�p���A8 �̃O���[�v�̏C���s���I�h�O����
%   ���v�Z���A���ω����܂��B
%
%   X �̒������A50% �̃I�[�o���b�v������ 8 �̃O���[�v�ɐ��m�ɕ����ł��Ȃ�
%   �ꍇ�AX �́A�K�؂ɕ�������܂��B
%
%   Pxx �́A�P�ʎ��g���ɑ΂���p���[�̕��z���������̂ł��B�f�t�H���g�ł́A
%   PWELCH �́A�����M���ł͕Б� PSD �ŁA���f���M���ł͗��� PSD �ł��B�Б� 
%   PSD �́A���͐M���̂��ׂẴp���[���܂�ł��邱�Ƃɒ��ӂ��Ă��������B
%
%   ����ɁA�f�t�H���g�E�B���h�E (Hamming) �́A42.5 dB �̃T�C�h���[�u�̌�����
%   �����Ƃɂ����ӂ��Ă��������B����́A(�s�[�N�̃X�y�N�g���ɑ΂���) ���̒l��
%   ���ƂŃX�y�N�g���Ƀ}�X�N��������\��������܂��B�ʂ̃E�B���h�E��I������
%   �ƁA����\ (��. ���^�E�B���h�E���g�p) �ƃT�C�h���[�u�̌��� (��. Hann 
%   �E�B���h�E���g�p) �Ԃ̃g���[�h�I�t���s�����Ƃ��\�ɂȂ�܂��B�ڍׂ́A
%   WinTool ���Q�Ƃ��Ă��������B
%
%   Pxx = PWELCH(X,WINDOW) �́AX �� WINDOW �̒����ɓ����������ŃI�[�o���b�v
%   ���镔���ɕ������AWINDOW �ɐݒ肵���x�N�g���Ŋe�������E�B���h�E�������܂��B
%   �����ŁAWINDOW �́A�x�N�g���Őݒ肵�Ă��܂��BWINDOW �������̏ꍇ�AX �͂���
%   �����l�ɓ����������̃Z�N�V�����ɕ�������A�����̓����� Hamming �E�B���h�E��
%   �g���܂��BX �̒������A50% �̃I�[�o���b�v���s���Ȃ��琮���{�ɐ��m�ɂȂ���
%   ���Ȃ��ꍇ�A�K�؂� X �𕪊����܂��BWINDOW ���ȗ�����邩�A�܂��͋�̏ꍇ�A
%   �f�t�H���g�̃E�B���h�E���AX �� 8 �ɕ������������Ɏg���܂��B
%
%   Pxx = PWELCH(X,WINDOW,NOVERLAP) �́ANOVERLAP �T���v���������I�[�o���b�v
%   �����������܂ނ悤�ɕ������܂��BNOVERLAP �́AWINDOW �� �����̏ꍇ�A
%   WINDOW ���������������Z�����̂ɂȂ�܂��BNOVERLAP �́AWINDOW ��
%   �x�N�g���̏ꍇ�AWINDOW �̒������������������Z�����̂ɂȂ�܂��B
%   NOVERLAP ���ȗ����ꂽ��A��Őݒ肳���ꍇ�A�f�t�H���g�l�́A50% ��
%   �I�[�o���b�v���g���܂��B
%
%   [Pxx,W] = PWELCH(X,WINDOW,NOVERLAP,NFFT) �́APSD ������v�Z���邽�߂� 
%   FFT �̒�����ݒ肵�܂��B���� X �ɑ΂��āAPxx �́ANFFT �������̏ꍇ 
%   (NFFT/2+1) �ŁA��̏ꍇ (NFFT+1)/2 �ł��B���f�� X �ɑ΂��āAPxx �́A
%   ��������� NFFT �ɂȂ�܂��BNFFT ����Ŏw�肳�ꂽ�ꍇ�A�f�t�H���g�� 
%   NFFT �́A256 �̍ő�A�܂��͎g�p���� X �̊e�Z�N�V�����̒������傫�� 
%   2 �ׂ̂���̂ǂ��炩�ł��B
%
%   NFFT ���Z�O�����g�����傫���ꍇ�A�f�[�^�� 0 ���������邱�Ƃɒ��ӂ���
%   ���������BNFFT ���Z�O�����g�����������ꍇ�́A�Z�O�����g�� (DATAWRAP ��
%   �g����) "wrapped" ����A������ NFFT �Ɠ������Ȃ�܂��B����ɂ��AL ���M���A
%   �܂��̓Z�O�����g�̒����ł���ANFFT < L �̂Ƃ��A������ FFT �𐶐����܂��B
%
%   PSD ���v�Z���鐳�K�����ꂽ���g������Ȃ�x�N�g�� W ��Ԃ��܂��BW �̒P��
%   �́A���W�A��/�T���v���ł��B�����M���ɑ΂��āAW �́ANFFT �������̏ꍇ 
%   [0,pi] �̋�ԂɍL����ANFFT ����̏ꍇ [0,pi) �͈̔͂ɂȂ�܂��B
%   ���f���M���̏ꍇ�AW �́A��ɁA[0.2*pi) �̋�Ԃł��B
%
%   [Pxx,W] = PWELCH(X,WINDOW,NOVERLAP,W) �́AW �� (2 �ȏ�̗v�f������) 
%   ���K�����g���x�N�g���Ƃ��āAGoertzel �A���S���Y�����g�p���āA������
%   ���g���ɂ����� PSD ���v�Z���܂��B���̏ꍇ�A���� PSD ���Ԃ���܂��BW ��
%   �w�肵�����g���́A�M���̕���\�ɔ�Ⴕ�čł��߂� DFT �̃o�C�i���̒l��
%   �ۂ߂��܂��B
%
%   [Pxx,F] = PWELCH(X,WINDOW,NOVERLAP,NFFT,Fs) �́A�����I�ȈӖ��������g�� 
%   (Hz) �̊֐��Ƃ��� PSD ���v�Z���܂��BFs �́AHz �Ŏw�肳�ꂽ�T���v�����O
%   ���g���ł��BFs ����̏ꍇ�A�f�t�H���g�� 1Hz �ɂȂ�܂��B
%
%   F �́AHz �P�ʂ̎��g���x�N�g���ŁA�����Őݒ肳��Ă�����g���ŁAPSD ���v�Z
%   ���܂��B�����M���ɑ΂��āAF �́ANFFT �������̏ꍇ [0,Fs/2] �ŁA��̏ꍇ 
%   [0,Fs/2) �͈̔͂ɍL����܂��B���f���M���ɑ΂��āAF �́A��ɁA[0,Fs) ��
%   �͈͂ł��B
%
%   [Pxx,F] = PWELCH(X,WINDOW,NOVERLAP,F,Fs) �́AF �� (2 �ȏ�̗v�f������) 
%   Hz �P�ʂ̎��g���x�N�g���Ƃ��āAGoertzel �A���S���Y�����g�p���āA������
%   ���g���ɂ����� PSD ���v�Z���܂��B���̏ꍇ�A���� PSD ���Ԃ���܂��BF ��
%   �w�肵�����g���́A�M���̕���\�ɔ�Ⴕ�čł��߂� DFT �̃o�C�i���̒l��
%   �ۂ߂��܂��B
%
%   [...] = PWELCH(...,'twosided') �́A�����M�� X �̗��� PSD ��Ԃ��܂��B����
%   �ꍇ�APxx �́A���� NFFT �������AFs ���ݒ肳��Ă��Ȃ��ꍇ [0,2*Pi) �͈̔́A
%   Fs ���ݒ肳��Ă���ꍇ [0,Fs) �͈̔͂ł��B����A������ 'twosided' �́A
%   �����M�� X �ɑ΂��镶���� 'onesided' �ƒu�������܂��B����́A�f�t�H���g��
%   �����Ɠ����ɂȂ�܂��B������ 'twosided' �܂��� 'onesided' �́A���͈����� 
%   NOVERLAP �̌�̔C�ӂ̈ʒu�ɐݒ肷�邱�Ƃ��ł��܂��B
%
%   �o�͈�����ݒ肵�Ȃ� PWELCH(...) �́A�f�t�H���g�ŁA���݂� Figure 
%   �E�B���h�E�Ɏ��g������ dB �P�ʂ� PSD �̐�����v���b�g���܂��B
%
%   ��:
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t)); % 200Hz �̗]���g�Ƀm�C�Y�����Z
%      pwelch(x,[],[],[],Fs,'twosided');   % �E�B���h�E�A�I�[�o���b�v�ʁA
%      NFFT �̒l�̓f�t�H���g���g�p
%
%   �Q�l PERIODOGRAM, PCOV, PMCOV, PBURG, PYULEAR, PEIG, PMTM, PMUSIC, 
%        SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
