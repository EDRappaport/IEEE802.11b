%SETSPECS  �t�B���^�f�U�C�i�̐݌v�d�l��ݒ�
%
%   SETSPECS(D, S1, S2, etc.) �́AD �̃R���X�g���N�^���Ŏw�肳�ꂽ���̂�
%   �������@�ŁA�t�B���^�f�U�C�i D ���̎d�l��ݒ肵�܂��BS1, S2 ���̐�����
%   ���ẮAGET(D, 'DESCRIPTION') ���g�p���Ă��������B
%
%   SETSPECS(D,...,Fs) �́AHz �P�ʂ̃T���v�����O���g�����w�肵�܂��B
%   ���̏ꍇ�A���̂��ׂĂ̎��g���̎d�l�� Hz �P�ʂɂȂ�܂��B
%
%   SETSPECS(D,...,MAGUNITS) �́A�^����ꂽ�C�ӂ̐U���̎d�l�ɑ΂���P�ʂ�
%   �w�肵�܂��BMAGUNITS �́A���̂����ꂩ�ł�:'linear', 'dB', 'squared'
%   ���̈������ȗ����ꂽ�ꍇ�A'dB' �Ɖ��肳��܂��B�U���̎d�l�́A����炪
%   �ǂ̂悤�Ɏw�肳��邩�Ɋւ�炸�A��ɕϊ�����AdB �P�ʂŊi�[�����
%   ���Ƃɒ��ӂ��Ă��������B
%
%   �f�t�H���g�ł́A���ׂĂ̎��g���̎d�l�́A���K�����ꂽ���g���P�ʂł���
%   ���̂Ɖ��肳��܂��B����ɁA���ׂĂ̐U���̎d�l�́AdB �P�ʂł�����̂�
%   ���肳��܂��B
%
%   �t�B���^�f�U�C�i D �ɑ΂��邷�ׂĂ̗��p�\�Ȏd�l�̃^�C�v�̃��X�g��
%   ����ɂ́ASET(D, 'SPECIFICATION') ���g�p���Ă��������B
%
%   % �� #1 - ���[�p�X�t�B���^�ɑ΂���d�l�̃^�C�v�̃��X�g���擾���܂��B
%   d = fdesign.lowpass;
%   set(d, 'Specification')
%
%   % �� #2 - ���K�����g�����w�肵�܂��B
%   d = fdesign.lowpass('N,Fc');
%   setspecs(d, 20, .4);
%   d
%
%   % �� #3 - Hz �P�ʂŃT���v�����O���g�����w�肵�܂��B
%   d = fdesign.lowpass('N,Fc');
%   setspecs(d, 20, 4, 20);
%   d
%
%   % �� #4 - �U���̒P�ʂ��w�肵�܂��B
%   d = fdesign.lowpass;
%   setspecs(d, .4, .5, .1, .05, 'linear');
%   d
%
%   �Q�l FDESIGN, FDESIGN/NORMALIZEFREQ.


%   Copyright 1999-2007 The MathWorks, Inc.
