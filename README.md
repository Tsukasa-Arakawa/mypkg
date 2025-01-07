# robosys2024 Assignment2 "Calendar"

ROS2 を使用した西暦を和暦に返還するパッケージ  
![GitHub Actions](https://github.com/Tsukasa-Arakawa/mypkg/actions/workflows/test.yml/badge.svg)

## 使用方法

以下の手順に従ってください。

- リポジトリをクローン
`git clone https://github.com/Tsukasa-Arakawa/mypkg`
- ディレクトリの移動
`cd mypkg`
- 端末１で talker_seireki を起動
`ros2 run mypkg talker_seireki`


## ノードについて

### パブリッシャーを持つノード
- 名前
**talker_seireki**
- 対応ファイル
`talker_seireki.py`
- 内容
1865年～2035年までの西暦を0.25秒間隔で送信する。2035年まで送りきると送信を停止する。
- トピック名 ：**year_topic**
- メッセージ型 ：**Int16** (ROS 2の標準メッセージパッケージ `std_msgs.msg.Int16`)


### サブスクライバーをもつノード(テスト用)
- 名前
**listener_wareki**
- 対応ファイル
`listener_wareki.py`
- 内容
受け取った年数に応じて和暦を返す。



## テスト内容
- 対応ファイル
`Calendar_test.bash`
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
- 実行環境：Ubuntu 20.04 
- Python version：3.10
- ROS2 : Humble

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．  
- © 2024 Tsukasa Arakawa
