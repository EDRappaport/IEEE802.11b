%IMPINVAR  �A�i���O����f�B�W�^���t�B���^�ւ̕ϊ��̃C���p���X�s�ω����@
%
%   [BZ,AZ] = IMPINVAR(B,A,Fs) �́A�C���p���X�������AFs �w���c�̎��g����
%   �T���v�����O���ꂽ�W�� B �� A �����A�i���O�t�B���^�̃C���p���X������
%   ���������ꂼ��̕��q�W���ƕ���W�� BZ �� AZ �����f�W�^���t�B���^��
%   �쐬���܂��BB �� A �̌W���́A1/Fs �ŃX�P�[�����O����܂��B
%
%   Fs ���w�肵�Ȃ��ꍇ�A�f�t�H���g�� 1 Hz �ł��B
%
%   [BZ,AZ] = IMPINVAR(B,A,Fs,TOL) �́A���ɏd������ɂ��O���[�v�����邽�߂ɁA
%   ���e�덷 TOL ���g�p���܂��B�f�t�H���g�l�� 0.001�A���Ȃ킿 0.1% �ł��B
%
%   ����:�d������ɂ̏ꍇ�͓��삵�܂����A�������̂悤�Ȉ��q�ւ̊֐� ROOTS ��
%        �@�\�Ő�������܂��B
%
%   % ��:�f�W�^���ƃA�i���O�̎��g�������Ԃ̊֌W�ɂ��Ď����܂��B
%   [b,a] = butter(4,0.3,'s');
%   [bz,az] = impinvar(b,a,10);
%   [Ha,Wa] = freqs(b,a,512);
%   [Hz,Wz] = freqz(bz,az,512,10);
%   plot(Wa/(2*pi),20*log10(abs(Ha))); hold on;
%   plot(Wz,20*log10(abs(Hz)))
%
%   �Q�l BILINEAR.


%   Copyright 1988-2007 The MathWorks, Inc.
