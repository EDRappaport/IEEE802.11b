%SOS2SS  2 ���\������ԋ�Ԍ^�֕ϊ�
%
%   [A,B,C,D]=SOS2SS(SOS,G) �́A�Q�C�� G �� 2 ���\���̍s�� SOS ��^���āA
%   ���U���ԃV�X�e���̏�ԋ�ԍs�� A,B,C,D ��Ԃ��܂��B
%
%   SOS �́A���̂悤�ɍ\������� L �s 6 ��̍s��ŁASOS �̊e�s�ɂ� 
%   2 ���\���V�X�e���̌W�����܂܂�܂��B
%       SOS = [ b01 b11 b21  1 a11 a21
%               b02 b12 b22  1 a12 a22
%               ...
%               b0L b1L b2L  1 a1L a2L ]
%   �V�X�e���̓`�B�֐��́A2 ���\���V�X�e���̓`�B�֐��ƃQ�C�� G �̐ςɂȂ�܂��B
%   G ���ݒ肳��Ă��Ȃ��ꍇ�A�f�t�H���g�� 1 �ł��BSOS �s��̊e�s�́A�ȉ��� 
%   2 ���^�`���̓`�B�֐���\���Ă��܂��B
%       b0k +  b1k z^-1 +  b2k  z^-2
%       ----------------------------
%       1 +  a1k z^-1 +  a2k  z^-2
%   �����ŁAk �͍s�C���f�b�N�X�ł��B
%
%   �Q�l SS2SOS, ZP2SOS, SOS2ZP, SOS2TF


%   Copyright 1988-2007 The MathWorks, Inc.