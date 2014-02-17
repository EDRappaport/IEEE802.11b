%SIGWIN  �E�B���h�E�I�u�W�F�N�g
%
%   HWIN = SIGWIN.WINDOW(input1,...) �́A�^�C�v WINDOW �̃E�B���h�E�I�u�W�F�N�g 
%   HWIN ��Ԃ��܂��BSIGWIN �ŃE�B���h�E�^�C�v���w�肵�Ȃ���΂Ȃ�܂���B
%   �e�E�B���h�E�́A�����̓��͂����܂��B���͈����Ȃ��� SIGWIN.WINDOW ���w�肷��
%   �ꍇ�A�f�t�H���g�̃v���p�e�B�l�����E�B���h�E���쐬����܂� (�f�t�H���g��
%   �X�̃E�B���h�E�Ɉˑ����܂�)�B�v���p�e�B�́ASET(H,PARAMNAME,PARAMVAL) ��
%   �ύX���܂��B
%
%   SIGWIN.WINDOW �́A���̂����ꂩ�ɂȂ�܂�:
%
%   <a href="matlab:help sigwin.bartlett">bartlett</a>       - Bartlett �E�B���h�E
%   <a href="matlab:help sigwin.barthannwin">barthannwin</a>    - �C�� Bartlett-Hanning �E�B���h�E
%   <a href="matlab:help sigwin.blackman">blackman</a>       - Blackman �E�B���h�E
%   <a href="matlab:help sigwin.blackmanharris"> - �ŏ� 4-�� Blackman-Harris �E�B���h�E
%   <a href="matlab:help sigwin.bohmanwin">bohmanwin</a>      - Bohman �E�B���h�E
%   <a href="matlab:help sigwin.chebwin">chebwin</a>        - �`�F�r�V�F�t�E�B���h�E
%   <a href="matlab:help sigwin.flattopwin">flattopwin</a>     - Flat Top �E�B���h�E
%   <a href="matlab:help sigwin.gausswin">gausswin</a>       - Gaussian �E�B���h�E
%   <a href="matlab:help sigwin.hamming">hamming</a>        - Hamming �E�B���h�E
%   <a href="matlab:help sigwin.hann">hann</a>           - Hann �E�B���h�E
%   <a href="matlab:help sigwin.kaiser">kaiser</a>         - Kaiser �E�B���h�E
%   <a href="matlab:help sigwin.nuttallwin">nuttallwin</a>     - Nuttall �̒�`�̍ŏ� 4-�� Blackman-Harris �E�B���h�E
%   <a href="matlab:help sigwin.parzenwin">parzenwin</a>      - Parzen (de la Valle-Poussin) �E�B���h�E
%   <a href="matlab:help sigwin.rectwin">rectwin</a>        - �����`�E�B���h�E
%   <a href="matlab:help sigwin.triang">triang</a>        - �����`�E�B���h�E
%   <a href="matlab:help sigwin.tukeywin">tukeywin</a>       - Tukey �E�B���h�E
%
%   �E�B���h�E�I�u�W�F�N�g���\�b�h
%   sigwin/generate - �E�B���h�E�x�N�g���̐���
%
%   % ��:128 �_�̃`�F�r�V�F�t�E�B���h�E�𐶐�
%   Hwin = sigwin.chebwin(128,100);
%   w = generate(Hwin) % �E�B���h�E��\���l��Ԃ�
%   wvtool(Hwin)       % Window Visualization �c�[��
%
%   ���ڂ������ɂ��ẮAMATLAB �̃R�}���h���C����
%       doc sigwin
%   �ƃ^�C�v�C�����Ă��������B


%   Copyright 1988-2007 The MathWorks, Inc.
