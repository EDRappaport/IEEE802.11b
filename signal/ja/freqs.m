%FREQS  ���v���X�ϊ� (S-�̈�) �̎��g������
%
%   H = FREQS(B,A,W) �́A�x�N�g�� B �� A �ɁA���q�ƕ���̌W�����^����ꂽ
%   �ꍇ�A�t�B���^ B/A �̕��f���g������ H ��Ԃ��܂��B
%                        nb-1         nb-2
%            B(s)   b(1)s     +  b(2)s     + ... +  b(nb)
%     H(s) = ---- = -------------------------------------
%                        na-1         na-2
%            A(s)   a(1)s     +  a(2)s     + ... +  a(na)
%
%   �́A�x�N�g�� B �� A �ɁA���q�ƕ���̌W����ݒ肵�܂��B���g�������́A
%   �x�N�g�� W (rad/s) �Ɏw�肳�ꂽ�_�Ŏ��s����܂��BFREQS(B,A,W) �ł́A
%   �o�͈�����ݒ肵�Ȃ��ꍇ�A���g���ɑ΂���Q�C������шʑ�������\�����܂��B
%
%   [H,W] = FREQS(B,A) �́A���g������ H ���v�Z���� 200 �̎��g���_ W ��
%   �����I�ɐݒ肵�܂��BFREQS(B,A,N) �́AN �_�̎��g���������v�Z���܂��B
%
%   �Q�l LOGSPACE, POLYVAL, INVFREQS, and FREQZ.


%   Copyright 1988-2007 The MathWorks, Inc.
