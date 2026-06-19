// Parametry pokrywki
cover_outer_diameter = 110;
cover_outer_radius = cover_outer_diameter / 2;
cover_inner_diameter = 92;
cover_inner_radius = cover_inner_diameter / 2;
cover_top_thickness = 3;
cover_inner_depth = 15;
cover_total_height = cover_top_thickness + cover_inner_depth;
cover_hole_diameter = 4;
cover_hole_radius = cover_hole_diameter / 2;
countersink_diameter = 8;
countersink_radius = countersink_diameter / 2;
countersink_depth = 2;
top_hole_diameter = 80;
top_hole_radius = top_hole_diameter / 2;
cover_hole_radius_from_center = 50;
num_holes = 4;

// Parametry elementu mocującego (na pokrywce)
mount_angle = 45; // pozycja kątowa wokół pokrywki, między dwoma otworami montażowymi
mount_gap = 12; // odsunięcie od ściany pokrywki
mount_width = 22;
mount_depth = 10;
mount_height = 90; // wysokość końcowa, od płaskiej góry do dołu
mount_tilt = 15; // nachylenie do osi pokrywki, w stopniach
mount_concave_r = 13.5; // promień wklęsłości ściany zewnętrznej
mount_hole_d = 5.5;
mount_inner_boss_r = 6; // promień wysepki wzmacniającej material wokół otworów (po stronie wewnętrznej)
mount_inner_boss_base_r = 8.5; // promień podstawy wysepki wzmacniającej material wokół otworów (po stronie wewnętrznej)
mount_inner_boss_len = 2; // o tyle wysepka wystaje od plaskiej, wewnetrznej sciany
mount_hole_z1 = -41; // położenie (we własnej, nieobróconej osi) pierwszego otworu
mount_hole_z2 = -77; // położenie drugiego otworu
mount_margin_top = 15; // naddatek materiału nad punktem obrotu, przycinany do płaskiej góry
mount_r_round = mount_depth / 2; // promień zaokrąglenia dolnej ściany

// Wysokość (przed obrotem) taka, by po nachyleniu dolny-zewnętrzny róg wypadł
// dokładnie na mount_height od płaskiej, przyciętej góry
mount_H = (mount_height - mount_depth * sin(mount_tilt)) / cos(mount_tilt);

// Oś walca wklęsłości ściany zewnętrznej - przechodzi przez krawędzie (Y = ±width/2)
mount_dish_axis_x = mount_depth + sqrt(mount_concave_r*mount_concave_r - (mount_width/2)*(mount_width/2));

module mount_screw_hole(z) {
    translate([0, 0, z]) rotate([0, 90, 0])
        translate([0, 0, -(mount_inner_boss_len + 2)])
        cylinder(h = mount_inner_boss_len + 32, r = mount_hole_d / 2);
}

// Wysepka wzmacniająca materiał wokół otworu, po stronie wewnętrznej (płaskiej)
module mount_inner_boss(z) {
    translate([-mount_inner_boss_len, 0, z]) rotate([0, 90, 0])
        cylinder(h = mount_inner_boss_len, r1 = mount_inner_boss_r, r2 = mount_inner_boss_base_r);
}

// Element mocujący: prostopadłościan nachylony do osi pokrywki, z płaską,
// przyciętą górą (współpłaszczyznową z górą pokrywki), zaokrąglonym dołem,
// wklęsłą ścianą zewnętrzną i dwoma otworami na wkręty
module mount_tab() {
    intersection() {
        rotate([0, mount_tilt, 0])
            difference() {
                union() {
                    translate([0, -mount_width/2, -mount_H + mount_r_round])
                        cube([mount_depth, mount_width, (mount_H - mount_r_round) + mount_margin_top]);
                    translate([mount_depth/2, 0, -mount_H + mount_r_round])
                        rotate([-90, 0, 0])
                        cylinder(h = mount_width, r = mount_r_round, center = true);
                    mount_inner_boss(mount_hole_z1);
                    mount_inner_boss(mount_hole_z2);
                }
                // Wklęsła ściana zewnętrzna
                translate([mount_dish_axis_x, 0, -mount_H - 20])
                    cylinder(h = mount_H + mount_margin_top + 40, r = mount_concave_r);
                mount_screw_hole(mount_hole_z1);
                mount_screw_hole(mount_hole_z2);
            }
        // Przycięcie do płaskiej góry, współpłaszczyznowej z górą pokrywki
        translate([-1000, -1000, -3000])
            cube([2000, 2000, 3000]);
    }
}

// Wypełnienie pomiędzy elementem mocującym a ścianą pokrywki (tylko na wysokości,
// na której ścianka pokrywki fizycznie istnieje)
module mount_fill() {
    top_z = 0;
    bot_z = -cover_total_height;
    eps = 0.1;
    overlap = 3; // wnikanie w istniejacą ściankę pokrywki, by zagwarantować zlączenie w jedną objętość
    hull() {
        translate([-mount_gap - overlap, -mount_width/2, top_z - eps])
            cube([mount_gap + overlap + 0.01, mount_width, eps]);
        translate([-mount_gap - overlap, -mount_width/2, bot_z])
            cube([(bot_z * tan(mount_tilt)) + mount_gap + overlap + 0.01, mount_width, eps]);
    }
}

// Pokrywka
translate([0, 120, 0]) {
    difference() {
        // Część stała pokrywki
        union() {
            // Górna część (płaska)
            cylinder(h = cover_top_thickness, r = cover_outer_radius, center = false);

            // Dolna część (ścianki)
            translate([0, 0, cover_top_thickness])
                cylinder(h = cover_inner_depth, r = cover_outer_radius, center = false);
        }

        // Wewnętrzna wnęka
        translate([0, 0, cover_top_thickness])
            cylinder(h = cover_inner_depth, r = cover_inner_radius, center = false);

        // Okrągły otwór z góry (80mm)
        translate([0, 0, -0.5])
            cylinder(h = cover_top_thickness + 1, r = top_hole_radius, center = false);

        // Cztery otwory do wkrętów
        for (i = [0:num_holes-1]) {
            angle = i * 360 / num_holes;
            x = cover_hole_radius_from_center * cos(angle);
            y = cover_hole_radius_from_center * sin(angle);

            // Otwór główny: 4mm średnicy na większości długości
            translate([x, y, 0])
                cylinder(h = cover_total_height, r = cover_hole_radius, center = false);

            // Pogłębienie stożkowe: na ostatnich 2.5mm zmienia się od 4mm do 7mm
            translate([x, y, 0])
                cylinder(h = 2.5, r1 = countersink_radius, r2 = cover_hole_radius, center = false);
        }
    }

    // Element mocujący, nachylony w stronę osi pokrywki, umieszczony między
    // dwoma istniejącymi otworami montażowymi (mirror koryguje odwrócony
    // układ Z pokrywki na modelu względem orientacji rzeczywistej)
    rotate([0, 0, mount_angle])
        translate([cover_outer_radius + mount_gap, 0, 0])
        mirror([0, 0, 1]) {
            mount_tab();
            mount_fill();
        }
}
