# delphi-sample-pj

## 新規ユニット追加方法

ファイル > 新規 > ユニット

## H2

`cmd`を起動し、`h2\bin`へカレントを移動。
以下のコマンドを実行。

'java -jar h2-2.3.232.jar' ※jarファイルは、bin配下のファイル名を確認し、適宜修正。

実行後、以下のメッセージがコンソールに出力される場合、ポートが競合しています。

'''
C:\workspace\delphi-sample-pj\BIN\H2Database\h2\bin>java -jar h2-2.3.232.jar
The Web Console server could not be started. Possible cause: another server is already running at http://192.168.1.5:8082
Root cause: ポート "8082" をオープン中に例外が発生しました (ポートが使用中の可能性があります)
'''

利用されていないポートを確認し、以下のとおりポート番号を指定して、再度実行してください。

java -jar h2-2.3.232.jar -webPort 8083

Webコンソールの起動後、`JDBC URL`に作成するdbのパスと名前を入力。

`jdbc:h2:パス\db名' ※例）jdbc:h2:C:\workspace\delphi-sample-pj\sample-db

`接続`ボタンを押下。

接続後、以下のように任意のテーブルを作成する。

```
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255)
);
```
