%GRPDELAY  �f�W�^���t�B���^�̌Q�x��
%
%   [Gd,W] = GRPDELAY(B,A,N) �́AN �̌v�Z�����_�ɂ�������g�� W (���W�A��
%   �P��) �ƌQ�x�� Gd ���܂ޒ��� N �̃x�N�g����Ԃ��܂��B�Q�x���́A
%   -d{angle(w)}/dw �ŕ\���܂��B���g�������́A�P�ʉ~�̏㔼���̓��Ԋu�� 
%   N �_��]�����܂��BN �� 2 �̃x�L��̏ꍇ�� FIR �t�B���^�ɑ΂��āA�v�Z�� 
%   FFT �A���S���Y�����g�p���č����ɍs���܂��BN ���w�肵�Ȃ��ꍇ�A
%   �f�t�H���g�� 512 �ł��B
%
%   GRPDELAY(B,A,N,'whole') �́A�P�ʉ~�S�̂̉~����� N �_���g�p���܂��B
%
%   [Gd,F] = GRPDELAY(B,A,N,Fs)�A�܂��� [Gd,F] = GRPDELAY(B,A,N,'whole',Fs) �́A
%   �T���v�����O���g�� Fs �� Hz �P�ʂŐݒ肷��ƁA�x�N�g�� F �Ɏ��g����Ԃ��܂��B
%
%   Gd = GRPDELAY(B,A,W)�A�܂��́AGd = GRPDELAY(B,A,F,Fs) �́A���ꂼ�� W 
%   (���W�A��/�T���v���P��)�A�܂��� F (Hz �P��) �̓_�Ōv�Z�����Q�x����Ԃ��܂��B
%
%   �o�͈����������Ȃ� GRPDELAY(B,A,...) �́A���K�����ꂽ���g�� (�i�C�L�X�g
%   ���g���� 1) �ɑ΂���Q�x�������݂� Figure �E�B���h�E�Ƀv���b�g���܂��B
%
%   �Q�l FREQZ


%   Copyright 1988-2007 The MathWorks, Inc.
