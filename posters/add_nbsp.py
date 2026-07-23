#!/usr/bin/env python3
import os
import re
from pathlib import Path

posters_dir = os.path.dirname(os.path.abspath(__file__))

# Pliki do przetworzenia
poster_files = [
    'slonce.md', 'merkury.md', 'wenus.md', 'ziemia.md', 'mars.md',
    'jowisz.md', 'saturn.md', 'uran.md', 'neptun.md',
    'pas_planetoid.md', 'obrzeza_ukladu.md', 'wstep.md'
]

def add_nbsp_before_short_words(text):
    """Dodaj &nbsp; za pojedynczymi literami i krótkim słowami"""

    # Krótkie słowa i litery, które powinny mieć &nbsp; za nimi
    # Litery: a, i, o, u, w, z (te które mogą być samodzielne)
    # Słowa: na, do, po, dla, jak, to, nie, są, ze, że, by, czy

    result = text

    # Najpierw pojedyncze litery
    single_letters = ['a', 'i', 'o', 'u', 'w', 'z']
    for letter in single_letters:
        # Dopasuj: [słowo] spacja [litera] spacja [następne słowo]
        # Zamień na: [słowo] spacja [litera] &nbsp; [następne słowo]
        pattern = r'(\S)\s+(' + re.escape(letter) + r')\s+([a-ząćęłńóśźż])'
        replacement = r'\1 \2&nbsp;\3'
        result = re.sub(pattern, replacement, result, flags=re.IGNORECASE)

    # Potem krótkie słowa
    short_words = ['na', 'do', 'po', 'dla', 'jak', 'to', 'nie', 'są', 'ze', 'że', 'by', 'czy']
    for word in short_words:
        pattern = r'(\S)\s+(' + re.escape(word) + r')\s+([a-ząćęłńóśźż])'
        replacement = r'\1 \2&nbsp;\3'
        result = re.sub(pattern, replacement, result, flags=re.IGNORECASE)

    return result

def process_file(file_path):
    """Przetwórz plik MD"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    lines = content.split('\n')
    updated_lines = []

    for line in lines:
        # Nie dodawaj &nbsp; w nagłówkach (linie zaczynające się od #)
        # ani w linijkach z danymi (zaczynające się od **)
        if line.startswith('#') or line.startswith('**'):
            updated_lines.append(line)
        else:
            # Najpierw usuń stare &nbsp; (zamień na zwykłą spację)
            cleaned_line = line.replace('&nbsp;', ' ')
            # Potem dodaj &nbsp; w prawidłowych miejscach
            updated_line = add_nbsp_before_short_words(cleaned_line)
            updated_lines.append(updated_line)

    updated_content = '\n'.join(updated_lines)

    # Zapisz plik tylko jeśli zmieniła się zawartość
    if updated_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(updated_content)
        print(f"[OK] Zaktualizowano: {os.path.basename(file_path)}")
        return True
    else:
        print(f"[BRAK ZMIAN] {os.path.basename(file_path)}")
        return False

# Przetwórz każdy plik
updated_count = 0
for md_file in poster_files:
    file_path = os.path.join(posters_dir, md_file)
    if os.path.exists(file_path):
        if process_file(file_path):
            updated_count += 1
    else:
        print(f"[BRAK] {md_file}")

print(f"\nZaktualizowano {updated_count} plików.")
