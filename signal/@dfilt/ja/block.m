%BLOCK  �t�B���^�I�u�W�F�N�g�Ɠ����� DSP System Toolbox �̃u���b�N�𐶐�
%
%   BLOCK(Hd) �́AHd �Ɠ����� DSP System Toolbox �̃u���b�N�𐶐����܂��B
%
%   BLOCK(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) �́A�p�����[�^/�l�̑g
%   �ݍ��킹�Ŏw�肳�ꂽ�I�v�V�������g���� DSP System Toolbox �̃u���b�N
%   �𐶐����܂��B���p�\�ȃp�����[�^�͎��̂Ƃ���ł�:
%
%     -------------       ---------------      ----------------------------
%     �v���p�e�B��        �v���p�e�B�l         ����
%     -------------       ---------------      ----------------------------
%     Destination         [{'current'}         �u���b�N�����݂� Simulink ���f����
%                          'new'               �ǉ�����A�u���b�N���܂ސV�K���f����
%                          <user defined>]     �쐬����A�܂��́A�^�[�Q�b�g��
%                                              �T�u�V�X�e���̖��O���w�肷�邩
%                                              �ǂ������w��
%
%     Blockname           {'filter'}           �V�K�T�u�V�X�e���u���b�N�ɑ΂��閼�O
%                                              ��^����B�f�t�H���g�ł́A�u���b�N�� 
%                                              'filter' �Ƃ������O���t���܂��B
%
%     OverwriteBlock      ['on' {'off'}]       Blockname �v���p�e�B�Ŏw�肳�ꂽ
%                                              ���̂Ɠ������O�Ŋ����̃u���b�N��
%                                              �㏑�����邩�A�V�K�u���b�N���쐬
%                                              ���邩���w��
%
%     MapStates           ['on' {'off'}]       �u���b�N�̏��������Ƃ��ăt�B���^��
%                                              ��Ԃ��}�b�v���邩�ǂ������w��
%
%     Link2Obj            ['on' {'off'}]       �W���l��ݒ肷����u���b�N��
%                                              �}�X�N���̃t�B���^�ϐ���ݒ肷�邩
%                                              �ǂ������w��
%
%    ��:
%    [b,a] = butter(5,.5);
%    Hd = dfilt.df1(b,a);
%
%    %#1 �f�t�H���g�̃V���^�b�N�X:
%    block(Hd);
%
%    %#2 �p�����[�^/�l�̑g�ݍ��킹���g�p:
%    block(Hd, 'Blockname', 'DF1');


% Copyright 1988-2011 The MathWorks, Inc.
