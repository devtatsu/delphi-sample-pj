@ECHO OFF

SETLOCAL

:: H2のダウンロードURL
SET H2_URL=https://github.com/h2database/h2database/releases/download/version-2.3.232/h2-2024-08-11.zip

:: ZIPファイル名
SET ZIP_FILE=h2.zip

:: 本batの配置場所のパス取得
SET CURRENT_PATH=%~dp0

:: カレントディレクトリを取得
SET CURRENT_DIR=%cd%

:: 2階層上のパスを取得
SET "PARENT_DIR=%CURRENT_DIR%\..\.."

:: 正規化
pushd "%PARENT_DIR%"
SET "GRANDPARENT_DIR=%cd%"
popd

:: カレントディレクトリ内で特定のフォルダが存在するか確認
IF exist "%GRANDPARENT_DIR%\BIN\H2Database\h2" (
    echo Folder "%GRANDPARENT_DIR%\BIN\H2Database\h2" already exists, so creating h2 db will be in progress.
    exit /b
)

:: インストール先のフォルダ
SET INSTALL_DIR=%GRANDPARENT_DIR%\BIN\H2Database

:: インストールディレクトリの作成
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)

:: H2データベースのダウンロード
echo Downloading H2 Database...
powershell -Command "Invoke-WebRequest -Uri %H2_URL% -OutFile %INSTALL_DIR%\%ZIP_FILE%"

:: ZIPファイルの解凍
echo Extracting H2 Database...
powershell -Command "Expand-Archive -Path '%INSTALL_DIR%\%ZIP_FILE%' -DestinationPath '%INSTALL_DIR%'"

:: ZIPファイルの削除
del "%INSTALL_DIR%\%ZIP_FILE%"

echo H2 Database installed in %INSTALL_DIR%.
endlocal

pause
