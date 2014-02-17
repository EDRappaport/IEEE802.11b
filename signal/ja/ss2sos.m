%SS2SOS  ��ԋ�Ԍ^�� 2 ���\���֕ϊ�
%
%   [SOS,G] = SS2SOS(A,B,C,D) �́A�P���͒P�o�͏�ԋ�ԍs�� A�AB�AC�AD ��
%   ������ 2 ���\���̍s�� SOS �ƃQ�C�� G �����߂܂��B�V�X�e�� A�AB�AC�AD 
%   �̗�_�Ƌɂ́A���𕡑f���̑g�łȂ���΂Ȃ�܂���B
%
%   [SOS,G] = SS2SOS(A,B,C,D,IU) �́A�����͒P�o�͂̏�ԋ�ԍs�� A�AB�AC�AD �� 
%   IU �Ԗڂ̓��͂��g�p���܂��B
%
%   SOS �́A���̍\�������� L�~6 �̍s��ł��B
%       SOS = [ b01 b11 b21  1 a11 a21
%               b02 b12 b22  1 a12 a22
%               ...
%               b0L b1L b2L  1 a1L a2L ]
%
%   �s�� SOS �̊e�s�́A2 ���\���̓`�B�֐���\���܂�:
%                 b0k +  b1k z^-1 +  b2k  z^-2
%       Hk(z) =  ----------------------------
%                  1 +  a1k z^-1 +  a2k  z^-2
%   �����ŁAk �͍s�C���f�b�N�X�ł��B
%
%   G �́A�V�X�e���S�̂̃Q�C�����߂�X�J���ł��BG ���w�肳��Ȃ��ꍇ�A
%   �Q�C���͍ŏ��̃Z�N�V�����ɑg�ݍ��܂�Ă��܂��B2 ���\���́A�V�X�e�� H(z) 
%   �Ƃ��Ă��̂悤�ɋL�q����܂�:
%       H(z) = G*H1(z)*H2(z)*...*HL(z)
%
%   ����:���ڌ^ II �\���̃X�P�[�����O�̍ۂɍŏ��̍\���̃Q�C����g�ݍ���
%   ���Ƃ͐�������܂���B�ُ�ȃX�P�[�����O�ɂȂ�ꍇ������܂��B�Q�C����
%   �g�ݍ��݂��������ɂ́A2 �̏o�͂��g���� ss2sos ���g�p���Ă��������B
%
%   SS2SOS(...,DIR_FLAG) �́A2 ���\���̏��Ԃ��w�肵�܂��BDIR_FLAG ='UP' �̏ꍇ�A
%   �ŏ��̍s�́A���_�ɍł��߂��ɂ��܂݁A�Ō�̍s�́A�P�ʉ~�ɍł��߂��ɂ�
%   �܂݂܂��BDIR_FLAG = 'DOWN' �̏ꍇ�A���̏��Ԃ́A'UP' �̋t�ɂȂ�܂��B
%   ��_�͏�ɂ����ɍł��߂��ɂ̑g�ݍ��킹�ɂȂ�܂��BDIR_FLAG �̃f�t�H���g�� 
%   'UP' �ł��B
%
%   SS2SOS(...DIR_FLAG,SCALE) �́A���ׂĂ� 2 ���\���̃Q�C���ƕ��q�W���ɑ΂��āA
%   ��]����X�P�[�����O���s���܂��BSCALE �́A���ꂼ��A�X�P�[�����O�����Ȃ��A
%   �����m�����̃X�P�[�����O�A2-�m�����̃X�P�[�����O�ɑΉ����� 'NONE', Inf, 2 
%   �̂����ꂩ�ɂȂ�܂��BSCALE �́A�f�t�H���g�� 'NONE' �ł��B�t�B���^�́A
%   2 �m�����܂��͖����m�����̈Ӗ��ł̓X�P�[�����O�̂��߂Ɉ���łȂ���΂Ȃ�܂���B
%   ���Ԃ�ݒ肷����� 'UP' �𖳌���m�����̃X�P�[�����O�@�Ƌ��Ɏg�p���邱�Ƃɂ��A
%   �����̒��ŃI�[�o�t���[�̉\�����ŏ����ɂ��܂��B����A'DOWN' �̏��� 2-�m������
%   �X�P�[�����O���g�p����ƁA�s�[�N�̊ۂ߃m�C�Y���ŏ������܂��B
%
%   ����:�����m������ 2-�m�����X�P�[�����O�́A���ڌ^ II �\���ɑ΂��Ă̂ݓK�؂ł��B
%
%   �Q�l ZP2SOS, SOS2ZP, SOS2TF, SOS2SS, tf2SOS, CPLXPAIR.


%   Copyright 1988-2007 The MathWorks, Inc.