# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

A scale model of the Solar System. The repository currently contains two kinds of content:

- **`facts.md`** — a Polish-language reference document with a data table and per-body sections (Sun, planets, asteroid belt, dwarf planets) covering diameter, distance from the Sun, mass, orbital period, and moon orbital radii. This is the source of truth for any astronomical figures used elsewhere in the project (e.g. when computing scale ratios for physical models).
- **`cassette.scad`** — an OpenSCAD model of a physical cassette/container (base + cover) with mounting holes, presumably used to house part of the physical scale model. `cassette.stl` and `cassette.3mf` are exported renders of this model.
- **`log.md`** — a running changelog of edits made to `facts.md`, written in Polish, describing each addition (new columns, new bodies, new data fields) in chronological order.

## Working conventions

- `facts.md` and `log.md` are written in Polish. Keep new entries consistent with the existing language and style.
- When editing `facts.md`, update `log.md` with a new numbered entry describing the change (matching the existing format: short heading + bullet points summarizing what was added/changed).
- Numeric data in `facts.md` uses space-separated thousands (e.g. `1 391 000`) and scientific notation for mass (e.g. `1,989 × 10³⁰ kg`, using a comma as decimal separator per Polish convention).
- `cassette.scad` uses parametric variables defined at the top of each section (cassette body, then cover) — adjust those named parameters rather than hardcoding new dimensions inline.

## Tooling

- OpenSCAD (`.scad` files) is used to generate the 3D model; `.stl`/`.3mf` are exported outputs. There is no build script — regenerate exports manually via the OpenSCAD GUI/CLI after editing `cassette.scad`.
- No automated tests, linters, or build commands exist in this repository.

## Tabliczki z opisami

- Tabliczki z opisami powinny znajdować się w katalogu poster_models.
- Źródłem tekstu dla tabliczek powinny być odpowiednie pliku z katalodu posters.
- Każda tabliczka powinna być modelem 3D w formacie OpenSCAD.
- Tabliczka powinna mieć wymiar 120mm szerokości na 170mm wysokości.
- Tabliczka powinna być biała.
- Tabliczka powinna mieć 2mm grubości.
- Tabliczka powinna mieć czarną ramkę 8mm szeroką, grubą na 3mm o przekroju prostokątnym.
- Podstawowy tekst powinien być napisany czcionką Georgia w rozmiarze 10pt.
- Tekst powinien być czarny, wyniesiony 0.3mm do góry.
- W prawym dolnym rogu powinien być kod QR odnoszący do strony http://solarsystem.skowron.it/{nazwa_planety}/ (nazwa planety w języku Angielskim).
- Pod kodem QR powinien być odnośnik napisany czcionką Lucida Sans Typewriter w rozmiarze 8pt, poprzedzony "http://", z 1mm odstępu od kodu QR.

### Implementacja - wnioski z poster_models/earth.scad

`poster_models/earth.scad` jest wzorcem dla kolejnych tabliczek. Przy nowej tabliczce kopiuj jego strukturę modułów (`base_plate`, `frame`, `screw_island`/`screw_islands`, `screw_hole`/`screw_holes`, `body_text`, `qr_code`) i podmieniaj tylko dane specyficzne dla ciała niebieskiego (tytuł, treść, macierz QR).

- **Przelicznik pt → mm:** `mm_per_pt = 25.4 / 72`. Rozmiar w `text()` to `{rozmiar w pt} * mm_per_pt`.
- **Zawijanie tekstu:** OpenSCAD nie zawija tekstu automatycznie — treść z `posters/*.md` trzeba ręcznie podzielić na linie (przy marginesach ~14mm i czcionce 10pt mieści się ~44-50 znaków/linię). Tytuł i nagłówek "Podstawowe dane" wyróżnione większym rozmiarem (np. ×1.6 i ×1.15 bazowego). Oczywiste literówki w źródle (`posters/*.md`) popraw przy przepisywaniu — trafiają na trwały fizyczny obiekt.
- **Kod QR:** OpenSCAD nie ma natywnego generatora QR. Wygeneruj macierz w Pythonie (`pip install qrcode`, `qrcode.QRCode(error_correction=qrcode.constants.ERROR_CORRECT_M)`), wypisz jako tablicę 0/1 i wklej do `.scad` jako `qr_matrix`. Renderuj jako siatkę `cube()` (rozmiar komórki = `qr_size / qr_modules`) — sąsiadujące kostki łączą się poprawnie bez owijania w `union()`.
- **Ramka** ma zwykły przekrój prostokątny (`frame_width` szerokość, `frame_height` wysokość ponad lico, bez skosu) — budowana jako unia czterech `cube()`: belki lewa/prawa na całą wysokość tabliczki (razem z narożnikami) + belka górna/dolna tylko na odcinku między nimi, żeby nic się nie nakładało. Same kostki, żadnych operacji boolowskich.
- **Otwory montażowe na wkręty** (`screw_island`, `screw_hole`) są wzniesione na licu tabliczki (ta sama strona co tekst/QR i ramka), nie z tyłu — wysepka to ścięty stożek (szerszy u podstawy przy płycie, węższy u góry przy łebku wkręta), otwór ma stożkowe zagłębienie na szczycie wysepki. Tekst/QR w rogu sąsiadującym z otworem trzeba odsunąć (np. `qr_lift`), żeby nie wchodził na wysepkę.
- **Otwór montażowy budować jako JEDNĄ bryłę `rotate_extrude()`** z profilu 2D (prosty przelot → stożek zagłębienia → prześwit), **nie** jako unię kilku nakładających się walców/stożków. Gdy dwie nakładające się bryły stykają się dokładnie na tej samej średnicy (np. zmieniony `island_height` przestaje pasować do `frame_height`, więc "margines bezpieczeństwa" robi się realnym nakładaniem), STL i podgląd wygląda OK, ale eksport do 3MF rzuca `EXPORT-ERROR: Can't add triangle to 3MF model` — walidacja siatki w 3MF jest znacznie ostrzejsza niż w STL.
- **`color()` jest atrybutem bryły (narzędzia), nie operacji.** Owinięcie WYNIKU `difference()` w `color(X)` nie koloruje nowo odsłonionej ścianki wycięcia — ta ścianka należy geometrycznie do odejmowanej bryły, więc bez koloru wychodzi w domyślnym, niezdefiniowanym kolorze (w praktyce: zielonym). Żeby ścianka otworu przejęła kolor materiału, w którym leży, trzeba pokolorować samo narzędzie wycinające w miejscu wycinania, np. `difference() { base_plate(); color(color_white) screw_holes(); }` — kolor wewnątrz `difference()`, nie wokół niej.
- **Walidacja `polyhedron()`/operacji boolowskich:** każda krawędź customowego `polyhedron()` musi występować w dokładnie dwóch ścianach, w przeciwnych kierunkach (konsekwentny "winding"). Błędny winding nie widać w podglądzie OpenCSG, ale powoduje `ERROR: The given mesh is not closed!` przy pełnym renderze i blokuje eksport do STL/3MF. Każdą nową geometrię tego typu waliduj pełnym renderem (`openscad --render -o test.png plik.scad`) i próbą eksportu do 3MF, nigdy samym podglądem.
- **OpenSCAD CLI na Windows:** zwykle nie jest w PATH — szukaj w `C:\Program Files\OpenSCAD\openscad.com`. Wersja 2021.01 nie ma backendu Manifold, więc pełny `--render` siatki ~800 osobnych `cube()` (kod QR) jest bardzo wolny (obserwowane: nieukończone po >5 min). Do szybkiej iteracji: podgląd bez `--render` do sprawdzania układu tekstu/QR (sekundy), a pełny `--render` tylko na izolowanych/uproszczonych fragmentach (np. `base_plate()+frame()` bez `qr_code()`) do sprawdzania poprawności geometrii.
