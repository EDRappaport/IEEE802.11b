%SPECIFYALL  �Œ菬���_�t�B���^�̐ݒ�����ׂĎw��
%
%   SPECIFYALL(Hd) �́A�t�B���^ Hd ���̂��ׂĂ̐ݒ�𒼐ڎw��ł���悤
%   �I�u�W�F�N�g�̃v���p�e�B��ݒ肵�܂��Btrue �ɐݒ肳�ꂽ���ׂĂ�
%   �I�[�g�X�P�[���I�v�V������ false �ɐݒ肳��A���ׂĂ� "modes" 
%   ('OutputMode', 'ProductMode', 'AccumMode' �̂悤��) �� 'SpecifyPrecision' 
%   �ɐݒ肳��܂��B
%
%   SPECIFYALL �́A�����̂��ׂẴv���p�e�B�� 1 �� 1 �ŕύX���邽�߂�
%   �V���[�g�J�b�g�Ƃ��ė��p����܂��B
%
%   SPECIFYALL(Hd,false) �́A��{�I�� SPECIFYALL(Hd) �̔��΂ł��B���ׂĂ�
%   �I�[�g�X�P�[���I�v�V������ true �ɐݒ肵�A"modes" �������̃f�t�H���g�l
%   �ɐݒ肵�܂��B
%
%   SPECIFYALL(Hd,true) �́ASPECIFYALL(Hd) �Ɠ����ł��B
%
%   % ��:���ڌ^�̍\���Ŏ������ꂽ FIR �t�B���^�̌Œ菬���_�ݒ�̂��ׂĂ�
%   % ���S�ɐ��䂵�܂��B 
%   f = fdesign.lowpass('N,Fp,Fst,Ast',12,0.4,0.5,20); 
%   Hd = design(f,'equiripple'); Hd.Arithmetic = 'fixed';
%   specifyall(Hd);
%
%   �Q�l DFILT/REFFILTER, DFILT/DOUBLE, DFILT/COPY.


%   Copyright 2003-2007 The MathWorks, Inc.
