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
frame_height = 6;  // wysokość (grubość) ramki, przekrój trójkątny [mm]

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
qr_link_gap = 1;  // odstęp między kodem QR a tekstem odnośnika [mm]
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

// Ramka o przekroju trójkątnym, zbudowana z prostych klinów
// (bez difference()/hull(), żeby podgląd OpenCSG odpowiadał
// rzeczywistej geometrii). Ściana zewnętrzna jest pionowa
// (flush z krawędzią tabliczki) i ma wysokość frame_height;
// ściana wewnętrzna opada po skosie do "ostrza" przy płaskiej
// powierzchni z tekstem, frame_width od krawędzi.

// Klin wzdłuż osi X. Ściana zewnętrzna (pionowa) przy Y=0,
// "ostrze" (zerowa wysokość) przy Y=frame_width.
module edge_wedge_x(length) {
    polyhedron(
        points = [
            [0, 0, 0], [0, 0, frame_height], [0, frame_width, 0],
            [length, 0, 0], [length, 0, frame_height], [length, frame_width, 0]
        ],
        faces = [
            [0, 1, 2],
            [3, 5, 4],
            [0, 3, 4, 1],
            [0, 2, 5, 3],
            [1, 4, 5, 2]
        ]
    );
}

// Klin wzdłuż osi Y. Ściana zewnętrzna (pionowa) przy X=0,
// "ostrze" (zerowa wysokość) przy X=frame_width.
module edge_wedge_y(length) {
    polyhedron(
        points = [
            [0, 0, 0], [0, 0, frame_height], [frame_width, 0, 0],
            [0, length, 0], [0, length, frame_height], [frame_width, length, 0]
        ],
        faces = [
            [0, 1, 2],
            [3, 5, 4],
            [0, 3, 4, 1],
            [0, 2, 5, 3],
            [1, 4, 5, 2]
        ]
    );
}

// Narożnik łączący dwa klince. Pełna wysokość w zewnętrznym
// rogu (0,0), "ostrze" w rogu wewnętrznym (frame_width, frame_width).
module corner_wedge() {
    fw = frame_width;
    fh = frame_height;
    polyhedron(
        points = [
            [0, 0, 0], [fw, 0, 0], [fw, fw, 0], [0, fw, 0],
            [0, 0, fh], [fw, 0, fh], [0, fw, fh]
        ],
        faces = [
            [0, 3, 2, 1],
            [0, 1, 5, 4],
            [0, 4, 6, 3],
            [4, 5, 6],
            [1, 2, 5],
            [3, 6, 2],
            [2, 6, 5]
        ]
    );
}

module frame() {
    edge_x_length = plaque_width - 2 * frame_width;
    edge_y_length = plaque_height - 2 * frame_width;
    color(color_black) {
        translate([frame_width, 0, plaque_thickness])
            edge_wedge_x(edge_x_length);
        translate([frame_width, plaque_height, plaque_thickness])
            mirror([0, 1, 0])
                edge_wedge_x(edge_x_length);

        translate([0, frame_width, plaque_thickness])
            edge_wedge_y(edge_y_length);
        translate([plaque_width, frame_width, plaque_thickness])
            mirror([1, 0, 0])
                edge_wedge_y(edge_y_length);

        translate([0, 0, plaque_thickness])
            corner_wedge();
        translate([plaque_width, 0, plaque_thickness])
            mirror([1, 0, 0])
                corner_wedge();
        translate([0, plaque_height, plaque_thickness])
            mirror([0, 1, 0])
                corner_wedge();
        translate([plaque_width, plaque_height, plaque_thickness])
            rotate([0, 0, 180])
                corner_wedge();
    }
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
    inner_bottom = frame_width + qr_margin;

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

base_plate();
frame();
body_text();
qr_code();
