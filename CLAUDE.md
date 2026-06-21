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
- Tabliczka powinna mieć czarną ramkę 8mm szeroką, grubą na 6mm o przekroju trójkątnym.
- Podstawowy tekst powinien być napisany czcionką Georgia w rozmiarze 10pt.
- Tekst powinien być czarny, wyniesiony 0.3mm do góry.
- W prawym dolnym rogu powinien być kod QR odnoszący do strony http://solarsystem.skowron.it/{nazwa_planety}/ (nazwa planety w języku Angielskim).
- Pod kodem QR powinien być odnośnik napisany czcionką Lucida Sans Typewriter w rozmiarze 8pt.
