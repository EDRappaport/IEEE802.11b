%DOUBLE  �t�B���^��\���x���Z�o�[�W�����ɃL���X�g
%
%   Hd = DOUBLE(H) �́AH �Ɠ����\���ƌW���������܂����A���̉��Z�� 'double' 
%   �ɐݒ肳�ꂽ�V�K�̃t�B���^ Hd ��Ԃ��܂��B
%
%   DOUBLE(H) �́A�Q�ƌW���̑��� H �̎� (�ʎq��) �W�������t�B���^��
%   �Ԃ���Ă��� REFFILTER(H) �Ƃ͈قȂ�܂��B
%
%   DOUBLE(H) �́A�t�B���^�W���̗ʎq���̉e�����u���������ꍇ�ɖ𗧂��܂��B
%
%   % ��:�����W�����g���āA�Œ菬���_�t�B���^�����O�Ɣ{���x���������_
%   % �t�B���^�����O���r���܂��B
%   f = fdesign.lowpass('N,Fp,Fst',27,0.4,0.6);
%   H = design(f,'FilterStructure','dffir');
%   H.Arithmetic = 'fixed'; % �Œ菬���_���Z���g���� H ���t�B���^�ɐݒ�
%   Hd = double(H);         % �{���x���������_�ɃL���X�g
%   n = 0:99; x = sin(0.7*pi*n(:)); % ���͐M���̐ݒ�
%   y = filter(H,x);   % �Œ菬���_�̏o��
%   yd = filter(Hd,x); % ���������_�̏o��
%   norm(yd-double(y),inf)
%
%   �Q�l DFILT/REFFILTER.


%   Copyright 2003-2007 The MathWorks, Inc.
