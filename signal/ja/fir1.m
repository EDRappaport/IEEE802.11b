%FIR1  �E�B���h�E�x�[�X�̗L���C���p���X�����t�B���^�̐݌v
%
%   B = FIR1(N,Wn) �́AN ���̃��[�p�X�f�W�^�� FIR �t�B���^��݌v���A�t�B���^
%   �W���𒷂� (N+1) �̍s�x�N�g�� B �ɕԂ��܂��B�J�b�g�I�t���g�� Wn �́A
%   0 < Wn < 1.0 �łȂ���΂Ȃ�܂���B�����ŁA1.0 �̓T���v�����O���[�g��
%   �����ɑΉ����܂��B�W�� B �͎����ŁA���`�ʑ� FIR �t�B���^�ł��B�t�B���^�́A
%   Wn �ł̐��K�����ꂽ�Q�C���́A-6 dB �ł��B
%
%   B = FIR1(N,Wn,'high') �́AN ���̃n�C�p�X�t�B���^��݌v���܂��B
%   B = FIR1(N, Wn,'low') �́A���[�p�X�p�X�t�B���^��݌v���܂��B
%
%   Wn �� 2 �v�f�x�N�g�� Wn  = [W1 W2] �̏ꍇ�AFIR1 �́A�ʉߑш� W1 < W < W2 
%   ������ N ���̃o���h�p�X�t�B���^��Ԃ��܂��BB = FIR1(N,Wn,'bandpass') ��
%   �w�肷�邱�Ƃ��ł��܂��BWn = [W1 W2] �̏ꍇ�AB = FIR1(N,Wn,'stop') �́A
%   �o���h�X�g�b�v�t�B���^��݌v���܂��B
%
%   Wn �������̗v�f�̃x�N�g���̏ꍇ�A
%          Wn = [W1 W2 W3 W4 W5 ... WN],
%   FIR1 �́A���̑ш�������� N �̕����ш�t�B���^��Ԃ��܂��B
%    0 < W < W1, W1 < W < W2, ..., WN < W < 1
%   B = FIR1(N,Wn,'DC-1') �́A�����ш�t�B���^�̍ŏ��̑ш��ʉߑш�Ƃ��܂��B
%   B = FIR1(N,Wn,'DC-0') �́A�����ш�t�B���^�̍ŏ��̑ш���Ւf�ш�Ƃ��܂��B
%
%   B = FIR1(N,Wn,WIN) �́A�C���p���X�����ɑ΂���E�B���h�E�̂��߂ɁA���� 
%   N+1 �̃x�N�g�� WIN ���g�p���� N ���� FIR �t�B���^��݌v���܂��B�󂠂邢��
%   �ȗ����ꂽ�ꍇ�AFIR1 �́A���� N+1 �� Hamming �E�B���h�E���g�p���܂��B
%   ���p�\�ȃE�B���h�E�̊��S�ȃ��X�g�ɂ��ẮA�֐� WINDOW �̃w���v��
%   �Q�Ƃ��Ă��������BKAISER ����� CHEBWIN �́A�I�v�V�����̌�ɑ���������
%   �Ƃ��Ɏw�肳��܂��B���Ƃ��΁AB = FIR1(N,Wn,kaiser(N+1,4)) �́AKaiser 
%   �E�B���h�E (beta = 4) ���g�p���܂��BB = FIR1(N,Wn,'high',chebwin(N+1,R)) 
%   �́A���ΓI�ȃT�C�h���[�u�̌����� R �f�V�x�������`�F�r�V�F�t�E�B���h�E��
%   �g�p���܂��B
%
%   Fs/2 �� 0 �ȊO�̃Q�C�������t�B���^�A���Ƃ��΁A�n�C�p�X�A�o���h�X�g�b�v
%   �t�B���^�́AN �������łȂ���΂Ȃ�܂���B����ȊO�̏ꍇ�́AN �� 1 �������܂��B
%   ���̏ꍇ�A�E�B���h�E�̒����́AN+2 �Ǝw�肳��܂��B
%
%   �f�t�H���g�ŁAFIR1 �́A�E�B���h�E�K�p��̐U�����ŏ��̒ʉߑш�̒��S�� 
%   1 �ɂȂ�悤�ɃX�P�[�����O����܂��B������ 'noscale' ���w�肷��ƁA
%   ���̃X�P�[�����O���s���܂���B���Ƃ��΁AB = FIR1(N,Wn,'noscale'), 
%   B = FIR1(N,Wn,'high','noscale'), B = FIR1(N,Wn,wind,'noscale')
%   �����I�ɃX�P�[�����O��ݒ肷��ɂ́A���̂悤�ɂ��܂��B���Ƃ��΁A
%   FIR1(N,Wn,'scale') ��
%
%   �Q�l KAISERORD, FIRCLS1, FIR2, FIRLS, FIRCLS, CFIRPM,
%        FIRPM, FREQZ, FILTER, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.
