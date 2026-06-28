// Słońce - Model w skali 1 : 10 000 000 000
// Średnica: 139,1 mm
// Kolor: Żółty (#FFFF00)

// Parametry Słońca
sun_diameter = 139.1;
sun_radius = sun_diameter / 2;
base_diameter = 110;
base_radius = base_diameter / 2;
base_thickness = 15;

// Kolory
color_sun = [1, 1, 0];
color_base = [0.2, 0.4, 0.8];

// Parametry elementu mocującego
mount_angle = 45;
mount_gap = 12;
mount_width = 22;
mount_depth = 10;
mount_height = 90;
mount_tilt = 15;
mount_concave_r = 13.5;
mount_hole_d = 5.5;
mount_inner_boss_r = 6;
mount_inner_boss_base_r = 8.5;
mount_inner_boss_len = 2;
mount_hole_z1 = -41;
mount_hole_z2 = -77;
mount_margin_top = 15;
mount_r_round = mount_depth / 2;
mount_H = (mount_height - mount_depth * sin(mount_tilt)) / cos(mount_tilt);
mount_dish_axis_x = mount_depth + sqrt(mount_concave_r*mount_concave_r - (mount_width/2)*(mount_width/2));

module mount_screw_hole(z) {
    translate([0, 0, z]) rotate([0, 90, 0])
        translate([0, 0, -(mount_inner_boss_len + 2)])
        cylinder(h = mount_inner_boss_len + 32, r = mount_hole_d / 2);
}

module mount_inner_boss(z) {
    translate([-mount_inner_boss_len, 0, z]) rotate([0, 90, 0])
        cylinder(h = mount_inner_boss_len, r1 = mount_inner_boss_r, r2 = mount_inner_boss_base_r);
}

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
                translate([mount_dish_axis_x, 0, -mount_H - 20])
                    cylinder(h = mount_H + mount_margin_top + 40, r = mount_concave_r);
                mount_screw_hole(mount_hole_z1);
                mount_screw_hole(mount_hole_z2);
            }
        translate([-1000, -1000, -3000])
            cube([2000, 2000, 3000]);
    }
}

module mount_fill() {
    top_z = 0;
    bot_z = -base_thickness;
    eps = 0.1;
    overlap = 3;
    hull() {
        translate([-mount_gap - overlap, -mount_width/2, top_z - eps])
            cube([mount_gap + overlap + 0.01, mount_width, eps]);
        translate([-mount_gap - overlap, -mount_width/2, bot_z])
            cube([(bot_z * tan(mount_tilt)) + mount_gap + overlap + 0.01, mount_width, eps]);
    }
}

// Część mount_fill przy podstawie (przed pionowym cięciem na x=-12)
module mount_fill_base() {
    cut_x = -12;  // 3mm od podstawy (mount_gap + overlap = 15, więc 15-3=12 od brzegu)
    top_z = 0;
    bot_z = -base_thickness;
    eps = 0.1;
    overlap = 3;

    intersection() {
        hull() {
            translate([-mount_gap - overlap, -mount_width/2, top_z - eps])
                cube([mount_gap + overlap + 0.01, mount_width, eps]);
            translate([-mount_gap - overlap, -mount_width/2, bot_z])
                cube([(bot_z * tan(mount_tilt)) + mount_gap + overlap + 0.01, mount_width, eps]);
        }
        // Ograniczyć do x < cut_x (od -mount_gap-overlap do cut_x)
        translate([-mount_gap - overlap - 1, -100, bot_z])
            cube([cut_x + mount_gap + overlap + 2, 200, mount_gap + overlap + 100]);
    }
}

// Część mount_fill z elementem mocującym (za pionowym cięciem)
module mount_fill_mount() {
    cut_x = -12;
    top_z = 0;
    bot_z = -base_thickness;
    eps = 0.1;
    overlap = 3;

    intersection() {
        hull() {
            translate([-mount_gap - overlap, -mount_width/2, top_z - eps])
                cube([mount_gap + overlap + 0.01, mount_width, eps]);
            translate([-mount_gap - overlap, -mount_width/2, bot_z])
                cube([(bot_z * tan(mount_tilt)) + mount_gap + overlap + 0.01, mount_width, eps]);
        }
        // Ograniczyć do x >= cut_x (od cut_x do 0)
        translate([cut_x, -100, bot_z])
            cube([-cut_x + 1, 200, mount_gap + overlap + 100]);
    }
}

// Graniastosłup trójkątny (wypustka) na powierzchni cięcia
module triangular_prism(y_center, z_min, z_max) {
    prism_width = 3;      // szerokość wzdłuż Y (3mm)
    prism_depth = 2;      // wysunięcie wzdłuż X (2mm)

    polyhedron(
        points = [
            [-12, y_center, z_min],
            [-12, y_center + prism_width, z_min],
            [-12, y_center + prism_width/2, z_max],
            [-12 + prism_depth, y_center, z_min],
            [-12 + prism_depth, y_center + prism_width, z_min],
            [-12 + prism_depth, y_center + prism_width/2, z_max],
        ],
        faces = [
            [0, 1, 2],        // przód (x=-12)
            [5, 4, 3],        // tył (x=-10.5)
            [0, 1, 4, 3],     // dół
            [1, 2, 5, 4],     // bok 1
            [2, 0, 3, 5],     // bok 2
        ]
    );
}

// Graniastosłup trójkątny (wgłębienie) - 10% większy niż wypustka
module triangular_prism_cavity(y_center, z_min, z_max) {
    prism_width = 3.3;    // 3mm * 1.1
    prism_depth = 2.2;    // 2mm * 1.1

    polyhedron(
        points = [
            [-12, y_center, z_min],
            [-12, y_center + prism_width, z_min],
            [-12, y_center + prism_width/2, z_max],
            [-12 + prism_depth, y_center, z_min],
            [-12 + prism_depth, y_center + prism_width, z_min],
            [-12 + prism_depth, y_center + prism_width/2, z_max],
        ],
        faces = [
            [0, 1, 2],        // przód (x=-12)
            [5, 4, 3],        // tył
            [0, 1, 4, 3],     // dół
            [1, 2, 5, 4],     // bok 1
            [2, 0, 3, 5],     // bok 2
        ]
    );
}

// Zygzakowana powierzchnia na x=-12
module mount_fill_zigzag() {
    cut_x = -12;
    top_z = 0;
    bot_z = -base_thickness;
    zigzag_length = 3;      // okres zygzaka (3mm)
    zigzag_depth = 2;       // amplituda (2mm)
    teeth_y = floor(mount_width / zigzag_length);

    for (iy = [0:teeth_y]) {
        y_start = -mount_width/2 + iy * zigzag_length;
        y_mid = y_start + zigzag_length/2;
        y_end = y_start + zigzag_length;
        y_offset = (iy % 2 == 0) ? zigzag_depth : -zigzag_depth;

        // Trójkąt zygzaka (hull dwóch linii)
        hull() {
            translate([cut_x, y_start, bot_z])
                cube([0.1, 0.1, top_z - bot_z + 1]);
            translate([cut_x + y_offset, y_mid, bot_z])
                cube([0.1, 0.1, top_z - bot_z + 1]);
            translate([cut_x, y_end, bot_z])
                cube([0.1, 0.1, top_z - bot_z + 1]);
        }
    }
}

// Niebieska podstawa
color(color_base) {
    difference() {
        union() {
            cylinder(h = base_thickness, r = base_radius, center = false);

            // Część łącznika przy podstawie
            translate([0, 0, base_thickness])
                rotate([0, 0, mount_angle])
                    translate([base_radius + mount_gap, 0, 0]) {
                        mount_fill_base();
                        // Dwie wypustki trójkątne
                        triangular_prism(-mount_width/4 - 1, -base_thickness, 0);
                        triangular_prism(mount_width/4 - 1, -base_thickness, 0);
                    }

            // Element mocujący na górze podstawy (skierowany w dół), przesunięty o 2cm
            translate([0, 0, base_thickness])
                rotate([0, 0, mount_angle])
                    translate([base_radius + mount_gap + 20, 0, 0]) {  // +20mm (2cm) radialnie
                        mount_tab();
                        mount_fill_mount();
                    }
        }

        // Otwór 2mm przechodzący poziomo przez wszystkie elementy
        translate([0, 0, base_thickness / 2])
            rotate([0, 0, mount_angle])
            translate([base_radius + mount_gap, 0, 0])
            rotate([0, 90, 0])
            cylinder(h = 500, r = 1, center = true);

        // Wgłębienia pasujące do wypustek (na mount_fill_mount, przesunięte o 2cm)
        // Wgłębienia są o 10% większe niż wypustki
        translate([0, 0, base_thickness])
            rotate([0, 0, mount_angle])
            translate([base_radius + mount_gap + 20, 0, 0]) {
                triangular_prism_cavity(-mount_width/4 - 1, -base_thickness, 0);
                triangular_prism_cavity(mount_width/4 - 1, -base_thickness, 0);
            }
    }
}

// Żółte Słońce - dolna część na górnej powierzchni podstawy
sun_center_z = base_thickness + sun_radius - 10;
color(color_sun)
    translate([0, 0, sun_center_z])
        sphere(r = sun_radius, $fn = 150);
