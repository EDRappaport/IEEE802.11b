%FFTFILT  �I�[�o�[���b�v���Z�@���g���� FFT �x�[�X�� FIR �t�B���^�����O
%
%   Y = FFTFILT(B,X) �́A���� X �ɑ΂��āA�ŗǂ̌v�Z�����������������
%   �p�����[�^ (�T�C�Y�ƃu���b�N��) ���g���A�I�[�o���b�v���Z�@�ŁA�W��
%   �x�N�g�� B �ŕ\����� FIR �t�B���^�ɂ��t�B���^�����O���s���܂��B
%
%   Y = FFTFILT(B,X,N) �́A���Ȃ��Ƃ� N �_�� FFT ���g�p���邱�ƂŁA����
%   �p�����[�^�S�̂̂������̃R���g���[���������܂��B
%
%   X ���s��̏ꍇ�AFFTFILT �͊e��ɓK�p����܂��BB ���s��̏ꍇ�AFFTFILT ��
%   �M���x�N�g�� X �ɁA�W���x�N�g�� B �̊e��̃t�B���^��K�p���܂��BX�AB ��
%   �񐔂̓������s��̏ꍇ�A�W���x�N�g�� B �� i �Ԗڂ̗�́A���̓x�N�g�� 
%   X �� i �Ԗڂ̗���t�B���^�����O���邽�߂Ɏg�p����܂��B
%
%   �M������r�I�傫���ꍇ�AFILTER �̑���� FFTFILT ���g���ƗL���ȏꍇ��
%   ����܂��BFILTER �́AN ���t�B���^���Ƃ����ꍇ�AX �̊e�T���v���ɑ΂��� 
%   N ���Z���܂��BFFTFILT �́AL ���u���b�N���Ƃ����ꍇ�AL*log2(L)/2 �� 
%   2 �� FFT ���Z�����s���܂��BL*(1+log2(L)) �̏�Z�̑����ɑ΂��� L �_�P�ʂ�
%   ���s���܂��B�䗦�́A���̂��߁A�ߎ��I�� log2(L)/N �Ƃ��āA
%   L*(1+log2(L))/(N*L) => (1+log2(L))/N �ɂȂ�܂��B���̂��߁AFFTFILT �� 
%   log2(L) �� N ��菬�����ꍇ�A�L���ɂȂ�܂��B
%
%   �Q�l FILTER, FILTFILT, DFILT.FFTFIR.


%   Copyright 1988-2007 The MathWorks, Inc.
