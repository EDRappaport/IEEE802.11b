%SPECTRUM  �X�y�N�g������
%
%   H = SPECTRUM.<ESTIMATOR> �́AESTIMATOR �Ŏw�肵���^�C�v�̃X�y�N�g�������� 
% H �ɕԂ��܂��B
%
%   �����ɂ� 3 �̃^�C�v������܂�:�p���[�X�y�N�g�����x (PSD)�A���ϓ��X�y�N
%�g�� (MSS)�A�[���X�y�N�g���B������ 3 �̃^�C�v�̂��ꂼ��� <ESTIMATOR> ��
%�΂���L���Ȓl���ȉ��Ƀ��X�g���܂��B����̃X�y�N�g�������̃w���v�𓾂��
%�́A"help spectrum.<ESTIMATOR>" �ƃ^�C�v���Ă��������B���Ƃ��΁A"help 
%spectrum.welch"�B
%
%   ----------------------------
%   �p���[�X�y�N�g�����x (PSD)
%   ----------------------------
%   <a href="matlab:help spectrum.burg">burg</a> - Burg
%   <a href="matlab:help spectrum.periodogram">periodogram</a> - �s���I�h�O����
%   
%   <a href="matlab:help spectrum.cov">cov</a>  - �����U
%   <a href="matlab:help spectrum.welch">welch</a>       - Welch
%   <a href="matlab:help spectrum.mcov">mcov</a> - �C�������U
%   <a href="matlab:help spectrum.yulear">yulear</a>      - Yule-Walker AR
%   <a href="matlab:help spectrum.mtm">mtm</a>  - Thomson �}���`�e�[�p�@ (MTM)
%
%   PSD ���v�Z����ɂ́A��L�̐����� 1 ���쐬���A�f�[�^�Ƌ��Ɉȉ��̊֐��� 
%   1 �ɂ����n���Ȃ���΂Ȃ�܂���B
%
%   <a href="matlab:help spectrum/psd">psd</a>     - PSD ���v�Z
%   <a href="matlab:help spectrum/psdopts">psdopts</a> - PSD ���v�Z���邽�߂̃I�v�V����
%
%   --------------------------
%   ���ϓ��X�y�N�g�� (MSS)
%   --------------------------
%   <a href="matlab:help spectrum.periodogram">periodogram</a> - �s���I�h�O����
%   <a href="matlab:help spectrum.welch">welch</a>       - Welch
%
%   MSS ���v�Z����ɂ́A��L�̐����� 1 ���쐬���A�f�[�^�Ƌ��Ɉȉ��̊֐��� 
%   1 �ɂ����n���Ȃ���΂Ȃ�܂���B
%
%   <a href="matlab:help spectrum/msspectrum">msspectrum</a>     - ���ϓ��X�y�N�g�� (MSS) ���v�Z
%   <a href="matlab:help spectrum/msspectrumopts">msspectrumopts</a> - MSS ���v�Z���邽�߂̃I�v�V����
%
%   ---------------
%   �[���X�y�N�g��
%   ---------------
%   <a href="matlab:help spectrum.eigenvector">eigenvector</a> - �ŗL�x�N�g��
%   <a href="matlab:help spectrum.music">music</a>       - ���d�M������ (MUSIC)
%
%   �[���X�y�N�g�����v�Z����ɂ́A��L�̐����� 1 ���쐬���A�f�[�^�Ƌ���
%   �ȉ��̊֐��� 1 �ɂ����n���Ȃ���΂Ȃ�܂���
%
%   <a href="matlab:help spectrum/powerest">powerest</a>           - �����g�̃p���[�Ǝ��g�����v�Z
%   <a href="matlab:help spectrum/pseudospectrum">pseudospectrum</a>     - �[���X�y�N�g�����v�Z
%   <a href="matlab:help spectrum/pseudospectrumopts.">pseudospectrumopts</a> - �[���X�y�N�g�����v�Z���邽�߂̃I�v�V����
%
%   ����:SPECTRUM �̊֐��̌`���͋����ł��B�܂��@�\���܂����A�����폜�����
%   �\��������܂��BSPECTRUM �́ASPECTRUM �I�u�W�F�N�g��A PWELCH, TFESTIMATE, 
%   MSCOHERE �̂悤�ȑ��̊֐��ɒu���������Ă��܂��B
%
%   ��:200Hz �̗]���g�ƃm�C�Y���܂ސM���̃X�y�N�g�����
%      Fs = 1000;   t = 0:1/Fs:.296;
%      x = cos(2*pi*t*200)+randn(size(t));
%      h = spectrum.welch;           % Welch �X�y�N�g�������̍쐬
%
%      Hpsd = psd(h,x,'Fs',Fs);             % PSD �̌v�Z
%      plot(Hpsd)                           % PSD �̃v���b�g
%
%   �ڍׂɂ��ẮA<a href="matlab:web([matlabroot,'\toolbox\signal\sigdemos\html\spectralanalysisobjsdemo.html'])">Getting Started �f��</a> ���Q�Ƃ��Ă��������B
%
%   <a href="matlab:help signal">Signal Processing Toolbox �̖ڎ�</a>
%
%   �Q�l DSPDATA.


%   Copyright 1988-2007 The MathWorks, Inc.
