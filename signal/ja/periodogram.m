%PERIODOGRAM  �s���I�h�O�����@���g�����p���[�X�y�N�g�����x (PSD) �̌v�Z
%
%   Pxx = PERIODOGRAM(X) �́A�x�N�g�� X �Őݒ肳���M���� PSD ������x�N�g�� 
%   Pxx �ɕԂ��܂��B�f�t�H���g�ł́AX �Ɠ��������̔��`�E�B���h�E���K�p����܂��B
%   PSD ����́A���� 256 ���A�܂��́AX �̒������傫�� 2 �̃x�L��ŋ��߂���
%   �����̑傫������ FFT ���v�Z���܂��B
%
%   �f�t�H���g�E�B���h�E (���^) �́A13.3 dB �̃T�C�h���[�u�̌����������Ƃ�
%   ���ӂ��Ă��������B����́A(�s�[�N�̃X�y�N�g���ɑ΂���) ���̒l�̂��Ƃ�
%   �X�y�N�g���Ƀ}�X�N��������\��������܂��B�ʂ̃E�B���h�E��I������ƁA
%   ����\ (��. ���^�E�B���h�E���g�p) �ƃT�C�h���[�u�̌��� (��. Hann �E�B���h�E��
%   �g�p) �Ԃ̃g���[�h�I�t���s�����Ƃ��\�ɂȂ�܂��B�ڍׂ́AWinTool ���Q��
%   ���Ă��������B
%
%   Pxx �́A�P�ʎ��g���ɑ΂���p���[�̕��z���������̂ł��B�����M���ɑ΂��āA
%   PERIODOGRAM �́A�Б� PSD ���f�t�H���g�Ƃ��ĕԂ��܂��B���f���M���̏ꍇ�A���� 
%   PSD ��Ԃ��܂��B�Б� PSD �́A���͐M���̂��ׂẴp���[���܂�ł��邱�Ƃɒ���
%   ���Ă��������B
%
%   Pxx = PERIODOGRAM(X,WINDOW) �́AX �ɓK�p����E�B���h�E��ݒ肵�܂��B
%   WINDOW �́AX �Ɠ��������̃x�N�g���ł��BWINDOW �ɔ��^�ȊO�̃E�B���h�E���g�p
%   ����ꍇ�A���ʂ̐���́A�C���s���I�h�O�����ɂȂ�܂��BWINDOW �ɋ�s���
%   �ݒ肷��ƁA�f�t�H���g�̃E�B���h�E���g�p����܂��B
%
%   [Pxx,W] = PERIODOGRAM(X,WINDOW,NFFT) �́APSD ���v�Z���邽�߂Ɏg�p���� 
%   FFT �̓_���ł��B���� X �ɑ΂��āAPxx �́ANFFT �������̏ꍇ (NFFT/2+1) �ŁA
%   ��̏ꍇ (NFFT+1)/2 �ł��B���f�� X �ɑ΂��āAPxx �́A��������� NFFT ��
%   �Ȃ�܂��BNFFT ����Ŏw�肳�ꂽ�ꍇ�A�f�t�H���g�� NFFT ���g���܂��B
%
%   NFFT ���Z�O�����g�����傫���ꍇ�A�f�[�^�� 0 ���������邱�Ƃɒ��ӂ���
%   ���������BNFFT ���Z�O�����g�����������ꍇ�́A�Z�O�����g�� (DATAWRAP ��
%   �g����) "wrapped" ����A������ NFFT �Ɠ������Ȃ�܂��B����ɂ��AL ���M���A
%   �܂��̓Z�O�����g�̒����ł���ANFFT < L �̂Ƃ��A������ FFT �𐶐����܂��B
%
%   PSD ���v�Z���鐳�K�����ꂽ���g������Ȃ�x�N�g�� W ��Ԃ��܂��BW �̒P��
%   �́A���W�A��/�T���v���ł��B�����M���ɑ΂��āAW �́ANFFT �������̏ꍇ [0,pi] 
%   �̋�ԂɍL����ANFFT ����̏ꍇ [0,pi) �͈̔͂ɂȂ�܂��B���f���M����
%   �ꍇ�AW �́A��ɁA[0.2*pi) �̋�Ԃł��B
%
%   [Pxx,W] = PERIODOGRAM(X,WINDOW,W) �́AW �� (2 �ȏ�̗v�f������) ���K��
%   ���g���x�N�g���Ƃ��āAGoertzel �A���S���Y�����g�p���āA�����̎��g����
%   ������s���I�h�O�������v�Z���܂��B���̏ꍇ�A���� PSD ���Ԃ���܂��BW ��
%   �w�肵�����g���́A�M���̕���\�ɔ�Ⴕ�čł��߂� DFT �̃o�C�i���̒l��
%   �ۂ߂��܂��B
%
%   [Pxx,F] = PERIODOGRAM(X,WINDOW,NFFT,Fs) �́A�����I�Ȏ��g�� (Hz) �֐��Ƃ���
%   �v�Z���ꂽ PSD ��Ԃ��܂��BFs �́AHz �Ŏw�肳�ꂽ�T���v�����O���g���ł��B
%   Fs ����̏ꍇ�A�f�t�H���g�� 1Hz �ɂȂ�܂��B
%
%   F �́AHz �P�ʂ̎��g���x�N�g���ŁA�����Őݒ肳��Ă�����g���ŁAPSD ���v�Z
%   ���܂��B�����M���ɑ΂��āAF �́ANFFT �������̏ꍇ [0,Fs/2] �ŁA��̏ꍇ 
%   [0,Fs/2) �͈̔͂ɍL����܂��B���f���M���ɑ΂��āAF �́A��ɁA[0,Fs) ��
%   �͈͂ł��B
%
%   [Pxx,F] = PERIODOGRAM(X,WINDOW,F,Fs) �́AF �� (2 �ȏ�̗v�f������) 
%   Hz �P�ʂ̎��g���x�N�g���Ƃ��āAGoertzel �A���S���Y�����g�p���āA������
%   ���g���ɂ�����s���I�h�O�������v�Z���܂��B���̏ꍇ�A���� PSD ���Ԃ���܂��B
%   F �Ɏw�肵�����g���́A�M���̕���\�ɔ�Ⴕ�čł��߂� DFT �̃o�C�i���̒l��
%   �ۂ߂��܂��B
%
%   [...] = PERIODOGRAM(...,'twosided') �́A�����M�� X �̗��� PSD ��Ԃ��܂��B
%   ���̏ꍇ�APxx �́A���� NFFT �������AFs ���ݒ肳��Ă��Ȃ��ꍇ [0,2*Pi) 
%   �͈̔́AFs ���ݒ肳��Ă���ꍇ [0,Fs) �͈̔͂ł��B����A������ 'twosided' 
%   �́A�����M�� X �ɑ΂��镶���� 'onesided' �ƒu�������܂��B����́A
%   �f�t�H���g�̋����Ɠ����ɂȂ�܂��B������ 'twosided' �܂��� 'onesided' �́A
%   WINDOW �����̌�̔C�ӂ̈ʒu�Őݒ�ł��܂��B
%
%   �o�͈�����ݒ肵�Ȃ� PERIODOGRAM(...) �́A�f�t�H���g�Ƃ��āA���݂� 
%   Figure �E�B���h�E�ɒP�ʎ��g���ɑ΂��� PSD �� dB �P�ʂŃv���b�g�\�����܂��B
%
%   ��:
%      Fs = 1000;   t = 0:1/Fs:.3;
%      x = cos(2*pi*t*200)+randn(size(t)); % 200Hz �̗]���g�Ƀm�C�Y�����Z
%      periodogram(x,[],'twosided',512,Fs);% �f�t�H���g�E�B���h�E���g�p
%
%   �Q�l PWELCH, PBURG, PCOV, PYULEAR, PMTM, PMUSIC, PMCOV, PEIG, SPECTRUM, 
%        DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
