@echo Off
cd /d %~dp0
:choose
echo 下載安裝所需的 筆硯安裝檔 與 微軟MDAC 2.8 SP1
set /P input="此兩軟體版權為原公司所有 下載請按 Y 或按 N 取消安裝 (Y/N)?"

if /I "%input%"=="Y" goto agree
if /I "%input%"=="N" echo "謝謝 掰~" && Goto End
echo 請選 Y 或 N
goto choose

:nofile
echo 錯誤: 下載檔案不存在
set /P input="按任意鍵結束"
goto end

:agree
REM 下載資料
@powershell -NoProfile -ExecutionPolicy Bypass .\files\get_files.ps1

REM 安裝軟體
if not exist .\files\MDAC_TYP.EXE goto nofile
if not exist .\files\docNinstall.msi goto nofile

START "" /WAIT .\files\MDAC_TYP.EXE /Q
START "" /WAIT .\files\docNinstall.msi /quiet

REM 加入信任網域
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "http" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 163.29.37.107 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "https" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 163.29.37.107 /f

REM 允許快顯
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\New Windows\Allow" /v "163.29.37.107" /t REG_BINARY /d 0000 /f

REM 允許信任網域啟用 ActiveX
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f

REM 砍了安裝完 docNinstall 的選擇應用程式視窗
taskkill /F /IM OpenWith.exe /T >nul

REM 替換桌面連結
del %SystemDrive%\Users\Public\Desktop\文書編輯-公文製作.lnk /f /q
copy /Y .\files\文書編輯-公文製作_IE32.lnk %SystemDrive%\Users\Public\Desktop\

:end