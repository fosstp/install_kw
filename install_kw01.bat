@echo Off
cd /d %~dp0
:choose
echo �U���w�˩һݪ� ���x�w���� �P �L�nMDAC 2.8 SP1
set /P input="����n�骩�v���줽�q�Ҧ� �U���Ы� Y �Ϋ� N �����w�� (Y/N)?"

if /I "%input%"=="Y" goto agree
if /I "%input%"=="N" echo "���� �T~" && Goto End
echo �п� Y �� N
goto choose

:nofile
echo ���~: �U���ɮפ��s�b
set /P input="�����N�䵲��"
goto end

:agree
REM �U�����
@powershell -NoProfile -ExecutionPolicy Bypass .\files\get_files.ps1

REM �w�˳n��
if not exist .\files\MDAC_TYP.EXE goto nofile
if not exist .\files\docNinstall.msi goto nofile

START "" /WAIT .\files\MDAC_TYP.EXE /Q
START "" /WAIT .\files\docNinstall.msi /quiet

REM �[�J�H������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "http" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 163.29.37.107 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "https" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 163.29.37.107 /f

REM ���\����
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\New Windows\Allow" /v "163.29.37.107" /t REG_BINARY /d 0000 /f

REM ���\�H������ҥ� ActiveX
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f

REM ��F�w�˧� docNinstall ��������ε{������
taskkill /F /IM OpenWith.exe /T >nul

REM �����ୱ�s��
del %SystemDrive%\Users\Public\Desktop\��ѽs��-����s�@.lnk /f /q
copy /Y .\files\��ѽs��-����s�@_IE32.lnk %SystemDrive%\Users\Public\Desktop\

:end