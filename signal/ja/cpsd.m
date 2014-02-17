%CPSD  Welch �@�ɂ��N���X�p���[�X�y�N�g�����x (CPSD) ����
%
%   Pxy = CPSD(X,Y) �́AWelch �̕��ω��A�C���s���I�h�O�����@���g���āA
%   ���U���ԐM���x�N�g�� X �� Y �̃N���X�p���[�X�y�N�g�����x���� Pxy ��
%   �Ԃ��܂��B�f�t�H���g�ŁAX �� Y �� 50% �̃I�[�o���b�v������ 8 ��
%   �O���[�v�ɕ������A�e�O���[�v�� Hamming �E�C���h�E��K�p���A8 ��
%   �O���[�v�̏C���s���I�h�O�������v�Z���A���ω����܂��B
%
%   X �� Y �̒������A50% �̃I�[�o���b�v������ 8 �̃O���[�v�ɐ��m��
%   �����ł��Ȃ��ꍇ�AX �� Y �́A�K�؂ɕ�������܂��B
%
%   Pxy �́A�P�ʎ��g���ɑ΂���p���[�̕��z���������̂ł��B�f�t�H���g�ł́A
%   CPSD �́A���M���ɑ΂��ĕБ��N���X PSD ���A���f���ɑ΂��ė����N���X 
%   PSD ���v�Z���܂��B�Б��N���X PSD �́A���͐M���̂��ׂẴp���[��
%   �܂�ł��邱�Ƃɒ��ӂ��Ă��������B
%
%   Pxy = CPSD(X,Y,WINDOW) �́AX �� WINDOW �̒����ɓ����������ŃI�[�o
%   ���b�v���镔���ɕ������AWINDOW �ɐݒ肵���x�N�g���Ŋe�������E�B���h�E
%   �������܂��B�����ŁAWINDOW �́A�x�N�g���Őݒ肵�Ă��܂��BWINDOW �� 
%   1 �̐����̏ꍇ�AX �� Y �͂��̐����l�ɓ����������̕����ɕ�������A
%   ���������� Hamming �E�B���h�E���g�p����܂��BX �� Y �̒������A50% ��
%   �I�[�o���b�v���s���Ȃ��琳�m�ɐ����{�ɂȂ��Ă��Ȃ��ꍇ�A�K�؂ɕ���
%   ���܂��BWINDOW ���ȗ�����邩�A�܂��͋�̏ꍇ�A�f�t�H���g�E�C���h�E���A
%   X �� Y �� 8 �ɕ������������Ɏg���܂��B
%
%   Pxy = CPSD(X,Y,WINDOW,NOVERLAP) �́ANOVERLAP �T���v���������I�[�o
%   ���b�v�����������܂ނ悤�ɕ������܂��BNOVERLAP �́AWINDOW �� ������
%   �ꍇ�AWINDOW ���������������Z�����̂ɂȂ�܂��BNOVERLAP �́AWINDOW 
%   ���x�N�g���̏ꍇ�AWINDOW �̒������������������Z�����̂ɂȂ�܂��B
%   NOVERLAP ���ȗ����ꂽ��A��Őݒ肳���ꍇ�A�f�t�H���g�l�́A50% ��
%   �I�[�o���b�v���g���܂��B
%
%   [Pxy,W] = CPSD(X,Y,WINDOW,NOVERLAP,NFFT) �́A�N���X PSD ������v�Z
%   ���邽�߂� FFT �̒�����ݒ肵�܂��B�����ɑ΂��āANFFT �������̏ꍇ�A
%   Pxy �� (NFFT/2+1) �ŁA��̏ꍇ (NFFT+1)/2 �ł��B���f���ł́APxy �́A
%   ��������� NFFT �ɂȂ�܂��BNFFT ����Ŏw�肳�ꂽ�ꍇ�A�f�t�H���g�� 
%   NFFT �́A256 �� X (����� Y) ���e�X�ɕ��������������傫�� 2 ��
%   �x�L�搔�̒��ōŏ��̂��̂Ƃ̂ǂ��炩�ő傫�����̂��g���܂��B
%
%   NFFT ���Z�O�����g�����傫���ꍇ�́A�f�[�^�ɂ� 0 ���������܂��B
%   NFFT ���Z�O�����g�����������ꍇ�́A�Z�O�����g�� (DATAWRAP ���g����) 
%   "wrapped" ����A������ NFFT �Ɠ������Ȃ�܂��B����ɂ��AL ���M���A
%   �܂��̓Z�O�����g�̒����ł���ANFFT < L �̂Ƃ��A������ FFT �𐶐����܂��B
%
%   PSD ���v�Z���鐳�K�����ꂽ���g������Ȃ�x�N�g�� W ��Ԃ��܂��BW ��
%   �P�ʂ́A���W�A��/�T���v���ł��B�����M���ɑ΂��āAW �́ANFFT ��������
%   �ꍇ [0,pi] �̋�ԂɍL����ANFFT ����̏ꍇ [0,pi) �͈̔͂ɂȂ�܂��B
%   ���f���M���̏ꍇ�AW �́A��ɁA[0.2*pi) �̋�Ԃł��B
%
%   [Pxy,F] = CPSD(X,Y,WINDOW,NOVERLAP,NFFT,Fs) �́A�����I�ȈӖ�������
%   ���g�� (Hz) �̊֐��Ƃ��ăN���X PSD ���v�Z���܂��BFs �́AHz �Ŏw��
%   ���ꂽ�T���v�����O���g���ł��BFs ����̏ꍇ�A�f�t�H���g�� 1Hz �ɂȂ�܂��B
%
%   F �́AHz �P�ʂ̎��g���x�N�g���ŁA�����Őݒ肳��Ă�����g���ŁA�N���X 
%   PSD ���v�Z���܂��B�����M���ɑ΂��āAF �́ANFFT �������̏ꍇ [0,Fs/2] �ŁA
%   ��̏ꍇ [0,Fs/2) �͈̔͂ɍL����܂��B���f���M���ɑ΂��āAF �́A��ɁA
%   [0,Fs) �͈̔͂ł��B
%
%   [...] = CPSD(...,'twosided') �́A�����M�� X �� Y �̗��� PSD ��Ԃ��܂��B
%   ���̏ꍇ�APxy �́A���� NFFT �������AFs ���ݒ肳��Ă��Ȃ��ꍇ�A[0,2*Pi) 
%   �͈̔́AFs ���ݒ肳��Ă���ꍇ�A[0,Fs) �͈̔͂ł��B����A������ 
%   'twosided' �́A�����M���ɑ΂��镶���� 'onesided' �ƒu�������܂��B
%   ����́A�f�t�H���g�̋����Ɠ����ɂȂ�܂��B������ 'twosided' �܂��� 
%   'onesided' �́A���͈����� NOVERLAP �̌�̔C�ӂ̈ʒu�ɐݒ肷�邱�Ƃ��ł��܂��B
%
%   �o�͈�����ݒ肵�Ȃ� CPSD(...) �́A�f�t�H���g�Ō��݂� Figure �E�C���h�E
%   �ɒP�ʎ��g���ɑ΂���N���X PSD �� dB �P�ʂŃv���b�g�\�����܂��B
%
%   ��:
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t)); % 200Hz �̃R�T�C���g�Ƀm�C�Y�����Z
%      y = cos(2*pi*t*100)+randn(size(t));  % �m�C�Y��t������ 100Hz �̗]���g
%      cpsd(x,y,[],[],[],Fs,'twosided');    % �f�t�H���g�̑��֐��A�I�[�o�[���b�v�ANFFT ���g�p
%
%   �Q�l PWELCH, PERIODOGRAM, PCOV, PMCOV, PBURG, PYULEAR, PEIG, PMTM, 
%        PMUSIC, SPECTRUM, DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
