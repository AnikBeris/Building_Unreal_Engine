@echo off
title UE5 Client - Marana
chcp 65001 >nul

REM === Настройки ===
set PROJECT_NAME=Marana
set ENGINE_PATH=E:\__EpicGames_UnrealEngine\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe
set PROJECT_PATH=%~dp0%PROJECT_NAME%.uproject
set LOG_DIR=%~dp0Logs
set SERVER_IP=127.0.0.1
set PORT=4567
set LOG_FILE=%LOG_DIR%\Client_%DATE:~0,10%_%TIME:~0,2%-%TIME:~3,2%.log

REM === Проверка проекта ===
if not exist "%PROJECT_PATH%" (
    echo [ERROR] Проект "%PROJECT_NAME%.uproject" не найден по пути "%PROJECT_PATH%"
    pause
    exit /b 1
)

REM === Создание папки логов ===
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

REM === Проверка аргументов ===
if not "%~1"=="" (
    set SERVER_IP=%~1
)
if not "%~2"=="" (
    set PORT=%~2
)

echo Подключение клиента %PROJECT_NAME% к %SERVER_IP%:%PORT%
echo Лог сохраняется в: %LOG_FILE%

REM === Запуск клиента ===
start "Client" ^
"%ENGINE_PATH%" "%PROJECT_PATH%" ^
"%SERVER_IP%:%PORT%" -game -log ^
-abslog="%LOG_FILE%" ^
-NoCrashDialog -NoLoadingScreen -ResX=1600 -ResY=900 -Windowed

REM === Ожидание завершения ===
echo Клиент запущен.
timeout /t 2 >nul
exit /b 0
