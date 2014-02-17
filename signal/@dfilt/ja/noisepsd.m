%NOISEPSD  �ۂߎG���ɂ��t�B���^�̏o�͂̃p���[�X�y�N�g�����x
%
%   Hpsd = NOISEPSD(Hd,L) �́A�t�B���^�̗ʎq���덷�ɂ�萶�������ۂ�
%   �G���ɂ��t�B���^ Hd �̏o�͂Ńp���[�X�y�N�g�����x (PSD) ���v�Z���܂��B
%   L �͎g���鎎�s�񐔂ł��BPSD �́AL �̎��s�S�̂̕��ς���v�Z����܂��B
%   ���s�񐔂������ق� (�����v�Z���]���ɂ���) �悢����ɂȂ�܂��BL ��
%   �ݒ肳��Ă��Ȃ��ꍇ�A�f�t�H���g�� 10 ��̎��s�ɂȂ�܂��B
%
%   Hpsd �� PSD �f�[�^�I�u�W�F�N�g�ł��BPSD �x�N�g���́AGET(Hpsd,'Data') �� 
%   Hpsd ���璊�o���邱�Ƃ��ł��܂��BPLOT(Hpsd) ���g���ăv���b�g���邱�Ƃ�
%   �ł��܂��B�o�̓m�C�Y�̕��σp���[ (PSD �̐ϕ�) �́AAVGPOWER(Hpsd) ��
%   �v�Z���邱�Ƃ��ł��܂��B
%
%   Hpsd = NOISEPSD(Hd,L,P1,V1,P2,V2,...) �́A�p�����[�^-�l�̑g�ݍ��킹��
%   �I�v�V�����p�����[�^���w�肵�܂��B�L���ȑg�ݍ��킹�͂��̒ʂ�ł�:
%        �p�����[�^               �f�t�H���g     ����/�L���Ȓl
%   ---------------------  -----------  ----------------------------------
%   'NFFT'                 512          FFT �_��
%   'NormalizedFrequency'  true         {true,false}
%   'Fs'                   'Normalized' �T���v�����O���g��'NormalizedFrequency' 
%                                       �� false �̂Ƃ��̂ݎg�p
%   'SpectrumType'         'Onesided'   {'Onesided','Twosided'}
%   'CenterDC'             false        {true,false}
%
%   NOISEPSD(Hd,L,OPTS) �́A�w�肷��p�����[�^-�l�̑g�ݍ��킹�� lieu ����
%   �I�v�V�����̃p�����[�^���w�肷�邽�߂ɁA�I�v�V�����̃I�u�W�F�N�g��
%   �g�p���܂��BOPTS �I�u�W�F�N�g�́AOPTS = NOISEPSDOPTS(Hd) �ō쐬�ł��܂��B
%   �ݒ�́ANOISEPSD ���Ăяo���O�� OPTS �ŕύX�ł��܂��B
%   ���Ƃ��΁Aset(OPTS,'Fs',48e3);
%
%   % ��:���ڌ^�Ŏ������ꂽ�Œ菬���_ FIR �t�B���^�̗ʎq���ɂ��ɏo�͂�
%   % �m�C�Y�� PSD ���v�Z���܂��B
%   f = fdesign.lowpass('N,Fp,Fst',27,.4,.6);
%   h = design(f,'equiripple','FilterStructure','dffir');
%   h.Arithmetic = 'fixed';
%   specifyall(h); h.OutputFracLength=15;
%   Hpsd = noisepsd(h);
%   plot(Hpsd)
%
%   �Q�l DFILT/NOISEPSDOPTS, DFILT/FREQRESPEST, DFILT/SCALE, 
%        DFILT/FUNCTIONS, DSPDATA/PSD.


%   Copyright 1988-2007 The MathWorks, Inc.
