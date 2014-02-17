%CCONV  N ��@�Ƃ��鏄���ݍ���
%
%   C = CCONV(A, B, N) �́A�x�N�g�� A �� B �̏����ݍ��݂��s���܂��B���ʂ�
%   �x�N�g���́A���� N �ł��B�ȗ����ꂽ�ꍇ�AN �́A�f�t�H���g�� 
%   LENGTH(A)+LENGTH(B)-1 �ł��BN = LENGTH(A)+LENGTH(B)-1 �̏ꍇ�A
%   �����ݍ��݂́ACONV �Ōv�Z�������`��ݍ��݂Ɠ����ɂȂ�܂��B
%
%   % �� #1: 4 ��@�Ƃ��鏄���ݍ���
%   a = [2 1 2 1];
%   b = [1 2 3 4];
%   c = cconv(a,b,4)
%
%   % �� #2: ��荂���Ȑ��`��ݍ��݂Ƃ��Ă̏����ݍ���
%   a = [1 2 -1 1];
%   b = [1 1 2 1 2 2 1 1];
%   c = cconv(a,b,11)
%   cref = conv(a,b)
%
%   % �� #3: ����I�ȑ��ݑ���
%   a = [1 2 2 1]+i;
%   b = [1 3 4 1]-2*i;
%   c = cconv(a,conj(fliplr(b)),7)
%   cref = xcorr(a,b)
%
%   �Q�l CONV, XCORR


%   Copyright 2006-2007 The MathWorks, Inc.
