%GOERTZEL  2 �� Goertzel �A���S���Y��
%
%   GOERTZEL(X,INDVEC) �́A2 ���� Goertzel �A���S���Y�����g�p���āA�x�N�g�� 
%   INDVEC �Ɋ܂܂��C���f�b�N�X�ŁAX �̗��U�t�[���G�ϊ� (DFT) ���v�Z���܂��B
%   �C���f�b�N�X�́A1 ����N �܂ł̐����l�ł���K�v������܂��B�����ŁAN �́A
%   �ŏ��̔�V���O���g�������̒����ł��B��A�܂��͏ȗ������ꍇ�AI �́A1:N ��
%   ����Ɖ��肵�܂��B
%
%   GOERTZEL(X,[],DIM) �܂��� GOERTZEL(X,INDVEC,DIM) �́A���� DIM �ɏ]���� 
%   DFT ���v�Z���܂��B
%
%   ��ʂɁA�\�Ȃ����� DFT �C���f�b�N�X���v�Z����ꍇ�AGOERTZEL �́A
%   FFT ���x���Ȃ�܂��B�������AX �������x�N�g���ŁADFT �̏ꍇ�A�ł�
%   �L���ł��B�C���f�b�N�X 1:length(X) �́A���g����� [0, 2*pi) ���W�A����
%   �Ή����܂��B
%
%   ��:
%   % 10 kHz �̐����������̃m�C�Y���܂ޗ]���ɁA1.24 kHz �� 1.26 kHz ��
%   % �������֘A�t���܂��B
%      Fs = 32e3;   t = 0:1/Fs:2.96;
%      x  = cos(2*pi*t*10e3)+cos(2*pi*t*1.24e3)+cos(2*pi*t*1.26e3)...
%           + randn(size(t));
%
%      N = (length(x)+1)/2;
%      f = (Fs/2)/N*(0:N-1);              % ���g���x�N�g���𐶐�
%      indxs = find(f>1.2e3 & f<1.3e3);   % �Ώۂ̎��g�������߂�;
%      X = goertzel(x,indxs);
%
%      hms = dspdata.msspectrum((abs(X)/length(X)).^2,f(indxs),'Fs',Fs);
%      plot(hms);                         % ���ϓ��X�y�N�g�����v���b�g
%
%   �Q�l FFT, FFT2.


%   Copyright 1988-2007 The MathWorks, Inc.
