%SCALE  2 ���^�X�P�[�����O
%
%   SCALE(Hd) �́AHd ���Œ菬���_���Z���[�h�̏ꍇ�A�I�[�o�[�t���[�̉\����
%   ���炷���߂ɁA�s�[�N�̐U�������̃X�P�[�����O (L-��) ���g���� 2 ���^�t�B���^ 
%   Hd ���X�P�[�����O���܂��B
%
%   HNEW = SCALE(Hd,Pnorm) �́A�o�͂��v�����ꂽ�ꍇ�A�V�K�t�B���^�̓X�P�[�����O
%   ���ꂽ 2 ���^�Ő�������A�I���W�i���̃t�B���^�͕ύX����܂���B
%
%   SCALE(Hd,Pnorm) �́A�t�B���^���X�P�[�����O���邽�߂Ɏg����m�������w��
%   ���܂��BPnorm �́A���U���ԗ̈�A�܂��͎��g���̈�̃m�����̂����ꂩ�ł��B
%   �L���Ȏ��ԗ̈�̃m�����́A'l1','l2', 'linf' �ł��B�L���Ȏ��g���̈�̃m����
%   �́A'L1','L2', 'Linf' �ł��BL2-�m�����́Al2-�m�����Ɠ������ł� (�p�[�Z�o��
%   �̒藝) ���A�������Ƃ́A���̃m�����ɑ΂��Ă͐������Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   �قȂ�m�����́A���̂悤�ɂǂ̂��炢�����ł��邩�̍��ŏ��ԕt�����܂�:
%   'l1' >= 'Linf' >= 'L2' = 'l2' >= 'L1' >= 'linf'
%   �ł������ȃX�P�[�����O 'l1' ���g�p����ƁA�t�B���^�́A�I�[�o�[�t���[��
%   �ŏ��ɂ��悤�Ƃ��܂����A�ň��̐M��-�G�� (SN) ��ɂ��Ȃ�܂��B
%   Linf �X�P�[�����O�́A���ۂɍł���ʓI�Ɏg����X�P�[�����O�ł��B
%
%   SCALE(Hd,Pnorm,P1,V1,P2,V2,...) �́A�p�����[�^-�l�̑g�ݍ��킹�ɂ��A
%   �I�v�V�����̃X�P�[�����O�p�����[�^���w�肵�܂��B�L���ȑg�ݍ��킹��
%   ���̒ʂ�ł�:
%   �p�����[�^              �f�t�H���g  ����/�L���Ȓl
%   ---------               -------     ------------------------
%   'sosReorder'            'auto'      �X�P�[�����O�̑O�ɃZ�N�V������
%                                       ���ёւ���B
%                                       {'auto','none','up','down','lowpass',
%                                       'highpass','bandpass','bandstop'}
%   'MaxNumerator'          2           ���q�W���̍ő�l
%   'NumeratorConstraint'   'none'      {'none', 'unit', 'normalize','po2'}
%   'OverflowMode'          'wrap'      {'wrap','saturate'}
%   'ScaleValueConstraint'  'unit'      {'unit','none','po2'}
%   'MaxScaleValue'         'Not used'  �X�P�[���l�̍ő�l
%
%   �����I�ȕ��ёւ��́AHd �� FDESIGN ���g���Đ݌v���ꂽ���ʂ��瓾��ꂽ�ꍇ
%   �̂ݗL���ɂȂ�܂��B�Z�N�V�����́A�݌v�̉����^�C�v (���[�p�X�A�n�C�p�X��) 
%   �Ɉˑ����Ď����I�ɕ��ёւ����܂��B
%
%   'MaxScaleValue' �́A'ScaleValueConstraint' �� 'unit' �ȊO�̉����ɐݒ�
%   ����Ă���ꍇ�ɂ̂ݎg���܂��B'MaxScaleValue' �������ɐݒ肳���ꍇ�A
%   'ScaleValueConstraint' �� 'none' �ɕύX����܂��B
%
%   Hd �� 'Arithmetic' �v���p�e�B�� 'double' �܂��� 'single' �ɐݒ肳���ꍇ�A
%   �������f�t�H���g�l�́A�w�肳��Ȃ����ׂẴI�v�V�����ɑ΂��Ďg���܂��B
%   'Arithmetic' �v���p�e�B�� 'fixed' �ɐݒ肳���ꍇ�A�X�P�[�����O�I�v�V����
%   �ɑ΂��Ďg����l�́AHd �̐ݒ�ɏ]���Đݒ肳��܂��B�������A�X�P�[�����O
%   �I�v�V������ Hd �̐ݒ�ƈ���Ďw�肳�ꂽ�ꍇ�A���̃I�v�V�����̓X�P�[�����O��
%   �ړI�̂��߂Ɏg���܂����AHd �̐ݒ�͕ύX����܂���B
%
%   SCALE(Hd,Pnorm,OPTS) �́A�w�肷��p�����[�^-�l�̑g�ݍ��킹�� lieu ����
%   �I�v�V�����̃X�P�[�����O�p�����[�^���w�肷�邽�߂ɁA�I�v�V�����̃I�u�W�F�N�g
%   ���g�p���܂��BOPTS �I�u�W�F�N�g�́AOPTS = SCALEOPTS(Hd) �ō쐬�ł��܂��B
%
%     % ��:���[�p�X�̑ȉ~�t�B���^�� Linf �m�����̃X�P�[�����O:
%     Hs = fdesign.lowpass; % �t�B���^�݌v�d�l�̃I�u�W�F�N�g���쐬
%     Hd = design(Hs,'ellip');       % �ȉ~ SOS �t�B���^��݌v
%     scale(Hd,'Linf','ScaleValueConstraint','none','MaxScaleValue',1);
%
%   �Q�l DFILT/SCALEOPTS, DFILT/SCALECHECK, DFILT/REORDER, 
%        DFILT/CUMSEC, DFILT/NORM, FDESIGN.


%   Copyright 1988-2007 The MathWorks, Inc.
