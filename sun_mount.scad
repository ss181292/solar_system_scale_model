// sun_mount.scad
// Element mocujący Słońca - DRUKOWAĆ OSOBNO
// Łączy się z podstawą (sun.scad) poprzez wypustki/wgłębienia

// ===== Parametry =====
mount_angle = 45;
mount_gap = 12;
mount_width = 22;
mount_depth = 10;
mount_height = 90;
mount_tilt = 15;
mount_concave_r = 13.5;
mount_inner_boss_r = 6;
mount_inner_boss_base_r = 8.5;
mount_inner_boss_len = 2;
mount_margin_top = 15;
mount_r_round = mount_depth / 2;
mount_H = (mount_height - mount_depth * sin(mount_tilt)) / cos(mount_tilt);
mount_dish_axis_x = mount_depth + sqrt(mount_concave_r*mount_concave_r - (mount_width/2)*(mount_width/2));

base_thickness = 15;

// Parametry otworu montażowego
mounting_hole_diameter = 4;
mount_hole_z1 = -35;
mount_hole_z2 = -70;

// Parametry otworu przechodzącego przez model
base_diameter = 110;
base_radius = base_diameter / 2;

// Kolory
color_mount = [0.7, 0.7, 0.7];

// ===== Moduły z mount_fill =====
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

// ===== Moduły pomocnicze =====
module mount_inner_boss(z) {
    translate([-mount_inner_boss_len, 0, z]) rotate([0, 90, 0])
        cylinder(h = mount_inner_boss_len, r1 = mount_inner_boss_r, r2 = mount_inner_boss_base_r);
}

module mount_screw_hole(z) {
    translate([0, 0, z]) rotate([0, 90, 0]) {
        translate([0, 0, -(mount_inner_boss_len + 2)])
            cylinder(h = mount_inner_boss_len + 32, r = mounting_hole_diameter / 2);
    }
}

module mounting_holes() {
    mount_screw_hole(mount_hole_z1);
    mount_screw_hole(mount_hole_z2);
}

// ===== Graniastosłup trójkątny (wgłębienie) - 10% większy niż wypustka =====
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

// ===== ELEMENT MOCUJĄCY - GŁÓWNA BRYŁA =====
color(color_mount) {
    difference() {
        union() {
            // Główne ciało elementu mocującego
            translate([0, 0, base_thickness])
                rotate([0, 0, mount_angle])
                    translate([base_radius + mount_gap, 0, 0]) {
                        rotate([0, mount_tilt, 0]) {
                            intersection() {
                                difference() {
                                    union() {
                                        // Główne ciało
                                        translate([0, -mount_width/2, -mount_H + mount_r_round])
                                            cube([mount_depth, mount_width, (mount_H - mount_r_round) + mount_margin_top]);

                                        // Zaokrąglenie
                                        translate([mount_depth/2, 0, -mount_H + mount_r_round])
                                            rotate([-90, 0, 0])
                                            cylinder(h = mount_width, r = mount_r_round, center = true);

                                        // Wysepki wzmacniające
                                        mount_inner_boss(mount_hole_z1);
                                        mount_inner_boss(mount_hole_z2);
                                    }

                                    // Wklęsła ściana
                                    translate([mount_dish_axis_x, 0, -mount_H - 20])
                                        cylinder(h = mount_H + mount_margin_top + 40, r = mount_concave_r);

                                    // Otwory montażowe
                                    mounting_holes();
                                }

                                // Przycięcie
                                translate([-1000, -1000, -3000])
                                    cube([2000, 2000, 3000]);
                            }
                        }
                    }

            // Część łącznika z elementem
            translate([0, 0, base_thickness])
                rotate([0, 0, mount_angle])
                    translate([base_radius + mount_gap, 0, 0]) {
                        mount_fill_mount();
                    }
        }

        // Otwór 4mm przechodzący poziomo wzdłuż osi X przez element mocujący
        // Na tej samej wysokości jak w sun.scad
        translate([0, 0, base_thickness / 2])
            rotate([0, 0, mount_angle])
                translate([base_radius + mount_gap, 0, 0])
                    rotate([0, 90, 0])
                    cylinder(h = 500, r = 2, center = true);

        // Wgłębienia pasujące do wypustek (o 10% większe)
        translate([0, 0, base_thickness])
            rotate([0, 0, mount_angle])
            translate([base_radius + mount_gap, 0, 0]) {
                triangular_prism_cavity(-mount_width/4 - 1, -base_thickness, 0);
                triangular_prism_cavity(mount_width/4 - 1, -base_thickness, 0);
            }
    }
}
