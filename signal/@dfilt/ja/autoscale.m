%AUTOSCALE  �_�C�i�~�b�N�����W�̃X�P�[�����O
%
%   AUTOSCALE(Hd,X) �́A�t�B���^ Hd �̊e�m�[�h�ɑ΂��ă_�C�i�~�b�N�����W��
%   �X�P�[�����O��^���܂��B���̃��\�b�h�́A���������_�̃t�B���^��ʂ���
%   �M�� X �����s���A�V�~�����[�V�����͈̔͂��J�o�[���Đ��x���ő剻�����
%   �悤�ȏ������̒�����ݒ肷�邽�߂ɁA�V�~�����[�V�������瓾��ꂽ�f�[�^��
%   �ő�ƍŏ����g�p���܂��B�꒷�͕ύX����܂���B
%
%   HNEW = AUTOSCALE(Hd,X) �́A�o�͂��v�����ꂽ�ꍇ�A�V�K�t�B���^�̓X�P�[�����O
%   ���ꂽ�������̒����Ő�������A�I���W�i���̃t�B���^�͕ύX����܂���B
%
%   % ��:�o���h�p�X IIR �ȉ~�t�B���^�̃I�[�g�X�P�[��
%   Hd = design(fdesign.bandpass, 'ellip');
%   Hd = convert(Hd, 'latticearma');
%   Hd.Arithmetic = 'fixed';
%   rand('state', 4)
%   x = rand(100,10);
%   Hd(2) = autoscale(Hd,x);
%   hfvt = fvtool(Hd,'Analysis','magestimate','Showreference','off');
%   legend(hfvt,'Before Autoscaling', 'After AutoScaling')
%
%   ���ڂ�����ɂ��ẮA<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\iirautoscaledemo.html'])">Fixed-Point Scaling of an Elliptic IIR Filter</a>
%   �� <a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\iirfloat2fixeddemo.html'])">Floating-point to Fixed-Point Conversion of IIR Filters</a> 
%   �̃f�����Q�Ƃ��Ă��������B
%
%   �Q�l DFILT


%   Copyright 2006-2007 The MathWorks, Inc.
