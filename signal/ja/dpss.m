%DPSS  ���U�G����]�ȉ~�̗� (Slepian ��)
%
%   [E,V] = DPSS(N,NW) �́A���� N �̍ŏ��� 2*NW �̗��U�G����]�ȉ~�̗� 
%   (DPSS) �𐶐����AE �̗�����ɏo�͂��܂��B�����āA�Ή�����W���x��
%   �x�N�g�� V �ɂ��ꂼ�ꐶ�����܂��B�����ŁA���g���ш�� |w|< = (2*pi*W) 
%   �ŁAW = NW/N �͑ш敝�̔����ŁAW �̓��W�A���P�ʂł��BE(:,1) �́A
%   ���g���ш惉�W�A�� (|w|< =(2*pi*W)) �ɏW�����钷�� N �̐M���ŁA
%   E(:,2) �́AE(:,1) �ɒ�������M���ŁA���̑ш�ɏW�����Ă��܂��B
%   �����āAE(:,3) �́AE(:,1) �� E(:,2) �ɋ��ɒ���������̂ŁA���������
%   �ш�ɏW�����Ă�����̂ł��B
%
%   Multiple Taper �X�y�N�g����͖@�ɑ΂��āANW �̎�蓾��l�́A
%   2,5/2,3,7/2,4 �̂����ꂩ�ł��B
%
%   [E,V] = DPSS(N,NW,K) �́A�v�Z���� 2*NW �̗��U�G����]�ȉ~�̗�� 
%   K �̑ш搧������ł��B[E,V] = DPSS(N,NW,[K1 K2]) �́A�v�Z���ꂽ 
%   2*NW �̗��U�G����]�ȉ~�̗�� K1 �Ԗڂ��� K2 �Ԗڂ܂ł̐����Ԃ��܂��B
%
%   [E,V] = DPSS(N,NW,'spline') �́A�X�v���C����Ԃ��g���āADPSS.mat ���� 
%   N �ɁA�ł��߂����������f�[�^�񂩂� E �� V ���v�Z���܂��B
%   [E,V] = DPSS(N,NW,'spline', Ni) �́A�����̒��� Ni �̃f�[�^�񂩂��Ԃ��܂��B
%   DPSS(N,NW,'linear') ����сADPSS(N,NW,'linear',Ni) �́A���`��Ԃ�
%   �g�p���܂��B����́A�X�v���C����Ԃ��͂邩�ɍ����ł����A���x�����܂��B
%   'linear' �́ANi>N �ł��邱�Ƃ��K�v�ł��B[E, V] = DPSS(N,NW,'calc') �́A
%   ���ڃA���S���Y�� (�f�t�H���g) ���g���܂��B
%
%   DPSS(N,NW,'trace') �́A���� 'trace' ���g���āADPSS ���g�p������@��
%   �T���܂��B
%
%   �Q�l PMTM, DPSSLOAD, DPSSDIR, DPSSSAVE, DPSSCLEAR.


%   Copyright 1988-2007 The MathWorks, Inc.
