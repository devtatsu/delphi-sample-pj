unit ConnectOpeUtil;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Stan.Param, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, Data.DB;

type
  TSQLiteDatabase = class
  private
    FConnection: TFDConnection;
    FDatabaseFile: string;
  public
    constructor Create(const DatabaseFile: string);
    destructor Destroy; override;

    function Connect: Boolean;          // データベースに接続
    procedure Disconnect;                // データベースから切断
    function ExecuteSQL(const SQL: string): Boolean; // SQLコマンドを実行
    function QuerySQL(const SQL: string): TDataSet;  // SQLクエリを実行
    property Connection: TFDConnection read FConnection;
  end;

implementation

{ TSQLiteDatabase }

constructor TSQLiteDatabase.Create(const DatabaseFile: string);
begin
  FDatabaseFile := DatabaseFile;

  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';  // SQLiteドライバーを指定
  FConnection.Params.Database := FDatabaseFile; // データベースファイルのパス
end;

destructor TSQLiteDatabase.Destroy;
begin
  Disconnect; // 切断してリソースを解放
  FConnection.Free;
  inherited;
end;

function TSQLiteDatabase.Connect: Boolean;
begin
  Result := False;
  try
    FConnection.Connected := True; // 接続を開く
    Result := True;
  except
    on E: Exception do
      Writeln('Database connection error: ' + E.Message);
  end;
end;

procedure TSQLiteDatabase.Disconnect;
begin
  if FConnection.Connected then
  begin
    FConnection.Connected := False; // 接続を閉じる
  end;
end;

function TSQLiteDatabase.ExecuteSQL(const SQL: string): Boolean;
begin
  Result := False;
  if not FConnection.Connected then Exit;

  try
    FConnection.ExecSQL(SQL); // SQLコマンドを実行
    Result := True;
  except
    on E: Exception do
      Writeln('SQL execution error: ' + E.Message);
  end;
end;

function TSQLiteDatabase.QuerySQL(const SQL: string): TDataSet;
var
  Query: TFDQuery;
begin
  Result := nil;
  if not FConnection.Connected then Exit;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection; // 接続を設定
    Query.SQL.Text := SQL;            // SQLを設定
    Query.Open;                       // クエリを実行
    Result := Query;                  // 結果を返す
  except
    on E: Exception do
    begin
      Writeln('SQL query error: ' + E.Message);
      Query.Free; // エラー発生時はQueryを解放
      Result := nil;
    end;
  end;
end;

end.

