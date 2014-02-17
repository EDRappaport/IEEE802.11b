%SPECTROGRAM  短時間フーリエ変換 (STFT) を使ったスペクトログラム
%
%   S = SPECTROGRAM(X) は、行列 S 内のベクトル X で指定された信号のスペクトロ
%   グラムを返します。デフォルトでは、X は 50% のオーバラップで 8 つのセグメント
%   に分割され、各セグメントは Hamming ウィンドウでウィンドウ処理が行なわれます。
%   離散フーリエ変換で計算に使われる周波数点数は、256、または X の各セグメントの
%   長さより大きい次の 2 のべき乗の大きい方と等しくなります。
%
%   X が 8 つのセグメントに明確に分割できない場合、X は結果に応じて打ち切られます。
%
%   S = SPECTROGRAM(X,WINDOW) は、WINDOW がベクトルの場合、WINDOW の長さに等しい
%   長さのセグメントに X を分割し、WINDOW に指定したベクトルで各セグメントの
%   ウィンドウ処理を行ないます。WINDOW が整数の場合、X はその整数値に等しい長さの
%   セグメントに分割され、長さの等しい Hamming ウィンドウが使われます。WINDOW が
%   指定されない場合、デフォルト値が使われます。
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP) の NOVERLAP は、X の各セグメントが
%   オーバラップするサンプル数です。WINDOW が整数の場合、NOVERLAP は WINDOW 
%   より小さい整数でなければなりません。NOVERLAP は、WINDOW がベクトルの場合、
%   WINDOW の長さよりも整数分だけ短いものになります。NOVERLAP が指定されない場合、
%   デフォルト値は、50% のオーバラップを得るために使われます。
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT) は、離散フーリエ変換を計算する
%   ために使われる周波数点数を指定します。NFFT が指定されない場合、デフォルトの 
%   NFFT が使われます。
%
%   S = SPECTROGRAM(X,WINDOW,NOVERLAP,NFFT,Fs) の Fs は、Hz 単位で指定する
%   サンプリング周波数です。Fs が空で指定された場合、デフォルトで 1 Hz に
%   なります。指定されない場合、正規化周波数が使われます。
%
%   S の各列は、信号 X の短期で時間で局所的な周波数成分の推定を含みます。
%   時間は、左から右に S の列内で増加します。周波数は、0 から始まり行方向に
%   増加します。X が長さ NX の複素信号の場合、S は NFFT 点の 行と 
%   k = fix((NX-NOVERLAP)/(length(WINDOW)-NOVERLAP)) 点の列をもつ複素行列に
%   なります。実数 X に対して、S は、NFFT が偶数の場合、(NFFT/2+1) 行を、
%   NFFT が奇数の場合 (NFFT+1)/2 行をもちます。
%
%   [S,F,T] = SPECTROGRAM(...) は、計算したスペクトログラムにおける周波数
%   ベクトル F と時間ベクトル T を返します。F は S の行数と等しい長さに
%   なります。T は長さ k (上記で定義) で、各セグメントの中心に対応する
%   値をもちます。
%
%   [S,F,T] = SPECTROGRAM(X,WINDOW,NOVERLAP,F,Fs) は、F が (2 以上の要素をもつ) 
%   Hz 単位の周波数ベクトルとして、Goertzel アルゴリズムを使用してこれらの
%   周波数におけるスペクトログラムを計算します。F に指定した周波数は、信号の
%   分解能に比例して最も近い DFT のバイナリの値に丸められます。
%
%   [S,F,T,P] = SPECTROGRAM(...) の P は、各セグメントのパワースペクトル密度 
%   (PSD) の行列表現です。実数信号に対して、SPECTROGRAM は各セグメントの 
%   PSD の片側修正ピリオドグラムの推定を返します。複素信号に対して、周波数
%   ベクトルが指定された場合は、両側 PSD を返します。
%
%   SPECTROGRAM(...) で、出力引数をもたない場合、現在の Figure のサーフェス上に
%   各セグメントに対する PSD 推定をプロットします。P が 4 番目の出力引数として、
%   SURF(f,t,10*log10(abs(P)) を使用します。後に続く入力の文字列 FREQLOCATION 
%   は、周波数軸を表示する軸を制御します。この文字列は、'xaxis' か 'yaxis' の
%   いずれかになります。この FREQLOCATION を 'yaxis' に設定すると、y 軸上に
%   周波数を、x 軸に時間を表示します。デフォルトは 'xaxis' で、x 軸上に周波数を
%   表示します。FREQLOCATION は、出力引数を必要とするときに指定した場合、
%   無視されます。
%
%   例 1:2 次 chirp の各セグメントの PSD を表示します。
%     t=0:0.001:2;                    % 1kHz のサンプルレートで 2 秒間
%     y=chirp(t,100,1,200,'q');       % 100Hz から開始し、t=1 秒で 200Hz に到達
%     spectrogram(y,128,120,128,1E3); % スペクトログラムの表示
%     title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');
%
%   例 2:線形 chirp の各セグメントの PSD を表示します。
%     t=0:0.001:2;                    % 1kHz のサンプルレートで 2 秒間
%     x=chirp(t,0,1,150);             % DC 成分から開始して、t=1秒で 150Hz に到達
%     F = 0:.1:100;
%     [y,f,t,p] = spectrogram(x,256,250,F,1E3,'yaxis');
%   % 注意:これは出力引数なしで SPECTROGRAM を呼び出す処理と同じです。
%     surf(t,f,10*log10(abs(p)),'EdgeColor','none');
%     axis xy; axis tight; colormap(jet); view(0,90);
%     xlabel('Time');
%     ylabel('Frequency (Hz)');
%
%   参考 PERIODOGRAM, PWELCH, SPECTRUM, GOERTZEL.


%   Copyright 1988-2007 The MathWorks, Inc.
