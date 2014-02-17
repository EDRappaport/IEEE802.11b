%AVGPOWER  ���σp���[
%
%   AVGPOWER(H) �́AH �ɗ^����ꂽ���̂悤�ȐM���̃p���[�X�y�N�g�����x (PSD) ��
%   �ϕ��̒����`�ߎ��ɂ��A�M���̕��σp���[���v�Z���܂��BH �� PSD �f�[�^���s��
%   �̏ꍇ�A�����́A�e��ōs���܂��BH �� DSP �f�[�^ (<a href="matlab:help dspdata">dspdata</a>) �I�u�W�F�N�g�ł��B
%
%   H �� SpectrumType �v���p�e�B�̒l�Ɉˑ����AAVGPOWER �́A�Б��A�܂��͗���
%   �X�y�N�g���̂����ꂩ�͈̔͂ŕ��σp���[�̑��a���v�Z���܂��B�Б��X�y�N�g����
%   �΂��āA���̉��Z�́A�����̎��g���_�ɑ΂��� [0,pi] �͈̔́A��̎��g���_��
%   �΂��� [0,pi) �͈̔͂ōs���܂��B�����X�y�N�g���ɑ΂��āA�v�Z�� [0,2pi) ��
%   �͈͂ōs���܂��B
%
%   AVGPOWER(H,FREQRANGE) �́A���σp���[���v�����邽�߂̎��g���͈͂��w�肵�܂��B
%   FREQRANGE �́A�p���[���v������͈͂� 2 �_�̎��g�����w�肷������l�� 2 �v�f
%   �x�N�g���ł��B
%
%   ����:���g���͈͂̒l�����m�ɃI�u�W�F�N�g H �Ɋi�[���ꂽ�l�ƈ�v���Ȃ��ꍇ�A
%   ���ɋ߂��l���g���܂��B����ɁA2 �v�f�̎��g���͈̓x�N�g���� 2 �Ԗڂ̒l��
%   �r������܂����A1 �Ԗڂ̗v�f�́A���σp���[�̌v�Z�Ɋ܂܂�܂��B
%
%   ��
%      0.2 Hz �̎��g���������������g�̕��σp���[���v�Z���܂��B(1 ������) 
%      ���σp���[�� A^2/2 = 8 �ŗ^���瓾�܂��B�����ŁAA �͐����g�̐U���ł��B
%
%      f = .2; Fs = 1;
%      n = 0:999;
%      x = 4*sin(2*pi*f/Fs*n);
%
%      h = spectrum.periodogram('rectangular');     % �s���I�h�O�����̃X�y�N�g�������
%      hopts = psdopts(h);                          % �f�t�H���g�̃I�v�V����
%      set(hopts,'NFFT',2^12,'Fs',Fs,'SpectrumType','twosided');
%      hpsd = psd(h,x,hopts);                       % PSD �f�[�^�̃v���b�g
%      pwr = avgpower(hpsd)
%
%      % 0.1 �� 0.3 �͈̔͂̑����̃p���[�ɒ��ڂ��ĕБ� PSD ���v�Z���ăv���b�g���܂��B
%      % ���̂��߁A���͈̔͂̃p���[���v�Z���邱�Ƃ́A���ׂĂł͂���܂��񂪁A������
%      % �M���̃p���[��Ԃ��K�v������܂��B����́A�X�y�N�g�����[�P�[�W�̂��߂ł��B
%
%      hopts.SpectrumType='onesided';
%      hpsd = psd(h,x,hopts);
%      plot(hpsd);
%      pwr = avgpower(hpsd,[.1 .3])
%
%   �Q�l DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
