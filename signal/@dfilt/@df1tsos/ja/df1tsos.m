% DF1TSOS   ���ڌ^I�]�u�\���A2���^
%
% Hd = DFILT.DF1TSOS(S) �́AS �s��ŗ^����ꂽ�W�������A���U���Ԃ�
% 2���^�A���ڌ^I�̓]�u�\���̃t�B���^�I�u�W�F�N�g Hd ���o�͂��܂��B
% 
% Hd = DFILT.DF1TSOS(b1,a1,b2,a2,...) �́A1�Ԗڂ̃Z�N�V������ b1 �� a1 
% �̃x�N�g���ŗ^�����A2�Ԗڂ̃Z�N�V������ b2 �� a2 �̃x�N�g���ŗ^��
% ����悤�Ȃ��W�������A���U���ԂŁA2���^�A���ڌ^I�̓]�u�\����
% �t�B���^�I�u�W�F�N�g Hd ���o�͂��܂��B
% 
% Hd = DFILT.DF1TSOS(...,g) �́A�Q�C���x�N�g�� g ���܂݂܂��Bg �̗v�f��
% �e�Z�N�V�����̃Q�C���ł��Bg �̍ő咷�̓Z�N�V�������{1�ł��Bg ���w��
% ����Ȃ��ꍇ�A���ׂẴQ�C���̓f�t�H���g��1�ł��B
%
% % ���: 6���̃��[�p�X�ȉ~�t�B���^�̐݌v�ɂ��W�������A���ڌ^I��
% %       �]�u�\���A2���^�̗��U���ԃt�B���^
%   [z,p,k] = ellip(6,1,60,.4);                                                  
%   [s,g] = zp2sos(z,p,k);                                                     
%   Hd = dfilt.df1tsos(s,g)  
%
% �Q�l DFILT/DF1T, DFILT/DF1, DFILT/DF1SOS, DFILT/DF2
%        DFILT/DF2SOS, DFILT/DF2T, DFILT/DF2TSOS.
  

%   Author: Thomas A. Bryan
%   Copyright 1988-2004 The MathWorks, Inc.
