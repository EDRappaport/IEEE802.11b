%MEASURE  �t�B���^�̎��g�����������̑���
%
%   MEASURE(H) �́A�t�B���^�̎��g����������̗l�X�ȗʂ̑���l��\�����܂��B
%   ���肳�ꂽ�l�́A�m�~�i���Ȓʉߑш�̃Q�C���� 3 dB ��������t�B���^��
%   �Q�C���ɂ�����A���ۂ̒ʉߑш�̃��b�v���A�ŏ��̒ʉߑш�̌����A
%   ���g���_���܂߂邱�Ƃ��ł��܂��BMEASURE �����삷��ɂ́A�t�B���^ H �́A
%   Filter Design Toolbox ���� FDESIGN ���g���Đ݌v�����K�v������܂��B
%   ���L�̗���Q�Ƃ��Ă��������B
%
%   M = MEASURE(H) �́A����l���v���O�����I�ɒ��ׂ���悤�ɕԂ��܂��B
%   ���Ƃ��΁A3 dB �̓_�𒲂ׂ�ɂ́AM.F3dB �ƃ^�C�v���܂��B���ׂ邱�Ƃ�
%   �ł��邷�ׂẴv���p�e�B���X�g���Q�Ƃ���ɂ́AGET(M) �ƃ^�C�v����
%   ���������B�قȂ�t�B���^�����́A�قȂ鑪��l�𐶐����邱�Ƃɒ��ӂ���
%   ���������B
%
%   ���g���̐���̂��������w��ł��Ȃ��݌v�ɂ��ẮA�Ή�����U����
%   ����l�����ł��Ȃ��\��������܂��B�����̏ꍇ�A���̂悤�Ȓl��
%   �Ή�����U���̑���l����肷�邽�߂ɁA���g���l�� MEASURE �ɓn�����Ƃ�
%   �ł��܂��B���̂��Ƃ��������߂ɁA���L�̗� #3 ���Q�Ƃ��Ă��������B
%
%   % �� #1:�o���h�p�X�t�B���^�̓����b�v�� FIR �݌v�𑪒�
%   f = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',0.3,0.4,0.6,0.7,80,1,75);
%   H = design(f,'equiripple');
%   measure(H)
%
%   % �� #2:���i�Ԉ����t�B���^�̍ŏ��Ւf�ш�̌��������
%   f = fdesign.decimator(4,'lowpass','Fp,Fst,Ap,Ast',0.2,0.22,1,75);
%   H = design(f,'multistage');
%   M = measure(H); M.Astop
%
%   % �� #3:
%   f = fdesign.lowpass('N,F3dB,Ast',8,0.5,80);
%   h = design(f,'cheby2');
%   measure(h,'Fpass',0.4)
%
%   �Q�l DFILT/INFO, DFILT/COST.


%   Copyright 2006-2007 The MathWorks, Inc.
