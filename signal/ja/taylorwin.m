%TAYLORWIN  Taylor �E�B���h�E
%
% TAYLORWIN (N) �́AN �_�� Taylor �E�B���h�E���x�N�g���ɕԂ��܂��B
%
% TAYLORWIN(N,NBAR) �́A���C�����[�u�ɗאڂ���A�قڒ萔���x���̃T�C�h���[�u 
% NBAR ������ N �_�� Taylor �E�B���h�E��Ԃ��܂��BNBAR �́A1 �ȏ�̐�����
% �Ȃ���΂Ȃ�܂���B
%
% TAYLORWIN(N,NBAR,SLL) �́A���C�����[�u�̃s�[�N�Ɋւ��� dB �P�ʂ� SLL 
% �ő�T�C�h���[�u���x�������� N �_�� Taylor �E�B���h�E��Ԃ��܂��BSLL ��
% ���̒l�łȂ���΂Ȃ�܂���B���Ƃ��� -30 dB�B
%
% NBAR �� NBAR >= 2*A^2+0.5 �𖞂����K�v������܂��B�����ŁAA �� 
% acosh(10^(-SLL/20))/pi �Ɠ������A�w�肳�ꂽ�T�C�h���[�u���x���ȊO��
% �ۏ؂��܂���BNBAR ���w�肳��Ȃ��ꍇ�A�f�t�H���g�� 4 �ł��BSLL ��
% �w�肳��Ȃ��ꍇ�A�f�t�H���g�� -30 dB �ł��B
%
% ��
%   ���̗�́A�قڒ萔���x���Ń��C�����[�u�ɗאڂ��� 4 �̃T�C�h���[�u�ƁA
%   ���C�����[�u�̃s�[�N�Ɋւ��� -35 dB �̃s�[�N�̃T�C�h���[�u���x�������� 
%   64 �_�� Taylor �E�B���h�E�𐶐����܂��B
%
%   w = taylorwin(64,5,-35);
%   wvtool(w);
%
%   �Q�l CHEBWIN.


%   Copyright 2005-2007 The MathWorks, Inc.
