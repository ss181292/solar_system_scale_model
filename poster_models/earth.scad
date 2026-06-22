// ============================================================
// Ziemia - tabliczka informacyjna do modelu Układu Słonecznego
// Źródło tekstu: posters/ziemia.md
// Adres QR: http://solarsystem.skowron.it/earth/
// ============================================================

// --- Wymiary tabliczki ---
plaque_width     = 120;  // szerokość [mm]
plaque_height    = 170;  // wysokość [mm]
plaque_thickness = 2;    // grubość płyty [mm]

// --- Ramka ---
frame_width  = 8;  // szerokość ramki [mm]
frame_height = 3;  // wysokość ramki, zwykły przekrój prostokątny [mm]

// --- Otwory montażowe na wkręty ---
screw_hole_diameter  = 4;   // średnica otworu na wkręt [mm]
screw_edge_margin    = 8;   // odległość środka otworu od górnej/dolnej krawędzi [mm]
countersink_diameter = 8;   // średnica stożkowego zagłębienia pod łeb wkręta [mm]
countersink_depth    = 2;   // głębokość zagłębienia [mm]
island_top_diameter  = 9;  // średnica wysepki u góry, przy łebku wkręta [mm]
island_base_diameter = 12;  // średnica wysepki u podstawy, przy płycie [mm]
island_height        = 3;   // wysokość wysepki na licu tabliczki, max 6mm [mm]

screw_x        = plaque_width / 2;
screw_y_top    = plaque_height - screw_edge_margin;
screw_y_bottom = screw_edge_margin;

// --- Kolory ---
color_white = [1, 1, 1];
color_black = [0, 0, 0];

// --- Typografia ---
mm_per_pt   = 25.4 / 72;       // przelicznik pt -> mm
main_font   = "Georgia";
link_font   = "Lucida Sans Typewriter";
text_size   = 10 * mm_per_pt;  // tekst podstawowy: 10pt
link_size   = 8 * mm_per_pt;   // odnośnik pod kodem QR: 8pt
title_size  = text_size * 1.6;
sub_size    = text_size * 1.15;
line_height = text_size * 1.3;
text_raise  = 0.3;             // wyniesienie tekstu nad powierzchnię [mm]

left_margin = 14;
top_margin  = 14;

// --- Treść tabliczki (na podstawie posters/ziemia.md) ---
title_line = "Ziemia";

body_lines = [
    ["Ziemia - planeta na której żyjemy. Ta mała", text_size],
    ["niebieska kuleczka o średnicy 1,28 mm to", text_size],
    ["właśnie ona. Okrąg, który widać na obrzeżu", text_size],
    ["modelu to orbita Księżyca. Księżyc w tej", text_size],
    ["skali miałby 0,34 mm średnicy.", text_size],
    ["", text_size],
    ["Znajdujemy się 149 598 023 km czyli", text_size],
    ["dokładnie 1 AU (jednostka astronomiczna)", text_size],
    ["od Słońca.", text_size],
    ["", text_size],
    ["Podstawowe dane", sub_size],
    ["Średnica: 12 756 km", text_size],
    ["Masa: 5,972 × 10²⁴ kg", text_size],
    ["Odległość od Słońca: 149 598 023 km", text_size],
    ["(1,00 AU)", text_size],
    ["Okres orbitalny: 365,256 dni", text_size],
];

// --- Kod QR (http://solarsystem.skowron.it/earth/, korekcja błędów M) ---
qr_link_display = "http://solarsystem.skowron.it/earth/";
qr_size    = 28;  // rozmiar boku kodu QR [mm]
qr_margin  = 4;   // odstęp od wewnętrznej krawędzi ramki [mm]
qr_link_gap = 2;  // odstęp między kodem QR a tekstem odnośnika [mm]
qr_lift    = 3;   // podniesienie kodu QR i odnośnika, by nie wchodziły na wysepkę [mm]
qr_modules = 29;
qr_matrix = [
    [1,1,1,1,1,1,1,0,1,1,0,0,0,1,0,1,0,0,0,1,1,0,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,0,1,0,0,0,0,0,1],
    [1,0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,0,0,1,0,1,0,1,0,1,1,1,0,1],
    [1,0,1,1,1,0,1,0,1,1,0,0,0,0,1,0,0,1,0,1,0,0,1,0,1,1,1,0,1],
    [1,0,1,1,1,0,1,0,0,1,0,0,0,0,1,1,0,1,1,1,0,0,1,0,1,1,1,0,1],
    [1,0,0,0,0,0,1,0,0,1,1,0,0,1,0,0,1,1,0,1,1,0,1,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1],
    [0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0],
    [1,0,1,1,0,1,1,1,0,0,0,0,1,1,0,1,1,1,1,0,0,0,1,0,0,1,0,1,1],
    [0,1,0,0,1,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,0,1,1,1,0,0,0,1],
    [1,0,1,1,0,1,1,0,1,1,1,1,0,1,0,0,0,0,1,0,0,0,0,1,1,0,1,1,0],
    [1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1],
    [1,0,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,1,0,0,1,0,1,1,0,0],
    [0,0,1,0,1,1,0,1,1,0,0,0,1,0,1,1,1,0,0,1,0,1,1,0,0,0,0,1,1],
    [0,0,0,0,1,0,1,0,1,0,1,0,0,1,0,0,1,1,1,1,0,0,0,1,0,1,1,1,1],
    [0,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0,1,1,1,0,0,0,1,0,0,1,0],
    [0,0,0,0,0,0,1,1,0,1,0,0,0,0,1,0,1,0,0,1,1,1,0,1,1,0,0,1,0],
    [0,0,0,0,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,1,0,0,1,1,0],
    [1,0,1,1,1,0,1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,0,0,1,1,1,0,0],
    [0,0,0,0,1,1,0,0,0,1,0,0,0,1,1,0,0,1,0,0,0,1,1,0,1,0,1,0,0],
    [0,1,0,1,1,0,1,1,1,1,0,1,0,1,1,0,1,1,1,0,1,1,1,1,1,1,1,0,0],
    [0,0,0,0,0,0,0,0,1,0,0,1,1,0,0,0,1,1,1,0,1,0,0,0,1,1,1,1,1],
    [1,1,1,1,1,1,1,0,1,1,1,0,0,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1,0],
    [1,0,0,0,0,0,1,0,1,1,0,1,0,1,1,0,0,0,1,0,1,0,0,0,1,0,0,0,1],
    [1,0,1,1,1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,1,1,1,1,1,1,1,0,0],
    [1,0,1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,1,1,1,1,0,1,1,0,1,0,1],
    [1,0,1,1,1,0,1,0,1,1,0,0,1,1,1,0,0,0,1,0,0,1,0,1,0,0,1,0,1],
    [1,0,0,0,0,0,1,0,0,1,1,0,1,1,0,0,1,0,1,0,1,0,0,1,0,1,0,1,0],
    [1,1,1,1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,1,0,0,1,0],
];

// ============================================================
// Geometria
// ============================================================

module base_plate() {
    color(color_white)
        cube([plaque_width, plaque_height, plaque_thickness]);
}

// Ramka o zwykłym przekroju prostokątnym, zbudowana z czterech
// belek (bez boolowskich operacji). Belki lewa/prawa biegną na
// całą wysokość tabliczki (razem z narożnikami), belki górna/dolna
// tylko na odcinku między nimi - dzięki temu nic się nie nakłada.
module frame() {
    inner_span = plaque_width - 2 * frame_width;
    color(color_black) {
        translate([0, 0, plaque_thickness])
            cube([frame_width, plaque_height, frame_height]);
        translate([plaque_width - frame_width, 0, plaque_thickness])
            cube([frame_width, plaque_height, frame_height]);

        translate([frame_width, 0, plaque_thickness])
            cube([inner_span, frame_width, frame_height]);
        translate([frame_width, plaque_height - frame_width, plaque_thickness])
            cube([inner_span, frame_width, frame_height]);
    }
}

// Wysepka wzmacniająca otwór montażowy, dodana na licu tabliczki
// (płyta ma tylko plaque_thickness, za mało na gwint wkręta).
// Ścięty stożek: szerszy (island_base_diameter) u podstawy, przy
// płycie, węższy (island_top_diameter) u góry, przy łebku wkręta.
module screw_island(x, y) {
    translate([x, y, plaque_thickness])
        cylinder(h = island_height, d1 = island_base_diameter, d2 = island_top_diameter, $fn = 48);
}

module screw_islands() {
    color(color_black) {
        screw_island(screw_x, screw_y_top);
        screw_island(screw_x, screw_y_bottom);
    }
}

// Otwór montażowy jako pojedyncza bryła obrotowa (rotate_extrude)
// zamiast kilku nakładających się walców/stożków: profil prosty
// przelot -> stożkowe zagłębienie -> prześwit (na wypadek gdyby
// ramka była wyższa niż wysepka). Nakładające się, stykające się
// na tej samej średnicy bryły dawały zdegenerowane trójkąty przy
// eksporcie do 3MF (walidacja siatki tam jest ostrzejsza niż w STL).
module screw_hole(x, y) {
    eps = 0.2;
    r_bore    = screw_hole_diameter / 2;
    r_counter = countersink_diameter / 2;

    z_back          = -eps;
    z_counter_start = plaque_thickness + island_height - countersink_depth;
    z_island_top    = plaque_thickness + island_height;
    z_top           = max(z_island_top, plaque_thickness + frame_height) + eps;

    translate([x, y, 0])
        rotate_extrude($fn = 32)
            polygon(points = [
                [0,         z_back],
                [r_bore,    z_back],
                [r_bore,    z_counter_start],
                [r_counter, z_island_top],
                [r_counter, z_top],
                [0,         z_top]
            ]);
}

module screw_holes() {
    screw_hole(screw_x, screw_y_top);
    screw_hole(screw_x, screw_y_bottom);
}

module body_text() {
    color(color_black) {
        translate([left_margin, plaque_height - top_margin, plaque_thickness])
            linear_extrude(height = text_raise)
                text(title_line, size = title_size, font = main_font, halign = "left", valign = "top");

        for (i = [0 : len(body_lines) - 1]) {
            line = body_lines[i][0];
            size = body_lines[i][1];
            y = plaque_height - top_margin - title_size * 1.4 - i * line_height;
            if (line != "") {
                translate([left_margin, y, plaque_thickness])
                    linear_extrude(height = text_raise)
                        text(line, size = size, font = main_font, halign = "left", valign = "top");
            }
        }
    }
}

module qr_code() {
    inner_right  = plaque_width - frame_width - qr_margin;
    inner_bottom = frame_width + qr_margin + qr_lift;

    qr_bottom = inner_bottom + link_size + qr_link_gap;
    qr_left   = inner_right - qr_size;
    cell      = qr_size / qr_modules;

    color(color_black) {
        for (row = [0 : qr_modules - 1]) {
            for (col = [0 : qr_modules - 1]) {
                if (qr_matrix[row][col] == 1) {
                    translate([qr_left + col * cell, qr_bottom + (qr_modules - 1 - row) * cell, plaque_thickness])
                        cube([cell, cell, text_raise]);
                }
            }
        }

        translate([inner_right, inner_bottom, plaque_thickness])
            linear_extrude(height = text_raise)
                text(qr_link_display, size = link_size, font = link_font, halign = "right", valign = "bottom");
    }
}

difference() {
    union() {
        base_plate();
        frame();
        screw_islands();
    }
    screw_holes();
}
body_text();
qr_code();
