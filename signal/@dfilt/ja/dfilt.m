%DFILT  ���U���ԃt�B���^�I�u�W�F�N�g
%
%   Hd = DFILT.<STRUCTURE>(COEFF,...) �́A����̃t�B���^ STRUCTURE ������
%   �W�� COEFFS �Ɋ֘A���闣�U���ԃt�B���^ Hd ��Ԃ��܂��B�W���́A�\����
%   �ˑ����镡���̓��͂Ŏw�肳��܂��B
%   <a href="matlab:help dfilt/structures">�\��</a> �̂��ׂẴ��X�g��
%   ����ɂ́A" help dfilt/structures" �ƃ^�C�v���Ă��������B
%
%   �f�W�^���t�B���^�́A<a href="matlab:help dfilt/freqtransform">���g���ϊ�</a>�A
%   <a href="matlab:help dfilt/analysis">���</a>�A<a href="matlab:help dfilt/simulation">�V�~�����[�V����</a>�A
%   <a href="matlab:help dfilt/codegeneration">�R�[�h����</a> �̃J�e�S����
%   �l�X�Ȋ֐�������Ă��܂��B(�ڍׂɂ��ẮAhelp dfilt/<function category> �ƃ^�C�v���Ă��������B
%   ��. help dfilt/analysis )
%
%   �֐��́A�f�W�^���t�B���^�Ɋւ��čł���ʓI�Ɏg���܂�:
%   <a href="matlab:help dfilt/filter">filter</a>      - ���U���ԃt�B���^�����s ("run")
%   <a href="matlab:help dfilt/freqz">freqz</a>       - ���U���ԃt�B���^�̎��g���������v�Z
%   <a href="matlab:help dfilt/realizemdl">realizemdl</a>  - Simulink �T�u�V�X�e���𐶐� (Simulink ���K�v)
%   <a href="matlab:help dfilt/block">block</a>       - Digital Filter �u���b�N�𐶐� (DSP System Toolbox ���K�v)
%   <a href="matlab:help dfilt/generatehdl">generatehdl</a> - HDL �R�[�h�𐶐� (Filter Design HDL Coder ���K�v)
%
%   Filter Design Toolbox �́AFixed-Point Designer �Ƌ��ɁA������ DFILT �\����
%   �P���x���������_�ƌŒ菬���_�̃T�|�[�g��L���ɂ��邱�Ƃɒ��ӂ��Ă��������B
%
%   % ��:���ڌ^ FIR ���[�p�X�t�B���^��݌v���č\�z���A��X�̉�������͂��܂��B
%   b = firls(80,[0 .4 .5 1],[1 1 0 0],[1 10]);
%   Hd = dfilt.dffir(b)
%   fvtool(Hd) % �t�B���^�̉��
%
%   ���ڂ������ɂ��ẮA<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\dfiltdemo.html'])">Getting Started Demo</a> 
%   ���Q�Ƃ��邩�A�܂��́AMATLAB �R�}���h���C���� "doc dfilt" �Ɠ��͂��Ă��������B
%
%   <a href="matlab:help signal">Signal Processing Toolbox �̖ڎ�</a>
%   <a href="matlab:help filterdesign">Filter Design Toolbox �̖ڎ�</a>
%
%   �Q�l Filter Design Toolbox �� FDESIGN, MFILT, ADAPTFILT.


%   Copyright 1988-2011 The MathWorks, Inc.
