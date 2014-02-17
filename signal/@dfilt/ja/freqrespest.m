%FREQRESPEST  �t�B���^�����O�ɂ����g�������̐���
%
%   [H,W] = FREQRESPEST(Hd,L) �́A�t�B���^��ʂ��Ĉ�l���z���郉���_����
%   ���g�����������g������ꂽ���̓f�[�^�����s���A�o�̓f�[�^�Ɠ��̓f�[�^��
%   �̔���`�����邱�ƂŁA�t�B���^ Hd �̎��g�������̐�����v�Z���܂��B
%   ����́A���ɌŒ菬���_�t�B���^�Ŗ𗧂��܂��B���g�������̐���́A�ʎq��
%   ���ꂽ�W���݂̂��g�����Ƃœ�������g�������ɋ߂��Ȃ�܂����A�Œ菬���_
%   �t�B���^�̉��Z��/��Z��𖳎�����ƁA�t�B���^�̌Œ菬���_�̎����́A���� 
%   (�ʎq�����ꂽ) �W���������������_�̎����Ƃ���v���܂��B
%
%   L �͐�����v�Z���邽�߂Ɏg���鎎�s�񐔂ł��B�w�肳��Ȃ��ꍇ�AL ��
%   �f�t�H���g�� 10 �ł��B��ʓI�ɁA��葽�����s���g���ƁA������v�Z����
%   ���߂ɕK�v�ƂȂ钷�����Ԃ��]���ɂ��āA��萸�x�̍������肪�����܂��B
%
%   H �͕��f���̎��g�������̐���ł��BW �͐��肳�ꂽ H �ɂ�������g��
%   �x�N�g���ł��B
%
%   [H,W] = FREQRESPEST(Hd,L,P1,V1,P2,V2,...) �́A�p�����[�^-�l�̑g�ݍ��킹��
%   �I�v�V�����p�����[�^���w�肵�܂��B�L���ȑg�ݍ��킹�͂��̒ʂ�ł�:
%         �p�����[�^               �f�t�H���g     ����/�L���Ȓl
%    ---------------------  -----------  ----------------------------------
%    'NFFT'                 512          FFT �_��
%    'NormalizedFrequency'  true         {true,false}
%    'Fs'                   'Normalized' �T���v�����O���g�� 'NormalizedFrequency' 
%                                        �� false �̂Ƃ��̂ݎg�p
%    'SpectrumRange'        'Half'       {'Half','Whole'}
%    'CenterDC'             false        {true,false}
%
%   FREQRESPEST(Hd,L,OPTS) �́A�w�肷��p�����[�^-�l�̑g�ݍ��킹�� lieu ����
%   �I�v�V�����̃p�����[�^���w�肷�邽�߂ɁA�I�v�V�����̃I�u�W�F�N�g���g�p���܂��B
%   OPTS �I�u�W�F�N�g�́AOPTS = FREQRESPOPTS(Hd) �ō쐬�ł��܂��B�ݒ�́A
%   FREQRESPEST ���Ăяo���O�� OPTS �ŕύX�ł��܂��B���Ƃ��΁Aset(OPTS,'Fs',48e3);
%
%   FREQRESPEST �̕ʂ̎g�p�́AFREQZ �ɂ��v�Z�ɉe�����y�ڂ��d�v�Ȋۂߌ덷�̂Ȃ�
%   �`�B�֐��`���ɕϊ��ł��Ȃ��{���x���������_�t�B���^�̎��g���������v�Z���邱��
%   �ł��B��́A���ɒ����t�B���^�ł��邢�����̏�ԋ�ԁA�܂��̓��e�B�X�t�B���^
%   �ł��B
%
%   % �� 1.�����̃t�B���^�����S���x (full precision) �ɐݒ肳��Ă���Œ菬���_ 
%   % FIR �t�B���^�̎��g�������̐�����v�Z���܂��B 
%   Hd = design(fdesign.lowpass(.4,.5,1,60),'equiripple');
%   Hd.Arithmetic = 'fixed';
%   [H,w] = freqrespest(Hd); % ����� FREQZ �Ɠ����ł���K�v������܂�
%
%   % �� 2.�� 1 �Ɠ����Œ菬���_ FIR �t�B���^�ɑ΂�����g���������v�Z���܂����A
%   % ���Z��/��Z��̐��x���w�肵�܂��B
%   Hd.FilterInternals = 'SpecifyPrecision';
%   Hd.OutputWordLength=16; Hd.OutputFracLength=15;
%   Hd.ProductWordLength=16; Hd.ProductFracLength=15;
%   Hd.AccumWordLength=16; Hd.AccumFracLength=15;
%   [H,w] = freqrespest(Hd,2);
%   [H2,w2] = freqz(Hd,512);
%   plot(w/pi,20*log10(abs([H,H2])))
%   legend('Frequency response estimate by filtering',...
%       'Frequency response computed by quantizing coefficients only');
%   xlabel('Normalized Frequency (\times\pi rad/sample)')
%   ylabel('Magnitude (dB)')
%
%   % �� 3.��ԋ�ԃt�B���^�̎��g�������𐄒肵�܂��B
%   Fs = 315000;
%   Wp = [320 3800]/(Fs/2);
%   Ws = [50 19000]/(Fs/2);
%   Rp=0.15; Rs=60;
%   [n,Wn]=cheb1ord(Wp,Ws,Rp,Rs);
%   [a,b,c,d] = cheby1(n,Rp,Wn);
%   Hd = dfilt.statespace(a,b,c,d);
%   freqrespest(Hd,1,'NFFT',8192); % freqz(Hd,8192); �Ɣ�r
%
%   �Q�l dfilt/freqrespopts, dfilt/noisepsd,  dfilt/scale, dfilt/functions.


%   Copyright 2006-2007 The MathWorks, Inc.
