%FDESIGN  �f�W�^���t�B���^�݌v
%
%   D = FDESIGN.<RESPONSE> �́A���[�p�X�A�n�C�p�X�A���̑������̃t�B���^�^�C�v
%   �̂悤�� RESPONSE �Ŏw�肳�ꂽ�t�B���^��݌v���邽�߂Ɏg�����Ƃ̂ł���d�l��
%   �Z�b�g��Ԃ��܂��B�T�|�[�g����� <a href="matlab:help fdesign/responses">responses</a> �̃��X�g��
%   ����ɂ́A"help fdesign/responses" �ƃ^�C�v���Ă��������B
%
%   �݌v�ߒ��́A�t�B���^�W�����쐬���A����̃t�B���^�̍\���������̌W����
%   �֘A�t���܂��B�t�B���^��݌v���邽�߂ɁA���̃R�}���h���g�p���܂��B
%   <a href="matlab:help fdesign/design">design</a>          -  �d�l����̐݌v
%
%   ���̊֐��͐݌v�ߒ��������܂�:
%   <a href="matlab:help fdesign/designmethods">designmethods</a>   -  �^����ꂽ�d�l�ɑ΂��ė��p�\�Ȑ݌v���\�b�h
%   <a href="matlab:help fdesign/help">help</a>            -  ����̐݌v���\�b�h�ɑ΂���w���v��\��
%   <a href="matlab:help fdesign/designopts">designopts</a>      -  <a href="matlab:help fdesign/design">design</a> �Ŏg�����߂̐݌v�I�v�V�����̍\���̂�Ԃ�
%   <a href="matlab:help fdesign/designoptions">designoptions</a>   -  ����̐݌v�ɑ΂��邷�ׂĂ̗��p�\�Ȑ݌v�I�v�V������\��
%   <a href="matlab:help fdesign/validstructures">validstructures</a> -  ����̐݌v�ɑ΂��ėL���ȃt�B���^�\����\��
%
%   �t�B���^��ʂ��ăf�[�^����������ɂ́A<a href="matlab:help dfilt/filter">dfilt/filter</a> �� <a href="matlab:help mfilt/filter">mfilt/filter</a> ���Q�Ƃ��Ă��������B
%
%   % �� - 0.2 �̐��K�����ꂽ�ʉߑш���g���A0.22 �̎Ւf�ш���g���A1 dB ��
%   %      �ʉߑш惊�b�v���A60 dB �̎Ւf�ш�̌��������ŏ������̃��[�p�X
%   %      �t�B���^��݌v���܂��B
%   d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.2, 0.22, 1, 60);
%   f = design(d, 'equiripple');      % FIR �����b�v���t�B���^��݌v
%   info(f)                           % �t�B���^�Ɋւ������\��
%
%   % ���̐݌v�𓯂��d�l�Ŏ��s���邱�Ƃ��\�ł�
%   designmethods(d,'iir');     % ���p�\�� IIR �݌v���\�b�h�̃��X�g
%   f = design(d, 'ellip')      % �ȉ~ IIR �t�B���^ (SOS) ��݌v
%   fvtool(f)                   % �l�X�ȃt�B���^�����̉���
%   input = randn(100,1);
%   output = filter(f,input);   % �ȉ~�t�B���^��ʂ��ăf�[�^������
%
%   �����b�v���̂悤�ȑ����̐݌v�́A�݌v�Ŏw�肳���l�X�ȃI�v�V������
%   �����܂��B�ڍׂ́A<a href="matlab:web([matlabroot,'\toolbox\filterdesign\filtdesdemos\html\fdesigngettingstarteddemo.html'])">Getting Started Demo</a> ���Q�Ƃ��邩�A�܂��́A
%   MATLAB �R�}���h���C���� "doc fdesign" �Ɠ��͂��Ă��������B
%
%   <a href="matlab:help filterdesign">Filter Design Toolbox �̖ڎ�</a>
%
%   �Q�l FDESIGN/SETSPECS, FDESIGN/NORMALIZEFREQ.


%   Copyright 1999-2007 The MathWorks, Inc.
