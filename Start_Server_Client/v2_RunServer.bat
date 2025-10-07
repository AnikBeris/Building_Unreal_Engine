@echo off
title UE5 Dedicated Server - Marana
chcp 65001 >nul

REM === Настройки ===
set PROJECT_NAME=Marana
set PORT=4567
set ENGINE_PATH=E:\__EpicGames_UnrealEngine\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe
set PROJECT_PATH=%~dp0%PROJECT_NAME%.uproject
set LOG_DIR=%~dp0Logs
set LOG_FILE=%LOG_DIR%\Server_%DATE:~0,10%_%TIME:~0,2%-%TIME:~3,2%.log

REM === Проверка проекта ===
if not exist "%PROJECT_PATH%" (
    echo [ERROR] Проект "%PROJECT_NAME%.uproject" не найден по пути "%PROJECT_PATH%"
    pause
    exit /b 1
)

REM === Создание папки логов ===
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo Запуск сервера %PROJECT_NAME% на порту %PORT%...
echo Лог сохраняется в: %LOG_FILE%

REM === Запуск сервера ===
start "Server" ^
"%ENGINE_PATH%" "%PROJECT_PATH%" ^
-server -port=%PORT% -log -log="Logs/Server.log" ^
-abslog="%LOG_FILE%" ^
-Multiprocess -NoCrashDialog -NoLoadingScreen

REM === Ожидание завершения ===
echo Сервер запущен.
timeout /t 2 >nul
exit /b 0
