@echo off
rem === Настраиваемые пути ===
set UE_PATH=C:/UE_Source/UE_5.6
set PROJECT_PATH=I:/Nextcloud/Village/Villag/Village.uproject

rem === Автоматически формируем пути ===
set UAT_PATH=%UE_PATH%/Engine/Build/BatchFiles/RunUAT.bat
set UNREAL_CMD=%UE_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe

rem === Запуск сборки куков ===
cmd.exe /c ""%UAT_PATH%" ^
  -ScriptsForProject="%PROJECT_PATH%" ^
  Turnkey -command=VerifySdk -platform=Win64 -UpdateIfNeeded -EditorIO -EditorIOPort=62109 ^
  -project="%PROJECT_PATH%" ^
  BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook ^
  -project="%PROJECT_PATH%" ^
  -unrealexe="%UNREAL_CMD%" ^
  -platform=Win64 -installed -skipstage -nocompile -nocompileuat"

pause
