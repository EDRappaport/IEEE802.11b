%FIR2  ���g���T���v�����O��@���g���� FIR �̔C�Ӑ��`�t�B���^�݌v
%
%   B = FIR2(N,F,A) �́A�x�N�g�� F ����� A �ɂ���ė^��������g��������
%   ���AN ���� FIR �f�W�^���t�B���^�� (N+1) �̌W�����܂񂾍s�x�N�g�� 
%   B ��Ԃ��܂��B�x�N�g�� F �� A �́APLOT(F,A) ����]������g��������
%   �v���b�g�������悤�ȃt�B���^�ɑ΂�����g���ƐU���̃u���[�N�|�C���g��
%   �w�肵�܂��BF �̎��g���́A0.0 <F < 1.0 �ŁA1.0 �̓T���v�����[�g�̔�����
%   �Ή����܂��BF �̍ŏ��̓_�� 0�A�Ō�̓_�� 1 �ŁA���Ԃ̓_�͑�������l��
%   �Ȃ���΂Ȃ�܂���B
%
%   �t�B���^ B �́A�����ŁA���`�ʑ��A���Ȃ킿�A�t�B���^�W���́A���̑Ώ̐���
%   ���� FIR �t�B���^�ł��BB(k) = B(N+2-k), k = 1,2,...,N+1
%
%   �f�t�H���g�ŁAFIR2 �� Hamming �E�B���h�E���g�p���܂��B���̑��A����
%   �E�B���h�E���I�v�V�����̈������w�肵�Ďg�p���邱�Ƃ��ł��܂��B
%   Boxcar, Hann, Bartlett, Blackman, Kaiser, Chebwin
%   ���Ƃ��΁AB = FIR2(N,F,M,bartlett(N+1)) �́ABartlett �E�B���h�E��
%   �g�p���܂��BB = FIR2(N,F,M,chebwin(N+1,R)) �́A�`�F�r�V�F�t�E�B���h�E��
%   �g�p���܂��B
%
%   Fs/2 �� 0 �ȊO�̃Q�C�������t�B���^�A���Ƃ��΁A�n�C�p�X�A�o���h�X�g�b�v
%   �t�B���^�́AN �������łȂ���΂Ȃ�܂���B����ȊO�̏ꍇ�́AN �� 1 ����
%   ���܂��B���̏ꍇ�A�E�B���h�E�̒����́AN+2 �Ƃ��Ďw�肷��K�v������܂��B
%
%   �Q�l FIR1, FIRLS, CFIRPM, FIRPM, BUTTER, CHEBY1, CHEBY2, YULEWALK, 
%        FREQZ, FILTER.


%   Copyright 1988-2007 The MathWorks, Inc.
