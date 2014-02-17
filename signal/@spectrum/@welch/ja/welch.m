%WELCH  Welch �@�X�y�N�g�������
%
%   H = SPECTRUM.WELCH �́AH �� Welch �@�X�y�N�g��������Ԃ��܂��B
%
%   H = SPECTRUM.WELCH(WINNAME) �́A�E�B���h�E�Ƃ��� WINNAME �Ŏw�肳�ꂽ
%   ����������� Welch �@�X�y�N�g������� H ��Ԃ��܂��B
%   �L���� <a href="matlab:set(spectrum.welch,'WindowName')">�E�B���h�E</a> �̃��X�g���擾����ɂ́A
%   set(H,'WindowName') ���g�p���Ă��������B
%
%   H = SPECTRUM.WELCH({WINNAME,WINPARAMETER}) �́A�Z���z����� WINNAME ��
%   �E�B���h�E���AWINPARAMETER �ɃE�B���h�E�̃p�����[�^�l���w�肵�܂��B
%
%   ���ӁFWINNAME �Ŏw�肳�ꂽ�E�B���h�E�Ɉˑ����āA�E�B���h�E�p�����[�^��
%   �v���p�e�B�́AWelch �@�X�y�N�g������� H �ɓ��I�ɒǉ�����܂��B�ڍׂ́A
%   "help <WINNAME>" �Ɠ��͂��Ă��������B
%
%   ����ɁA�f�t�H���g�E�B���h�E (Hamming) �́A42.5 dB �̃T�C�h���[�u�̌�����
%   �����Ƃɂ����ӂ��Ă��������B����́A(�s�[�N�̃X�y�N�g���ɑ΂���) 
%   ���̒l�̂��ƂŃX�y�N�g���Ƀ}�X�N��������\��������܂��B�ʂ̃E�B���h�E��
%   �I������ƁA����\ (��. ���^�E�B���h�E���g�p) �ƃT�C�h���[�u�̌��� 
%   (��. Hann �E�B���h�E���g�p) �Ԃ̃g���[�h�I�t���s�����Ƃ��\�ɂȂ�܂��B
%   �ڍׂ́AWinTool ���Q�Ƃ��Ă��������B
%
%   H = SPECTRUM.WELCH(WINNAME,SEGMENTLENGTH) �́ASEGMENTLENGTH �Ƃ���
%   �e�Z�O�����g�̒������w�肵�܂��B�Z�O�����g�̒����́A����\�ƕ��U��
%   �g���[�h�I�t�ɂȂ�܂��B�����Z�O�����g���́A�ǂ�����\�ɂȂ����ŁA
%   �Z���Z�O�����g���́A�����̕��ς��s���܂��B���̂��߁A���U���������܂��B
%
%   H = SPECTRUM.WELCH(WINNAME,SEGMENTLENGTH,OVERLAPPERCENT) �́A
%   �e�Z�O�����g�Ԃ̃I�[�o�[���b�v�̊������w�肵�܂��B
%
%   Welch �@�� PSD �����́A���̂悤�Ȋ֐������s���邽�߂Ƀf�[�^�Ƌ���
%   ���L�̊֐��ɓn�����Ƃ��ł��܂��B
%       <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - ���ϓ��X�y�N�g�� (MSS) ���v�Z
%       <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS ���v�Z���邽�߂̃I�v�V�������o��
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD ���v�Z
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD ���v�Z���邽�߂̃I�v�V�������o��
%
%   ��: 200Hz �̗]���g�ƃm�C�Y���܂ސM���̃X�y�N�g�����
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;           % Welch �X�y�N�g�������̍쐬
%      psd(h,x,'Fs',Fs);              % PSD �̌v�Z�ƃv���b�g
%
%   �Q�l SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
