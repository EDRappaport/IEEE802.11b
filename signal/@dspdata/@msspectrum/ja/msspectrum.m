%MSSPECTRUM  ���ϓ��X�y�N�g��
%
%   H = DSPDATA.MSSPECTRUM(DATA) �́A�f�[�^�v���p�e�B�̐ݒ�� DATA ��
%   �w�肳�ꂽ���ϓ��X�y�N�g���̃I�u�W�F�N�g H �̃C���X�^���X���쐬���܂��B
%   DATA �̓p���[��\�����߁A�����Ő��̒l���܂�ł��Ȃ���΂Ȃ�܂���B
%   DATA �́A�x�N�g���܂��͍s��ɂȂ�܂��B�����ŁA�e��́A�Ɨ����s��\���܂��B
%   �Ή�������g���x�N�g���́A[0, pi] �͈͓̔��Ŏ����I�ɐ�������܂��B
%   Fs �́A�f�t�H���g�� "Normalized" �ł��B
%
%   ���ϓ��X�y�N�g���͗��U�X�y�N�g����ΏۂƂ��Ă��܂��B�p���[�X�y�N�g��
%   ���x (PSD) �Ƃ͈قȂ�A���ϓ��X�y�N�g���̃s�[�N�͔C�ӎ��g���ɂ�����
%   �M�����̃p���[�𔽉f���܂��B
%
%   H = DSPDATA.MSSPECTRUM(DATA,FREQUENCIES) �́AH �ɕԂ����f�[�^�I�u�W�F�N�g
%   �Ɏ��g���x�N�g�� FREQUENCIES ��ݒ肵�܂��B�x�N�g�� FREQUENCIES �̒����́A
%   DATA �̗�̒����Ɠ������Ȃ���΂Ȃ�܂���B
%
%   H = DSPDATA.MSSPECTRUM(...,'Fs',Fs) �́A�T���v�����O���g���� Fs �ɐݒ�
%   ���܂��BFREQUENCIES ���w�肳��Ȃ��ꍇ�A���g���x�N�g���́A�f�t�H���g�� 
%   [0,Fs/2] �ł��B�ڍׂ́A�ȉ��̒��ӂ��Q�Ƃ��Ă��������B
%
%   H = DSPDATA.MSSPECTRUM(...,'SpectrumType',SPECTRUMTYPE) �́ASpectrumType 
%   �v���p�e�B�� SPECTRUMTYPE �Ŏw�肳��镶���� 'onesided' �܂��� 'twosided' ��
%   �����ꂩ�ɐݒ肵�܂��B
%
%   H = DSPDATA.MSSPECTRUM(...,'CenterDC',true) �́A�f�[�^�� DC �l���x�N�g��
%   �̒����ɂ��邱�Ƃ������܂��BCenterDC �� true �ɐݒ肷��ƁA�����I�� 
%   'SpectrumType' �� 'twosided' �ɐݒ肳��܂��B
%
%   ���g���x�N�g�����w�肳��Ȃ��ꍇ�A�f�t�H���g�̎��g���x�N�g���́A
%   'CenterDC' �̐ݒ�ɏ]���Đ�������܂��B���g���x�N�g�����w�肳�ꂽ�ꍇ�A
%   'CenterDC' �́A�w�肵�����g���x�N�g�� (�ƃf�[�^) �ƈ�v����悤�ɐݒ�
%   ����K�v������܂��B���̃v���p�e�B���C������ɂ́A<a href="matlab:help dspdata/centerdc">centerdc</a> ���\�b�h��
%   �g�p���Ă��������B
%
%   ���ӁF �w�肵���X�y�N�g���f�[�^�� "������" �i�C�L�X�g��ԂŌv�Z����A
%   �Ή�������g���x�N�g�����w�肵�Ă��Ȃ��ꍇ�A�f�t�H���g�̎��g���x�N�g���́A
%   "�S�̂�" FFT ���̓_���������ł�����̂Ɖ��肵�܂��B����ɁA"�S�̂�" 
%   �X�y�N�g���ɕϊ����邽�߂̃v���b�g�I�v�V�����́A�I���W�i���� "�S�̂�" 
%   FFT ���������ł�����̂Ɖ��肵�܂��B
%
%   ��: 2 �̎��g�����������m�C�Y���܂ސ����g�M���̕��ϓ��X�y�N�g����
%            �v�Z���邽�߂� FFT ���g�p���܂��BMSSPECTRUM �f�[�^�I�u�W�F�N�g��
%            ���ʂ��i�[���A�v���b�g���܂��B
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3) + cos(2*pi*t*10e3) + randn(size(t));
%        X = fft(x);
%        P = (abs(X)/length(x)).^2;    % ���ϓ����v�Z
%
%        hms = dspdata.msspectrum(P,'Fs',Fs,'SpectrumType','twosided');
%        plot(hms);                         % ���ϓ��X�y�N�g�����v���b�g
%
%   �Q�l DSPDATA, SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
