import subprocess

# Путь к программе
program_path = r"C:\UE_Source\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe"
# путь к запуску проекта
uproject_path = r"D:\_SVN Unreal Projects\village\Villag\Village.uproject"
base_dir = r"C:/UE_Source/UE_5.6/Engine/Binaries/Win64/"
# куда сохраняем логи
log_path = r"F:\LOG_HLOD\WorldPartitionHLODsBuilder.log"
# путь до карты
level_path = "/Game/_Games/1_Maps/1_1_GAMES_Level/L_Games_1"



arguments = [
    uproject_path,
    "-Unattended",
    f"-BaseDir={base_dir}",
    f"-AbsLog={log_path}",
    level_path,
    "-run=WorldPartitionBuilderCommandlet",
    # Билдим HLODs
    "-Builder=WorldPartitionHLODsBuilder",
    "-SetupHLODs",
    "-BuildHLODs",
    "-AllowCommandletRendering",
]



try:
    subprocess.run([program_path] + arguments, check=True)
    print("✅ Программа успешно запущена.")
except subprocess.CalledProcessError as e:
    print(f"❌ Ошибка при запуске программы: {e}")
except FileNotFoundError:
    print("❌ Указанный путь к Unreal Editor не найден. Проверьте его корректность.")
