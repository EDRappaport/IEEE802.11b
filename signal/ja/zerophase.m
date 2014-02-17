%ZEROPHASE  �����t�B���^�̃[���ʑ�����
%
%   [Hr,W] = ZEROPHASE(B,A) �́A�[���ʑ����� Hr �ƁAHr ���v�Z�����_�ɂ�����
%   ���g���x�N�g�� W (rad/sample �P��) ��Ԃ��܂��B�[���ʑ������́A�P�ʉ~��
%   �㔼���ɓ��Ԋu�ɔz�u���ꂽ 512 �_�ŕ]������܂��B
%
%   �[���ʑ����� Hr(w) �́A���g������ H(w) �Ƃ��̊֌W������܂��B
%                                       jPhiz(w)
%                          H(w) = Hr(w)e
%
%   �[���ʑ������͏�Ɏ����ł����A�U�������Ɠ����ł͂Ȃ����Ƃɒ��ӂ��Ă��������B
%   ���ɁA�O�҂͕��ɂȂ�܂����A��҂͕��ɂł��܂���B
%
%   [Hr,W] = ZEROPHASE(B,A, NFFT) �́A�[���ʑ��������v�Z����ꍇ�A�P�ʉ~��
%   �㔼���� NFFT ���g���_���g�p���܂��B
%
%   [Hr,W] = ZEROPHASE(B,A,NFFT,'whole') �́A�P�ʉ~�̑S���� NFFT �̎��g���_��
%   �g�p���܂��B
%
%   [Hr,W] = ZEROPHASE(B,A,W) �́A�x�N�g�� W �Ŏ�����郉�W�A��/�T���v�� (�ʏ�A
%   0 �� �� �̊�) �́A���g���ł̗�_�]�ʑ�������Ԃ��܂��B
%
%   [Hr,F] = ZEROPHASE(...,Fs) �́AHz �ŕ\�����T���v�����O���g�����g�p���āA
%   Hr ���v�Z�����A���g���x�N�g�� F (Hz �P��) �����肵�܂��B
%
%   [Hr,W,Phi] = ZEROPHASE(...) �́A�A���I�Ȉʑ� Phi ��Ԃ��܂��B�[���ʑ�������
%   ���̏ꍇ�A���̒l�̓t�B���^�̈ʑ������Ɠ������Ȃ�Ȃ����Ƃɒ��ӂ��Ă��������B
%
%   ZEROPHASE(...) ���A�o�͈����������Ȃ��ꍇ�A���g���ɑ΂���[���ʑ�������
%   �v���b�g���܂��B
%
%   �� #1:
%     b=fircls1(54,.3,.02,.008);
%     zerophase(b)
%
%   �� #2:
%     [b,a] = ellip(10,.5,20,.4);
%     zerophase(b,a,512,'whole')
%
%   �Q�l FREQZ, INVFREQZ, PHASEZ, FREQS, PHASEDELAY, GRPDELAY, FVTOOL.


%   Copyright 1988-2007 The MathWorks, Inc.
