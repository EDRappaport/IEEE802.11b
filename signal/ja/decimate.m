%DECIMATE  ���[�p�X�t�B���^��K�p������̃T���v�����O���[�g�̒ጸ (�Ԉ���)
%
%   Y = DECIMATE(X,R) �́A�I���W�i���̃T���v�����[�g�� 1/R �{�Ńx�N�g�� 
%   X �̗�����T���v�����܂��B���ʂ̃��T���v�����ꂽ�x�N�g�� Y �́AR �{
%   �Z���Ȃ�܂��B���Ȃ킿�ALENGTH(Y) = CEIL(LENGTH(X)/R)�B�f�t�H���g�ł́A
%   DECIMATE �́A���T���v�����O�̑O�ɁA�J�b�g�I�t���g�� 0.8*(Fs/2)/R �� 
%   8 ���̃��[�p�X�`�F�r�V�F�t I �^�t�B���^�Ńf�[�^���t�B���^�����O���܂��B
%
%   Y = DECIMATE(X,R,N) �́AN ���̃`�F�r�V�F�t�t�B���^���g�p���܂��B13 ��
%   ���傫�� N �ɑ΂��āADECIMATE �͌��ʂ̐M�����̌��@�Ɋւ���x����
%   �������܂��B�ȉ��̒��ӂ��Q�Ƃ��Ă��������B
%
%   Y = DECIMATE(X,R,'FIR') �́AFIR1(30,1/R) �Ő�������� 30 ���� FIR 
%   �t�B���^���g�p���܂��B
%
%   Y = DECIMATE(X,R,N,'FIR') �́A���� N �� FIR �t�B���^���g�p���܂��B
%
%   ����:R ���傫���Ȃ�� (���Ȃ킿 R > 13)�AR ���e�v�f�ɕ������� DECIMATE 
%   �����񂩎��s������@�����߂܂��B
%
%   ��: 4 �̗v�f�ŐM�����Ԉ������܂��B
%   t = 0:.00025:1;  % ���ԃx�N�g��
%   x = sin(2*pi*30*t) + sin(2*pi*60*t);
%   y = decimate(x,4);
%   subplot(1,2,1);
%   stem(x(1:120)), axis([0 120 -2 2])   % �I���W�i���̐M��
%   title('Original Signal')
%   subplot(1,2,2);
%   stem(y(1:30)))                        % �Ԉ�����̐M��
%   title('Decimated Signal')
%
%   �Q�l DOWNSAMPLE, INTERP, RESAMPLE, FILTFILT, FIR1, CHEBY1, 
%        Filter Design Toolbox �� MFILT/FIRDECIM, MFILT.


%   Copyright 1988-2007 The MathWorks, Inc.
