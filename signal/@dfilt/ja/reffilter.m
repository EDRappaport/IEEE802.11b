%REFFILTER  �{���x���������_�t�B���^�̎Q��
%
%   Href = REFFILTER(Hd) �́AHd �Ɠ����\���̂����V�K�t�B���^ Href ��
%   �Ԃ��܂����A�Q�ƌW�����g�p���A���̉��Z�v���p�e�B�� 'double' �ɐݒ�
%   ����Ă��܂��B
%
%   REFFILTER(Hd) �́A�Ԃ��ꂽ�t�B���^���A���ۂ� (�ʎq�����ꂽ) �W���ł�
%   �Ȃ��AHd �̎Q�ƌW�������_�ŁADOUBLE(Hd) �Ƃ͈قȂ�܂��B
%
%   REFFILTER(Hd) �́A��r�ړI�̂��߂ɋ@�\����t�B���^�̎Q�ƃo�[�V������
%   �����ɓ��邽�߂ɗL���ł��B
%
%   % ��:�l�X�ȌŒ菬���_�t�B���^�Ɣ{���x���������_�t�B���^���r���܂��B
%   f = fdesign.lowpass('N,Fc,Ap,Ast',87,.5,1e-3,1e-6,'linear');
%   H = design(f,'FilterStructure','dffir');
%   H1 = copy(H); H2 = copy(H); % �����t�B���^�� 2 �̃R�s�[�𐶐� 
%   H.Arithmetic = 'fixed'; % �Œ菬���_���Z���g���� H ���t�B���^�ɐݒ�
%   H1.Arithmetic = 'fixed'; % H1 �Ɠ���
%   H2.Arithmetic = 'fixed'; % H2 �Ɠ���
%   H.CoeffWordLength  = 16;  % �W����\�����߂� 16 �r�b�g���g�p 
%   H1.CoeffWordLength = 12;  % �W����\�����߂� 12 �r�b�g���g�p 
%   H2.CoeffWordLength =  8;  % �W����\�����߂� 8 �r�b�g���g�p
%   Href = reffilter(H);
%   Hfvt = fvtool(Href,H,H1,H2);
%   set(Hfvt,'ShowReference','off'); % �Q�Ƃ͊��ɕ\�� (��x) 
%   legend(Hfvt,'Reference filter','16-bits','12-bits','8-bits');
%
%   �Q�l dfilt/double.


%   Copyright 2003-2007 The MathWorks, Inc.
