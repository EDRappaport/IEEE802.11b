%BITREVORDER  ���͂��r�b�g���]���������ɕ��בւ�
%
%   Y = BITREVORDER(X) �́A�r�b�g���]���������ŁA������ς����ŏ���
%   ��V���O���g�������ŁAX �Ɠ����T�C�Y�����z�� Y ��Ԃ��܂��B
%
%   [Y,I] = BITREVORDER(X) �́A�r�b�g���]�C���f�b�N�X�x�N�g�� I ��Ԃ��܂��B
%   ���Ƃ��΁A�x�N�g�� Y �ɑ΂��ẮAY=X(I) �ł��B
%
%   ���̑���́A���g���̈�t�B���^�����O�A���S���Y���Ŏg�p���邽�߂ɁA
%   �t�B���^�W���̃x�N�g�����A�O�����ĕ��ׂ�ۂɗL���ł��B�����ŁAFFT 
%   ����� IFFT �ϊ��́A���ǂ��ꂽ���s���̌����̂��߂ɁA�r�b�g���]����
%   �����t���������Ɍv�Z����܂��B
%
%   BITREVORDER(X) �̌Ăяo���́ADIGITREVORDER(X, 2) ���Ăяo�����ƂƓ����ł��B
%
%   ��:
%       x = [0:15].';
%       y = bitrevorder(x); % � 2 (�r�b�g���]) �ł� x �̕��בւ�
%       [x y]
%
%   �Q�l DIGITREVORDER, FFT, IFFT.


% Copyright 1988-2007 The MathWorks, Inc.
