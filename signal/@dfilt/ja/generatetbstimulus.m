%GENERATETBSTIMULUS  HDL �e�X�g�x���`�̎h���M���𐶐����ďo��
%
%   GENERATETBSTIMULUS(Hd) �́A���݂̃t�B���^�ɑ΂���ݒ�Ɋ�Â��A�t�B���^��
%   ���͂̎h���M���𐶐����܂��B�h���M���́A�C���p���X�A�X�e�b�v�A�����v�Achirp�A
%   �m�C�Y�A�܂��̓��[�U��`�̎h���M���̂����ꂩ�A���邢�͂��ׂĂ��܂�ł��܂��B
%   ���ʂ́AHd �̓��̗͂ʎq���̐ݒ���g���ėʎq������邱�Ƃɒ��ӂ��Ă��������B
%   �t�B���^ Hd �̉��Z�v���p�e�B�� 'double' �ɐݒ肳��Ă���ꍇ�A�{���x��
%   �h���M�����Ԃ���܂��B���Z�v���p�e�B�� 'fixed' �ɐݒ肳��Ă���ꍇ�A
%   �h���M���͌Œ菬���_�I�u�W�F�N�g�Ƃ��ĕԂ���܂��B
%
%   GENERATETBSTIMULUS(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) �́A
%   �p�����[�^/�l�̑g�ݍ��킹�Ńe�X�g�x���`�𐶐����܂��BGENERATETBSTIMULUS ��
%   �΂���L���ȃv���p�e�B�ƒl�́AFilter Design HDL Coder �̃h�L�������e�[�V������ 
%   "Property Reference" �̐߂Ƀ��X�g����Ă��܂��B
%
%   Y = GENERATETBSTIMULUS(Hd,...) �́AMATLAB �ϐ� Y �ւ̎h���M����Ԃ��܂��B
%
%   �o�͈����������Ȃ� GENERATETBSTIMULUS(Hd,...) �́A���݂� Figure �E�B���h�E��
%   �h���M�����v���b�g���܂��B
%
%   ��:
%   % �t�B���^�̃Z�b�g�A�b�v
%   h = firceqrip(30,0.4,[0.05 0.03]);
%   Hb = dfilt.dffir(h);
%   Hb.arithmetic = 'fixed';
%
%   % �h���M���̐����A�܂��̓v���b�g
%   % �����v�� Chirp �̎h���M���𐶐����A�ϐ� y �ɕԂ��܂��B
%   y = generatetbstimulus(Hb, 'TestBenchStimulus',{'ramp','chirp'});
%
%   % �m�C�Y�̎h���M���𐶐����A���݂� Figure �E�B���h�E�Ƀv���b�g���܂��B
%   generatetbstimulus(Hb, 'TestBenchStimulus','noise');
%
%   �Q�l GENERATEHDL, GENERATETB, FDHDLTOOL


%   Copyright 2003-2007 The MathWorks, Inc.
