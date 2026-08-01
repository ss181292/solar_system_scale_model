# Założenia dotyczące skali mapy

## Dane wejściowe
- Skala mapy (wg systemu źródłowego): **1:250**
- Piksel mapy = **0,28 mm** (standardowy rozmiar piksela GIS/WMS wg specyfikacji OGC; przyjęty w braku metadanych DPI w plikach PNG)

## Przeliczenie
- 1 px = 0,28 mm × 250 = 70 mm = **7 cm w terenie**

## Plik mapa_polaczona.png
- Wymiary: 8994 × 2010 px
- Szerokość w terenie: 8994 px × 7 cm/px = 62 958 cm ≈ **629,6 m**
- Wysokość w terenie: 2010 px × 7 cm/px = 14 070 cm ≈ **140,7 m**

## Zastrzeżenie
Przeliczenie zakłada standardową konwencję GIS (0,28 mm/piksel). Jeśli system źródłowy eksportu używa innego założenia (np. 96 DPI ekranu = 0,2646 mm/piksel), rzeczywista wartość może się różnić o ok. 5% (np. 6,6 cm/piksel zamiast 7 cm). Pliki PNG nie zawierają metadanych DPI, więc nie da się tego zweryfikować bezpośrednio z obrazu.
