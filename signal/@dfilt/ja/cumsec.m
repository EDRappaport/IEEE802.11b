%CUMSEC  �ݐς̃Z�N�V�����ɑ΂���t�B���^�̃x�N�g�����o��
%
%   H = CUMSEC(Hd) �́A�ݐς̃Z�N�V������ SOS �t�B���^�I�u�W�F�N�g�̃x�N�g����
%   �Ԃ��܂��B
%
%   H = CUMSEC(Hd, INDICES) �́A�I���W�i���̃t�B���^�ւ̃C���f�b�N�X�� 
%   INDICES �ɂ��� SOS �t�B���^�I�u�W�F�N�g�̃x�N�g����Ԃ��܂��B
%
%   H = CUMSEC(Hd, INDICES, SECONDARY) �́ASECONDARY �� true �̏ꍇ�ɂǂ�
%   �Z�N�V�����𕪗�����K�v�����邩����肷�� 2 �Ԗڂ̃X�P�[�����O�|�C���g��
%   �w�肵�܂��BSECONDARY �̓f�t�H���g�ł� false �ł��B���̃I�v�V�����́A
%   DF2SOS �� DF1TSOS �t�B���^�I�u�W�F�N�g�ł̂݌��ʂ�����܂��B������
%   �\���̂ɑ΂��āA2 �Ԗڂ̃X�P�[�����O�|�C���g�́A�ċA�Ɣ�ċA���̊� 
%   (���Ȃ킿�A�Z�N�V������ "�^��") �̈ʒu���Q�Ƃ��܂��B
%
%   �o�͈����������Ȃ� CUMSEC(Hd,...) �́AFVTOOL ���g���ėݐς̃Z�N�V������
%   �U���������v���b�g���܂��B
%
%   % ��: 6 ���� sos �t�B���^�̗ݐς̃Z�N�V�����̉������v���b�g���܂��B
%   Hs = fdesign.lowpass('N,F3db',6,.4);
%   Hd = design(Hs,'butter');
%   H = cumsec(Hd);
%   Hfvt = fvtool(H);
%   legend(Hfvt,'First section','First two sections','Overall filter');
%
%   �Q�l DFILT/SCALE, DFILT/SCALECHECK.


%   Copyright 2003-2007 The MathWorks, Inc.
