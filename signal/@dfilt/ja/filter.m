%FILTER  ���U���ԃt�B���^�̎��s ("run")
%
%   Y = FILTER(Hd,X) �́A�t�B���^�����O���ꂽ�f�[�^ Y ���쐬���邽�߂ɁA
%   ���U���ԃt�B���^�I�u�W�F�N�g Hd ���g���āA�f�[�^ X ���t�B���^�����O���܂��B
%   �ŏI������ Hd.States �Ɋi�[����܂��B
%
%   Hd.PersistentMemory �� false (�f�t�H���g) �̏ꍇ�A���������́A�t�B���^�����O
%   �̑O�� 0 �ɐݒ肳��܂��B
%
%   Hd.PersistentMemory ���U (�f�t�H���g) �̏ꍇ�A���������̓t�B���^�����O��
%   �O�� 0 �ɐݒ肳��܂��B�X�J�����w�肳�ꂽ�ꍇ�A�����������̃x�N�g����
%   �g������܂��B
%
%   X ���s��̏ꍇ�A�e��́A�Ɨ��ȃ`���l���Ƃ��ăt�B���^�����O����܂��B
%   ���̏ꍇ�A���������́AHd.States �� NSTATES(Hd) �s�� SIZE(X,2) ��̍s���
%   �ݒ肷�邱�ƂŁA�e�`���l���ɑ΂��ČX�ɍœK�Ɏw�肳��܂��BX ��������
%   �z��̏ꍇ�A�t�B���^�� 1 �Ԗڂ̔�V���O���g�������ŏ������s�Ȃ��܂��B
%
%   FILTER(Hd,X,DIM) �́A���� DIM �ɉ����ĉ��Z���s�Ȃ��܂��BX ���x�N�g���A
%   �܂��͍s��ŁADIM �� 1 �̏ꍇ�AX �̊e��́A�`���l���Ƃ��Ĉ����܂��B
%   DIM �� 2 �̏ꍇ�A�e�s�̓`���l����\���܂��B
%
%   ��:
%   x = randn(100,1);       % �I���W�i���M��
%   b = fir1(50,.4);        % 50 ���̐��`�ʑ� FIR �t�B���^
%   Hd = dfilt.dffir(b);    % ���ڌ^ FIR �����s
%
%   % ���������Ȃ�
%   y1 = filter(Hd,x);      % PersistentMemory �� false (�f�t�H���g)
%   zf = Hd.States;         % �ŏI����
%
%   % ���̏�������
%     Hd.PersistentMemory = true;
%   Hd.States = 1;          % �X�J���g���𗘗p
%     y2 = filter(Hd,x);
%   stem([y1 y2])           % ���߂̈قȂ��
%
%   % �f�[�^�̃X�g���[�~���O
%   reset(Hd);              % �t�B���^�����̃N���A
%   y3 = filter(Hd,x);      % 1 �̃u���b�N�œ��͐M���̃t�B���^�����O
%   reset(Hd);              % �t�B���^�����̃N���A
%     yloop = [];
%     xblock = reshape(x,[20 5]);
%   % �Z�N�V�������̐M�����t�B���^�����O�́A�S�̂̐M������x�Ƀt�B���^�����O
%   % ���邱�ƂƓ����ł��B
%     for i=1:5,
%       yloop = [yloop; filter(Hd,xblock(:,i))];
%     end
%
%   �Q�l DFILT/NSTATES


%   Copyright 1988-2007 The MathWorks, Inc.
