%CHEB2ORD  �`�F�r�V�F�t II �^�t�B���^�̎����I��
%
%   [N, Ws] = CHEB2ORD(Wp, Ws, Rp, Rs) �́A�ʉߑш�� Rp dB �ȉ��̌����A
%   �Ւf�ш�ŁARs dB �ȏ�̌��������f�W�^���`�F�r�V�F�t II �^�t�B���^��
%   �ŏ����� N ��Ԃ��܂��B�ʉߑш� Wp�A�Ւf�ш� Ws �́A0 ���� 1 �܂ł�
%   ���K�����ꂽ�l�ł��B�����ŁA1 �̓΃��W�A��/�T���v���ɑΉ����܂�)�B
%   ���Ƃ��΁A���̂悤�ɂȂ�܂��B
%       Lowpass:    Wp = .1,      Ws = .2
%       Highpass:   Wp = .2,      Ws = .1
%       Bandpass:   Wp = [.2 .7], Ws = [.1 .8]
%       Bandstop:   Wp = [.1 .8], Ws = [.2 .7]
%   CHEBY2 ��g�ݍ��킹�Ďg�p���邱�Ƃɂ��ACHEB2ORD �́A�d�l�𖞑�����
%   �`�F�r�V�F�t�ŗL���g�� Wst ��Ԃ��܂��B
%
%   [N, Ws] = CHEB2ORD(Wp, Ws, Rp, Rs, 's') �́A�A�i���O�t�B���^��݌v���܂��B
%   ���̏ꍇ�AWp �� Ws �̎��g���̓��W�A��/�b�ł��B
%
%   �Q�l CHEBY2, CHEB1ORD, BUTTORD, ELLIPORD.


%   Copyright 1988-2007 The MathWorks, Inc.
