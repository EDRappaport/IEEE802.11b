%NORMALIZEFREQ  ���g���d�l�̐��K��
%
%   NORMALIZEFREQ(H) �́ADSP �f�[�^�I�u�W�F�N�g (<a href="matlab:help dspdata">dspdata</a>) 
%   H �̎��g���̎d�l�𐳋K�����܂��B����́A�f�[�^�I�u�W�F�N�g 
%   'NormalizedFrequency' �v���p�e�B�� true �ɐݒ肵�A0 �� 1 �͈̔͂ɂȂ�悤 
%   Fs �� Frequencies �𐳋K�����܂��B
%
%   NORMALIZEFREQ(H,BFL) �́A'NormalizedFrequency' �v���p�e�B�� true �܂��� 
%   false �̂����ꂩ�ɂȂ� boolean �t���O BFL �̒l�ɐݒ肵�܂��B�w�肳��Ȃ�
%   �ꍇ�ABFL �̓f�t�H���g�� true �ł��BBFL �� false �̏ꍇ�A�f�[�^�I�u�W�F�N�g 
%   H �̎��g���́A���`���g���ɕϊ�����܂��B
%
%   NORMALIZEFREQ(H,false,Fs) �́A'NormalizedFrequency' �v���p�e�B�� false ��
%   �ݒ肳���ꍇ�A�V�K�̃T���v�����O���g�� Fs �̐ݒ���󂯓���܂��B
%
%   ��: �m�C�Y���܂ސ����g�̃p���[�X�y�N�g�����x�𐄒肷�邽�߂� periodogram ��
%       �g�p���܂��BPSD �f�[�^�I�u�W�F�N�g�Ɍ��ʂ��i�[���A���K�����g���ɕϊ����āA
%       �v���b�g���܂��B
%
%         Fs = 32e3;   t = 0:1/Fs:2.96;
%         x = cos(2*pi*t*1.24e3)+ cos(2*pi*t*10e3)+ randn(size(t));
%         Pxx = periodogram(x);
%         hpsd = dspdata.psd(Pxx,'Fs',Fs) % PSD �f�[�^�I�u�W�F�N�g�̍쐬
%         normalizefreq(hpsd);            % ���g���̐��K��
%         plot(hpsd)
%
%   �Q�l DSPDATA, SPECTRUM.


%   Copyright 1988-2007 The MathWorks, Inc.
