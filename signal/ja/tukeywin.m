%TUKEYWIN  Tukey �E�B���h�E
%
%   TUKEYWIN(N) �́AN �_�� Tukey �E�B���h�E���x�N�g���ɕԂ��܂��B
%
%   W = TUKEYWIN(N,R) �́AN �_�� Tukey �E�B���h�E���x�N�g���ɕԂ��܂��B
%   Tukey �E�B���h�E�́A�]���̃e�[�p�E�B���h�E�Ƃ��Ă��m���Ă��܂��B
%   R �p�����[�^�́A����Ԃɂ�����e�[�p�̔䗦���w�肵�܂��B���̔�́A
%   1 (���Ȃ킿�A0 < R < 1) �ɐ��K������Ă��܂��B�ȗ������ꍇ�AR �� 
%   0.500 �ɐݒ肳��܂��B
%
%   ����: R �̒l���ɒ[�ȏꍇ�ATukey �E�B���h�E�́A���̋��ʂ̃E�B���h�E��
%   �މ����邱�Ƃɒ��ӂ��Ă��������B���̂��߁AR = 1 �̏ꍇ�A����� Hanning 
%   �E�B���h�E�Ɠ����ɂȂ�܂��B�t�ɁAR = 0 �ɂ���ƁATukey �E�B���h�E�� 
%   boxcar �E�B���h�E�Ɠ����ł��B
%
%   ��:
%      N = 64;
%      w = tukeywin(N,0.5);
%      plot(w); title('64-point Tukey window, Ratio = 0.5');
%
%   �Q�l CHEBWIN, GAUSSWIN, KAISER, WINDOW.


%   Copyright 1988-2007 The MathWorks, Inc.
