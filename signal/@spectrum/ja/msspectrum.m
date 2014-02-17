%MSSPECTRUM  ���ϓ��X�y�N�g�� (MSS)
%
%    Hmss = MSSPECTRUM(H,X) �́AH �Ŏw�肵�� MSS �������g���Đ��肳�ꂽ�A
%    ���U���ԐM���x�N�g�� X �̕��ϓ�� (�p���[) ������܂� DSP �f�[�^�I�u�W�F�N�g 
%    (<a href="matlab:help dspdata">dspdata</a>) �� Hmss �ɕԂ��܂��B
%
%    �L���� MSS �����:
%           <a href="matlab:help spectrum.periodogram">periodogram</a>
%           <a href="matlab:help spectrum.welch">welch</a>
%
%    �I�u�W�F�N�g Hmss �Ɋ܂܂�镽�ϓ��X�y�N�g���́A���g���S�̂̃p���[��
%    ���z�ł��B�����M���ɑ΂��āAMSSPECTRUM �́A�f�t�H���g�ŕБ����ϓ��X�y�N�g��
%    ��Ԃ��܂��B���f���M���ɑ΂��āA�������ϓ��X�y�N�g����Ԃ��܂��B�Б�����
%    ���X�y�N�g���́A���͐M���̂��ׂẴp���[���܂ނ��Ƃɒ��ӂ��Ă��������B
%
%    ���ϓ��X�y�N�g���͗��U�X�y�N�g����ΏۂƂ��Ă��܂��B�p���[�X�y�N�g��
%    ���x (PSD) �Ƃ͈قȂ�A���ϓ��X�y�N�g���̃s�[�N�͔C�ӎ��g���ɂ�����
%    �M�����̃p���[�𔽉f���܂��B
%
%    Hmss �I�u�W�F�N�g�́A���ϓ��X�y�N�g���𐄒肷��_�ɂ����鐳�K�����g��
%    �x�N�g�� W ���܂�ł��܂��BW �̒P�ʂ́A���W�A��/�T���v���ł��B�����M����
%    �΂��āAW �́ANFFT �������̏ꍇ [0,pi] �̋�ԂɍL����ANFFT ����̏ꍇ 
%    [0,pi) �͈̔͂ɂȂ�܂��B���f���M���̏ꍇ�AW �́A��ɁA[0.2*pi) �̋�Ԃł��B
%
%    Hmss = MSSPECTRUM(H,X,'Fs',Fs) �́A�����I�Ȏ��g�� (Hz) �̊֐��Ƃ��Čv�Z
%    �����X�y�N�g�����܂ޕ��ϓ��X�y�N�g���I�u�W�F�N�g��Ԃ��܂��BFs �́A
%    Hz �Ŏw�肳�ꂽ�T���v�����O���g���ł��B
%
%    Hmss = MSSPECTRUM(...,'SpectrumType','twosided') �́A�����M�� X �̗���
%    ���ϓ��X�y�N�g���������ϓ��X�y�N�g���I�u�W�F�N�g��Ԃ��܂��B
%    ���̏ꍇ�A�X�y�N�g���́AFs ���w�肳��Ă��Ȃ��ꍇ [0,2*Pi) �͈̔́A
%    Fs ���w�肳�ꂽ�ꍇ [0,Fs) �͈̔͂Ōv�Z����܂��BSpectrumType �́A
%    �����M�� X �ɑ΂��ăf�t�H���g�ƂȂ� 'onesided' ���w��ł��܂��B
%
%    Hmss = MSSPECTRUM(...,'NFFT',nfft) �́A���ϓ��X�y�N�g�����v�Z����
%    ���߂Ɏg���� FFT �_���Ƃ��� nfft ���w�肵�܂��B
%
%    Hmss = MSSPECTRUM(...,'CenterDC',true) �́A0 �̎��g���������X�y�N�g����
%    ���S�ƂȂ�悤�ɃV�t�g����K�v�̂���X�y�N�g�����w�肵�܂��BCenterDC ��
%    �f�t�H���g�� false ���ݒ肳��Ă��܂��B
%
%    Hmss = MSSPECTRUM(...,'FreqPoints','User Defined','FrequencyVector',f)
%    �́A���g���̃x�N�g�� f �Œ�`���ꂽ���g���Ŏ��s���ꂽ���ϓ��X�y�N�g��
%    ��Ԃ��܂��B
%
%    Hmss = MSSPECTRUM(...,'ConfLevel',p) �́A�M�����x�� p ���w�肵�܂��B
%    p �́A��� (0,1) ���̒l�����܂��B�M����Ԃ́A2 ��̍s��Ƃ��� Hmss 
%    �I�u�W�F�N�g�ɒǉ�����܂��B1 �Ԗڂ̗�͉������܂݁A2 �Ԗڂ̗�͏����
%    �܂݂܂��B
%
%    MSSPECTRUM(...) �Ƃ��ďo�͈������w�肵�Ȃ��ꍇ�A�f�t�H���g�Ō��݂� 
%    Figure �E�B���h�E�ɒP�ʎ��g���ɂ��� dB �ŕ��ϓ��X�y�N�g����
%    �v���b�g���܂��B
%
%    MSSPECTRUM �ɌX�ɓ��͈������w�肷�����ɁA<a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> ���g���ăI�v�V������
%    �I�u�W�F�N�g���쐬���邱�Ƃ��ł��܂��B
%
%   �� 1:
%      % ���̗�ł́A200Hz �̎��g�����������m��I�ȃp���[�M���̃p���[��
%      % ���肵�܂��B3 �{���g�̃s�[�N�̐U�������M�����g�p���邽�߁A200Hz 
%      % �ł̗��_�I�ȃp���[�́A3^2/2 �{���g^2 (���b�g) �܂��� 6.5321dB ��
%      % ����K�v������܂��B
%      Fs = 1000;   t = 0:1/Fs:.2;
%      x = 3*cos(2*pi*t*200);
%      h = spectrum.welch;           % Welch �X�y�N�g�������̍쐬
%
%      % �Б����ϓ��X�y�N�g���̃v���b�g
%      msspectrum(h,x,'Fs',Fs,'NFFT',2^14);
%
%   �� 2:200 Hz �ߕӂ̎��g���ŕ��ϓ��X�y�N�g����]�����܂��B
%      msspectrum(h,x,'Fs',Fs,'FreqPoints','User Defined','SpectrumType',...
%      'TwoSided','FrequencyVector',linspace(150,250,100),'ConfLevel',0.95);
%
%   �Q�l SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
