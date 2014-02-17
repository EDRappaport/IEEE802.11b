%MAXFLAT  �ł�����蕽�R�� (�ėp�o�^���[�X) �f�W�^���t�B���^�̐݌v
%
%   [B,A] = MAXFLAT(NB,NA,Wn) �́A���ꂼ��A���� NB ����� NA �̕��q�W�� 
%   B ����ѕ���W�� A �������[�p�X�o�^���[�X�t�B���^��݌v���܂��BWn �́A
%   �t�B���^�̐U�������� 1/sqrt(2) (�� -3 dB) �ƂȂ�_�ł̃J�b�g�I�t���g���ł��B
%   Wn �́A1 ���t�B���^�̃T���v�����O���g���̔����ɑΉ�������̂Ƃ��āA
%   0 �� 1 �̊ԂłȂ���΂Ȃ�܂���BNA=0 �̏ꍇ�A�t�B���^�̎��g��������
%   ���������邽�߂ɁAWn �͈̔͂͂���ɐ�������܂��B
%
%   B = MAXFLAT(NB,'sym',Wn) �́A�Ώ� FIR �o�^���[�X�t�B���^��݌v���܂��B
%   NB �͋����łȂ���΂Ȃ炸�AWn �� [0,1] �̋�Ԃɐ�������܂��BWn ��
%   ���̋�Ԃ̊O�ɐݒ肳�ꂽ�ꍇ�A�֐��̓G���[�ɂȂ�܂��B�t�B���^���� 
%   NB �� 140 ��菬�����Ȃ���΂Ȃ�܂���B
%
%   [B,A,B1,B2] = MAXFLAT(NB,NA,Wn) �� [B,A,B1,B2] = MAXFLAT(NB,'sym',Wn) �́A
%   ���̐ς����q������ B �ɓ������Ȃ� 2 �̑����� B1 �� B2 ��Ԃ��܂� 
%   (���Ȃ킿 B = CONV(B1,B2))�BB1 �� z=-1 �ł̂��ׂĂ̗�_���܂݁AB2 ��
%   ���̂��ׂĂ̗�_���܂݂܂��B
%
%   [B,A,B1,B2,SOS,G] = MAXFLAT(NB,NA,Wn) �́A�s�� SOS ���� 2 ���^�\����
%   �Q�C�� G ��Ԃ��܂��B���l�I�ȗ��R�ɂ��ASOS �� G ��p����ƕ֗���
%   �ꍇ������܂��B
%
%   �� 1:IIR �݌v
%      NB = 10; NA = 2; Wn = 0.6;
%      [b,a,b1,b2] = maxflat(NB,NA,Wn);
%      fvtool(b,a);
%   �� 2:FIR �݌v
%      NB = 10; Wn = 0.6;
%      h = maxflat(NB,'sym',Wn);
%      fvtool(h);
%
%   �݌v�̃��j�^�����O
%   ���� 'trace' ��^����ƁA�J��Ԃ��@�ł̐݌v�ߒ������|�[�g���܂��B
%   ���Ƃ��΁AMAXFLAT(NB,NA,Wn,'trace')�B�t�B���^�̐U���A�x���A��_�A�ɂ�
%   �v���b�g��\��������ɂ́AMAXFLAT(NB,NA,Wn,'plots') �̂悤�ɑ�����
%   'plots' ������^���܂��B�e�L�X�g�\���ƃv���b�g�\�������ɍs�Ȃ������ꍇ�A
%   'both' ��ݒ肵�Ă��������B
%
%   �Q�l BUTTER, FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
