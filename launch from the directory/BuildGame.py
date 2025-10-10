import os
import subprocess
import glob
import sys

# === Определяем текущую директорию проекта ===
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

# === Ищем .uproject файл в папке ===
uproject_files = glob.glob(os.path.join(PROJECT_DIR, "*.uproject"))
if not uproject_files:
    print(f"❌ Не найден .uproject файл в папке: {PROJECT_DIR}")
    input("Нажмите Enter для выхода...")
    sys.exit(1)

PROJECT_PATH = uproject_files[0]

# === Настраиваем пути ===
UE_PATH = r"C:/UE_Source/UE_5.6"
BUILD_OUTPUT = r"D:/BUILDs"

# === Автоматически формируем пути ===
UAT_PATH = os.path.join(UE_PATH, "Engine/Build/BatchFiles/RunUAT.bat")
UNREAL_CMD = os.path.join(UE_PATH, "Engine/Binaries/Win64/UnrealEditor-Cmd.exe")

# === Проверка существования путей ===
for path_label, path in [
    ("UE_PATH", UE_PATH),
    ("UAT_PATH", UAT_PATH),
    ("UNREAL_CMD", UNREAL_CMD),
]:
    if not os.path.exists(path):
        print(f"❌ Путь не найден: {path_label} = {path}")
        input("Нажмите Enter для выхода...")
        sys.exit(1)

print("🚀 Запуск полной сборки проекта...")
print(f"UE Path: {UE_PATH}")
print(f"Project: {PROJECT_PATH}")
print(f"Output:  {BUILD_OUTPUT}\n")

# === Аргументы для RunUAT.bat ===
arguments = [
    UAT_PATH,
    f'-ScriptsForProject="{PROJECT_PATH}"',
    "Turnkey",
    "-command=VerifySdk",
    "-platform=Win64",
    "-UpdateIfNeeded",
    "-EditorIO",
    "-EditorIOPort=61842",
    f'-project="{PROJECT_PATH}"',
    "BuildCookRun",
    "-nop4",
    "-utf8output",
    "-nocompileeditor",
    "-skipbuildeditor",
    "-cook",
    f'-project="{PROJECT_PATH}"',
    f'-unrealexe="{UNREAL_CMD}"',
    "-platform=Win64",
    "-installed",
    "-stage",
    "-archive",
    "-package",
    "-build",
    "-clean",
    "-pak",
    "-iostore",
    "-compressed",
    "-prereqs",
    f'-archivedirectory="{BUILD_OUTPUT}"',
    "-distribution",
    "-manifests",
    "-clientconfig=Shipping",
    "-nodebuginfo",
    "-nocompile",
    "-nocompileuat",
]

# === Запуск процесса ===
try:
    subprocess.run(["cmd.exe", "/c"] + arguments, check=True)
    print("\n✅ Сборка успешно завершена.")
except subprocess.CalledProcessError as e:
    print(f"\n❌ Ошибка при выполнении сборки: {e}")
except FileNotFoundError:
    print("❌ Не найден RunUAT.bat или UnrealEditor-Cmd.exe.")
finally:
    input("\nНажмите Enter для выхода...")
