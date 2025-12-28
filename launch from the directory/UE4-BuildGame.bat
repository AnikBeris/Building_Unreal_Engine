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
set UE_PATH=C:/UE_Source/UE_5.6
set BUILD_OUTPUT=D:/BUILDs

rem === Автоматически формируем пути ===
set UAT_PATH=%UE_PATH%/Engine/Build/BatchFiles/RunUAT.bat
set UNREAL_CMD=%UE_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe

echo 🚀 Запуск полной сборки проекта...
echo UE Path: %UE_PATH%
echo Project: %PROJECT_PATH%
echo Output:  %BUILD_OUTPUT%
echo.

cmd.exe /c ""%UAT_PATH%" ^
  -ScriptsForProject="%PROJECT_PATH%" ^
  Turnkey -command=VerifySdk -platform=Win64 -UpdateIfNeeded -EditorIO -EditorIOPort=61842 ^
  -project="%PROJECT_PATH%" ^
  BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook ^
  -project="%PROJECT_PATH%" ^
  -unrealexe="%UNREAL_CMD%" ^
  -platform=Win64 -installed -stage -archive -package -build -clean ^
  -pak -iostore -compressed -prereqs ^
  -archivedirectory="%BUILD_OUTPUT%" -distribution -manifests ^
  -clientconfig=Shipping -nodebuginfo -nocompile -nocompileuat"

pause
