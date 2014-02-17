%CORRMTX  ���ȑ��֍s��
%
%   X = CORRMTX(S,M) �́A���� N �̃x�N�g�� S �Ɛ��� M ��^���āAX'*X ���A
%   S �� M+1 �s M+1 ��̎��ȑ��֍s��� (�o�C�A�X�t��) ����ɂȂ� N+M �s 
%   M+1 ��̍s�� X ��Ԃ��܂��B
%
%   X = CORRMTX(S,M,METHOD) �́A METHOD �ɏ]���č쐬���ꂽ�s�� X ��Ԃ��܂��B
%   METHOD �ɂ́A���̂����ꂩ��ݒ肷�邱�Ƃ��ł��܂��B
%       'autocorrelation' - ����́A���萄�肪�]�܂��ꍇ�Ɏg�p�ł��܂��B
%                           �������A�o�C�A�X�ŁA�f�[�^�ɃE�B���h�E��K�p
%                           ���܂��B(�f�t�H���g)
%       'prewindowed'     - �f�[�^�́A�ŏ��ɃE�C���h�E���K�p����܂��B
%                           X �́AN �s M+1 ��ł��B
%       'postwindowed'    - �f�[�^�́A�Ō�ɃE�C���h�E���K�p����܂��B
%                           X �́AN �s M+1 ��ł��B
%       'covariance'      - �f�[�^�̃E�C���h�E�����͍s���܂���B���x��
%                           �オ��܂��B����̓o�C�A�X������܂���B
%                           X �́AN-M �s M+1 ��ł��B
%       'modified'        - ����́A�C�������U�@ (�ʖ��A�t�H���[�h-�o�b�N���[�h�@) 
%                           �ɑΉ����܂��B�����̏ꍇ�A�����U��萸�x�̍���
%                           ���肪�s���܂��B�o�C�A�X�͂���܂���BX �́A
%                           2*(N-M) �s M+1 ��ł��B
%
%   [X,R] = CORRMTX(...) �́AM+1 �s M+1 ��̑��֍s�� R ���Ԃ��܂��BR ��
%   �����悻 X'*X �Ɠ������ł����A����Ώ� R �� (X'*X + (X'*X)')/2 �Ƃ���
%   �v�Z����邱�Ƃ�ۏ؂��܂��B
%
%   �Q�l XCORR, CONVMTX, ARCOV, ARMCOV, ARYULE, PMUSIC, ROOTMUSIC.


%   Copyright 1988-2007 The MathWorks, Inc.
