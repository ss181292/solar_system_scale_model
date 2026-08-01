# Fakty o mapie układu słonecznego

Dokument roboczy podsumowujący ustalenia z sesji tworzenia mapy skalowego modelu Układu Słonecznego. Wszystkie pozycje i obliczenia opierają się na tych danych.

## Pliki

- `mapa_polaczona.png` — oryginalna, połączona mapa terenu (bez adnotacji), 8994×2010 px. Powstała ze złożenia 5 plików eksportu (`eksport.png`, `eksport (1-4).png`).
- `mapa_układu_słonecznego.png` — plik roboczy z narysowanym Słońcem, orbitami i planetami. **Przycięty z lewej strony** — patrz sekcja "Przycięcie mapy" niżej. Aktualny rozmiar: 7613×2010 px.

## Skala i georeferencja

- Skala mapy: **1:250**
- Przyjęty rozmiar piksela: standard GIS/WMS **0,28 mm/piksel** (OGC) → **1 px = 7 cm w terenie = 0,07 m**
- Założenie: mapa jest zorientowana górą na północ (brak korekty obrotu), prawa strona = wschód
- Punkt odniesienia (Słońce): **52.108785°N, 20.733085°E** (podane przez użytkownika, traktowane jako dokładne)
- Pozostałe współrzędne geograficzne obiektów obliczone metodą płaskiej aproksymacji (m/stopień wg wzoru WGS84 dla szer. geogr. 52,1°): ok. 111 269 m/stopień szerokości, ok. 68 511 m/stopień długości

## Konwencje symboli na mapie (ustalone w toku rozmowy)

- **Niebieska linia ciągła** = granica działki ewidencyjnej
- **Czarna linia przerywana** = granica pasa drogowego / linia rozgraniczająca drogę (NIE granica działki — ignorować przy szukaniu granic)
- **Czarna linia ciągła z czarnymi kropkami, nałożona na niebieską** = ogrodzenie pokrywające się z granicą działki
- **Wąski prostokąt z czarnej linii ciągłej** (czasem z zaokrąglonym/prostym końcem) = rów
- Małe czarne kropki na liniach = wierzchołki (punkty załamania) linii
- Numery działek podpisane są niebieskim tekstem, budynki obrysowane czerwoną linią z etykietą użytkową (np. "m1", "m2", "i1")
- Budynki bywają też rysowane szarą linią przerywaną (np. budynek na działce 100/4) — to obrys budynku, nie granica działki

## Przycięcie mapy

Mapa `mapa_układu_słonecznego.png` została przycięta z lewej strony tak, aby lewa krawędź była **dokładnie 65 m w terenie od Neptuna**.

- Przycięcie w oryginalnym układzie współrzędnych (`mapa_polaczona.png`): lewa krawędź = x = 1381 px
- **Offset przycięcia: -1381 px w osi X** — aby przeliczyć współrzędną z oryginalnej mapy na aktualny plik: `x_aktualny = x_oryginalny - 1381`
- Rzeczywista odległość Neptun→lewa krawędź: 65,02 m

Poniższa tabela podaje współrzędne **w aktualnym, przyciętym pliku** (`mapa_układu_słonecznego.png`).

## Słońce i orbity

Słońce ustawione w punkcie: 50 cm na północ (prostopadle do dłuższej krawędzi) od północno-wschodniego rogu rowu na działce 147/1, następnie przesunięte o 2 m na wschód i 1,5 m na południe.

Orbity narysowane jako żółte okręgi wyśrodkowane na Słońcu, o promieniach (w metrach):

| Obiekt | Promień orbity (m) |
|---|---|
| Merkury | 5,79 |
| Wenus | 10,82 |
| Ziemia | 14,96 |
| Mars | 22,79 |
| Pas planetoid | 41,37 |
| Jowisz | 77,85 |
| Saturn | 143,35 |
| Uran | 287,10 |
| Neptun | 449,5 |

## Pozycje obiektów

Współrzędne px podane dla aktualnego (przyciętego) pliku `mapa_układu_słonecznego.png`.

| Obiekt | X (px) | Y (px) | Szerokość geogr. | Długość geogr. | Zasada umieszczenia |
|---|---|---|---|---|---|
| Słońce | 7272,80 | 1773,98 | 52.108785° | 20.733085° | Punkt odniesienia (patrz wyżej) |
| Merkury | 7195,51 | 1744,51 | 52.108804° | 20.733006° | 50 cm na północ (prostopadle) od krawędzi rowu (fragment wsch-zach ogrodzenia 147/1\|147/2), na orbicie |
| Wenus | 7123,93 | 1732,38 | 52.108811° | 20.732933° | Ta sama odległość od ogrodzenia 147/1\|147/2 co Merkury (~1,76 m), na orbicie |
| Ziemia | 7065,39 | 1722,46 | 52.108817° | 20.732873° | jw. |
| Mars | 6954,89 | 1703,74 | 52.108829° | 20.732760° | jw. |
| Pas planetoid | 6694,24 | 1653,35 | 52.108861° | 20.732494° | 10 cm na północ (prostopadle) od granicy działek 144/1 i 116, na orbicie |
| Jowisz | 6177,88 | 1577,58 | 52.108909° | 20.731966° | Na przecięciu orbity z granicą działek 144/3 i 116 (drugie/dalsze przecięcie, w wierzchołku granicy), plus 10 cm dalej na północ |
| Saturn | 5282,92 | 1290,28 | 52.109089° | 20.731052° | Środek wąskiego pasa działki 104/5 (między dwiema niebieskimi liniami), na orbicie |
| Uran | 3244,11 | 1004,95 | 52.109269° | 20.728969° | 10 cm na południe (prostopadle) od południowej granicy działki 100/4 (ogrodzenie), na orbicie |
| Neptun | 928,85 | 779,44 | 52.109411° | 20.726603° | Dokładnie na czarnej linii granicy rowu (w pobliżu działki 117/1), na orbicie |
| Obrzeża Układu Słonecznego | 717,75 | 742,63 | 52.109434° | 20.726388° | Na tej samej czarnej linii rowu co Neptun, 15 m dalej na zachód (wzdłuż linii) |

## Odległości i relacje

- Wszystkie odległości od Słońca to promienie orbit z tabeli wyżej (dokładnie, bo punkty leżą na okręgach orbit)
- Merkury, Wenus, Ziemia i Mars leżą w jednej linii — wzdłuż fragmentu ogrodzenia 147/1\|147/2 — w tej samej odległości prostopadłej od tego ogrodzenia (~1,76 m)
- Neptun i "Obrzeża Układu Słonecznego" leżą na tej samej linii (granica rowu), w odległości 15 m wzdłuż tej linii
- Rozpiętość całego modelu (Słońce → Obrzeża UŁ): ok. 458,85 m na wschód, 72,19 m na północ (linia prosta ok. 464,5 m)

## Etykiety na mapie

- Nazwa obiektu: czcionka DejaVu Sans Bold, 14 pt, kolor czerwony
- Współrzędne geograficzne: czcionka DejaVu Sans Bold, 13 pt, kolor czerwony
- Etykiety Ziemi i Merkurego obrócone o 45° w dół (zgodnie z ruchem wskazówek zegara), punkt obrotu na początku tekstu (przy obiekcie)
- Etykiety Marsa i Wenus obrócone o 45° w górę (przeciwnie do ruchu wskazówek zegara), punkt obrotu na początku tekstu
