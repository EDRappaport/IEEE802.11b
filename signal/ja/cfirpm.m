%CFIRPM  ���f��������`�ʑ��̓����b�v�� FIR �t�B���^�݌v
%
%  CFIRPM �́A���f���ɂȂ�\���̂��� FIR �t�B���^�݌v�ɑ΂��āA�ݒ�
%  �����C�ӂ̎��g���̈�̐����ݒ�ł��܂��B�����b�v�� FIR �t�B���^
%  �݌v���s�Ȃ��̂ɁA�`�F�r�V�F�t (�܂��́A�~�j�}�b�N�X) �t�B���^�덷��
%  �œK�����܂��B
%
%  B = CFIRPM(N,F,A,W) �́A�~�j�}�b�N�X�̕����� F �� A �ŋL�q���ꂽ�ړI��
%  ���g�������ɍœK�ߎ����钷�� N+1 �� FIR �t�B���^��Ԃ��܂��B
%
%  �����ŁA
%  N �́A�t�B���^�̎����ł��B
%  F �� -1 �� +1 �̊ԂŒP������������g���ш�G�b�W�̃x�N�g���ł��B������ 
%    1 �̓i�C�L�X�g���g���ł��B���g���ш�́Ak ����̏ꍇ F(k) ���� 
%    F(k+1) �̗̈�ŁAk �������̏ꍇ�� F(k+1) ���� F(k+2) �̋�Ԃ́A
%    �œK���̊Ԃ� "�J�ڑш�" �܂��� "don't care" �̈�ł��B
%  A �́A���ʂ̃t�B���^ B �̊�]������g�������̐U����\�킷�����x�N�g���ŁA
%    F �Ɠ����T�C�Y�łȂ���΂Ȃ�܂���B�ړI�̉����́Ak ����̏ꍇ�ɁA 
%    F(k),A(k)) �� (F(k+1),A(k+1)) �̓_�Ő��`�Ɍ�������܂��B
%  W �͍œK���̊ԂɎg�p�����A�ш�� 1 �̐��̏d�݂Ŏ����̃x�N�g���ł��B
%    W �̓I�v�V�����ŁA�w�肳��Ȃ��ꍇ�A1 �ɐݒ肳��܂��B
%
%  Fs/2 �� 0 �ȊO�̃Q�C�������t�B���^�A���Ƃ��΁A�n�C�p�X�A�o���h�X�g�b�v
%  �t�B���^�́AN �������łȂ���΂Ȃ�܂���B����ȊO�̏ꍇ�́AN �� 1 ����
%  ���܂��B
%
%  B = CFIRPM(N,F,@fresp,W) �́A�֐� @fresp �ɂ���ĕԂ����ړI�̎��g��
%  �����ɍœK�ߎ����钷�� N+1 �� FIR �t�B���^��Ԃ��܂��B���̃V���^�b�N�X
%  ���g���āA�֐� CFIRPM ����Ăяo����܂��B
%                    [DH,DW] = fresp(N,F,GF,W);
%  �����ŁA
%  N, F, W �͏�L�ɒ�`���Ă��܂��B
%  GF �́ACFIRPM �ɂ���Đݒ肳�ꂽ�e���g���ш��Ő��`�ɕ�Ԃ��ꂽ�O���b�h�_
%    �̃x�N�g���ŁA�����֐���]�����Ȃ���΂Ȃ�Ȃ����g���O���b�h�����肵�܂��B
%  DH �� DW �́A�O���b�h GF ���̊e���g���ŕ]�������A��]���镡�f���g��������
%    �œK���̏d�݃x�N�g���ł��B
%
%  B = CFIRPM(N,F,{@fresp,P1,P2,...},W) �́A�I�v�V�������� P1,P2... ��
%  �����֐� @fresp �ɓn���܂��B
%
%  �ȉ��̊֐� @fresp �ɑ΂��āA���g�������֐���O�����Ē�`�ł��܂��B
%       'lowpass'  'bandpass' 'multiband'      'hilbfilt'   'allpass'
%       'highpass' 'bandstop' 'differentiator' 'invsinc'
%  ����ɏ��𓾂邽�߂ɂ́APRIVATE/LOWPASS �Ȃǂ̃w���v���Q�Ƃ��Ă��������B
%
%  B = CFIRPM(N,F,{@multiband,A},W) �́AB = CFIRPM(N,F,A,W) �Ɠ����ł��B
%
%  B = CFIRPM(..., SYM) �́A�݌v�̃C���p���X�����ɑΏ̐��𐧖�Ƃ��ĉۂ��܂��B
%  �����ŁASYM �́A���̕������ݒ肷�邱�Ƃ��ł��܂��B
%          'none' - ����́A�C�ӂ̕��̑ш�G�b�W���g����ʉ߂�����ꍇ���A
%                   ���邢�́A@fresp ���f�t�H���g�l��^���Ȃ��ꍇ��
%                   �f�t�H���g�l�ł��B
%          'even' - �����������̃C���p���X�����ł��B����́A�n�C�p�X�A
%                   ���[�p�X�o���h�p�X�A�o���h�X�g�b�v�A����сA�}���`
%                   �o���h�݌v�̏ꍇ�̃f�t�H���g�l�ł��B
%          'odd'  - ��������̃C���p���X�����ł��B����́A�q���x���g
%                   �ϊ��q����є�����݌v�̏ꍇ�̃f�t�H���g�l�ł��B
%                   DC �ł̃Q�C���� 0 �łȂ���΂Ȃ�܂���B
%          'real' - ���g�������ɑ΂��鋤��Ώ̂ł��B
%
%  �e���g�������֐� @fresp �́ASYM �ɑ΂���f�t�H���g�l��^���܂�; 
%  ���ڂ������ɂ��ẮAprivate/lowpass ���̃w���v���Q�Ƃ��Ă��������B
%  'none' �ȊO�̔C�ӂ� SYM �I�v�V������ݒ肵���ꍇ�A�ш�G�b�W�͐���
%  ���g����ɂ̂ݐݒ肵�܂��B���Ȃ킿�A���̎��g���̈�͑Ώ̐��ɂ�蓾���܂��B
%
%  �C�ӂ̃��[�U��`�� @fresp �֐��́A�t�B���^�̎����� N �Ƃ��ĕ����� 
%  'defaults' �ɓn�����ꍇ�ɐ����� SYM �������Ԃ��܂��B
%
%  B = CFIRPM(..., 'skip_stage2') �́ACFIRPM ���W���� Remez �덷������
%  ����čœK�������߂��Ȃ������Ɣ��肵���ꍇ�ɂ̂݁A���s������ 2 �i
%  �œK���A���S���Y���𖳌��ɂ��܂��B���̃A���S���Y���𖳌��ɂ���ƌv�Z
%  ���x�����シ��ꍇ������܂����A���x���ቺ����\��������܂��B
%  �f�t�H���g�ł́A�� 2 �i�œK���͗L���ł��B
%
%  B = CFIRPM(..., DEBUG) �́A�t�B���^�݌v�ߒ��̌��ʂ̕\�����s�Ȃ��܂��B
%  �����ŁADEBUG �́A'trace', 'plots', 'both', 'off' �̂����ꂩ 1 ��
%  �ݒ肷�邱�Ƃ��ł��܂��B�f�t�H���g�ł́A'off' �ɐݒ肳��܂��B
%
%  B = CFIRPM(...,{LGRID}) �ł́A{LGRID} �́A��̐�������Ȃ� 1 �s 1 ��
%  �̃Z���z��ŁA���g���O���b�h�̊Ԋu���R���g���[�����܂��B���̊Ԋu�́A
%  �����܂��ɁA2^nextpow2(L-GRID*N) �_�������܂��BLGRID �̃f�t�H���g�l�� 
%  25 �ł��B
%
%  SYM, DEBUG, 'skip_stage2', {LGRID} �I�v�V�����̔C�ӂ̑g�������w��
%  �����\�������邱�Ƃɒ��ӂ��Ă��������B
%
%  [B,ERR] = CFIRPM(...) �́A�ő僊�b�v���̍��� ERR ��Ԃ��܂��B
%
%  [B,ERR,RES] = CFIRPM(...) �́ACFIRPM ���v�Z�����I�v�V�������ʂ̍\���� 
%  RES ��Ԃ��܂��B�ȉ��̃t�B�[���h���܂܂�Ă��܂��B
%
%     RES.fgrid:�t�B���^�݌v�̍œK���Ɏg�p������g���O���b�h���܂ރx�N�g��
%       RES.des:fgrid �̊e�_�ɑ΂����]������g������
%        RES.wt:fgrid �̒��̊e�_�ɑ΂���d��
%         RES.H:�O���b�h���̊e�_�ɑ΂�����ۂ̎��g������
%     RES.error:���g���O���b�h��̊e�_�ɂ�����덷
%     RES.iextr:�]���Ȏ��g���� fgrid �̃C���f�b�N�X�x�N�g��
%     RES.fextr:�]���Ȏ��g���̃x�N�g��
%
%  �� #1:
%    % 31 �^�b�v�̕��f�����[�p�X�t�B���^�̐݌v
%    b = cfirpm(30,[-1 -.5 -.4 .7 .8 1],@lowpass);
%    fvtool(b); % �t�B���^�̉�����\��
%
%  �� #2:
%     % �t sinc �̃p�X�o���h�������������̃��[�p�X�t�B���^
%     [b,del,res] = cfirpm(64,[0 0.3 0.4 1],{@invsinc,3},[1,1],'even');
%     fvtool(b);
%
%  �� #3:
%     % 31 �^�b�v�̕��f���}���`�o���h�t�B���^�̐݌v
%     b = cfirpm(30,[-1 -.5 -.4 .7 .8 1],{@multiband,[0 0 1 2 0 0]});
%     fvtool(b);
%
%  �Q�l FIRPM, FIR1, FIRLS, FILTER,  PRIVATE/LOWPASS, PRIVATE/HIGHPASS, 
%       PRIVATE/BANDPASS, PRIVATE/BANDSTOP, PRIVATE/MULTIBAND,  PRIVATE/INVSINC, 
%       PRIVATE/HILBFILT, PRIVATE/DIFFERENTIATOR.


%   Copyright 1988-2007 The MathWorks, Inc.
