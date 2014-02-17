%FREQZ  �f�W�^���t�B���^���g������
%
%   [H,W] = FREQZ(B,A,N) �́AN �_�ł̃t�B���^�̕��f���g�������x�N�g�� 
%   H �Ƃ�����v�Z���� N �_�̎��g���x�N�g�� (�P�ʂ̓��W�A��/�T���v��) ��
%   �Ԃ��܂��B
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%   �́A�x�N�g�� B �� A �ɁA���q�ƕ���̌W����ݒ肵�܂��B���g�������́A
%   �P�ʉ~�̏㔼���̓��Ԋu�� N �_��]�����܂��BN ���w�肵�Ȃ��ꍇ�A
%   �f�t�H���g�� 512 �ł��B
%
%   [H,W] = FREQZ(B,A,N,'whole') �́A�P�ʉ~�S�̂� N �_���g���܂��B
%
%   H = FREQZ(B,A,W) �́A�ݒ肷����g�������W�A��/�T���v���P�ʂŁA
%   �x�N�g�� W �ɐݒ� (�ʏ�́A0 �����) �������g���ɑ΂��鉞����Ԃ��܂��B
%
%   [H,F] = FREQZ(B,A,N,Fs) �� [H,F] = FREQZ(B,A,N,'whole',Fs) �́A���g��
%   �x�N�g�� F (Hz �P��) ���Ԃ��܂��B�����ŁAFs �̓T���v�����O���g�� (Hz �P��) �ł��B
%
%   H = FREQZ(B,A,F,Fs) �́A�x�N�g�� F (Hz �P��) �ɐݒ肵�����g���ŁA
%   ���f���g��������Ԃ��܂��B�����ŁAFs �̓T���v�����O���g�� (Hz �P��) �ł��B
%
%   FREQZ(B,A,...) ���g�ł́A���݂� Figure �E�B���h�E���ɃQ�C���ƘA����
%   �␳���ꂽ�ʑ����v���b�g���܂��B
%
%   �Q�l FILTER, FFT, INVFREQZ, FVTOOL, FREQS.


%   Copyright 1988-2007 The MathWorks, Inc.
