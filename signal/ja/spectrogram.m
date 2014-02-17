%SPECTROGRAM  �Z���ԃt�[���G�ϊ� (STFT) ���g�����X�y�N�g���O����
%
%   S = SPECTROGRAM(X) �́A�s�� S ���̃x�N�g�� X �Ŏw�肳�ꂽ�M���̃X�y�N�g��
%   �O������Ԃ��܂��B�f�t�H���g�ł́AX �� 50% �̃I�[�o���b�v�� 8 �̃Z�O�����g
%   �ɕ�������A�e�Z�O�����g�� Hamming �E�B���h�E�ŃE�B���h�E�������s�Ȃ��܂��B
%   ���U�t�[���G�ϊ��Ōv�Z�Ɏg������g���_���́A256�A�܂��� X �̊e�Z�O�����g��
%   �������傫������ 2 �ׂ̂���̑傫�����Ɠ������Ȃ�܂��B
%
%   X �� 8 �̃Z�O�����g�ɖ��m�ɕ����ł��Ȃ��ꍇ�AX �͌��ʂɉ����đł��؂��܂��B
%
%   S = SPECTROGRAM(X,WINDOW) �́AWINDOW ���x�N�g���̏ꍇ�AWINDOW �̒����ɓ�����
%   �����̃Z�O�����g�� X �𕪊����AWINDOW �Ɏw�肵���x�N�g���Ŋe�Z�O�����g��
%   �E�B���h�E�������s�Ȃ��܂��BWINDOW �������̏ꍇ�AX �͂��̐����l�ɓ�����������
%   �Z�O�����g�ɕ�������A�����̓����� Hamming �E�B���h�E���g���܂��BWINDOW ��
%   �w�肳��Ȃ��ꍇ�A�f�t�H���g�l���g���܂��B
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP) �� NOVERLAP �́AX �̊e�Z�O�����g��
%   �I�[�o���b�v����T���v�����ł��BWINDOW �������̏ꍇ�ANOVERLAP �� WINDOW 
%   ��菬���������łȂ���΂Ȃ�܂���BNOVERLAP �́AWINDOW ���x�N�g���̏ꍇ�A
%   WINDOW �̒������������������Z�����̂ɂȂ�܂��BNOVERLAP ���w�肳��Ȃ��ꍇ�A
%   �f�t�H���g�l�́A50% �̃I�[�o���b�v�𓾂邽�߂Ɏg���܂��B
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT) �́A���U�t�[���G�ϊ����v�Z����
%   ���߂Ɏg������g���_�����w�肵�܂��BNFFT ���w�肳��Ȃ��ꍇ�A�f�t�H���g�� 
%   NFFT ���g���܂��B
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT,Fs) �� Fs �́AHz �P�ʂŎw�肷��
%   �T���v�����O���g���ł��BFs ����Ŏw�肳�ꂽ�ꍇ�A�f�t�H���g�� 1 Hz ��
%   �Ȃ�܂��B�w�肳��Ȃ��ꍇ�A���K�����g�����g���܂��B
%
%   S �̊e��́A�M�� X �̒Z���Ŏ��ԂŋǏ��I�Ȏ��g�������̐�����܂݂܂��B
%   ���Ԃ́A������E�� S �̗���ő������܂��B���g���́A0 ����n�܂�s������
%   �������܂��BX ������ NX �̕��f�M���̏ꍇ�AS �� NFFT �_�� �s�� 
%   k = fix((NX-NOVERLAP)/(length(WINDOW)-NOVERLAP)) �_�̗�������f�s���
%   �Ȃ�܂��B���� X �ɑ΂��āAS �́ANFFT �������̏ꍇ�A(NFFT/2+1) �s���A
%   NFFT ����̏ꍇ (NFFT+1)/2 �s�������܂��B
%
%   [S,F,T] = SPECTROGRAM(...) �́A�v�Z�����X�y�N�g���O�����ɂ�������g��
%   �x�N�g�� F �Ǝ��ԃx�N�g�� T ��Ԃ��܂��BF �� S �̍s���Ɠ�����������
%   �Ȃ�܂��BT �͒��� k (��L�Œ�`) �ŁA�e�Z�O�����g�̒��S�ɑΉ�����
%   �l�������܂��B
%
%   [S,F,T] = SPECTROGRAM(X,WINDOW,NOVERLAP,F,Fs) �́AF �� (2 �ȏ�̗v�f������) 
%   Hz �P�ʂ̎��g���x�N�g���Ƃ��āAGoertzel �A���S���Y�����g�p���Ă�����
%   ���g���ɂ�����X�y�N�g���O�������v�Z���܂��BF �Ɏw�肵�����g���́A�M����
%   ����\�ɔ�Ⴕ�čł��߂� DFT �̃o�C�i���̒l�Ɋۂ߂��܂��B
%
%   [S,F,T,P] = SPECTROGRAM(...) �� P �́A�e�Z�O�����g�̃p���[�X�y�N�g�����x 
%   (PSD) �̍s��\���ł��B�����M���ɑ΂��āASPECTROGRAM �͊e�Z�O�����g�� 
%   PSD �̕Б��C���s���I�h�O�����̐����Ԃ��܂��B���f�M���ɑ΂��āA���g��
%   �x�N�g�����w�肳�ꂽ�ꍇ�́A���� PSD ��Ԃ��܂��B
%
%   SPECTROGRAM(...) �ŁA�o�͈����������Ȃ��ꍇ�A���݂� Figure �̃T�[�t�F�X���
%   �e�Z�O�����g�ɑ΂��� PSD ������v���b�g���܂��BP �� 4 �Ԗڂ̏o�͈����Ƃ��āA
%   SURF(f,t,10*log10(abs(P)) ���g�p���܂��B��ɑ������͂̕����� FREQLOCATION 
%   �́A���g������\�����鎲�𐧌䂵�܂��B���̕�����́A'xaxis' �� 'yaxis' ��
%   �����ꂩ�ɂȂ�܂��B���� FREQLOCATION �� 'yaxis' �ɐݒ肷��ƁAy �����
%   ���g�����Ax ���Ɏ��Ԃ�\�����܂��B�f�t�H���g�� 'xaxis' �ŁAx ����Ɏ��g����
%   �\�����܂��BFREQLOCATION �́A�o�͈�����K�v�Ƃ���Ƃ��Ɏw�肵���ꍇ�A
%   ��������܂��B
%
%   �� 1:2 �� chirp �̊e�Z�O�����g�� PSD ��\�����܂��B
%     t=0:0.001:2;                    % 1kHz �̃T���v�����[�g�� 2 �b��
%     y=chirp(t,100,1,200,'q');       % 100Hz ����J�n���At=1 �b�� 200Hz �ɓ��B
%     spectrogram(y,128,120,128,1E3); % �X�y�N�g���O�����̕\��
%     title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');
%
%   �� 2:���` chirp �̊e�Z�O�����g�� PSD ��\�����܂��B
%     t=0:0.001:2;                    % 1kHz �̃T���v�����[�g�� 2 �b��
%     x=chirp(t,0,1,150);             % DC ��������J�n���āAt=1�b�� 150Hz �ɓ��B
%     F = 0:.1:100;
%     [y,f,t,p] = spectrogram(x,256,250,F,1E3,'yaxis');
%   % ����:����͏o�͈����Ȃ��� SPECTROGRAM ���Ăяo�������Ɠ����ł��B
%     surf(t,f,10*log10(abs(p)),'EdgeColor','none');
%     axis xy; axis tight; colormap(jet); view(0,90);
%     xlabel('Time');
%     ylabel('Frequency (Hz)');
%
%   �Q�l PERIODOGRAM, PWELCH, SPECTRUM, GOERTZEL.


%   Copyright 1988-2007 The MathWorks, Inc.
