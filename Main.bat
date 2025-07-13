@echo off
cls
setlocal enabledelayedexpansion
set "ScriptVersion=1.0.1"
title ClipStudio Paint Data Manager
goto :check_administrator_privilege

:check_administrator_privilege
net session >nul 2>&1
if %errorlevel% neq 0 (
echo Administrator privileges required...
timeout /t 2 /nobreak >nul
echo Please try run program with Administrator.
timeout /t 3 /nobreak >nul
exit
)
set "source=%~dp0"
set "MaterialPath="
set "logfile=!source!\log.txt"
set "ZipEXE=!source!module\7z.exe"
set "ZipDll=!source!module\7z.dll"
set "BackupPointFile=%appdata%\backup.point"
set "CSPUserData1=%appdata%\CELSYSUserData"
set "CSPUserData2=%appdata%\CELSYS"
for /d %%G in ("%appdata%\CELSYS_*") do (
if /I not "%%~nxG"=="CELSYS" (
set "CSPUserData3=%%G"
)
)
set "ConfigDBPath=!CSPUserData1!\CELSYS\CLIPStudioCommon\Preference\config.sqlite"
set "ConfigDBPathLocation=!CSPUserData1!\CELSYS\CLIPStudioCommon\Preference"
set "SQLiteEXE=!source!\module\sqlite3.exe"
set "SQLiteDLL=!source!\module\sqlite3.dll"
set "MaterialPathDefault=!CSPUserData1!\CELSYS\CLIPStudioCommon\Material"
set "MaterialPathDefaultDB=!CSPUserData1!\CELSYS\CLIPStudioCommon"
cls
mode con: cols=75 lines=25
goto check_module

:check_module
cls
echo Initializing...
echo Checking PowerShell environment... >> "%logfile%"
powershell -Command "Write-Output 'PowerShell OK'" >nul 2>&1
if %errorlevel% neq 0 (
echo [ERROR] PowerShell not available. >> "%logfile%"
echo Windows PowerShell not available or cannot start. Please check your system.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Windows PowerShell not available or cannot start. Please check your system','ClipStudio Paint Data Manager')"
timeout /t 3 /nobreak >nul
exit /b
) else (
echo PowerShell ready >> "%logfile%"
)
echo Checking SQLite3.exe at !SQLiteEXE! >> "%logfile%"
if not exist "!SQLiteEXE!" (
echo [ERROR] SQLite3.exe not found. >> "%logfile%"
echo SQLite3.exe was not found.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('SQLite3.exe was not found. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
echo Checking SQLite3.dll at !SQLiteDLL! >> "%logfile%"
if not exist "!SQLiteDLL!" (
echo [ERROR] SQLite3.dll not found. >> "%logfile%"
echo SQLite3.dll was not found.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('SQLite3.dll was not found. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 3 /nobreak >nul
exit /b
) else (
echo SQLite3.dll found >> "%logfile%"
)
) else (
echo SQLite3.exe found >> "%logfile%"
)
echo Verifying SQLite3 hashes... >> "%logfile%"
set "SHA256SQLite3EXE=E7E7FF8CFA4D85CA6CA10B9C81924EEF483912566B8A1EEA35EA505FC10B964F"
set "SHA256SQLite3DLL=44D7C8AAAD2C1E19AE50A6DF2A91CC8AF36D735691EFE0C19041E77F0FEE9A41"
for /f "delims=" %%i in ('powershell -Command "Get-FileHash -Algorithm SHA256 -Path '!SQLiteEXE!' ^| Select-Object -ExpandProperty Hash"') do (
set "SQLite3ExeHash=%%i"
)
for /f "delims=" %%i in ('powershell -Command "Get-FileHash -Algorithm SHA256 -Path '!SQLiteDLL!' ^| Select-Object -ExpandProperty Hash"') do (
set "SQLite3DllHash=%%i"
)
if /i "!SQLite3ExeHash!"=="!SHA256SQLite3EXE!" (
if /i "!SQLite3DllHash!"=="!SHA256SQLite3DLL!" (
echo SQLite3 hash verified successfully. >> "%logfile%"
) else (
echo [ERROR] SQLite3.dll hash mismatch. >> "%logfile%"
echo Hash mismatch for SQLite3.dll.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Hash mismatch for SQLite3.dll. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 3 /nobreak >nul
exit /b
)
) else (
echo [ERROR] SQLite3.exe hash mismatch. >> "%logfile%"
echo Hash mismatch for SQLite3.exe.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Hash mismatch for SQLite3.exe. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 3 /nobreak >nul
exit /b
)
echo Checking 7-Zip module exist >> "%logfile%"
if exist "!ZipEXE!" (
if exist "!ZipDll!" (
echo Checking hash Module... >> "%logfile%"
set "SHA256ZipEXE=B200B887BD7CBF83FA4FEEF54797622D04729144DD58428A97982839F3134BA5"
set "SHA256ZipDLL=AFFFCF0732BF096AEE18D2AB6363DF21F53EBC053412747D64BDB6FF8E56ECF0"
for /f "delims=" %%i in ('powershell -Command "Get-FileHash -Algorithm SHA256 -Path '!ZipEXE!' ^| Select-Object -ExpandProperty Hash"') do (
set "ZipExeHash=%%i"
)
for /f "delims=" %%i in ('powershell -Command "Get-FileHash -Algorithm SHA256 -Path '!ZipDll!' ^| Select-Object -ExpandProperty Hash"') do (
set "ZipDllHash=%%i"
)
if /i "!ZipExeHash!"=="!SHA256ZipEXE!" (
if /i "!ZipDllHash!"=="!SHA256ZipDLL!" (
echo Hash verified. >> "%logfile%"
goto manage_userdata
)
)
echo Hash mismatch. Exiting...
echo [ERROR] Hash mismatch. >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('7-Zip module hash mismatch. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 3 /nobreak >nul
exit
) else (
echo 7z.dll not found. Exiting...
echo [ERROR] 7z.dll missing >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('7z.dll not found. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 2 /nobreak >nul
exit
)
) else (
echo 7z.exe not found. Exiting...
echo [ERROR] 7z.exe missing >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('7z.exe not found. Try re-download application or check module manually','ClipStudio Paint Data Manager')"
timeout /t 2 /nobreak >nul
exit
)

:check_material_location
for /f "delims=" %%i in ('""!SQLiteEXE!" "!ConfigDBPath!" "SELECT DataFolderPath FROM CategoryFolderPath LIMIT 1;""') do (
set "MaterialPath=%%i"
)
if not defined MaterialPath (
set "MaterialPath=!MaterialPathDefault!"
)
goto :eof


:check_program_running
set "flag=0"
tasklist /FI "IMAGENAME eq ClipStudio.exe" | find /I "ClipStudio.exe" >nul
if not errorlevel 1 (
set "flag=1"
)
tasklist /FI "IMAGENAME eq ClipStudioPaint.exe" | find /I "ClipStudioPaint.exe" >nul
if not errorlevel 1 (
set "flag=1"
)
if "%flag%"=="1" (
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('ClipStudio Apps is running. Please close the program before proceeding.','ClipStudio Paint Data Manager')"
cls
goto check_program_running
)
goto :eof

:manage_userdata
call :reset_value
call :check_material_location
cls
echo ======================================================================
echo     		  ClipStudio Paint Data Manager v!ScriptVersion!
echo ======================================================================
echo.
echo		[1]. Backup my CLIPStudioPaint UserData
echo		[2]. Restore my CLIPStudioPaint UserData
echo		[3]. Wipe all my current CLIPStudioPaint UserData
echo		[4]. Get help
echo		[5]. Show license
echo.
echo		[0]. Open log
echo.
echo ======================================================================
echo.
echo Press number key to select your choice

choice /c 123450 /n
if errorlevel 6 goto open_log
if errorlevel 5 goto open_license
if errorlevel 4 goto gethelp
if errorlevel 3 goto check_delete_userdata
if errorlevel 2 goto select_file_contain_backup
if errorlevel 1 goto check_userdata_exist_for_backup

:open_license
start notepad "!source!\LICENSE.txt"
goto manage_userdata

:open_log
start notepad "!logfile!" >nul
goto manage_userdata

:gethelp
cls
timeout /t 1 /nobreak >nul
echo ======================================================================
echo 				Help
echo ======================================================================
echo 1. Your data backup file has *.bak extension.
echo 2. If you want to see *.bak content(s), use WinRAR or 7-Zip.
echo 3. Content(s) in *.bak file(s) does not encrypt. If you want more security, encrypt it with 3rd-party program.
echo 4. If you get any trouble, contact technican and send them log.txt file to get assistance.
echo.
echo Press any key to go back Menu
pause >nul
cls
goto manage_userdata

:select_file_contain_backup
cls
echo Select file contain backup
for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object Windows.Forms.OpenFileDialog; $dialog.Filter = 'Backup Files (*.bak)|*.bak'; $dialog.Title = 'Select file'; $dialog.ShowDialog() | Out-Null; $dialog.FileName"') do set SelectedBak=%%i
if not defined SelectedBak (
echo No file selected. Returning to menu...
timeout /t 2 /nobreak >nul
goto manage_userdata
)
echo Selected: !SelectedBak!
goto verify_backup_point

:select_location_save_backup
echo Select location to save
for /f "delims=" %%i in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object Windows.Forms.SaveFileDialog; $dialog.Filter = 'Backup Files (*.bak)|*.bak'; $dialog.Title = 'Save to'; $dialog.ShowDialog() | Out-Null; $dialog.FileName"') do set SaveFile=%%i
goto :eof

:start_backup
cls
call :check_program_running
call :merge_material_data
if exist "!CSPUserData1!\" (
echo Checking "!CSPUserData1!" >> "!BackupPointFile!"
echo Status1: OK >> "!BackupPointFile!"
) else (
echo Checking "!CSPUserData1!" >> "!BackupPointFile!"
echo Status1: NOTFOUND >> "!BackupPointFile!"
)
if exist "!CSPUserData2!\" (
echo Checking "!CSPUserData2!" >> "!BackupPointFile!"
echo Status2: OK >> "!BackupPointFile!"
) else (
echo Checking "!CSPUserData2!" >> "!BackupPointFile!"
echo Status2: NOTFOUND >> "!BackupPointFile!"
)
if exist "!CSPUserData3!\" (
echo Checking "!CSPUserData3!" >> "!BackupPointFile!"
echo Status3: OK >> "!BackupPointFile!"
) else (
echo Checking "!CSPUserData3!" >> "!BackupPointFile!"
echo Status3: NOTFOUND >> "!BackupPointFile!"
)
if not "!MaterialPath!"=="!MaterialPathDefault!" (
echo Checking "!MaterialPathDefault!" >> "!BackupPointFile!"
echo Status4: 0 >> "!BackupPointFile!"
) else (
echo Checking "!MaterialPathDefault!" >> "!BackupPointFile!"
echo Status4: 1 >> "!BackupPointFile!"
)
echo Backing up...
echo Do not close this window...
echo [ACTION] Start backup >> "%logfile%"
start /wait /b "" "!ZipEXE!" a "!SaveFile!" "!CSPUserData1!" "!CSPUserData2!" "!CSPUserData3!" "!BackupPointFile!"
if exist "!BackupPointFile!" (
del /f /q "!BackupPointFile!"
)
if exist "!ConfigDBPathLocation!\ConfigBackup.sqlite" (
call :recover_old_database
)
goto :eof

:check_userdata_exist_for_backup
cls
if exist "!CSPUserData1!" (
echo Found "!CSPUserData1!". Proceeding...
call :select_location_save_backup
if not defined SaveFile (
echo No path selected. Returning to menu...
timeout /t 2 /nobreak >nul
goto manage_userdata
) else (
call :start_backup
call :check_backup_status
)
) else (
echo CELSYSUserData not found. Nothing to backup.
echo [ERROR] CELSYSUserData not found >> "%logfile%"
pause
goto manage_userdata
)


:check_backup_status
if exist "!SaveFile!" (
echo Backup completed successfully.
echo [INFO] Backup completed. >> "%logfile%"
echo Your backup location is: !SaveFile!
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Backup completed','ClipStudio Paint Data Manager')"
goto manage_userdata
) else (
echo Backup failed
echo [ERROR] Backup failed >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Backup failed','ClipStudio Paint Data Manager')"
pause
goto manage_userdata
)

:check_userdata_exist_for_restore
cls
if exist "!CSPUserData1!" (
echo Detected old appdata >> "%logfile%"
echo Detected old appdata.
echo [WARNING] This action will overwrite your current app data.
echo Do you want to continue?
echo.
echo [Y]= YES				[N]= NO
choice /c YN /n
if errorlevel 2 goto manage_userdata
if errorlevel 1 goto start_restore
)

:start_restore
call :check_program_running
set "DesExtr=!SelectedBak!"
set "outdir=%appdata%"
if not exist "!DesExtr!" (
echo Error: Backup file not found.
echo [ERROR] Backup file not found >> "%logfile%"
pause
goto manage_userdata
) else (
cls
echo Restoring...
echo [ACTION] Start restore >> "%logfile%"
echo Do not close this window...
start /wait /b "" "!ZipEXE!" x "%DesExtr%" -o"%outdir%" -y
if exist "!BackupPointFile!" (
del /f /q "!BackupPointFile!"
)
"%ZipEXE%" e "!SelectedBak!" "backup.point" -o"%temp%\backup_check" -y -bd >nul
findstr /c:"Status4: 1" "%temp%\backup_check\backup.point" >nul
if errorlevel 1 (
echo Detected need rebuild material database.
echo [INFO] Detected need rebuild material database  >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Restore successfully. But to ensure the material works stably, please use ClipStudio to rebuild the material database','ClipStudio Paint Data Manager')"
)
if exist "%temp%\backup_check" (
rmdir /S /Q "%temp%\backup_check" >nul
)
echo Restore completed.
echo [INFO] Restore completed >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Restore completed','ClipStudio Paint Data Manager')"
goto manage_userdata
)

:check_delete_userdata
cls
if exist "!CSPUserData1!" (
timeout /t 1 /nobreak >nul
echo Found "!CSPUserData1!".
echo [WARNING] This action CANNOT BE UNDONE. Deleted data CANNOT be recovered.
echo Make sure you have backed up your data before.
echo Do you want to continue?
echo.
echo [Y] YES			[N] No
choice /c YN /n
if errorlevel 2 goto manage_userdata
if errorlevel 1 goto wipe_all_userdata
) else (
timeout /t 1 /nobreak >nul
echo CELSYSUserData not found. Nothing to delete.
echo [WARN] CELSYSUserData not found >> "%logfile%"
echo Press any key to go back.
pause >nul
goto manage_userdata
)

:wipe_all_userdata
cls
call :check_program_running
timeout /t 1 /nobreak >nul
echo [INFO] Deleting CELSYSUserData... >> "%logfile%"
echo Deleting...
rmdir /S /Q "!CSPUserData1!" >> "%logfile%"
rmdir /S /Q "!CSPUserData2!" >> "%logfile%"
rmdir /S /Q "!CSPUserData3!" >> "%logfile%"
echo [INFO] Deleted CELSYSUserData. >> "%logfile%"
echo Deleted CELSYSUserData.
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Deleted','ClipStudio Paint Data Manager')"
goto manage_userdata

:verify_backup_point
echo Checking file...
"%ZipEXE%" l "!SelectedBak!" | findstr /i "backup.point" >nul
if errorlevel 1 (
echo [ERROR] backup.point not found inside backup file >> "%logfile%"
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Invalid backup file: backup.point not found','ClipStudio Paint Data Manager')"
goto manage_userdata
)
"%ZipEXE%" e "!SelectedBak!" "backup.point" -o"%temp%\backup_check" -y -bd >nul
findstr /c:"Status1: OK" "%temp%\backup_check\backup.point" >nul
if errorlevel 1 (
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('This file is not a valid backup','ClipStudio Paint Data Manager')"
echo Invalid backup.
echo [ERROR] Invalid backup >> "%logfile%"
if exist "%temp%\backup_check" (
rmdir /S /Q "%temp%\backup_check" >nul
)
goto manage_userdata
) else (
echo Valid backup found.
echo [INFO] Valid backup found  >> "%logfile%"
timeout /t 2 /nobreak >nul
if exist "%temp%\backup_check\" (
rmdir /S /Q "%temp%\backup_check" >> "%logfile%"	
)
goto check_userdata_exist_for_restore
)

:merge_material_data
call :check_program_running
if not "!MaterialPath!"=="!MaterialPathDefault!" (
echo [INFO] Detected material path is not default >> "%logfile%"
echo Detected material path is not default. Script merging and updating data...
echo Keep this window running. DO NOT CLOSE this window.
if not exist "!MaterialPathDefault!" (
mkdir "!MaterialPathDefault!"
)
echo [ACTION] Temporary update to database done for data merge >> "%logfile%"
if exist "!ConfigDBPath!" (
copy "!ConfigDBPath!" "!ConfigDBPathLocation!\ConfigBackup.sqlite" >nul
) else (
echo [WARN] File config.sqlite not exist.
echo [WARN] File config.sqlite not exist  >> "%logfile%"
)
xcopy "!MaterialPath!\*" "!MaterialPathDefaultDB!" /E /H /C /Y >nul
"!SQLiteEXE!" "!ConfigDBPath!" "UPDATE CategoryFolderPath SET DataFolderPath = NULL, OldDataFolderPath = NULL;"
)

goto :eof


:recover_old_database
echo [ACTION] Restore original database after merge. >> "%logfile%"
del "!ConfigDBPath!" >nul
ren "!ConfigDBPathLocation!\ConfigBackup.sqlite" "Config.sqlite"
goto :eof


:reset_value
echo Reset value >> "%logfile%"
set "SelectedBak="
set "SaveFile="
set "MaterialPath="
goto :eof