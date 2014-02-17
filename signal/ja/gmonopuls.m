%GMONOPULS  Gaussian ���m�p���X������
%
%   Y = GMONOPULS(T,FC) �́A�z�� T �Ɏ����ꂽ���Ԃɂ����钆�S���g�� FC 
%   (�w���c) �����P�ʐU���� Gaussian ���m�p���X�̃T���v����Ԃ��܂��B
%   �f�t�H���g�ł́AFC=1000 Hz �ł��B
%
%   TC = GMONOPULS('cutoff',FC) �́A�p���X�̍ő�U���ƍŏ��U���̊Ԃ̎��ԕ���
%   �Ԃ��܂��B
%
%   �f�t�H���g�l�́A��܂��͓��͈������ȗ����邱�Ƃɂ��g�p�ł��܂��B
%
%   �� 1:100 GHz �̃��[�g�ŃT���v�����O���ꂽ 2 GHz �� Gaussian ���m�p���X��
%      �v���b�g���܂��B
%       fc = 2E9;  fs=100E9;
%       tc = gmonopuls('cutoff', fc);
%       t  = -2*tc : 1/fs : 2*tc;
%       y = gmonopuls(t,fc); plot(t,y)
%
%   �� 2:�� 1 ���� 7.5nS �̊Ԋu�Ń��m�p���X��𐶐����܂��B
%       fc = 2E9;  fs=100E9;           % ���S���g���A�T���v�����g��
%       D = [2.5 10 17.5]' * 1e-9;     % �p���X�x�ꎞ��
%       tc = gmonopuls('cutoff', fc);  % �e�p���X�Ԃ̕�
%       t  = 0 : 1/fs : 150*tc;        % �M�����v�Z���鎞��
%      yp = pulstran(t,D,@gmonopuls,fc);
%      plot(t,yp)
%
%   �Q�l GAUSPULS, TRIPULS, PULSTRAN, CHIRP.


%   Copyright 1988-2007 The MathWorks, Inc.
