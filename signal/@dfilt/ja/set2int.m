%SET2INT  �W���𐮐��ɃX�P�[�����O
%
%   SET2INT(Hd) �́A�W���𐮐��ɃX�P�[�����O���A�W���Ɠ��͂̏�������
%   ������ 0 �ɐݒ肵�܂��B
%
%   SET2INT(Hd, COEFFWL) �́A�W����\�����߂� COEFFWL �Œ�`���ꂽ�r�b�g����
%   �g�p���܂��B
%
%   SET2INT(Hd, COEFFWL, INWL) �́A�W����\�����߂� COEFFWL �Œ�`���ꂽ
%   �r�b�g�����g�p���A�r�b�g���́A���͂�\�����߂� INWL �Œ�`����܂��B
%
%   G = SET2INT(...) �́A�W���𐮐��ɃX�P�[�����O���邱�ƂŃt�B���^��
%   ���������Q�C�� G ��Ԃ��܂��BG �͏�� 2 �ׂ̂���ł��B
%
%   ��F
%
%   �p�[�g 1:�����Ɛ����̃��[�h�ɂ�����t�B���^�̃X�e�b�v�������r
%   ---------------------------------------------------------------
%   f = fdesign.lowpass('N,Fc',100,.25);
%   h = design(f);
%   h.Arithmetic = 'fixed';
%   h.InputFracLength = 0; % �����̓���
%   x = ones(100,1);
%   yfrac = filter(h,x); % �������[�h
%
%   g = set2int(h);
%   yint = filter(h,x);  % �������[�h
%   % �����̏o�͂��ăX�P�[�����O
%   ysint1 = double(yint)/g;
%   % �X�P�[�����O���ꂽ�o�͂������̏o�͂Ɠ�������������
%   max(abs(ysint1-double(yfrac)))
%
%   �p�[�g 2:�o�͂̃o�C�i�����ĉ���
%   -------------------------------
%   % �����X�P�[���œ��͂Əo�͂�����ʂ̕��@�� MSB �𓯂��悤�ɏd��
%   % �t�����܂��B
%   WL = yint.WordLength;
%   FL = yint.Fractionlength + log2(g);
%   ysint2 = fi(zeros(size(yint)),true,WL,FL);
%   ysint2.bin = yint.bin;
%   max(abs(double(ysint2)-double(yfrac)))


%   Copyright 2004-2007 The MathWorks, Inc.
