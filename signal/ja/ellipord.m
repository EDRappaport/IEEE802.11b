%ELLIPORD  �ȉ~�t�B���^�̎�������
%
%   [N, Wp] = ELLIPORD(Wp, Ws, Rp, Rs) �́A�ʉߑш�̕ϓ��� Rp dB �ȉ��ŁA
%   �Ւf�ш�ɏ��Ȃ��Ƃ� Rs dB �̌��������ŏ������̑ȉ~�t�B���^�̎��� 
%   N ��Ԃ��܂��B�ʉߑш� Wp�A�Ւf�ш� Ws �́A0 ���� 1 �܂ł̐��K�����ꂽ
%   �l�ł��B�����ŁA1 �̓΃��W�A��/�T���v���ɑΉ����܂�)�B���Ƃ��΁A����
%   �悤�ɂȂ�܂��B
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   ELLIPORD �́A�d�l�𖞑�����ȉ~�ŗL�U���� Wp ���Ԃ��܂��B
%
%   [N, Wp] = ELLIPORD(Wp, Ws, Rp, Rs, 's') �́A�A�i���O�t�B���^��݌v
%   ���܂��B���̏ꍇ�AWp�� Ws �̎��g���̓��W�A��/�b�P�ʂł��B
%
%   ����:Rs �� Rp �ɔ�ׂĂ��Ȃ�傫���ꍇ��AWp �� Ws �����Ȃ�߂��l�̏ꍇ�A
%   ���肳�ꂽ�����́A���l���x�̌��E�̂��ߖ����ɂȂ�܂��B
%
%   �Q�l ELLIP, BUTTORD, CHEB1ORD, CHEB2ORD.


%   Copyright 1988-2007 The MathWorks, Inc.
