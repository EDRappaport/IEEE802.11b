%FIRRCOS  ���C�Y�h�R�T�C�� FIR �t�B���^�̐݌v
%
%   B = FIRRCOS(N,Fc,DF,Fs) �́A���C�Y�h�R�T�C���J�ڑш������ N ����
%   ���[�p�X���`�ʑ� FIR �t�B���^��Ԃ��܂��B���̃t�B���^�́A�J�b�g�I�t
%   ���g�� Fc�A�T���v�����O���g�� Fs�A�J�ڕ� DF �ŁA�P�ʂ� Hz �ł��B
%   �t�B���^���� N �͋����łȂ���΂Ȃ�܂���B
%
%   Fc +/- DF/2 �́A[0 Fs/2] �͈̔͂ɂȂ���΂Ȃ�܂���B
%
%   B �̌W���́A�m�~�i���Ȓʉߑш�̃Q�C������� 1 �ɂȂ�悤�ɐ��K������܂��B
%
%   FIRRCOS(N,Fc,DF) �́A�f�t�H���g�̃T���v�����O���g���Ƃ��āAFs = 2 ���g���܂��B
%
%   B = FIRRCOS(N,Fc,R,Fs,'rolloff') �́A3 �Ԗڂ̈�����^���邱�ƂŁA�J�ڕ� 
%   DF �̑���Ƀ��[���I�t�t�@�N�^���w�肷�邱�Ƃ��ł��܂��B���邢�́A
%   B=FIRRCOS(N,Fc,DF,Fs) �Ɠ����� B=FIRRCOS(N,Fc,DF,Fs,'bandwidth') ��
%   �w�肷�邱�Ƃ��ł��܂��B
%
%   R �́A[0 1] �łȂ���΂Ȃ�܂���B
%
%   B=FIRRCOS(N,Fc,DF,Fs,DESIGNTYPE) �܂���
%   B=FIRRCOS(N,Fc,R,Fs,'rolloff',DESIGNTYPE)
%�A ���� DESIGNTYPE �ɋ�s����w�肷�邩 'normal' ���w�肷��ƁA���K��
%   ���C�Y�h�R�T�C�� FIR �t�B���^��݌v���܂��B�܂��A���� DESIGNTYPE �� 
%   'sqrt' ��^����Ɠ�捪���C�Y�h�R�T�C�� FIR �t�B���^��݌v���܂��B
%
%   B=FIRRCOS(...,DESIGNTYPE,DELAY) �́A�����x�����w��ł��܂��BDELAY 
%   �������ȗ����邩�A��̏ꍇ�́AN ������������ɂ���āA�f�t�H���g�l�� 
%   N/2 �� (N+1)/2 �ɂȂ�܂��B
%
%   DELAY �́A[0,N+1] �͈̔͂̐����łȂ���΂Ȃ�܂���B
%
%   B = FIRRCOS(...,DELAY,WINDOW) �́A ���� N+1 �̃E�B���h�E��݌v����
%   �t�B���^�ɓK�p���āA���g�������ɂ����郊�b�v�������������邱�Ƃ��\�ł��B
%   WINDOW �͒��� N+1 �̗�x�N�g���łȂ���΂Ȃ�܂���BWINDOW ���w��
%   ���Ȃ��ꍇ�́A���`�E�B���h�E���g���܂��B
%
%   �x��:�f�t�H���g�l�ȊO�̒x�����������E�B���h�E���g���ꍇ�͒��ӂ��Ă��������B
%
%   [B,A] = FIRRCOS(...)�́A��� A = 1 ��Ԃ��܂��B
%
%   �Q�l FIRLS, FIR1, FIR2.


%   Copyright 1988-2007 The MathWorks, Inc.
