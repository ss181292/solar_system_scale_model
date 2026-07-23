#!/usr/bin/env python3
import os
import subprocess
import sys
from pathlib import Path

models_dir = os.path.dirname(os.path.abspath(__file__))

# Ścieżka do OpenSCAD (domyślnie dla Windows)
openscad_exe = r"C:\Program Files\OpenSCAD\openscad.com"

# Jeśli nie znaleźć, spróbuj wersji Nightly
if not os.path.exists(openscad_exe):
    openscad_exe = r"C:\Program Files\OpenSCAD (Nightly)\openscad.exe"

if not os.path.exists(openscad_exe):
    print("Błąd: Nie znaleziono OpenSCAD")
    sys.exit(1)

print(f"Używam OpenSCAD: {openscad_exe}\n")

# Pliki .scad do przetworzenia
scad_files = [
    'slonce.scad', 'merkury.scad', 'wenus.scad', 'ziemia.scad', 'mars.scad',
    'jowisz.scad', 'saturn.scad', 'uran.scad', 'neptun.scad',
    'pas_planetoid.scad', 'obrzeza_ukladu.scad', 'wstep.scad'
]

def generate_model(scad_file, format='3mf'):
    """Wygeneruj model w danym formacie"""
    scad_path = os.path.join(models_dir, scad_file)
    base_name = os.path.splitext(scad_file)[0]
    output_file = os.path.join(models_dir, f"{base_name}.{format}")

    if not os.path.exists(scad_path):
        print(f"[BRAK] {scad_file}")
        return False

    # Komenda do OpenSCAD
    # Dla 3MF nie używamy --render (jest szybszy)
    # Dla STL możemy użyć --render dla lepszej jakości, ale jest wolniejszy
    cmd = [openscad_exe, '-o', output_file, scad_path]

    print(f"Generuje: {scad_file} -> {base_name}.{format}...", end=' ', flush=True)

    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
        if result.returncode == 0:
            if os.path.exists(output_file):
                file_size = os.path.getsize(output_file)
                print(f"[OK] ({file_size:,} bajtów)")
                return True
            else:
                print("[BŁĄD] Plik nie został utworzony")
                return False
        else:
            print(f"[BŁĄD] Kod wyjścia: {result.returncode}")
            if result.stderr:
                print(f"  Stderr: {result.stderr[:200]}")
            return False
    except subprocess.TimeoutExpired:
        print("[TIMEOUT] (>120 sekund)")
        return False
    except Exception as e:
        print(f"[BŁĄD] {e}")
        return False

# Generuj modele w obu formatach
success_count = 0
total_count = len(scad_files)

print("=" * 60)
print("Generowanie modeli 3D tabliczek")
print("=" * 60 + "\n")

for scad_file in scad_files:
    # Generuj 3MF (szybciej)
    if generate_model(scad_file, '3mf'):
        success_count += 1

print(f"\n{'=' * 60}")
print(f"Wygenerowano: {success_count}/{total_count} modeli")
print(f"{'=' * 60}")
