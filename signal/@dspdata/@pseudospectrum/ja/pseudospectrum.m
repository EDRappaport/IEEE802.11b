%PSEUDOSPECTRUM  �[���X�y�N�g��
%
%   H = DSPDATA.PSEUDOSPECTRUM(DATA) �́ADATA �ɐݒ肳�ꂽ�v���p�e�B��
%   �ݒ�ŁA�I�u�W�F�N�g H �̃C���X�^���X���쐬���܂��BDATA �̓p���[��
%   �\�����߁A�����Ő��̒l���܂�ł��Ȃ���΂Ȃ�܂���BDATA �́A�x�N�g��
%   �܂��͍s��ɂȂ�܂��B�����ŁA�e��́A�Ɨ����s��\���܂��B�Ή�����
%   ���g���x�N�g���́A[0, pi] �͈͓̔��Ŏ����I�ɐ�������܂��BFs �́A
%   �f�t�H���g�� "Normalized" �ł��B
%
%   H = DSPDATA.PSEUDOSPECTRUM(DATA,FREQUENCIES) �́A�I�u�W�F�N�g���̎��g��
%   �x�N�g���� FREQUENCIES �ɐݒ肵�܂��B�x�N�g�� FREQUENCIES �̒����́A
%   DATA �̗�̒����Ɠ������Ȃ���΂Ȃ�܂���B
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'Fs',Fs) �́A�T���v�����O���g���� Fs ��
%   �ݒ肵�܂��BFREQUENCIES ���w�肳��Ȃ��ꍇ�A���g���x�N�g���́A�f�t�H���g�� 
%   [0,Fs/2] �ł��B�ڍׂ́A�ȉ��̒��ӂ��Q�Ƃ��Ă��������B
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'SpectrumRange',SPECTRUMRANGE) �́A
%   SpectrumRange �v���p�e�B�� SPECTRUMRANGE �Ŏw�肳��镶���� 'half' 
%   �܂��� 'whole' �̂����ꂩ�ɐݒ肵�܂��B
%
%   H = DSPDATA.PSEUDOSPECTRUM(...,'CenterDC',true) �́A�f�[�^�� DC �l��
%   �x�N�g���̒����ɂ��邱�Ƃ������܂��BCenterDC �� true �ɐݒ肷��ƁA
%   �����I�� 'SpectrumRange' �� 'whole' �ɐݒ肳��܂��B
%
%   ���g���x�N�g�����w�肳��Ȃ��ꍇ�A�f�t�H���g�̎��g���x�N�g���́A
%   'CenterDC' �̐ݒ�ɏ]���Đ�������܂��B���g���x�N�g�����w�肳�ꂽ�ꍇ�A
%   'CenterDC' �́A�w�肵�����g���x�N�g�� (�ƃf�[�^) �ƈ�v����悤��
%   �ݒ肷��K�v������܂��B���̃v���p�e�B���C������ɂ́A<a href="matlab:help dspdata/centerdc">centerdc</a> ���\�b�h��
%   �g�p���Ă��������B
%
%   ���ӁF �w�肵���X�y�N�g���f�[�^�� "������" �i�C�L�X�g��ԂŌv�Z����A
%   �Ή�������g���x�N�g�����w�肵�Ă��Ȃ��ꍇ�A�f�t�H���g�̎��g���x�N�g���́A
%   "�S�̂�" FFT ���̓_���������ł�����̂Ɖ��肵�܂��B����ɁA"�S�̂�" 
%   �X�y�N�g���ɕϊ����邽�߂̃v���b�g�I�v�V�����́A�I���W�i���� "�S�̂�" 
%   FFT ���������ł�����̂Ɖ��肵�܂��B
%
%   ��: �ŗL�l��͂��g���āA��̎��g���v�f�Ńm�C�Y�����M���̋[���X�y�N�g����
%            ���肵�܂��B�����ŁAPSEUDOSPECTRUM �f�[�^�I�u�W�F�N�g�̌��ʂ�ۑ����A
%            �v���b�g���܂��B
%
%        Fs = 32e3;   t  = 0:1/Fs:2.96;
%        x = cos(2*pi*t*1.24e3) + cos(2*pi*t*10e3) + randn(size(t));
%        P = pmusic(x,4);
%        hps = dspdata.pseudospectrum(P,'Fs',Fs); % �f�[�^�I�u�W�F�N�g�̍쐬
%        plot(hps);                          % pseudospectrum�̃v���b�g
%
%   �Q�l DSPDATA, SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
