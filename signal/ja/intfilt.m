%INTFILT  ��� FIR �t�B���^�݌v
%
%   B = INTFILT(L,P,ALPHA) �́AL �T���v������ L-1 �̘A������ 0 ���g��
%   �����ꂽ��Ŏg�p�����ꍇ�ɁA�ߖT�� 2*P �̔��̃T���v�����g���āA
%   �܂��A�i�C�L�X�g���g���� ALPHA �{�����I���W�i���̑ш搧���ł�����̂�
%   ���肵�āA�ш搧�����ꂽ���}���s�����`�ʑ� FIR �t�B���^��݌v���܂��B
%   B �� 2*L*P-1 �̒����ł��B
%
%   �ш搧���x�t�@�N�^ (bandlimitedness factor) �́A��Ԃ����M���ɂ��
%   �ǂꂾ���i�C�L�X�g��Ԃ���߂��邩��\���܂��B���̃t�@�N�^�́A0 ���
%   �傫���A1 �ȉ��ł��B1 ��菬�����ш搧���x�t�@�N�^�́A�M����������
%   �X�y�N�g�����e�������Ȃ��t�B���^�̎Ւf�ш���̑傫�ȑJ�ڑш�� 
%   "don't care" �̈���l�����܂��B1 �ȉ��Ɏw�肵�� ALPHA �̍ŏI���ʂ́A
%   �^����ꂽ L �� P �ɑ΂��āA�悢�Ւf�ш�̌����ɂȂ�܂��B�ȉ��̗��
%   �Q�Ƃ��Ă��������B
%
%   B = INTFILT(L,N,'Lagrange') �́AL �T���v������ L-1 �̘A������ 0 ���g��
%   �����ꂽ��� N ���̃��O�����W�F��������Ԃ����s���� FIR �t�B���^��
%   �݌v���܂��BB �� N ����̏ꍇ�A���� (N+1)*L-1 �ŁA�����̏ꍇ�A���� 
%   (N+1)*L �ł��BN �� L �̗����Ƃ������̏ꍇ�A�݌v���ꂽ�t�B���^�́A
%   ���`�ʑ��ɂ͂Ȃ�܂���B
%
%   ������̃^�C�v�̃t�B���^����{�I�Ƀ��[�p�X�ł���A�ʉߑш���� L ��
%   �Q�C���������܂��B
%
%   ��F�قȂ�ш搧���x�t�@�N�^������ 2 �̃t�B���^���r���܂��B 
%   b1 = intfilt(5,10,1);  % �M���͊��S�Ƀi�C�L�X�g��Ԃ��߂܂��B
%   b2 = intfilt(5,10,.8); % �M���̓i�C�L�X�g��Ԃ� 80% ���߂܂��B
%   hfvt = fvtool(b1,1,b2,1); 
%   legend(hfvt,'Alpha = 1','Alpha = 0.8');
%
%   �Q�l INTERP, DECIMATE, RESAMPLE, Filter Design Toolbox �� FIRHALFBAND, 
%        FIRNYQUIST, FIREQINT, MFILT.


%   Copyright 1992-2007 The MathWorks, Inc.
