%QREPORT  �ʎq�����|�[�g
%
%   R = QREPORT(Hd) �́A�t�B���^�I�u�W�F�N�g Hd �Ɋi�[���ꂽ���O���|�[�g 
%   R ��Ԃ��܂��B���M���O�̐��\�́A'Arithmetic' �v���p�e�B�� 'fixed' ��
%   �ݒ肵�� 'filter' ���\�b�h�ɑg�ݍ��܂�Ă��܂��B'Logging' FI �ݒ肪 
%   'on' �̏ꍇ�A�g���K����܂��B�i�[���ꂽ���|�[�g�́A�Ō�̃V�~�����[�V����
%   �ɑΉ����Ă��܂��B�t�B���^�R�}���h�����s�����x�ɏ㏑������܂��B
%
%   QREPORT �́A�Œ菬���_�t�B���^��������i�ƁA�t�B���^���ǂ̂悤��
%   �^����ꂽ�h���M���ɉ������邩�𓴎@������@��^���܂��B���|�[�g�I�u�W�F�N�g 
%   R �́A�t�B���^�̓����M���̍\���̎w���̃��X�g���܂�ł��܂��B���ꂼ���
%   �M���͂��̂��̂��܂݂܂�:
%   - �Ō�̃V�~�����[�V�����̊ԂɋL�^���ꂽ (�ʎq������O�Ƀ��O��������l��) 
%     �ŏ��ƍő�l
%   - �M���͈̔�
%   - �I�[�o�[�t���[�̐�
%
%   ���̃��\�b�h�́AFixed-Point Designer ���K�v�ł��邱�Ƃɒ��ӂ��Ă��������B
%
%   % �� #1:���ڌ^ FIR �t�B���^�̗ʎq�����|�[�g�B
%   fipref('LoggingMode', 'on');
%   Hd = design(fdesign.lowpass, 'equiripple');
%   Hd. arithmetic = 'fixed';
%   rand('state', 0);
%   y = filter(Hd, rand(100,1));
%   R = qreport(Hd)
%
%   % �� #2:���ڌ^ II �� 2 ���^ IIR �t�B���^�̗ʎq�����|�[�g�B
%   fipref('LoggingMode', 'on');
%   Hd = design(fdesign.lowpass, 'ellip');
%   Hd. arithmetic = 'fixed';
%   rand('state', 0);
%   y = filter(Hd, rand(100,1));
%   R = qreport(Hd)
%
%   �Q�l DFILT/FUNCTIONS


%   Copyright 2005-2007 The MathWorks, Inc.
