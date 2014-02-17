% MARCUMQ   ��ʉ� Marcum Q �֐�
%
% MARCUMQ(A,B,M) �́A���̂悤�ɒ�`������ʉ� Marcum Q �֐��ł��B
%
%      Q_m(a,b) = 1/a^(m-1) * integral from b to inf of
%                 [x^m * exp(-(x^2+a^2)/2) * I_(m-1)(ax)] dx,
%
% �����ŁAI_(m-1)() �́A���� m-1 �̑�1��̏C���x�b�Z���֐��ł��B
%
% a �� b �́A�����̔񕉂łȂ���΂Ȃ�܂���Bm �͐��̐����łȂ���΂Ȃ�܂���B
% ���͂̂����ꂩ���X�J���̏ꍇ�A���̓��͂̃T�C�Y�Ɋg������܂��B
%
% MARCUMQ(A,B) �́A���Ƃ��ƁAMarcum �ɂ��ꗗ�ɂ��ꂽ���̂ŁAM = 1 ��
% �΂��ē��ʂȂ��̂ł��B�����āA���΂��΁A�T�u�X�N���v�g�Ȃ��� Q(a,b) ��
% �L�q����邱�Ƃ�����܂��B
%
% �Q�l BESSELI.


%   Copyright 1996-2006 The MathWorks, Inc.
