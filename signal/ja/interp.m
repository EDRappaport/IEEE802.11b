%INTERP  ���[�p�X��Ԃ��g�����������[�g�ł̃f�[�^�̃��T���v�����O
%
%   Y = INTERP(X,R) �́A�x�N�g�� X �̃T���v�����O���[�g�� R �{��������
%   �����܂��B��Ԃ��ꂽ�x�N�g�� Y �́A�I���W�i���̓��� X ��� R �{����
%   �Ȃ�܂��F LENGTH(Y) = R*LENGTH(X)
%
%   �I���W�i���f�[�^��ω������Ȃ��ŁA���}�����_�Ƃ��̗��z�I�ȓ_�Ƃ̊Ԃ�
%   ���ϓ��덷���ŏ��ɂȂ�悤�ȓ��ʂȑΏ� FIR �t�B���^ B ��݌v���܂��B
%   Y = INTERP(X,R,L,CUTOFF) �́A���ꂼ��f�t�H���g�� 4 �� .5 �ł������ 
%   L �� CUTOFF ���w�肵�܂��B2*L �́A��ԂɎg�p�����I���W�i���T���v���l��
%   ���ł��B�ʏ�AL �� 10�ȉ��ɂ��Ă��������B�܂��A�t�B���^�̒����́A
%   2*L*R+1 �ł��B�I���W�i���̐M���́A���K���J�b�g�I�t���g�� 0 < CUTOFF < = 1.0 
%   �Ő������ꂽ�ш���ɂ�����̂Ɖ��肵�Ă��܂��B
%   [Y,B] = INTERP(X,R,L,CUTOFF) �́A��ԂɎg�p���ꂽ�t�B���^�W���x�N�g�� 
%   B ��Ԃ��܂��B
%
%   �Q�l DECIMATE, RESAMPLE, UPFIRDN.


%   Copyright 1988-2007 The MathWorks, Inc.
