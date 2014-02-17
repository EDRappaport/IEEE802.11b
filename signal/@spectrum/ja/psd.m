%PSD  �p���[�X�y�N�g�����x (PSD) �̐���
%
%    Hpsd = PSD(H,X) �́AH �Ŏw�肵�� PSD �������g���Đ��肳�ꂽ�A
%    ���U���ԐM���x�N�g�� X �� PSD ������܂� DSP �f�[�^�I�u�W�F�N�g 
%    (<a href="matlab:help dspdata">dspdata</a>) ��Ԃ��܂��B
%
%    �L���� PSD �����:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>    <a href="matlab:help spectrum.mcov">mcov</a>
%           <a href="matlab:help spectrum.welch">welch</a>          <a href="matlab:help spectrum.mtm">mtm</a>
%           <a href="matlab:help spectrum.burg">burg</a>           <a href="matlab:help spectrum.yulear">yulear</a>
%           <a href="matlab:help spectrum.cov">cov</a>
%
%    �I�u�W�F�N�g Hpsd �Ɋ܂܂�� PSD �f�[�^�́A�P�ʎ��g���ɑ΂���p���[��
%    ���z�ł��B�����M���ɑ΂��āAPSD �́A�Б� PSD ���f�t�H���g�Ƃ��ĕԂ��܂��B
%    ���f���M���̏ꍇ�A���� PSD ��Ԃ��܂��B�Б� PSD �́A���͐M���̂��ׂĂ�
%    �p���[���܂�ł��邱�Ƃɒ��ӂ��Ă��������B
%
%    �p���[�X�y�N�g�����x�͘A���X�y�N�g���ɑ΂��闘�p���Ӑ}���Ă��܂��B
%    ���ϓ��X�y�N�g�� (MSS) �ƈقȂ�A���̏ꍇ�A�X�y�N�g�����̃s�[�N�́A
%    �^����ꂽ���g���ł̃p���[�𔽉f���Ȃ����Ƃɒ��ӂ��Ă��������B����ɁA
%    �C�ӂ̎��g���тł� PSD �̐ϕ��́A���̎��g���тɑ΂���M���̕��σp���[��
%    �v�Z���܂��B�ڍׂ́AAVGPOWER �̃w���v���Q�Ƃ��Ă��������B
%
%    Hpsd �I�u�W�F�N�g���A���肳��� PSD �ɂ����鐳�K�����g���x�N�g�� W ��
%    �܂݂܂��BW �̒P�ʂ́A���W�A��/�T���v���ł��B�����M���ɑ΂��āAW �́A
%    NFFT �������̏ꍇ [0,pi] �̋�ԂɍL����ANFFT ����̏ꍇ [0,pi) ��
%    �͈͂ɂȂ�܂��B���f���M���̏ꍇ�AW �́A��ɁA[0.2*pi) �̋�Ԃł��B
%
%    Hpsd = PSD(...,'Fs',Fs) �́A�����I�Ȏ��g�� (Hz) �̊֐��Ƃ��Čv�Z���ꂽ
%    �X�y�N�g�������� PSD �I�u�W�F�N�g��Ԃ��܂��BFs �́AHz �Ŏw�肳�ꂽ
%    �T���v�����O���g���ł��B
%
%    Hpsd = PSD(...,'SpectrumType','twosided') �́A�����M�� X �̗��� PSD ��
%    ���� PSD �I�u�W�F�N�g��Ԃ��܂��B���̏ꍇ�A�X�y�N�g���́AFs ���w�肳���
%    ���Ȃ��ꍇ [0,2*Pi) �͈̔́AFs ���w�肳�ꂽ�ꍇ [0,Fs) �͈̔͂Ōv�Z����܂��B
%    SpectrumType �́A�����M�� X �ɑ΂��ăf�t�H���g�ƂȂ� 'onesided' ���w��
%    �ł��܂��B
%
%    Hpsd = PSD(...,'NFFT',nfft) �́A�p���[�X�y�N�g�����x���v�Z���邽�߂�
%    �g���� FFT �_���Ƃ��� nfft ���w�肵�܂��B
%
%    Hpsd = PSD(...,'CenterDC',true) �́A0 �̎��g���������X�y�N�g���̒��S��
%    �Ȃ�悤�ɃV�t�g����K�v�̂���X�y�N�g�����w�肵�܂��BCenterDC �́A
%    �f�t�H���g�� false �ɐݒ肳��܂��B
%
%    Hpsd = PSD(...,'FreqPoints','User Defined','FrequencyVector',f) �́A
%    ���g���̃x�N�g�� f �Œ�`���ꂽ���g���ŕ]������� PSD �I�u�W�F�N�g��
%    �Ԃ��܂��B
%
%    Hpsd = PSD(...,'ConfLevel',p) �́A�M�����x�� p ���w�肵�܂��Bp �́A
%    ��� (0,1) ���̒l�����܂��B�M����Ԃ́A2 ��̍s��Ƃ��� Hpsd 
%    �I�u�W�F�N�g�ɒǉ�����܂��B1 �Ԗڂ̗�͉������܂݁A2 �Ԗڂ̗��
%    ������܂݂܂��B
%
%    �o�͈�����ݒ肵�Ȃ� PSD(...) �́A�f�t�H���g�Ƃ��āA���݂� Figure 
%    �E�B���h�E�ɒP�ʎ��g���ɑ΂��� PSD �� dB �P�ʂŃv���b�g�\�����܂��B
%
%    PSD �ɌX�ɓ��͈������w�肷�����ɁA<a href="matlab:help 
%    spectrum/psdopts">psdopts</a> ���g���ăI�v�V�����̃I�u�W�F�N�g��
%    �쐬���邱�Ƃ��ł��܂��B
%
%   ��: 200Hz �̗]���g�ƎG�����܂ސM���̃X�y�N�g�����
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;               % Welch �X�y�N�g�������̍쐬
%      psd(h,x,'Fs',Fs);                 % �Б� PSD �̌v�Z�ƃv���b�g
%      hpsd = psd(h,x,'ConfLevel',p);    % �M�����x�������� PSD
%      figure,plot(hpsd)
%
%    �Q�l SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
