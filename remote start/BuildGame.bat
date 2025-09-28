@echo off
rem === Настраиваемые пути ===
set UE_PATH=C:/UE_Source/UE_5.6
set PROJECT_PATH=I:/Nextcloud/Village/Villag/Village.uproject
set BUILD_OUTPUT=D:/BUILDs

rem === Автоматически формируем пути ===
set UAT_PATH=%UE_PATH%/Engine/Build/BatchFiles/RunUAT.bat
set UNREAL_CMD=%UE_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe

rem === Запуск сборки ===
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
