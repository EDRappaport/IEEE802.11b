%ICCEPS  �t���f�P�v�X�g����
%
%   ICCEPS(XHAT,ND) �́A�x���� ND �T���v������������������ XHAT �̋t���f
%   �P�v�X�g������Ԃ��܂��BXHAT ���ACCEPS(X) �œ���ꂽ�ꍇ�AX �ɕt��
%   ���ꂽ�x�����ʂ́A�΃��W�A���ɑ������� round(unwrap(angle(fft(x)))/pi) 
%   �̗v�f�ɂȂ�܂��B
%
%   ��:�t���f�P�v�X�g�������v�Z���邽�߂� ICCEPS ���g�p���܂��B
%   x = 1:10;
%   [xh,nd] = cceps(x);
%   % ���f�P�v�X�g�����̋t������s�� icceps �Œx���p�����[�^���g�p���܂��B
%   icceps(xh,nd)
%
%   �Q�l CCEPS, RCEPS, HILBERT, FFT.


%   Copyright 1988-2007 The MathWorks, Inc.
