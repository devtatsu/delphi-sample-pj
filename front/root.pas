unit Root;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Vcl.StdCtrls, ConnectOpeUtil;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  cnt: Integer;
  AppPath, ParentPath: string;
  SQLiteDB: TSQLiteDatabase;
  DataSet: TDataSet;

begin

  // 実行ファイルのパスを取得
  AppPath := ExtractFilePath(ParamStr(0));

  // 2階層上のパスを取得
  ParentPath := ExtractFileDir(ExtractFileDir(ExtractFileDir(ExtractFileDir(AppPath))));

  // パスを表示
  ShowMessage('app root path: ' + ParentPath);

  SQLiteDB := TSQLiteDatabase.Create(ParentPath + '\sample_db.db');

  try
    if SQLiteDB.Connect then
    begin

      // データの取得
      DataSet := SQLiteDB.QuerySQL('SELECT * FROM users;');
      try
        if Assigned(DataSet) then
        begin
          // データセットを処理する（例: Gridに表示するなど）
          ShowMessage('Records: ' + IntToStr(DataSet.RecordCount));
        end
        else
        begin
          ShowMessage('Query returned no data.');
        end;
      finally
        DataSet.Free; // データセットの解放
      end;

      // 切断
      SQLiteDB.Disconnect;
    end
    else
      ShowMessage('Failed to connect to the database.');
  finally
    SQLiteDB.Free; // SQLiteDBインスタンスの解放
  end;

end;

end.
