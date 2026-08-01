# Założenia dotyczące skali mapy

## ⚠️ SKALA SKORYGOWANA (aktualna, obowiązująca)

Pierwotne założenie (0,28 mm/piksel, standard OGC) okazało się błędne — zweryfikowane pomiarem w terenie.

- Zmierzona w rzeczywistości odległość Słońce–Neptun: **424,85 m**
- Odległość ta odpowiada w pliku mapy odcinkowi **6421,43 px** (promień orbity Neptuna, taki sam w pikselach niezależnie od skali)
- Skorygowana skala: **424,85 m ÷ 6421,43 px = 0,0661612 m/px = 6,61612 cm/px**
- Współczynnik korekty względem starego założenia: **k = 0,07 / 0,0661612 = 1,058021** (wszystkie dawne odległości w pikselach trzeba pomnożyć przez k, żeby uzyskać tę samą rzeczywistą odległość w metrach)

Ciekawostka: skorygowana wartość (6,616 cm/px) jest niemal dokładnie równa alternatywnemu założeniu wskazanemu w pierwotnym zastrzeżeniu poniżej (96 DPI ekranu = 0,2646 mm/piksel × 250 = 6,615 cm/px) — to najpewniej faktyczne źródło skali eksportu.

## Dane wejściowe (PIERWOTNE — nieaktualne, zachowane dla historii)
- Skala mapy (wg systemu źródłowego): **1:250**
- Piksel mapy = **0,28 mm** (standardowy rozmiar piksela GIS/WMS wg specyfikacji OGC; przyjęty w braku metadanych DPI w plikach PNG) — **to założenie było błędne, patrz sekcja korekty wyżej**

## Przeliczenie (PIERWOTNE — nieaktualne)
- 1 px = 0,28 mm × 250 = 70 mm = 7 cm w terenie ~~(błędne)~~

## Przeliczenie (AKTUALNE)
- **1 px = 6,61612 cm = 0,0661612 m w terenie**

## Plik mapa_polaczona.png
- Wymiary: 8994 × 2010 px
- Szerokość w terenie: 8994 px × 6,61612 cm/px ≈ **595,0 m**
- Wysokość w terenie: 2010 px × 6,61612 cm/px ≈ **133,0 m**

## Zastrzeżenie
Poprzednie przeliczenie zakładało standardową konwencję GIS (0,28 mm/piksel), co dawało 7 cm/piksel. Pomiar terenowy (Słońce–Neptun) wykazał, że rzeczywista wartość to 6,61612 cm/piksel — bliska alternatywnemu założeniu 96 DPI wspomnianemu w poprzedniej wersji tego dokumentu. Wszystkie pozycje obiektów i promienie orbit na mapie `mapa_układu_słonecznego.png` zostały przeliczone na nową skalę. Współrzędne geograficzne (lat/lon) obiektów **nie zostały jeszcze przeliczone** — oczekują na korelację z pomiarami w terenie.
