%STEPZ  �f�W�^���t�B���^�̃X�e�b�v����
%
%   [S,T] = STEPZ(B,A) �́A�t�B���^ B/A �̃X�e�b�v�������v�Z���āA�T���v������
%   �I�����A�x�N�g�� S �ɕԂ��܂��B�]�����ꂽ S �ł̎��ԃT���v���̃x�N�g���́A
%   �x�N�g�� T �ɕԂ���܂��B
%
%   [H,T] = STEPZ(B,A,N) �́A�X�e�b�v�����̍ŏ��� N �T���v�����v�Z���܂��B
%
%   [H,T] = STEPZ(B,A,N,Fs) �́AT = 1/Fs �Ŏ��ԃT���v���𕪗����܂��BFs �́A
%   Hz �ł���Ɖ��肵�܂��B
%
%   STEPZ(...) �Ƃ��ďo�͈����������Ȃ��ꍇ�A�X�e�b�v�������v���b�g���܂��B
%
%   % ��: 3 ���̃o�^���[�X�f�W�^���t�B���^�̃X�e�b�v�����B
%   [b,a] = butter(3,.4);
%   stepz(b,a)
%
%   �Q�l IMPZ, FREQZ, ZPLANE, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
