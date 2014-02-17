%DESIGN  �d�l����t�B���^��݌v
%
%   H = DESIGN(D) �́AD �̎d�l����t�B���^ H ��݌v���܂��B�A���S���Y���́A
%   �^����ꂽ�d�l�ɑ΂��ė��p�\�Ȃ��̂���I������܂��B
%
%   DESIGN(...) �́A�݌v�����t�B���^���������邽�߂� FVTool ���N�����܂��B
%
%   H = DESIGN(D, 'FIR') �́AFIR �݌v���s���܂��B���̃��\�b�h�́A���p�\�� 
%   FIR �݌v���Ȃ��ꍇ�A�G���[�ɂȂ�܂��B
%
%   H = DESIGN(D, 'IIR') �́AIIR �݌v���s���܂��B���̃��\�b�h�́A���p�\�� 
%   IIR �݌v���Ȃ��ꍇ�A�G���[�ɂȂ�܂��B
%
%   H = DESIGN(D, 'ALL') �́A�d�l�ɑ΂��ė��p�\�Ȑ݌v�̂��ׂĂ��g���ĕ�����
%   �t�B���^��݌v���܂��B
%
%   H = DESIGN(D, 'ALLFIR') �́A�d�l�ɑ΂��ė��p�\�� FIR �݌v�̂��ׂĂ�
%   �g���ĕ����̃t�B���^��݌v���܂��B
%
%   H = DESIGN(D, 'ALLIIR') �́A�d�l�ɑ΂��ė��p�\�� IIR �݌v�̂��ׂĂ�
%   �g���ĕ����̃t�B���^��݌v���܂��B
%
%   H = DESIGN(D, METHOD) �́A������ METHOD �Ŏw�肳�ꂽ�݌v���\�b�h���g���܂��B
%   METHOD �́A<a href="matlab:help fdesign/designmethods">designmethods</a> �ŕԂ���镶�����
%   �����ꂩ�łȂ���΂Ȃ�܂���B�f�t�H���g�Ŏg����A���S���Y�����`����ɂ́A
%   designmethods(D,'default') ���g�p���Ă��������B
%
%   H = DESIGN(D, METHOD, PARAM1, VALUE1, PARAM2, VALUE2, etc.) �́A
%   �݌v���\�b�h�̓���̃I�v�V�������w�肵�܂��B�I�v�V�����̓��͂̏ڍׂ́A
%   <a href="matlab:help fdesign/help">help(D, METHOD)</a> ���g�p���Ă��������B
%
%   H = DESIGN(D, METHOD, OPTS) �́A�\���� OPTS ���g���āA�݌v���\�b�h��
%   ����̃I�v�V�������w�肵�܂��BOPTS �́A�ʏ� <a href="matlab:help fdesign/designopts">designopts</a> 
%   ���瓾���A�C������A���̌�ADESIGN �ɓ��͂Ƃ��Ďw�肳��܂��B
%   �I�v�V�����̓��͂̏ڍׂ́A<a href="matlab:help fdesign/help">help(D, METHOD)</a> ���g�p���Ă��������B
%
%   % �� #1 - �f�t�H���g (�����b�v��) ���\�b�h���g���ăt�B���^��݌v���A
%   %         FVTool �Ńt�B���^�̉������������܂��B
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',.2, .22, 1, 60);
%   Hd = design(d)
%   fvtool(Hd)
%   designmethods(d,'default')
%
%   % �� #2 - �^����ꂽ�d�l�ɑ΂��ĉ\�Ȃ��ׂĂ� IIR ��݌v���܂��B
%   Fs = 48e3; % �T���v�����O���g���� 48 kHz
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',10000,11000,0.5,80,Fs);
%   designmethods(d, 'iir')
%   Hd = design(d, 'alliir'); % Hd �� IIR �t�B���^�̃x�N�g���ł�
%   fvtool(Hd)
%
%   % �� #3 - Kaiser �E�B���h�E�̃n�C�p�X FIR �t�B���^��݌v���܂��B 
%   d  = fdesign.highpass('Fst,Fp,Ast,Ap',0.35, 0.4,74,1);
%   Hd = design(d, 'kaiserwin');
%   fvtool(Hd)
%
%   % �� #4 - �X�����Ւf�ш������ 50 ���̓����b�v�� FIR �t�B���^��
%   %         �݌v���܂��B�ڍׂ́Ahelp(d, 'equiripple') �Ɠ��͂��Ă������� (*)
%   d = fdesign.lowpass('N,Fc,Ap,Ast',50, 0.4, 0.8, 80); 
%   Hd = design(d, 'equiripple', 'StopbandShape', 'linear', 'StopbandDecay', 40); 
%   fvtool(Hd)
%
%   % �� #5 - ��� FIR ���\�b�h���g���ă��[�p�X�t�B���^��݌v���܂� (*)
%   d = fdesign.decimator(4,'lowpass','Fp,Fst,Ap,Ast',.2, .22, 1 ,60);
%   opts = designopts(d,'ifir');
%   opts.JointOptimization = true;
%   Hd = design(d,'ifir',opts); % Hd �́A2 �̒���� FIR �t�B���^�ɂȂ�܂�
%   fvtool(Hd)
%
%   (*) Filter Design Toolbox ���K�v
%
%   �Q�l FDESIGN, FDESIGN/DESIGNMETHODS, FDESIGN/DESIGNOPTS, FDESIGN/HELP.


%   Copyright 2005-2007 The MathWorks, Inc.
