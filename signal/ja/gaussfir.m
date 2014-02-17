%GAUSSFIR  �K�E�X FIR �p���X���`�t�B���^�̐݌v
%
%   H=GAUSSFIR(BT) �́A���[�p�X FIR �K�E�X�p���X���`�t�B���^��݌v���܂��B
%   BT �́AB �� Hz �P�ʂ̕Б��ш�AT ��b�P�ʂƂ��� 3dB �̑ш敝�V���{��
%   ���Ԃ̐ςł��B
%
%   H=GAUSSFIR(BT,NT) �� NT �́A�t�B���^�̃C���p���X�����̊J�n�_�ƃs�[�N�Ԃ�
%   �V���{���ς̐��ł��BNT ���w�肳��Ȃ��ꍇ�ANT = 3 ���g���܂��B
%
%   H=GAUSSFIR(BT,NT,OF) �� OF �́A�V���{�����̃T���v�����ƂȂ�I�[�o�[
%   �T���v�����O�v�f�ł��BOF ���w�肳��Ȃ��ꍇ�AOF = 2 ���g���܂��B
%
%   �t�B���^�̃C���p���X�����̒����́A2*OF*NT+1 �ŗ^�����܂��B����ɁA
%   �W�� H �́A�m�~�i���ȃp�X�o���h�Q�C������� 1 �ɓ������Ȃ�悤��
%   ���K������܂��B
%
%   % ��:GSM GMSK �X�L�[���𗘗p���邽�߂ɁA�K�E�X�t�B���^��݌v���܂��B
%   BT = .3; % 3dB�̑ш敝�V���{������
%   OF = 8;  % �I�[�o�[�T���v�����O�v�f (���Ƃ��΁A�V���{�����̃T���v����)
%   NT = 2;  % �t�B���^�̃s�[�N�ւ� 2 �V���{���̎���
%   h = gaussfir(BT,NT,OF);
%   hfvt = fvtool(h,'impulse');
%
%   �Q�l FIRRCOS.


%   Copyright 2004-2007 The MathWorks, Inc.
