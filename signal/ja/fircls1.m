%FIRCLS1  ��������t���ŏ����@�ɂ�郍�[�p�X&�n�C�p�X FIR �t�B���^�̐݌v
%
%   B = FIRCLS1(N,WO,DEVP,DEVS) �́A�ő�ш�΍��A�܂��̓��b�v�� (���`�̒P��) 
%   DEVP �� DEVS�A�J�b�g�I�t���g�� W0 �������� N+1 �̐��`�ʑ����[�p�X FIR 
%   �t�B���^�ł��B
%
%   W0 �� 0 �� 1 �̊� (1 �̓T���v�����O���g���̔����ɑΉ�) �ł��BDEVP �́A
%   1 ����̍ő�ʉߑш�΍������b�v�� (���`�̒P��) �ł��BDEVS �� 0 �����
%   �ő�Ւf�ш�΍������b�v�� (���`�̒P��) �ł��B
%
%   B = FIRCLS1(N,WO,DEVP,DEVS,'high') �́A�n�C�p�X�t�B���^�ł��B���̏ꍇ�A
%   ���� N �͋����łȂ���΂Ȃ�܂���B���̑��̏ꍇ�A������ 1 �ŃC���N�������g
%   ����܂��B
%
%   B = FIRCLS1(N,WO,DEVP,DEVS,WT) �� B = FIRCLS1(N,WO,DEVP,DEVS,WT,'high') �́A
%   �ʉߑш�A�܂��́A�Ւf�ш�ł̃G�b�W�̕K�v�����𖞂����܂��BWT ���ʉߑш��
%   �ꍇ�A���̃p�����[�^�̎g�p�́A|E(WT)| <= DEVP �𖞑����܂��B������ E(w) �́A
%   �덷�֐��ł��B���l�ɁAWT ���Ւf�ш�̏ꍇ�AWT �̎g�p�ɂ��A|E(WT)| <= DEVS 
%   �𖞑����܂��B������ DEVP �� DEVS �Ŕ��ɋ����ш�̃t�B���^��݌v����ꍇ�A
%   �����̎d�l�𖞂������߂ɗ^����ꂽ�����̃t�B���^�͑��݂��Ȃ��\��������
%   ���Ƃɒ��ӂ��Ă��������B
%
%   B = FIRCLS1(N,WO,DEVP,DEVS,WP,WS,K) �́A�Ւf�ш�ł̓��a�덷���A�ʉߑш��
%   ���a�덷�� K �{�ɂȂ�悤�ɏd�݂�K�p���܂��BWP �́A L2 �d�݊֐��̒ʉߑш�
%   �G�b�W�ŁAWS �͎Ւf�ш�̃G�b�W (WP < W0 < WS) �ł��B���̂悤�ɁA������ 
%   WT ��'high' �������g�p���ď����𖞑�������A�d�݊֐��Ȃ��̏ꍇ�Ɠ��l��
%   �n�C�p�X�t�B���^��݌v���܂��B���Ƃ��΁A
%      FIRCLS1(N,WO,DEVP,DEVS,WP,WS,K,WT,'high')
%   'high' �p�X�t�B���^�̏ꍇ�AWS < W0 < WP �łȂ���΂Ȃ�܂���B
%
%   �݌v�̃��j�^�����O
%      ���� 'trace' ��^����ƁA�J��Ԃ��@�ł̐݌v�ߒ������|�[�g���܂��B
%      ���Ƃ��΁AFIRCLS1(N,W0,DEVP,DEVS,...,'trace')�B�v���b�g��\��������ɂ́A
%      FIRCLS1(N,W0,DEVP,DEVS,...,'plots') �̂悤�ɑ����� 'plots' ������^���܂��B
%      �e�L�X�g�\���ƃv���b�g�\�������ɍs�Ȃ������ꍇ�A'both' ��ݒ肵�Ă��������B
%
%   ��
%      n = 55;
%      wo = 0.3;
%      dp = 0.02; ds = 0.008;
%      h = fircls1(n,wo,dp,ds);           % L2 �̏d�݂Ȃ�
%      wp = 0.28; ws = 0.32;
%      K = 10;
%      h1 = fircls1(n,wo,dp,ds,wp,ws,K);  % L2 �d��
%      fvtool(h,1,h1,1);
%
%   �Q�l FIRCLS, FIRLS, FIRPM.


%   Copyright 1988-2007 The MathWorks, Inc.
