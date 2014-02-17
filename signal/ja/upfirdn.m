%UPFIRDN  FIR �t�B���^�̓K�p�ƊԈ�����K�p
%
%   UPFIRDN(X,H,P,Q) �́A���� 3 �̑������͐M�� X �ɃJ�X�P�[�h�I��
%   ���s���܂��B
%         (1) P �ɂ��A�b�v�T���v�����O (0 �}��)�BP ���ݒ肳��Ă��Ȃ��ꍇ�A
%             �f�t�H���g�� 1 ���g���܂��B
%         (2) H �ɗ^����ꂽ�C���p���X�����Őݒ肳�ꂽ�t�B���^���g���� 
%             FIR �̃t�B���^�����O���s���܂��B
%         (3) Q �ɂ��_�E���T���v�����O (�T���v�����Ԉ���)�B�ݒ肳���
%             ���Ȃ��ꍇ�AQ �̓f�t�H���g�� 1 �ł��B
%   UPFIRDN �́A�|���t�F�[�Y�\�����g�p���܂��B
%
%   �ʏ�A���� X �ƃt�B���^ H �̓x�N�g���ŁA�o�͂� (�M��) �x�N�g���ł��B
%   UPFIRDN �ł́A�z������ɑ΂��āA�ȉ��̑g����������܂��BX ���s��ŁA
%   H ���x�N�g���̏ꍇ�AX �̊e��́AH �Ńt�B���^�����O���܂��BX ���x�N�g���ŁA
%   H ���s��̏ꍇ�AH �̊e�� X ���t�B���^�����O���邽�߂Ɏg���܂��B
%   X �� H �����ɍs�� (������) �̏ꍇ�AH �� i �Ԗڂ̗񂪁AX �� i �Ԗڂ�
%   ����t�B���^�����O���邽�߂Ɏg���܂��B
%
%   ���ɁA�����̑g�ݍ��킹�́A���̂悤�Ɏ��s����܂��B�o�͂̒����́A
%   Ly = ceil( ((Lx-1)*P + Lh)/Q ) �ł��邱�Ƃɒ��ӂ��Ă��������B
%   �����ŁALx = length(X)�ALh = length(H) �ł��B
%
%      ���͐M�� X        ���̓t�B���^ H    �o�͐M�� Y        �L�@
%      -----------------------------------------------------------------
%   1) ���� Lx �x�N�g��  ���� Lh �x�N�g��  ���� Ly �x�N�g��  �ʏ�g�p
%   2) Lx�~Nx �s��       ���� Lh �x�N�g��  Ly�~Nx �s��       X �̊e��� H ��
%                                                            �t�B���^�����O
%   3) ���� Lx �x�N�g��  Lh�~Nh �s��       Ly�~Nh �s��       H �̊e��� X ��
%                                                            �t�B���^�����O����
%                                                            ���߂Ɏg�p
%   4) Lx�~N �s��        Lh�~N �s��        Ly�~N �s��        H ��i�Ԗڂ̗���g���� 
%                                                            X �� i �Ԗڂ̗��
%                                                            �t�B���^�����O
%
%   UPFIRDN ���A�����ƊȒP�Ɏg���ɂ́A�t�B���^��ݒ肵����A�t�B���^�����O��
%   ��蓱�������M���̒x���⏞����K�v�̂Ȃ� RESAMPLE ���g���Ă��������B
%
%   ��: 147/160 �̃t�@�N�^�ŃT���v�����[�g��ϊ� (48kHz ���� 44.1kHz ��
%       �_�E���R���o�[�g���邽�߂Ɏg�p)
%        L = 147; M = 160;            % ���}/�Ԉ����t�@�N�^
%        N = 24*M;
%        h = fir1(N,1/M,kaiser(N+1,7.8562));
%        h = L*h; % Passband gain = L
%        Fs = 48e3;                   % �I���W�i���̃T���v�����O���g��: 48kHz
%        n = 0:10239;                 % 10240 �T���v���A 0.213 �b
%        x  = sin(2*pi*1e3/Fs*n);     % �I���W�i���M�� 1kHz �ł̐����g
%        y = upfirdn(x,h,L,M);        % 9408 �T���v���A0.213 �b
%
%        % �I���W�i�� (48kHz) �ƃ��T���v�����O���ꂽ�M�� (44.1kHz) ��ԐF�ŏd�˂�
%        stem(n(1:49)/Fs,x(1:49)); hold on
%        stem(n(1:45)/(Fs*L/M),y(13:57),'r','filled');
%        xlabel('Time (sec)');ylabel('Signal value');
%
%   �Q�l RESAMPLE, INTERP, DECIMATE, FIR1, INTFILT, Filter Design Toolbox �� 
%        MFILT/FIRSRC.


%   Copyright 1988-2007 The MathWorks, Inc.
