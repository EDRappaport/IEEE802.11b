% PSEUDOSPECTRUM   �X�y�N�g����͂ɑ΂���I�u�W�F�N�g�̃I�v�V����
%
% OPTS = DSPOPTS.PSEUDOSPECTRUM �́A���\�b�h�ɑ΂��Ēǉ��̓��͈������w��
% ���邽�߂̂���[���X�y�N�g�����\�b�h�ɑ΂�����͈����Ƃ��Ďg�p���邱�Ƃ�
% �ł���I�u�W�F�N�g�ł��B
%
% OPTS �́A���̒ǉ��̈������܂܂�܂�:
%
%   �p�����[�^             �f�t�H���g   �ڍ�/�L���Ȓl
%   ----------             ---------    -------------
%   'NFFT'                 8192         FFT�_��
%   'NormalizedFrequency'  true         {true,false}
%   'Fs'                   'Normalized' �T���v�����O���g���B'NormalizedFrequency' ��
%                                       false �̂Ƃ��̂ݎg�p�ł��܂��B
%   'SpectrumRange'       'Half'       {'Half','Whole'}
%
% �ʏ�́AOPTS �𒼐ڍ쐬���Ȃ����Ƃɒ��ӂ��Ă��������B���ɁAOPTS �́A
% ���̃��\�b�h���瓾�邱�Ƃ��ł��܂��B�������̂΂����ɁAOPTS ���쐬����
% ���߂Ƀ��\�b�h���g���ꍇ�A�f�t�H���g�l�́A��q�̂����̃��X�g�Ƃ�
% �قȂ�܂��B
%
% ���: SPECTRUM.MUSIC �I�u�W�F�N�g�ɑ΂��� DSPOPTS.PSEUDOSPECTRUM �I�u�W�F�N�g��
%       �쐬���܂��B
%   s = spectrum.music; s.FFTLength = 'UserDefined';
%   n = 0:199; 
%   Fs = 48e3;
%   x = sin(2*pi*n*10e3/Fs)+2*sin(2*pi*n*20e3/Fs)+randn(1,200);
%   opts = pseudospectrumopts(s,x);
%   opts.NFFT = 1024;
%   opts.Fs = Fs;  % opts.NormalizedFrequency��false�ɐݒ�
%   d = pseudospectrum(s,x,opts);
%
%   �Q�l SPECTRUM/SPECTRUMOPTS, SPECTRUM/PSD, SPECTRUM/MSSPECTRUM.


%   Author(s): R. Losada
%   Copyright 1988-2004 The MathWorks, Inc.
