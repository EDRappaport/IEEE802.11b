%BUTTORD  �o�^���[�X�t�B���^�̎�������
%
%   [N, Wn] = BUTTORD(Wp, Ws, Rp, Rs) �́A�ʉߑш�̑����� Rp dB �ȉ��ŁA
%   �Ւf�ш�ɏ��Ȃ��Ƃ� Rs dB �̌��������A�f�W�^���o�^���[�X�t�B���^��
%   �ŏ����� N ��Ԃ��܂��B�ʉߑш� Wp�A�Ւf�ш� Ws �́A0 ���� 1 �܂ł�
%   ���K�����ꂽ�l�ł��B�����ŁA1 �̓΃��W�A��/�T���v���ɑΉ����܂�)�B
%   ���Ƃ��΁A���̂悤�ɂȂ�܂��B
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   BUTTORD �́A�d�l�𖞑����邽�߂ɁA�֐� BUTTER ���g�����A�o�^���[�X
%   �J�b�g�I�t���g�� (���邢�́A"3 dB ���g��") Wn ��Ԃ��܂��B
%
%   [N, Wn] = BUTTORD(Wp, Ws, Rp, Rs, 's') �́A�A�i���O�t�B���^��݌v
%   ���܂��B���̏ꍇ�AWp �� Ws �̎��g���̓��W�A��/�b�P�ʂł��B
%
%   �܂��ARp �� 3 dB �̏ꍇ�A�֐� BUTTER �� Wn �Ɗ֐� BUTTORD �� Wp ��
%   �����ɂȂ�܂��B
%
%   �Q�l BUTTER, CHEB1ORD, CHEB2ORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.
