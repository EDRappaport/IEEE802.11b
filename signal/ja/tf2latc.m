%TF2LATC  �`�B�֐������e�B�X�t�B���^�ɕϊ�
%
%   K = TF2LATC(NUM) �́ANUM(1) �Ő��K�����ꂽ FIR(MA) ���e�B�X�t�B���^��
%   �΂��郉�e�B�X�p�����[�^ K �����߂܂��BFIR �t�B���^�̗�_���P�ʉ~���
%   ����ꍇ�ɂ́A�덷��������ꍇ������܂��B
%
%   K = TF2LATC(NUM,'max') �ŁANUM �͍ő�ʑ� FIR �t�B���^�ɑΉ����AFIR 
%   ���e�B�X�ɕϊ�����O�� NUM �𔽓]�����A���������܂��B����́Aabs(K) <= 1 
%   �ƂȂ�ALATCFILT �� 2 �Ԗڂ̏o�͂Ƃ��čő�ʑ��t�B���^���������邽�߂�
%   �p�����܂��B
%
%   K = TF2LATC(NUM,'min') �ŁANUM �͍ŏ��ʑ� FIR �t�B���^�ɑΉ����A����́A
%   abs(K) <= 1 �ƂȂ�ALATCFILT �� 1 �Ԗڂ̏o�͂Ƃ��čŏ��ʑ��t�B���^��
%   �������邽�߂ɗp�����܂��B
%
%   K = TF2LATC(NUM,DEN,...) �ŁADEN �́AK = TF2LATC(NUM/DEN,...) �Ɠ�����
%   �X�J���ł��B
%
%   [K,V] = TF2LATC(NUM,DEN) �́ADEN(1) �Ő��K�����ꂽ IIR (ARMA) ���e�B�X-���_�[
%   �t�B���^�ɑ΂��郉�e�B�X�p�����[�^ K �ƃ��_�[�p�����[�^ V �����߂܂��B
%   �`�B�֐��̋ɂ��P�ʉ~��ɂ���ꍇ�ɂ́A�덷��������ꍇ������܂��B
%
%   K = TF2LATC(1,DEN) �́AIIR �S�� (AR) ���e�B�X�t�B���^�ɑ΂��郉�e�B�X
%   �p�����[�^ K �����߂܂��B[K,V] = TF2LATC(B0,DEN) �́AB0 ���X�J���̏ꍇ�A
%   ���_�[�W�� V �̃x�N�g����Ԃ��܂��B���̏ꍇ�AV �̍ŏ��̗v�f�݂̂�����
%   ���邱�Ƃɒ��ӂ��Ă��������B
%
%   ��:
%   % �S�� IIR �t�B���^�����e�B�X�W���ɕϊ�:
%      DEN = [1 13/24 5/8 1/3];
%      K = tf2latc(1,DEN);  % K �� [1/4 1/2 1/3]' �ɂȂ�܂�
%
%   �Q�l LATC2TF, LATCFILT, POLY2RC and RC2POLY.


%   Copyright 1988-2007 The MathWorks, Inc.
