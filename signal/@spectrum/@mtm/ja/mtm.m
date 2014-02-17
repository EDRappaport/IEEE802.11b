%MTM  Thomson �}���`�e�[�p�@ (MTM) �̃p���[�X�y�N�g�����x (PSD) �����
%
%   H = SPECTRUM.MTM(TIMEBW) �́A����-�ш敝�̐ς� TIMEBW �ɐݒ肳�ꂽ 
%   MTM �� PSD ������Ԃ��܂��B���� - �ш敝�̐ς́A�f�[�^�E�B���h�E
%   �Ƃ��Ďg�p����闣�U�G����]�ȉ~�̗� (�܂��� Slepian ��) �ł��B
%
%   H = SPECTRUM.MTM(DPSS,CONCENTRATIONS) �́A���U�G����]�ȉ~�̗�Ƃ�����
%   �W���x�����ꂼ�� DPSS �� CONCENTRATIONS �ɐݒ肳�ꂽ mtm �X�y�N�g��������
%   �Ԃ��܂��B������ 2 �̓��͈����̏ڍׂɂ��ẮA"help dpss" �Ɠ��͂���
%   ���������B
%
%   ���ӁFDPSS �� CONCENTRATIONS ���w�肷��ƁAMTM �������쐬����Ƃ��ɁA
%   SpecifyDataWindowAs �v���p�e�B�̒l���f�t�H���g�l 'TimeBW' ���� 'DPSS' ��
%   �����I�ɕύX���܂��B
%
%   H = SPECTRUM.MTM(...,COMBINEMETHOD) �́A�X�̃X�y�N�g����������������
%   ���߂̃A���S���Y�����w�肵�܂��BCOMBINEMETHOD �́A�ȉ��̕������ 1 ��
%   �g�p�ł��܂��B
%      'Adaptive'   - Thomson �̓K������`����
%      'Eigenvalue' - �ŗL�l���d�݂Ƃ�����`����
%      'Unity'      - �P�ʏd�݂��g�������`����
%
%   MTM �� PSD �����́A���̂悤�Ȋ֐������s���邽�߂Ƀf�[�^�Ƌ��ɉ��L��
%   �֐��ɓn�����Ƃ��ł��܂��B
%       <a href="matlab:help spectrum/psd">psd</a>     - PSD ���v�Z
%       <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD ���v�Z���邽�߂̃I�v�V�������o��
%
%   �� #1: 200Hz �̐����g�ɎG���������܂��B
%      Fs = 1000;   t = 0:1/Fs:.3;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.mtm(3.5);         % MTM �X�y�N�g���������쐬����ꍇ�A
%                                     % ����-�ш敝�̐ς��w��
%      psd(h,x,'Fs',Fs);              % PSD �̌v�Z�ƃv���b�g
%
%   �� #2: ��L�Ɠ�����ł����A���� BW �̐ς̑���ɁA�f�[�^�e�[�p�Ƃ��̏W��
%   �x���w�肵�܂��B
%      Fs = 1000;   t = 0:1/Fs:.3;
%      x = cos(2*pi*t*200)+randn(size(t));
%      [E,V] = dpss(length(x),3.5);
%      h = spectrum.mtm(E,V);          % MTM �X�y�N�g���������쐬����ꍇ�A
%                                      % DPSS �ƏW���x���w��
%      psd(h,x,'Fs',Fs);              % PSD �̌v�Z�ƃv���b�g
%
%   �Q�l SPECTRUM, DSPDATA.


%   Copyright 1988-2008 The MathWorks, Inc.
