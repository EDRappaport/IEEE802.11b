%PLOT  DSP �f�[�^ (DSPDATA) �I�u�W�F�N�g�̃v���b�g
%
%   PLOT(H) �́A<a href="matlab:help dspdata">dspdata</a> �I�u�W�F�N�g H ��
%   �f�[�^���v���b�g���܂��B
%
%   ��: 2 �̎��g�����������m�C�Y���܂ސ����g�̃p���[�X�y�N�g�����x��
%       ���肷�邽�߂� periodogram ���g�p���܂��B�I�u�W�F�N�g�Ɍ��ʂ��i�[���A
%       �v���b�g���܂��B
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3)+ cos(2*pi*t*10e3)+ randn(size(t));
%        Pxx = periodogram(x);
%        hpsd = dspdata.psd(Pxx,'Fs',Fs); % PSD �f�[�^�I�u�W�F�N�g�̍쐬
%        plot(hpsd);                     % PSD �̃v���b�g
%
%   �Q�l DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
