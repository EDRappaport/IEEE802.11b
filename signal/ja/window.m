%WINDOW  Window 関数のゲートウェイ
%
%   WINDOW(@WNAME,N) は、列ベクトルで、関数ハンドル @WNAME で指定される
%   タイプの N-点ウィンドウを返します。@WNAME は、任意の正しいウィンドウ
%   関数名になります。たとえば、つぎのようなものです。
%
%   @bartlett       - Bartlett ウィンドウ
%   @barthannwin  - 修正 Bartlett-Hanning ウィンドウ
%   @blackman   - Blackman ウィンドウ
%   @blackmanharris - 最小 4-項 Blackman-Harris ウィンドウ
%   @bohmanwin      - Bohman ウィンドウ
%   @chebwin        - チェビシェフウィンドウ
%   @flattopwin     - Flat Top ウィンドウ
%   @gausswin       - Gaussian ウィンドウ
%   @hamming        - Hamming ウィンドウ
%   @hann           - Hann ウィンドウ
%   @kaiser         - Kaiser ウィンドウ
%   @nuttallwin     - Nuttall の定義による最小 4 項 Blackman-Harris ウィンドウ
%   @parzenwin      - Parzen (de la Valle-Possin) ウィンドウ
%   @rectwin        - 長方形ウィンドウ
%   @tukeywin       - Tukey ウィンドウ
%   @triang         - 三角ウィンドウ
%
%   WINDOW(@WNAME,N,OPT) は、OPT に指定されるオプションの入力引数をもつ
%   ウィンドウを設計します。オプションの入力引数について参照するには、
%   たとえば、KAISER あるいは CHEBWIN のような、個々のウィンドウのヘルプを
%   参照してください。
%
%   WINDOW は、Window Design & Analysis Tool (WinTool) を起動します。
%
%   例:
%      N  = 65;
%      w  = window(@blackmanharris,N);
%      w1 = window(@hamming,N);
%      w2 = window(@gausswin,N,2.5);
%      plot(1:N,[w,w1,w2]); axis([1 N 0 1]);
%      legend('Blackman-Harris','Hamming','Gaussian');
%
%   参考 BARTLETT, BARTHANNWIN, BLACKMAN, BLACKMANHARRIS, BOHMANWIN,
%        CHEBWIN, GAUSSWIN, HAMMING, HANN, KAISER, NUTTALLWIN, PARZENWIN,
%        RECTWIN, TRIANG, TUKEYWIN, WINTOOL.


%    Copyright 1988-2007 The MathWorks, Inc.
