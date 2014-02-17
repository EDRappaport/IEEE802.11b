%PHASEDELAY  �f�W�^���t�B���^�̈ʑ��x��
%
%   [PHI,W] = PHASEDELAY(B,A,N) �́AN-�_�ʑ��x�������̃x�N�g�� PHI ��
%   �t�B���^�̃��W�A��/�T���v���ł� N-�_���g���x�N�g�� W ��Ԃ��܂�:
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%   �́A�x�N�g�� B �� A �ɁA���q�ƕ���̌W����ݒ肵�܂��B�ʑ������͒P�ʉ~��
%   ��㔼���� N �_�̓��Ԋu�ȋ�Ԃŕ]������܂��BN ���w�肵�Ȃ��ꍇ�A�f�t�H���g�� 
%   512 �ł��B
%
%   [PHI,W] = PHASEDELAY(B,A,N,'whole') �́A�P�ʉ~�S�̂̎��� N �_���g�p���܂��B
%
%   PHI = PHASEDELAY(B,A,W) �́A�x�N�g�� W �Ŏ�����郉�W�A��/�T���v�� (�ʏ�A0 
%   �� �� �̊�) �́A���g���ł̈ʑ��x���̉�����Ԃ��܂��B
%
%   [PHI,F] = PHASEDELAY(B,A,N,Fs) �� [PHI,F] = PHASEDELAY(B,A,N,'whole',Fs) 
%   �́A Fs (Hz) ���T���v�����O���g���Ƃ��āA�ʑ��x���x�N�g�� F ��Ԃ��܂��B
%
%   PHI = PHASEDELAY(B,A,F,Fs) �� Fs (Hz) ���T���v�����O���g���Ƃ��āA�w�肳�ꂽ
%   �x�N�g�� F (Hz) �ł̎��g���̈ʑ��x����Ԃ��܂��B
%
%   PHASEDELAY(B,A,...) ���A�o�͈����������Ȃ��ꍇ�A���݂� Figure �E�B���h�E��
%   �t�B���^�̈ʑ��x���̉������v���b�g���܂��B
%
%   �� #1:
%     b=fircls1(54,.3,.02,.008);
%     phasedelay(b)
%
%   �� #2:
%     [b,a] = ellip(10,.5,20,.4);
%     phasedelay(b,a,512,'whole')
%
%   �Q�l FREQZ, PHASEZ, ZEROPHASE, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
