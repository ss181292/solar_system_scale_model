# Fakty o mapie układu słonecznego

Dokument roboczy podsumowujący ustalenia z sesji tworzenia mapy skalowego modelu Układu Słonecznego. Wszystkie pozycje i obliczenia opierają się na tych danych.

**⚠️ Aktualizacja skali (2026-08-01):** pierwotne założenie skali mapy (7 cm/px) było błędne. Zweryfikowano pomiarem w terenie (odległość Słońce–Neptun) i skorygowano na **6,61612 cm/px**. Wszystkie pozycje obiektów i promienie orbit poniżej są już PRZELICZONE na nową, poprawną skalę.

**✅ Aktualizacja współrzędnych (2026-08-01):** współrzędne geograficzne zostały ponownie przeliczone na podstawie DWÓCH zmierzonych w terenie punktów (Słońce i Obrzeża Układu Słonecznego — patrz sekcja "Skala i georeferencja"), z dopasowaniem transformacji podobieństwa (skala + rotacja). Współrzędne są z powrotem na mapie, na etykietach obróconych o 45° przeciwnie do ruchu wskazówek zegara.

## Pliki

- `mapa_polaczona.png` — oryginalna, połączona mapa terenu (bez adnotacji), 8994×2010 px. Powstała ze złożenia 5 plików eksportu (`eksport.png`, `eksport (1-4).png`).
- `mapa_układu_słonecznego.png` — plik roboczy z narysowanym Słońcem, orbitami i planetami. **Przycięty z lewej strony** — patrz sekcja "Przycięcie mapy" niżej. Aktualny rozmiar: 8023×2010 px. Etykiety zawierają obecnie tylko nazwy obiektów (bez współrzędnych geograficznych — patrz uwaga wyżej).

## Skala i georeferencja

- **Skala skorygowana pomiarem terenowym: 1 px = 6,61612 cm = 0,0661612 m w terenie** (szczegóły korekty w `skala_mapy.md`)
- Pierwotne (błędne) założenie: 1:250 / 0,28 mm/px / 7 cm/px — **nieaktualne, zastąpione powyższym**
- Współczynnik korekty k = 1,058021 (stary_px × k = nowy_px dla tej samej odległości rzeczywistej)
- **Georeferencja (zaktualizowana):** wyznaczona z DWÓCH zmierzonych w terenie punktów:
  - Słońce: 52.108785°N, 20.733085°E
  - Obrzeża Układu Słonecznego: 52.109566°N, 20.726578°E
  - Z tych dwóch punktów dopasowano transformację podobieństwa piksel→metry (skala + rotacja), metodą liczb zespolonych: skala |k| = 0,0661169 m/px (potwierdza niezależnie skalę z korekty terenowej — zgodność do 0,008%), rotacja mapy względem północy = **-1,39°** (mapa nie jest idealnie zorientowana górą na północ — niewielkie odchylenie, prawdopodobnie różnica północ geograficzna/siatki)
  - Pozostałe współrzędne geograficzne obliczane przez zastosowanie tej samej transformacji do wektora piksel-offset względem Słońca
- Wzory na metry/stopień (WGS84 dla szer. geogr. 52,1°): 111 269,4 m/stopień szerokości, 68 511,4 m/stopień długości

## Konwencje symboli na mapie (ustalone w toku rozmowy)

- **Niebieska linia ciągła** = granica działki ewidencyjnej
- **Czarna linia przerywana** = granica pasa drogowego / linia rozgraniczająca drogę (NIE granica działki — ignorować przy szukaniu granic)
- **Czarna linia ciągła z czarnymi kropkami, nałożona na niebieską** = ogrodzenie pokrywające się z granicą działki
- **Wąski prostokąt z czarnej linii ciągłej** (czasem z zaokrąglonym/prostym końcem) = rów
- Małe czarne kropki na liniach = wierzchołki (punkty załamania) linii
- Numery działek podpisane są niebieskim tekstem, budynki obrysowane czerwoną linią z etykietą użytkową (np. "m1", "m2", "i1")
- Budynki bywają też rysowane szarą linią przerywaną (np. budynek na działce 100/4) — to obrys budynku, nie granica działki

## Przycięcie mapy

Mapa `mapa_układu_słonecznego.png` została przycięta z lewej strony tak, aby lewa krawędź była **dokładnie 65 m w terenie od Neptuna** (przeliczone na nowej skali).

- Przycięcie w oryginalnym układzie współrzędnych (`mapa_polaczona.png`): lewa krawędź = x = 985 px (przeliczane automatycznie od aktualnej pozycji Neptuna, więc może się nieznacznie zmieniać przy każdej korekcie pozycji Neptuna)
- **Offset przycięcia: -985 px w osi X** — aby przeliczyć współrzędną z oryginalnej mapy na aktualny plik: `x_aktualny = x_oryginalny - 985`
- Aktualny rozmiar pliku: 8009×2010 px

Poniższa tabela podaje współrzędne **w aktualnym, przyciętym pliku** (`mapa_układu_słonecznego.png`).

## Słońce i orbity

Słońce ustawione w punkcie: 50 cm na północ (prostopadle do dłuższej krawędzi) od północno-wschodniego rogu rowu na działce 147/1, następnie przesunięte o 2 m na wschód i 1,5 m na południe (offsety przeliczone na skorygowanej skali).

Orbity narysowane jako żółte okręgi wyśrodkowane na Słońcu, o promieniach w metrach (dane wejściowe, niezależne od skali mapy) oraz promieniach w pikselach na nowej, skorygowanej skali:

| Obiekt | Promień orbity (m) | Promień (px, nowa skala) |
|---|---|---|
| Merkury | 5,79 | 87,51 |
| Wenus | 10,82 | 163,54 |
| Ziemia | 14,96 | 226,11 |
| Mars | 22,79 | 344,46 |
| Pas planetoid | 41,37 | 625,29 |
| Jowisz | 77,85 | 1176,67 |
| Saturn | 143,35 | 2166,68 |
| Uran | 287,10 | 4339,40 |
| Neptun | 449,5 | 6794,01 |

## Pozycje obiektów

Współrzędne px podane dla aktualnego (przyciętego) pliku `mapa_układu_słonecznego.png`, po korekcie skali.

| Obiekt | X (px) | Y (px) | Szerokość geogr. | Długość geogr. | Zasada umieszczenia |
|---|---|---|---|---|---|
| Słońce | 7680,27 | 1773,52 | 52.108785° | 20.733085° | Punkt odniesienia, zmierzony w terenie |
| Merkury | 7597,37 | 1745,50 | 52.108803° | 20.733006° | 50 cm na północ (prostopadle) od krawędzi rowu (fragment wsch-zach ogrodzenia 147/1\|147/2), na orbicie |
| Wenus | 7521,91 | 1732,72 | 52.108812° | 20.732933° | Ta sama odległość od ogrodzenia 147/1\|147/2 co Merkury, na orbicie |
| Ziemia | 7460,05 | 1722,23 | 52.108819° | 20.732874° | jw. |
| Mars | 7345,93 | 1690,63 | 52.108839° | 20.732764° | **Ręczna korekta:** przesunięty łącznie 80 cm na północ (prostopadle do ogrodzenia) od pierwotnej pozycji na linii ogrodzenia (50 cm + kolejne 30 cm), następnie ustawiony z powrotem dokładnie na orbicie (22,79 m od Słońca) — nie leży już na linii ogrodzenia wspólnej z Merkurym/Wenus/Ziemią |
| Pas planetoid | 7067,32 | 1649,92 | 52.108867° | 20.732497° | 10 cm na północ (prostopadle) od granicy działek 144/1 i 116, na orbicie |
| Jowisz | 6521,38 | 1569,76 | 52.108923° | 20.731972° | ~10 cm na północ (prostopadle) od granicy działek 144/3 i 116, na orbicie |
| Saturn | 5572,01 | 1273,81 | 52.109112° | 20.731063° | Środek wąskiego pasa działki 104/5 (między dwiema niebieskimi liniami), na orbicie |
| Uran | 3414,87 | 975,59 | 52.109320° | 20.728989° | **Ręczna korekta:** dokładnie 20 cm na południe (prostopadle) od południowej granicy działki 100/4 (ogrodzenie, dopasowanie liniowe na szerszym odcinku), na orbicie |
| Neptun | 982,49 | 634,10 | 52.109558° | 20.726650° | **Ręczna korekta:** 20 cm na południe (prostopadle) od granicy/ogrodzenia działki 94/3 (czarna linia), dokładnie na orbicie (449,5 m od Słońca) |
| Obrzeża Układu Słonecznego | 907,77 | 622,81 | 52.109566° | 20.726578° | **Ręczna korekta, zmierzona w terenie:** dokładnie na niebieskiej linii granicy działki 94/3 (osobna linia niż ogrodzenie Neptuna), w odległości 5 m od Neptuna |

Metoda przeliczenia: linie/narożniki odniesienia (ogrodzenia, rowy, granice działek) są cechami fizycznymi mapy i **nie zależą od skali** — zostały odtworzone z oryginalnego obrazu (`mapa_polaczona.png`) w tych samych miejscach co poprzednio. Przesunięcia wyrażone w metrach (np. "10 cm na północ") zostały przeliczone na piksele na NOWEJ skali, a każdy obiekt na orbicie umieszczony ponownie jako przecięcie odpowiedniej linii odniesienia z okręgiem o nowym (większym) promieniu.

## Odległości i relacje

- Wszystkie odległości od Słońca to promienie orbit z tabeli wyżej (dokładnie, bo punkty leżą na okręgach orbit) — zweryfikowane obliczeniowo z dokładnością <0,001 m
- Merkury, Wenus, Ziemia i Mars leżą w jednej linii — wzdłuż fragmentu ogrodzenia 147/1\|147/2 — w tej samej odległości prostopadłej od tego ogrodzenia
- Neptun leży 20 cm na południe od ogrodzenia (czarnej linii) działki 94/3; Obrzeża Układu Słonecznego leży dokładnie na niebieskiej linii granicy tej samej działki, 5 m od Neptuna (to już nie ta sama linia co Neptun — dwie osobne, blisko siebie leżące linie: ogrodzenie i granica ewidencyjna)
- Rozpiętość całego modelu (Słońce → Obrzeża UŁ): ok. **454,5 m** (składowa wschód: 448,1 m, składowa północ: 76,1 m)

## Etykiety na mapie

- Nazwa obiektu: czcionka DejaVu Sans Bold, 14 pt, kolor czerwony
- Współrzędne geograficzne: czcionka DejaVu Sans Bold, 13 pt, kolor czerwony, pod nazwą obiektu
- **Wszystkie etykiety** (nazwa + współrzędne razem) obrócone o 45° przeciwnie do ruchu wskazówek zegara, punkt obrotu na początku tekstu (przy obiekcie)

## Do zrobienia

- Przejrzeć pozycję Jowisza — jego zmierzony offset od granicy okazał się inny niż pierwotnie zakładane okrągłe "10 cm" (patrz sekcja "Metoda przeliczenia") i ew. skorygować ręcznie (Mars, Uran, Neptun i Obrzeża zostały już ręcznie skorygowane, patrz tabela pozycji)
- Zaktualizować arkusze do druku PDF (obecne pliki `arkusz_*_z_4.pdf` bazują na starej, błędnej skali i starych pozycjach obiektów)
