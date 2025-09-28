@echo off
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

rem === Настраиваем пути ===
set UE_PATH=C:/UE_Source/UE_5.4

rem === Автоматически формируем пути ===
set UAT_PATH=%UE_PATH%/Engine/Build/BatchFiles/RunUAT.bat
set UNREAL_CMD=%UE_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe

echo 🍳 Запуск сборки куков...
echo UE Path: %UE_PATH%
echo Project: %PROJECT_PATH%
echo.

cmd.exe /c ""%UAT_PATH%" ^
  -ScriptsForProject="%PROJECT_PATH%" ^
  Turnkey -command=VerifySdk -platform=Win64 -UpdateIfNeeded -EditorIO -EditorIOPort=62109 ^
  -project="%PROJECT_PATH%" ^
  BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook ^
  -project="%PROJECT_PATH%" ^
  -unrealexe="%UNREAL_CMD%" ^
  -platform=Win64 -installed -skipstage -nocompile -nocompileuat"

pause
