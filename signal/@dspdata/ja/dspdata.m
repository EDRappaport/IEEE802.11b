%DSPDATA  DSP �f�[�^�I�u�W�F�N�g
%
%   Hs = DSPDATA.<DATAOBJECT>(...) �́ADATAOBJECT �Ŏw�肵���^�C�v�� DSP 
%   �f�[�^�I�u�W�F�N�g Hs ��Ԃ��܂��B���ꂼ��� DATAOBJECT �́A��������
%   ���͂�^���܂��B���ꂼ��� DATAOBJECT �́A�����̓��͂��󂯓���܂��B
%
%   �L���� DATAOBJECT �̃��X�g���ȉ��Ɏ����܂��B(����̃f�[�^�I�u�W�F�N�g��
%   �w���v���擾����ɂ́A"help dspdata.<DATAOBJECT>" �Ɠ��͂��Ă��������B
%   - ��. "help dspdata.psd"):
%
%   <a href="matlab:help dspdata.msspectrum">msspectrum</a>     - ���ϓ��X�y�N�g�� (MSS) �f�[�^�I�u�W�F�N�g
%   <a href="matlab:help dspdata.psd">psd</a>            - �p���[�X�y�N�g�����x (PSD) �f�[�^�I�u�W�F�N�g
%   <a href="matlab:help dspdata.pseudospectrum">pseudospectrum</a> - �[���X�y�N�g���f�[�^�I�u�W�F�N�g
%
%   �ȉ��̃��\�b�h�́A��q�̃I�u�W�F�N�g�ɑ΂��ė��p�\�ł� (����̃��\�b�h
%   �̃w���v���擾����ɂ́A"help dspdata/<METHOD>" �Ɠ��͂��Ă��������B
%   - ��. "help dspdata/avgpower")�B
%
%   <a href="matlab:help dspdata/avgpower">avgpower</a>      - PSD �f�[�^�I�u�W�F�N�g�̕��σp���[
%   <a href="matlab:help dspdata/centerdc">centerdc</a>      - 0 �̎��g���������X�y�N�g���̒��S�ɃV�t�g
%   <a href="matlab:help dspdata/findpeaks">findpeaks</a>     - �f�[�^�I�u�W�F�N�g���̋Ǐ��I�ȃs�[�N
%   <a href="matlab:help dspdata/halfrange">halfrange</a>     - �S�̂̔����̃i�C�L�X�g��ԂŌv�Z�����[���X�y�N�g��
%   <a href="matlab:help dspdata/normalizefreq">normalizefreq</a> - ���g���̎d�l�𐳋K��
%   <a href="matlab:help dspdata/onesided">onesided</a>      - �S�̂̔����̃i�C�L�X�g�̋�ԂŌv�Z���ꂽ PSD �܂��� MSS (�������A���S�ȃp���[���܂݂܂�)
%   <a href="matlab:help dspdata/plot">plot</a>          - �f�[�^�I�u�W�F�N�g�Ɋ܂܂��X�y�N�g���̃v���b�g
%   <a href="matlab:help dspdata/sfdr">sfdr</a>          - MSS �f�[�^�I�u�W�F�N�g�̃X�v���A�X�t���[�_�C�i�~�b�N�����W
%   <a href="matlab:help dspdata/twosided">twosided</a>      - �i�C�L�X�g��ԑS�̂Ōv�Z���� PSD �܂��� MSS
%   <a href="matlab:help dspdata/wholerange">wholerange</a>    - �i�C�L�X�g��ԑS�̂Ōv�Z�����[���X�y�N�g��
%
%   ��: FFT ���g���Đ����g�M���̃p���[���v�Z���APSD �I�u�W�F�N�g�Ɍ��ʂ�
%       �i�[���ăv���b�g���܂��B
%
%        Fs = 32e3;   t = 0:1/Fs:2.96;
%        x  = cos(2*pi*t*10e3)+cos(2*pi*t*1.24e3)+ randn(size(t));
%        X  = fft(x);
%        P  = (abs(X).^2)/length(x)/Fs;  % PSD ���`�����邽�߂ɁA�p���[��
%                                        % �v�Z���A�X�P�[�����O����
%
%        hpsd = dspdata.psd(P,'Fs',Fs,'SpectrumType','twosided');
%        plot(hpsd);                     % PSD �̃v���b�g
%
%
%   <a href="matlab:help signal">Signal Processing Toolbox �̖ڎ�</a>
%
%   �Q�l SPECTRUM.


%   Copyright 1988-2008 The MathWorks, Inc.
