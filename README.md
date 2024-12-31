# robosys2024 Assignment2 "Calendar"

西暦を和暦に返還するノード


## 使用方法

以下の手順に従ってください。

- リポジトリをクローン
```git clone https://github.com/Tsukasa-Arakawa/mypkg```
- ディレクトリの移動
```cd mypkg```
- 端末１でtalker を起動
```ros2 run mypkg talker```
- 端末２でlistener を起動
```ros2 run mypkg listener```


## ノードについて

### パブリッシャーを持つノード
- 名前
**talker**
- 対応ファイル
```talker_seireki.py```
- 内容
1865年～2035年までの西暦を0.25秒間隔で送信する。2035年まで送りきると送信を停止する。
- 実行例
```
[INFO] [1735490201.848518377] [talker]: 西暦: 1865
[INFO] [1735490202.343045011] [talker]: 西暦: 1866
[INFO] [1735490202.842971751] [talker]: 西暦: 1867
[INFO] [1735490203.342325078] [talker]: 西暦: 1868
[INFO] [1735490203.843150854] [talker]: 西暦: 1869
(中略)
[INFO] [1735490286.342896922] [talker]: 西暦: 2034
[INFO] [1735490286.842992805] [talker]: 西暦: 2035
[INFO] [1735490287.342983322] [talker]: Reached the year 2035. Terminating.
```

### サブスクライバーを持つノード
- 名前
***listener***
- 対応ファイル
```listener_wareki.py```
- 内容
talker で送信されたものを受信する。talker の送信が停止すると停止する。
- 実行例
```
[INFO] [1735490196.922082353] [listener]: Waiting for reception...
[INFO] [1735490201.842870617] [listener]: 西暦: 1865, 和暦: 西暦1865年（和暦対応外）
[INFO] [1735490202.344561617] [listener]: 西暦: 1866, 和暦: 西暦1866年（和暦対応外）
[INFO] [1735490202.844105975] [listener]: 西暦: 1867, 和暦: 西暦1867年（和暦対応外）
[INFO] [1735490203.342941480] [listener]: 西暦: 1868, 和暦: 慶応4年（1月1日～10月22日） / 明治元年（10月23日以降）
[INFO] [1735490203.844133404] [listener]: 西暦: 1869, 和暦: 明治2年
(中略)
[INFO] [1735490286.343811888] [listener]: 西暦: 2034, 和暦: 令和16年
[INFO] [1735490286.843878382] [listener]: 西暦: 2035, 和暦: 令和17年
[INFO] [1735490286.844704344] [listener]: It can be displayed until 2035. Exit.
```
### その他
- 明治以前は和暦対応外と処理しています。
- 年号が切り替わった年は切り替わる前後を表示しています。


## テスト内容
- 対応ファイル
```Calendar_test.bash```
- 内容
1865年から1900年までの表示テストをする。
- 実行結果
```
Starting >>> mypkg
(中略)
Talker sent: 1865, Listener response: [INFO] [1735663552.699130451] [listener]: 西暦: 1865, 和暦: 西暦1865年（和暦対応外）
Talker sent: 1866, Listener response: [INFO] [1735663552.949108418] [listener]: 西暦: 1866, 和暦: 西暦1866年（和暦対応外）
(中略)
Talker sent: 1898, Listener response: [INFO] [1735663560.949113851] [listener]: 西暦: 1898, 和暦: 明治31年
Talker sent: 1899, Listener response: [INFO] [1735663561.199530022] [listener]: 西暦: 1899, 和暦: 明治32年
Talker sent: 1900, Listener response: [INFO] [1735663561.448884503] [listener]: 西暦: 1900, 和暦: 明治33年
Reached END_YEAR 1900. Stopping test.
Stopping nodes...
Test completed.
```


## テスト済み環境
- 実行環境：GitHub が提供する最新の Ubuntu ベースの仮想環境
- Python version：3.7~3.12


## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．  
- © 2024 Tsukasa Arakawa
