rem === перекомпиляция всех блюпринтов ===


@echo off

rem === Настраиваем путь к Unreal Editor Cmd ===
set UE_PATH=G:/Unreal Engine/UE_5.6
set UEEDITORCMD_EXE=%UE_PATH%/Engine/Binaries/Win64/UnrealEditor-Cmd.exe

rem === Проверяем существование исполняемого файла ===
if not exist "%UEEDITORCMD_EXE%" (
    echo ❌ Не найден UnrealEditor-Cmd.exe по пути:
    echo %UEEDITORCMD_EXE%
    pause
    exit /b 1
)


rem === Определяем текущую директорию проекта ===
set PROJECT_DIR=%~dp0

rem === Ищем .uproject файл в папке ===
for %%f in ("%PROJECT_DIR%*.uproject") do set PROJECT_PATH=%%f

rem === Проверка, найден ли проект ===
if "%PROJECT_PATH%"=="" (
    echo ❌ Не найден .uproject файл в папке: %PROJECT_DIR%
    pause
    exit /b 1
)

echo 🛠 Запуск компиляции всех блюпринтов...
echo UE Path: %UE_PATH%
echo Project: %PROJECT_PATH%
echo.

call "%UEEDITORCMD_EXE%" "%PROJECT_PATH%" -run=CompileAllBlueprints -ShowResultsOnly

pause
