%CHEB1ORD  �`�F�r�V�F�t I �^�t�B���^�̎����I��
%
%   [N, Wp] = CHEB1ORD(Wp, Ws, Rp, Rs) �́A�ʉߑш�̕ϓ��� Rp dB �ȉ��ŁA
%   �Ւf�ш�ɏ��Ȃ��Ƃ� Rs dB �̌��������f�W�^���`�F�r�V�F�t I �^�t�B���^
%   �̍ŏ����� N ��Ԃ��܂��B�ʉߑш� Wp�A�Ւf�ш� Ws �́A0 ���� 1 �܂ł�
%   ���K�����ꂽ�l�ł��B�����ŁA1 �̓΃��W�A��/�T���v���ɑΉ����܂�)�B
%   ���Ƃ��΁A���̂悤�ɂȂ�܂��B
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   CHEB1ORD �́A�d�l�𖞑����� CHEBY1 �Ŏg�p����`�F�r�V�F�t�ŗL�U���� 
%   Wp ���Ԃ��܂��B
%
%   [N, Wp] = CHEB1ORD(Wp, Ws, Rp, Rs, 's') �́A�A�i���O�t�B���^��݌v���܂��B
%   ���̏ꍇ�AWp �� Ws �̎��g���̓��W�A��/�b�P�ʂł��B
%
%   �Q�l CHEBY1, CHEB2ORD, BUTTORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.
