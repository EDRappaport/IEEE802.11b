%GAUSPULS �K�E�X�ϒ������g�p���X������
%
%   YI = GAUSPULS(T,FC,BW) �́A�z�� T ���Ŏ�����鎞�Ԃɂ�����A���S���g�� 
%   FC (�w���c) �Ƒш敝 BW �����A�P�ʐU���� Gauss RF �p���X�̃T���v����
%   �Ԃ��܂��BBW �� 0 ���傫���Ȃ���΂Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%   �f�t�H���g�ł́AFC=1000 Hz �� BW=0.5 �ł��B
%
%   YI=GAUSPULS(T,FC,BW,BWR) �́A�I�v�V�����̕����ш敝�Q�ƃ��x�� BWR ��
%   �w�肵�܂��B�p���X�ш敝�́A���K�����ꂽ�M���̃s�[�N�ɂ��āABWR dB ��
%   ���x���ő��肵���Ƃ� 100*BW �p�[�Z���g�ł��B�f�t�H���g�ł́ABWR=-6 dB �ł��B
%   �ш敝�̊���x�� BWR �́A�s�[�N�P�ʕ���U�������̊���x�����������߁A
%   0 �����łȂ���΂Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   [YI,YQ] = GAUSPULS(...) �́A�����p���X�ƒ����p���X�̗�����Ԃ��܂��B
%   [YI,YQ,YE] = GAUSPULS(...) �́ARF �M���̕����Ԃ��܂��B
%
%   TC = GAUSPULS('cutoff',FC,BW,BWR,TPE) �́A�s�[�N����U���ɂ��āA
%   �㑱�̃p���X����� TPE dB ��艺�ɂȂ� 0 �ȏ�̃J�b�g�I�t���� TC ��
%   �Ԃ��܂��B�f�t�H���g�ł� TPE=-60 dB �ł��BTPE �́ABWR �ŗ^����ꂽ���̂�
%   �������R�� 0 ��菬�����Ȃ���΂Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   �f�t�H���g�l�́A��܂��͓��͈������ȗ����邱�Ƃɂ��g�p�ł��܂��B
%
%   ���Ƃ��΁A1 MHz �̃T���v�����O���[�g�ŁA60% �̑ш敝������ 50 kHz �� 
%   Gauss RF �p���X���v���b�g���܂��B������s�[�N���� 40 dB ��������
%   �Ƃ���Ńp���X��ł��؂�܂��B
%       tc = gauspuls('cutoff',50E3,.6,[],-40);
%       t  = -tc : 1E-6 : tc;
%       yi = gauspuls(t,50E3,.6); plot(t,yi)
%
%   �Q�l CHIRP, SAWTOOTH, SQUARE.


%   Copyright 1988-2007 The MathWorks, Inc.
