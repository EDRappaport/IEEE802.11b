%DESIGNMETHODS  �t�B���^�f�U�C�i�ɑ΂��ė��p�\�Ȑ݌v���\�b�h��Ԃ�
%
%   M = DESIGNMETHODS(D) �́A�t�B���^�f�U�C�i D �ƌ��݂� 'Specification' ��
%   �΂��闘�p�\�Ȑ݌v���\�b�h��Ԃ��܂��B
%
%   M = DESIGNMETHODS(D, 'default') �́A�t�B���^�f�U�C�i D �ƌ��݂� 
%   'Specification' �ɑ΂���f�t�H���g�̐݌v���\�b�h��Ԃ��܂��B
%
%   M = DESIGNMETHODS(D, TYPE) �́A������ 'fir' �܂��� 'iir' �Ŏw�肳�ꂽ 
%   FIR �܂��� IIR �݌v���\�b�h�̂����ꂩ��Ԃ��܂��B�f�t�H���g�ł́A
%   ���ׂĂ̐݌v���\�b�h��������܂��B
%
%   M = DESIGNMETHODS(D, 'full') �́A���ꂼ��̗��p�\�Ȑ݌v���\�b�h��
%   �΂��銮�S�Ȗ��O��Ԃ��܂��B�Ⴆ�΁A'butter' �́A'Butterworth' �ɂȂ�܂��B
%
%   % �� #1 - ���[�p�X�̃t�B���^�f�U�C�i���쐬���A���̐݌v���\�b�h���m�F���܂��B
%   d = fdesign.lowpass('N,Fc',10,12000,48000)
%   m = designmethods(d)
%
%   % �� #2 - �d�l��ύX���A�X�V�������\�b�h���m�F���܂��B
%   d.Specification = 'Fp,Fst,Ap,Ast';
%   m2 = designmethods(d)
%   m3 = designmethods(d, 'iir')
%   m4 = designmethods(d, 'iir', 'full')
%
%   % �� #3 - ����̃��\�b�h�̃w���v���擾���܂��B
%   help(d, m2{1})
%
%   �Q�l FDESIGN, FDESIGN/DESIGN, FDESIGN/DESIGNOPTS, FDESIGN/HELP.


%   Copyright 1999-2007 The MathWorks, Inc.
