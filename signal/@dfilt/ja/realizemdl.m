%REALIZEMDL  �t�B���^���� (Simulink �_�C�A�O����)
%
%     REALIZEMDL(Hd) �́A���[�U��`�̎d�l�ɏ]���A�X�� sum, gain, delay �u���b�N
%     ���g���āASimulink �T�u�V�X�e���u���b�N�Ƀt�B���^ Hd �̃A�[�L�e�N�`�����f��
%     �������I�ɐ������܂��B
%
%     REALIZEMDL(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) �́A�p�����[�^/�l
%     �̑g�ݍ��킹�Ń��f���𐶐����܂��Brealizemdl �ɑ΂���L���ȃv���p�e�B�ƒl�ƁA
%     ���̃f�t�H���g�l�A���̃v���p�e�B�������s�Ȃ����̐��������̕\�Ƀ��X�g����Ă��܂��B
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
%     Blockname           {'filter'}           �V�K�T�u�V�X�e���u���b�N�ɑ΂���
%                                              ���O��^����B�f�t�H���g�ł́A
%                                              �u���b�N�� 'filter' �Ƃ������O��
%                                              �t���܂��B
%
%     OverwriteBlock      ['on' {'off'}]       Blockname �v���p�e�B�Ŏw�肳�ꂽ
%                                              ���̂Ɠ������O�Ŋ����̃u���b�N��
%                                              �㏑�����邩�A�V�K�u���b�N���쐬
%                                              ���邩���w��
%
%     OptimizeZeros       [{'on'} 'off']       ��_-�Q�C���u���b�N���폜���邩
%                                              �ǂ������w��
%
%     OptimizeOnes        [{'on'} 'off']       ���ڐڑ������P��Q�C���u���b�N��
%                                              �u�������邩�ǂ������w��
%
%     OptimizeNegOnes     [{'on'} 'off']       �ł��߂� Sum �u���b�N�ł̕�����
%                                              �ύX�������̒P��Q�C���u���b�N��
%                                              �u�������邩�ǂ������w��
%
%     OptimizeDelayChains [{'on'} 'off']       �����Ȓx����^���邽�߂ɁA�J�X�P�[�h
%                                              �Ɍq���ꂽ Delay �u���b�N��P��� 
%                                              Integer Delay �u���b�N�ɒu�������邩
%                                              �ǂ������w��
%
%    ��:
%    [b,a] = butter(4,.4);
%    Hd = dfilt.df1(b,a);
%
%    %#1 �f�t�H���g�̃V���^�b�N�X:
%    realizemdl(Hd);
%
%    %#2 �p�����[�^/�l�̑g�ݍ��킹���g�p:
%    realizemdl(Hd, 'OverwriteBlock', 'on');


%    Copyright 1988-2007 The MathWorks, Inc.
