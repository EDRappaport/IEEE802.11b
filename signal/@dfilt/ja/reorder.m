%REORDER  �Z�N�V�����̕��ёւ�
%
%   REORDER(HD, ORDER) �́AORDER ���̃C���f�b�N�X�̃x�N�g�����g���āA
%   �t�B���^�̃Z�N�V��������ёւ��܂��BORDER �́A�t�B���^�̃C���f�b�N�X��
%   ���ׂĂ��܂ޕK�v�͂���܂���B����́A�t�B���^���猩����Ȃ��C���f�b�N�X
%   ���폜���܂��B�_���z��́A�t�B���^����̃Z�N�V�������폜���邽�߂Ɏg�p
%   ���邱�Ƃ��ł��܂����A���ёւ����s�Ȃ��܂���B
%
%   HNEW = REORDER(HD, ORDER) �́A�o�͂��v�����ꂽ�ꍇ�A�V�K�t�B���^��
%   �V�K�Z�N�V�����̕��тŐ�������A�I���W�i���̃t�B���^�͕ύX����܂���B
%
%   REORDER(HD, NUMORDER, DENORDER) �́ANUMORDER �� DENORDER �̂��ꂼ���
%   �C���f�b�N�X�̃x�N�g�����g���āA�ʁX�ɕ��q�W���ƕ���W������ёւ��܂��B
%   �����̃x�N�g���͓��������łȂ���΂Ȃ�܂���B
%
%   REORDER(HD, NUMORDER, DENORDER, SVORDER) �́AScaleValues ��Ɨ��ɕ���
%   �ւ��邱�Ƃ��ł��܂��BSVORDER ���w�肳��Ă��Ȃ��ꍇ�AScaleValues ��
%   ���q�W���ŕ��ёւ����܂��B�o�͂̃X�P�[���l�́ANUMORDER ���X�P�[���l��
%   ���ёւ��邽�߂Ɏg����ꍇ�A��ɍŌ�̒l���c��܂��B
%
%   REORDER(HD, FILTER_TYPE) �� FILTER_TYPE �͂��̂����ꂩ�ł�: 
%   'auto','lowpass', 'highpass', 'bandpass', 'bandstop'�B�^����ꂽ
%   �t�B���^�^�C�v�ɓK�������@�� HD ����ёւ��܂��B���̃��[�h�́A�Œ�
%   �����_�̎������Ӑ}���Ă���A�Z�N�V�����̕��ёւ��́A�t�B���^�̎��s��
%   �����đ傫�ȉe���������܂��B
%
%   �����I�ȕ��ёւ��́AHd �� FDESIGN ���g���Đ݌v���ꂽ���ʂ��瓾��ꂽ
%   �ꍇ�̂ݗL���ɂȂ�܂��B�Z�N�V�����́A�݌v�̉����^�C�v (���[�p�X�A
%   �n�C�p�X��) �Ɉˑ����Ď����I�ɕ��ёւ����܂��B
%
%   REORDER(HD, DIR_FLAG) �́ADIR_FLAG ='UP' �̏ꍇ�A1 �Ԗڂ̃Z�N�V�����́A
%   ���_�ɍł��߂��ɂ��܂݁A�Ō�̍s�́A�P�ʉ~�ɍł��߂��ɂ��܂݂܂��B
%   DIR_FLAG = 'DOWN' �̏ꍇ�A���̏��Ԃ́A'UP' �̋t�ɂȂ�܂��B��_�͏��
%   �����ɍł��߂��ɂƂ̑g�ݍ��킹�ɂȂ�܂��B
%
%   REORDER(HD, DIR_FLAG, SV) �� SV �́AScaleValues ���ǂ̂悤�ɕ��ёւ���
%   �K�v�����邩������������ 'poles' �܂��� 'zeros' �̂����ꂩ�ɂȂ�܂��B
%   �f�t�H���g�ł́A�X�P�[���l�́ADIR_FLAG �I�v�V�������g�p����ꍇ�͕���
%   �ւ����܂���B
%
%   % ��
%   % �����I�ȕ��ёւ����g�p���܂��B
%   Hs = fdesign.lowpass('N,F3db',15, .5);
%   Hd = design(Hs,'butter');
%   reorder(Hd,'auto');
%
%   % 2 �Ԗڂ̃Z�N�V������ 7 �Ԗڂ� 8 �Ԗڂ̃Z�N�V�����ԂɈړ����邱�Ƃ�
%   % �Z�N�V�����̕��ёւ����s�Ȃ��܂��B
%   reorder(Hd, [1 3:7 2 8]);
%   hfvt = fvtool(Hd, 'Analysis', 'coefficients');
%
%   % 3 �Ԗڂ� 4 �Ԗڂ� 7 �Ԗڂ̃Z�N�V�������폜���܂��B
%   Hd1 = reorder(Hd, logical([1 1 0 0 1 1 0 1]));
%   setfilter(hfvt, Hd1);
%
%   % 1 �Ԗڂ̃Z�N�V�������Ō�Ɉړ����A8 �Ԗڂ̃Z�N�V�������폜���܂��B
%   Hd2 = reorder(Hd, [2:7 1]);
%   setfilter(hfvt, Hd2);
%
%   % ���q�W���ƕ���W����Ɨ��Ɉړ����܂��B
%   Hd3 = reorder(Hd, [1 3:8 2], [1:8]);
%   setfilter(hfvt, Hd3);
%
%   �Q�l DFILT/CUMSEC, DFILT/SCALE, DFILT/SCALECHECK, FDESIGN.


%   Copyright 1988-2007 The MathWorks, Inc.
