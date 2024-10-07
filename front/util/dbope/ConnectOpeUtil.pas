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

    function Connect: Boolean;          // �f�[�^�x�[�X�ɐڑ�
    procedure Disconnect;                // �f�[�^�x�[�X����ؒf
    function ExecuteSQL(const SQL: string): Boolean; // SQL�R�}���h�����s
    function QuerySQL(const SQL: string): TDataSet;  // SQL�N�G�������s
    property Connection: TFDConnection read FConnection;
  end;

implementation

{ TSQLiteDatabase }

constructor TSQLiteDatabase.Create(const DatabaseFile: string);
begin
  FDatabaseFile := DatabaseFile;

  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';  // SQLite�h���C�o�[���w��
  FConnection.Params.Database := FDatabaseFile; // �f�[�^�x�[�X�t�@�C���̃p�X
end;

destructor TSQLiteDatabase.Destroy;
begin
  Disconnect; // �ؒf���ă��\�[�X�����
  FConnection.Free;
  inherited;
end;

function TSQLiteDatabase.Connect: Boolean;
begin
  Result := False;
  try
    FConnection.Connected := True; // �ڑ����J��
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
    FConnection.Connected := False; // �ڑ������
  end;
end;

function TSQLiteDatabase.ExecuteSQL(const SQL: string): Boolean;
begin
  Result := False;
  if not FConnection.Connected then Exit;

  try
    FConnection.ExecSQL(SQL); // SQL�R�}���h�����s
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
    Query.Connection := FConnection; // �ڑ���ݒ�
    Query.SQL.Text := SQL;            // SQL��ݒ�
    Query.Open;                       // �N�G�������s
    Result := Query;                  // ���ʂ�Ԃ�
  except
    on E: Exception do
    begin
      Writeln('SQL query error: ' + E.Message);
      Query.Free; // �G���[��������Query�����
      Result := nil;
    end;
  end;
end;

end.

