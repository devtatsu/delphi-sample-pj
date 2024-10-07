# delphi-sample-pj

## DB

```
DBは、sqliteを使用します。以下では、sqlite3を利用した説明のため、
sqlite3がインストールされていない場合は、準備してください。
```

### DB作成

`cmd`を起動し、以下のコマンドでDBを作成。

`sqlite3 <path>\<filename>.db`

dbが作成されると、コンソールには、以下のようなものが表示される。

```
C:\workspace\delphi-sample-pj>sqlite3 sample_db.db
SQLite version 3.39.2 2022-07-21 15:24:47
Enter ".help" for usage hints.
sqlite> 
```

db作成後、以下のように登録、参照することで利用できるようになる。

```
sqlite> CREATE TABLE IF NOT EXISTS users (
   ...>     id INTEGER PRIMARY KEY,
   ...>     name TEXT NOT NULL,
   ...>     age INTEGER,
   ...>     email TEXT UNIQUE
   ...> );
sqlite> INSERT INTO users (name, age, email) VALUES ('Alice', 30, 'alice@example.com');
sqlite> SELECT * FROM users;
1|Alice|30|alice@example.com
```

以下で終了することで、指定場所にdbファイルが作成されている。

`.exit`
