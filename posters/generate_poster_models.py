#!/usr/bin/env python3
"""
Generuje pliki .scad dla tabliczek informacyjnych.
Tekst odwzorowuje formatowanie MD (**pogrubiony** / zwykły).
Marginesy 6 mm od wewnętrznej krawędzi ramki (8 mm).
QR wczytywany z .png, URL z .url.
"""

import os
import re
import html
from PIL import Image

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
MODELS_DIR = os.path.join(os.path.dirname(SCRIPT_DIR), "poster_models")

POSTER_NAMES = [
    'slonce', 'merkury', 'wenus', 'ziemia', 'mars',
    'jowisz', 'saturn', 'uran', 'neptun',
    'pas_planetoid', 'obrzeza_ukladu', 'wstep',
]

# ── Wymiary ───────────────────────────────────────────────────────────────────

PLAQUE_W = 120.0
PLAQUE_H = 170.0
PLAQUE_T = 2.0
FRAME_W  = 8.0
FRAME_H  = 3.0

MARGIN   = 6.0                          # od wewnętrznej krawędzi ramki
LEFT     = FRAME_W + MARGIN             # 14 mm od lewej krawędzi
RIGHT    = PLAQUE_W - FRAME_W - MARGIN  # 106 mm od lewej (= 14 mm od prawej)
TOP      = PLAQUE_H - FRAME_W - MARGIN  # 148 mm od dołu
BOTTOM   = FRAME_W + MARGIN             # 14 mm od dołu
TEXT_W   = RIGHT - LEFT                 # 92 mm dostępnej szerokości

# ── Czcionki i rozmiary ───────────────────────────────────────────────────────

PT         = 25.4 / 72.0
BODY_PT    = 10.0
TITLE_PT   = BODY_PT * 1.6
SYMBOL_PT  = TITLE_PT * 1.75
LINK_PT    = 9.0

BODY_MM    = BODY_PT   * PT   # ≈ 3.528 mm
TITLE_MM   = TITLE_PT  * PT   # ≈ 5.644 mm
SYMBOL_MM  = SYMBOL_PT * PT   # ≈ 9.877 mm
LINK_MM    = LINK_PT   * PT   # ≈ 3.175 mm

MAIN_FONT   = "Baloo 2"
BOLD_FONT   = "Baloo 2:style=Bold"
SYMBOL_FONT = "Liberation Sans:style=Bold"
LINK_FONT   = "Baloo 2:style=Bold"

LINE_H   = BODY_MM * 1.35   # odstęp między liniami
PARA_GAP = BODY_MM * 0.55   # dodatkowy odstęp między akapitami
RAISE    = 0.3               # wyniesienie tekstu nad płytę

# Szacunkowa szerokość znaku [mm] przy zawijaniu tekstu w Pythonie.
# Wartości dobrane empirycznie: Baloo 2 Bold 10 pt w 92 mm ≈ 25–34 zn./linię.
# Używamy ostrożnych wartości, żeby tekst nie wychodził poza margines.
CHAR_W_REG  = 2.45   # mm / znak, Baloo 2 regular
CHAR_W_BOLD = 2.70   # mm / znak, Baloo 2 bold

# ── QR ───────────────────────────────────────────────────────────────────────

QR_SIZE     = 37.8
QR_MARGIN   = 2.0    # od wewnętrznej krawędzi ramki (prawej / dolnej)
QR_LINK_GAP = 1.5    # odstęp między URL a dolną krawędzią QR

# Pozycja QR i URL (URL jest POD kodem QR)
# Y rośnie w górę w OpenSCAD.
URL_BOTTOM  = BOTTOM                        # dolna krawędź tekstu URL
URL_TOP     = URL_BOTTOM + LINK_MM          # górna krawędź tekstu URL
QR_BOTTOM   = URL_TOP + QR_LINK_GAP        # dolna krawędź kodu QR
QR_TOP      = QR_BOTTOM + QR_SIZE          # górna krawędź kodu QR
QR_RIGHT    = RIGHT                         # prawa krawędź QR
QR_LEFT     = QR_RIGHT - QR_SIZE           # lewa krawędź QR

ASTRO_SYMBOLS = '☉☿♀♁♂♃♄♅♆♇⊳'

HTML_ENTITIES = {
    '&#x2609;': '☉', '&#x263F;': '☿', '&#x2640;': '♀', '&#x2641;': '♁',
    '&#x2642;': '♂', '&#x2643;': '♃', '&#x2644;': '♄', '&#x2645;': '♅',
    '&#x2646;': '♆', '&#x2647;': '♇', '&#x26B3;': '⊳',
    '&nbsp;': '\xa0',  # U+00A0 – zachowaj jako nierozdzielającą podczas zawijania
}

# ── Pomocnicze ────────────────────────────────────────────────────────────────

def unescape(text):
    for entity, ch in HTML_ENTITIES.items():
        text = text.replace(entity, ch)
    return html.unescape(text)

def char_w(is_bold):
    return CHAR_W_BOLD if is_bold else CHAR_W_REG

def frag_width(text, is_bold):
    """Szacunkowa szerokość fragmentu tekstu [mm]."""
    return len(text) * char_w(is_bold)

def strip_nbsp(text):
    """Usuń spacje (także nierozdzielające) z początku i końca."""
    return text.strip('  ')

def esc(text):
    """Escape dla ciągów OpenSCAD. Zamień nbsp na zwykłą spację."""
    return text.replace('\xa0', ' ').replace('\\', '\\\\').replace('"', '\\"')

# ── Parser MD ─────────────────────────────────────────────────────────────────

def parse_inline(text):
    """
    Parsuje fragment tekstu zawierający **pogrubienie**.
    Zwraca listę (text, is_bold).
    """
    fragments = []
    parts = re.split(r'(\*\*)', text)
    bold = False
    for part in parts:
        if part == '**':
            bold = not bold
        elif part:
            fragments.append((part, bold))
    return fragments

def parse_md(path):
    """
    Parsuje plik MD i zwraca:
      title_frags  – lista (text, is_bold) dla tytułu
      sections     – lista (typ, frags)
                       typ = 'body'   – zwykły akapit (przerwa po nim)
                       typ = 'detail' – linia danych (**klucz:** wartość)
    """
    with open(path, encoding='utf-8') as f:
        raw = f.read()

    lines = raw.split('\n')

    title_raw = ''
    sections  = []
    body_acc  = []   # akumulowane linie bieżącego akapitu

    def flush_body():
        if body_acc:
            text = ' '.join(body_acc)
            sections.append(('body', parse_inline(unescape(text))))
            body_acc.clear()

    for raw_line in lines:
        line = raw_line.rstrip()

        if line.startswith('# '):
            title_raw = line[2:].strip()
            continue
        if line.startswith('#'):
            continue

        # Usuń znacznik łamania linii Markdown (dwie spacje na końcu)
        line = line.rstrip('  ').strip()
        line_unesc = unescape(line)

        if not line_unesc:
            flush_body()
            continue

        # Linia danych: zaczyna się od **...:**
        if line_unesc.startswith('**') and ':**' in line_unesc:
            flush_body()
            sections.append(('detail', parse_inline(line_unesc)))
        else:
            body_acc.append(line)

    flush_body()

    return parse_inline(unescape(title_raw)), sections

# ── Zawijanie tekstu ──────────────────────────────────────────────────────────

def wrap_frags(frags, max_w):
    """
    Zawija listę fragmentów (text, is_bold) do szerokości max_w [mm].
    Zwraca listę linii; każda linia to lista (text, is_bold).
    """
    # Rozwiń na słowa z informacją o pogrubieniu
    words = []
    for (text, is_bold) in frags:
        for word in text.split(' '):
            if word:
                words.append((word, is_bold))

    visual_lines = []
    cur_words    = []   # lista (word, is_bold)
    cur_w        = 0.0

    for (word, is_bold) in words:
        w     = frag_width(word, is_bold)
        space = char_w(is_bold)

        if cur_words and cur_w + space + w > max_w:
            visual_lines.append(merge_words(cur_words))
            cur_words = [(word, is_bold)]
            cur_w     = w
        else:
            if cur_words:
                cur_w += space
            cur_words.append((word, is_bold))
            cur_w += w

    if cur_words:
        visual_lines.append(merge_words(cur_words))

    return visual_lines

def merge_words(words):
    """
    Scala listę słów [(word, is_bold)] w listę fragmentów [(text, is_bold)],
    łącząc sąsiednie słowa tego samego stylu.
    """
    if not words:
        return []
    frags = []
    cur_text, cur_bold = words[0]
    for word, is_bold in words[1:]:
        if is_bold == cur_bold:
            cur_text += ' ' + word
        else:
            frags.append((strip_nbsp(cur_text), cur_bold))
            cur_text = ' ' + word
            cur_bold = is_bold
    frags.append((strip_nbsp(cur_text), cur_bold))
    return frags

def build_layout(sections, max_w):
    """
    Buduje layout tabliczki: listę linii wizualnych.
    Każda linia to lista (text, is_bold) lub [] (przerwa między akapitami).
    Przerwa jest dodawana między akapitami (body) i przed blokiem danych,
    ale NIE między kolejnymi liniami danych.
    """
    layout   = []
    prev_typ = None

    for (typ, frags) in sections:
        # Przerwa: tak, chyba że obie strony to 'detail'
        if prev_typ is not None and not (prev_typ == 'detail' and typ == 'detail'):
            layout.append([])

        wrapped = wrap_frags(frags, max_w)
        layout.extend(wrapped)
        prev_typ = typ

    return layout

# ── QR ───────────────────────────────────────────────────────────────────────

def load_qr_png(path):
    img = Image.open(path).convert('L')
    w, h = img.size
    matrix = [[1 if img.getpixel((x, y)) <= 127 else 0 for x in range(w)] for y in range(h)]
    return matrix, h

def load_url(path):
    with open(path, encoding='utf-8') as f:
        for line in f:
            if line.startswith('URL='):
                return line[4:].strip()
    return ''

# ── Generowanie SCAD ──────────────────────────────────────────────────────────

def mm(v):
    return f'{v:.4f}'

def emit_text(x, y, text, font, size_mm, halign='left', valign='top'):
    return (
        f'translate([{mm(x)}, {mm(y)}, {PLAQUE_T}]) '
        f'linear_extrude(height = {RAISE}) '
        f'text("{esc(text)}", size = {mm(size_mm)}, '
        f'font = "{font}", halign = "{halign}", valign = "{valign}");'
    )

def generate_scad(name):
    md_path  = os.path.join(SCRIPT_DIR, f'{name}.md')
    png_path = os.path.join(SCRIPT_DIR, f'{name}.png')
    url_path = os.path.join(SCRIPT_DIR, f'{name}.url')
    out_path = os.path.join(MODELS_DIR, f'{name}.scad')

    if not os.path.exists(md_path):
        print(f'[BRAK] {name}.md')
        return

    title_frags, sections = parse_md(md_path)
    qr_matrix, qr_modules = load_qr_png(png_path)
    url = load_url(url_path)

    # Rozdziel symbol astronomiczny od tytułu
    symbol     = ''
    title_rest = list(title_frags)
    if title_rest and title_rest[0][0] and title_rest[0][0][0] in ASTRO_SYMBOLS:
        symbol = title_rest[0][0][0]
        remainder = title_rest[0][0][1:].lstrip('  ')
        title_rest = ([(remainder, title_rest[0][1])] if remainder else []) + title_rest[1:]

    title_str = ''.join(t for t, _ in title_rest)

    # Oblicz pozycję X tytułu (za symbolem)
    title_x = LEFT
    if symbol:
        title_x = LEFT + SYMBOL_MM * 0.75 + 2.0

    # Zbuduj layout tekstu
    layout  = build_layout(sections, TEXT_W)

    # Oblicz Y dla każdej linii
    title_y      = TOP
    body_start_y = title_y - TITLE_MM * 1.5

    line_ys = []
    y = body_start_y
    for line in layout:
        line_ys.append(y)
        y -= LINE_H if line else (LINE_H + PARA_GAP)

    # ── Buduj plik SCAD ──────────────────────────────────────────────────────

    out = []

    def w(s=''):
        out.append(s)

    w(f'// Tabliczka: {esc(title_str or name)}')
    w(f'// Źródło:    posters/{name}.md')
    w()
    w(f'plaque_width     = {PLAQUE_W};')
    w(f'plaque_height    = {PLAQUE_H};')
    w(f'plaque_thickness = {PLAQUE_T};')
    w(f'frame_width      = {FRAME_W};')
    w(f'frame_height     = {FRAME_H};')
    w('screw_edge_margin    = 8;')
    w('screw_hole_diameter  = 4;')
    w('countersink_diameter = 8;')
    w('countersink_depth    = 2;')
    w('island_top_diameter  = 9;')
    w('island_base_diameter = 12;')
    w('island_height        = 3;')
    w('screw_x        = plaque_width / 2;')
    w('screw_y_top    = plaque_height - screw_edge_margin;')
    w('screw_y_bottom = screw_edge_margin;')
    w('color_white = [1, 1, 1];')
    w('color_black = [0, 0, 0];')
    w(f'qr_modules = {qr_modules};')
    w(f'qr_cell    = {mm(QR_SIZE)} / qr_modules;')
    w('qr_matrix = [')
    for row in qr_matrix:
        w('    [' + ','.join(str(c) for c in row) + '],')
    w('];')
    w(f'qr_url = "{esc(url)}";')
    w()

    # Moduły struktury
    w('module base_plate() {')
    w('    color(color_white)')
    w('        cube([plaque_width, plaque_height, plaque_thickness]);')
    w('}')
    w()
    w('module frame() {')
    w('    s = plaque_width - 2 * frame_width;')
    w('    color(color_black) {')
    w('        translate([0, 0, plaque_thickness])')
    w('            cube([frame_width, plaque_height, frame_height]);')
    w('        translate([plaque_width - frame_width, 0, plaque_thickness])')
    w('            cube([frame_width, plaque_height, frame_height]);')
    w('        translate([frame_width, 0, plaque_thickness])')
    w('            cube([s, frame_width, frame_height]);')
    w('        translate([frame_width, plaque_height - frame_width, plaque_thickness])')
    w('            cube([s, frame_width, frame_height]);')
    w('    }')
    w('}')
    w()
    w('module screw_island(x, y) {')
    w('    translate([x, y, plaque_thickness])')
    w('        cylinder(h=island_height, d1=island_base_diameter, d2=island_top_diameter, $fn=48);')
    w('}')
    w('module screw_islands() {')
    w('    color(color_black) {')
    w('        screw_island(screw_x, screw_y_top);')
    w('        screw_island(screw_x, screw_y_bottom);')
    w('    }')
    w('}')
    w('module screw_hole(x, y) {')
    w('    eps = 0.2;')
    w('    r1 = screw_hole_diameter / 2;')
    w('    r2 = countersink_diameter / 2;')
    w('    z0 = -eps;')
    w('    z1 = plaque_thickness + island_height - countersink_depth;')
    w('    z2 = plaque_thickness + island_height;')
    w('    z3 = max(z2, plaque_thickness + frame_height) + eps;')
    w('    translate([x, y, 0])')
    w('        rotate_extrude($fn=32)')
    w('            polygon([[0,z0],[r1,z0],[r1,z1],[r2,z2],[r2,z3],[0,z3]]);')
    w('}')
    w('module screw_holes() {')
    w('    screw_hole(screw_x, screw_y_top);')
    w('    screw_hole(screw_x, screw_y_bottom);')
    w('}')
    w()

    # Moduł tekstu – statyczne wywołania text()
    w('module body_text() {')
    w('    color(color_black) {')

    # Symbol
    if symbol:
        w(f'        {emit_text(LEFT, title_y, symbol, SYMBOL_FONT, SYMBOL_MM)}')

    # Tytuł
    if title_str:
        w(f'        {emit_text(title_x, title_y, title_str, BOLD_FONT, TITLE_MM)}')

    # Linie tekstu
    for i, line_frags in enumerate(layout):
        if not line_frags:
            continue
        ly = line_ys[i]
        x = LEFT
        for (frag_text, is_bold) in line_frags:
            if not frag_text.strip('  '):
                x += char_w(is_bold)
                continue
            font = BOLD_FONT if is_bold else MAIN_FONT
            w(f'        {emit_text(x, ly, frag_text, font, BODY_MM)}')
            x += frag_width(frag_text, is_bold)
            # Spacja między fragmentami na tej samej linii
            x += char_w(is_bold)

    w('    }')
    w('}')
    w()

    # Moduł QR (URL jest POD kodem QR)
    w('module qr_code() {')
    w('    color(color_black) {')
    w(f'        for (row = [0 : qr_modules - 1])')
    w(f'            for (col = [0 : qr_modules - 1])')
    w(f'                if (qr_matrix[row][col] == 1)')
    w(f'                    translate([{mm(QR_LEFT)} + col * qr_cell,')
    w(f'                               {mm(QR_BOTTOM)} + (qr_modules - 1 - row) * qr_cell,')
    w(f'                               {PLAQUE_T}])')
    w(f'                        cube([qr_cell, qr_cell, {RAISE}]);')
    w(f'        translate([{mm(QR_RIGHT)}, {mm(URL_BOTTOM)}, {PLAQUE_T}])')
    w(f'            linear_extrude(height = {RAISE})')
    w(f'                text(qr_url, size = {mm(LINK_MM)}, font = "{LINK_FONT}",')
    w(f'                     halign = "right", valign = "bottom");')
    w('    }')
    w('}')
    w()
    w('difference() { base_plate(); color(color_white) screw_holes(); }')
    w('difference() { union() { frame(); screw_islands(); } color(color_black) screw_holes(); }')
    w('body_text();')
    w('qr_code();')

    os.makedirs(MODELS_DIR, exist_ok=True)
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(out) + '\n')

    print(f'[OK] {name}.scad')

# ── Main ──────────────────────────────────────────────────────────────────────

for name in POSTER_NAMES:
    generate_scad(name)

print('Gotowe!')
