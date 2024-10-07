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
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  cnt: Integer;
  AppPath, ParentPath: string;
begin

  // ���s�t�@�C���̃p�X���擾
  AppPath := ExtractFilePath(ParamStr(0));

  // 2�K�w��̃p�X���擾
  ParentPath := ExtractFileDir(ExtractFileDir(ExtractFileDir(ExtractFileDir(AppPath))));

  // �p�X��\��
  ShowMessage('�A�v���P�[�V�����̃p�X: ' + ParentPath);

  // �f�[�^�x�[�X�ڑ��̐ݒ�
  FDConnection1.DriverName := 'SQLite';
  // FDConnection1.Params.Database := 'C:\workspace\delphi-sample-pj\sample_db.db';  // �f�[�^�x�[�X�t�@�C���̃p�X
  FDConnection1.Params.Database := ParentPath + '\sample_db.db';  // �f�[�^�x�[�X�t�@�C���̃p�X
  FDConnection1.LoginPrompt := False;
  FDConnection1.Connected := True;

  // �N�G���̐ݒ�
  FDQuery1.Connection := FDConnection1;
  FDQuery1.SQL.Text := 'SELECT count(*) as aa FROM users';  // �f�[�^���擾����N�G��
  FDQuery1.Open;  // �N�G�������s���ăf�[�^���擾

  cnt := FDQuery1.FieldByName('aa').AsInteger;

  ShowMessage(Format('Count: %d', [cnt]));

end;

end.
