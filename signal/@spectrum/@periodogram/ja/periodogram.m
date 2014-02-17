%PERIODOGRAM  �s���I�h�O�����X�y�N�g�������
%
%   H = SPECTRUM.PERIODOGRAM �́AH �Ƀs���I�h�O�����X�y�N�g��������Ԃ��܂��B
%
%   H = SPECTRUM.PERIODOGRAM(WINNAME) �́A�E�B���h�E�Ƃ��� WINNAME �Ŏw��
%   ���ꂽ����������s���I�h�O�����X�y�N�g������� H ��Ԃ��܂��B�L���� 
%   <a href="matlab:set(spectrum.periodogram,'WindowName')">�E�B���h�E</a> �̃��X�g���擾����ɂ́Aset(H,'WindowName') ���g�p���Ă��������B
%
%   H = SPECTRUM.PERIODOGRAM({WINNAME,WINPARAMETER}) �́A�Z���z����� 
%   WINNAME �ɃE�B���h�E���AWINPARAMETER �ɃE�B���h�E�̃p�����[�^�l��
%   �w�肵�܂��B
%
%   ���ӁFWINNAME �Ŏw�肳�ꂽ�E�B���h�E�Ɉˑ����āA�E�B���h�E�p�����[�^��
%   �v���p�e�B�́A�s���I�h�O�����X�y�N�g������� H �ɓ��I�ɒǉ�����܂��B
%   �ڍׂ́A"help <WINNAME>" �Ɠ��͂��Ă��������B
%
%   �f�t�H���g�E�B���h�E (���^) �́A13.3 dB �̃T�C�h���[�u�̌����������Ƃ�
%   ���ӂ��Ă��������B����́A(�s�[�N�̃X�y�N�g���ɑ΂���) ���̒l�̂��Ƃ�
%   �X�y�N�g���Ƀ}�X�N��������\��������܂��B�ʂ̃E�B���h�E��I������ƁA
%   ����\ (��. ���^�E�B���h�E���g�p) �ƃT�C�h���[�u�̌��� (��. Hann �E�B���h�E��
%   �g�p) �Ԃ̃g���[�h�I�t���s�����Ƃ��\�ɂȂ�܂��B�ڍׂ́AWinTool ��
%   �Q�Ƃ��Ă��������B
%
%   �s���I�h�O������ PSD �����́A���̂悤�Ȋ֐������s���邽�߂Ƀf�[�^��
%   ���ɉ��L�̊֐��ɓn�����Ƃ��ł��܂��B
%       <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - ���ϓ��X�y�N�g�� (MSS) ���v�Z
%       <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS ���v�Z���邽�߂̃I�v�V�������o��
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD ���v�Z
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD ���v�Z���邽�߂̃I�v�V�������o��
%
%   ��: ���f�M���ɎG�����������M���̃X�y�N�g�����
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = exp(i*2*pi*200*t)+randn(size(t));
%      h = spectrum.periodogram;      % �s���I�h�O�����X�y�N�g�������̍쐬
%      psd(h,x,'Fs',Fs);                    % ���� PSD �̌v�Z�ƃv���b�g
%
%   �Q�l SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
