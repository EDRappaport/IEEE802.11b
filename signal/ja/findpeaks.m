%FINDPEAKS  �f�[�^���̋Ǐ��I�ȃs�[�N�����o
%
%   PKS = FINDPEAKS(X) �́A�x�N�g���̃f�[�^�Z�b�g X ���̋Ǐ��I�ȃs�[�N��
%   �����܂��B
%
%   [PKS,LOCS]= FINDPEAKS(X) �́A����Ƀs�[�N�̔�������ӏ��̃C���f�b�N�X 
%   LOCS ���Ԃ��܂��B
%
%   [...] = FINDPEAKS(X,'MINPEAKHEIGHT',MPH) �́AMINPEAKHEIGHT MPH ���傫��
%   �����̃s�[�N�݂̂������܂��B�ŏ��̃s�[�N�̍������w�肷��ƁA�������Ԃ�
%   �����ɖ𗧂��܂��BMPH �́A�����l�̃X�J���ł��BMPH �̃f�t�H���g�l�� -Inf �ł��B
%
%   [...] = FINDPEAKS(X,'MINPEAKDISTANCE',MPD) �́A���Ȃ��Ƃ� 
%   MINPEAKDISTANCE MPD �ŕ�����ꂽ�s�[�N�������܂��BMPD �́A���̐����l��
%   �X�J���ł��B���̃p�����[�^�́A�Ǐ��I�ȍő�s�[�N�ɋ߂��Ƃ���Ŕ�������
%   �\���̂��鏬�����s�[�N�𖳎����邽�߂Ɏw�肳��邱�Ƃ�����܂��B
%   ���Ƃ��΁A�Ǐ��I�ȍő�s�[�N���C���f�b�N�X N �Ŕ�������ꍇ�A�͈� 
%   (N-MPD, N+MPD) ���̂��ׂĂ̏������s�[�N�͖�������܂��B�w�肳��Ȃ��ꍇ�A
%   MPD �́A1 �̒l�Ɋ��蓖�Ă��܂��B
%
%   [...] = FINDPEAKS(X,'THRESHOLD',TH) �́A���Ȃ��Ƃ� THRESHOLD TH �ɂ��
%   ���ӂ̃s�[�N�����傫���s�[�N�������܂��BTH �́A0 �ȏ�̎����l��
%   �X�J���ł��BTH �̃f�t�H���g�l�� 0 �ł��B
%
%   [...] = FINDPEAKS(X,'NPEAKS',NP) �́A������s�[�N�����w�肵�܂��B
%   NP �́A0 ���傫�������ł��B�w�肳�ꂽ�ꍇ�ANP �̃s�[�N�������� 
%   NP �̃s�[�N���Ԃ����ƁA�������I�����܂��B�w�肳��Ȃ��ꍇ�A���ׂĂ�
%   �s�[�N��Ԃ��܂��B
%
%   [...] = FINDPEAKS(X,'SORTSTR',STR) �́A�s�[�N�̕��בւ��̕������w��
%   ���܂��BSTR �́A'ascend','descend', 'none' �̂����ꂩ�̒l�����܂��B
%   �w�肳��Ȃ��ꍇ�ASTR �� 'none' �̒l�����A�s�[�N�͂����̔�������
%   ���ɕԂ���܂��B
%
%   �Q�l DSPDATA/FINDPEAKS


%   Copyright 2007-2008 The MathWorks, Inc.
