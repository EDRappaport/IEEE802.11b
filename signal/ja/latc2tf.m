%LATC2TF  ���e�B�X�t�B���^��`�B�֐��ɕϊ�
%
%   [NUM,DEN] = LATC2TF(K,V) �́A���e�B�X�W�� K �ƃ��_�[�W�� V ������ 
%   IIR �t�B���^���番�q NUM�A���� DEN �����`�B�֐������߂܂��B
%
%   [NUM,DEN] = LATC2TF(K,'allpole') �ł́AK �͑S�� IIR ���e�B�X�t�B���^��
%   �Ή�������̂Ɖ��肵�܂��B
%
%   [NUM,DEN] = LATC2TF(K,'allpass') �ł́AK �̓I�[���p�X�� IIR ���e�B�X
%   �t�B���^�ɑΉ�������̂Ɖ��肵�܂��B
%
%   NUM = LATC2TF(K) �� NUM = LATC2TF(K,'fir') �́AK �� FIR �t�B���^�\����
%   �Ή����A�\���̂̏o�͂̏㑤�����p�������̂Ɖ��肵�܂� (FIR �̏ꍇ�� 
%   LATCFILT �� 1 �Ԗڂ̏o�͂ɑΉ�)�B
%
%   NUM = LATC2TF(K,'min') �́Aabs(K) <= 1 �̂Ƃ��AK ���ŏ��ʑ� FIR ���e�B�X
%   �t�B���^�\���ɑΉ�������̂Ɖ��肵�܂��B
%
%   NUM = LATC2TF(K,'max') �́Aabs(K) <= 1 �Ƃ��āAK ���ő�ʑ� FIR ���e�B�X
%   �t�B���^�\���ɑΉ����A�\���̏o�͂̉��������p�������̂Ɖ��肵�܂� 
%   (FIR �̏ꍇ�� LATCFILT �� 2 �Ԗڂ̏o�͂ɑΉ�)�B
%
%   �Q�l LATCFILT AND TF2LATC.


%   Copyright 1988-2007 The MathWorks, Inc.
