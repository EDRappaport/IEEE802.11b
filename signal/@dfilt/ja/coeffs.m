%COEFFS  �\���̓��̃t�B���^�W�����o��
%
%   S = COEFFS(Hd) �́A�I�u�W�F�N�g Hd �̃t�B���^�W�����\���� S �ɕԂ��܂��B
%   �\���̂́A�I�u�W�F�N�g Hd ���̃v���p�e�B���ƈ�v����t�B�[���h�������܂��B
%
%   Hd �����i�I�u�W�F�N�g (�J�X�P�[�h�A�܂��͕���) �̏ꍇ�A�Ԃ����\���̂́A
%   ���i�t�B���^�̊e�i�̃t�B�[���h���܂݂܂��B
%
%   % ��:
%   b  = fir1(25,.5);
%   Hd = dfilt.dffir(b);
%   c  = coeffs(Hd)
%   b2 = firpm(20,[0 0.4 0.5 1],[1 1 0 0]);
%   Hc = cascade(Hd, dfilt.dffir(b2));
%   c2 = coeffs(Hc)


%   Copyright 1988-2007 The MathWorks, Inc.
