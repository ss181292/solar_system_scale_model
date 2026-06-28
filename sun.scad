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

// Niebieska podstawa
color(color_base) {
    difference() {
        union() {
            cylinder(h = base_thickness, r = base_radius, center = false);

            // Element mocujący na górze podstawy (skierowany w dół)
            translate([0, 0, base_thickness])
                rotate([0, 0, mount_angle])
                    translate([base_radius + mount_gap, 0, 0]) {
                        mount_tab();
                        mount_fill();
                    }
        }

        // Otwór 2mm przechodzący poziomo przez wszystkie elementy
        translate([0, 0, base_thickness / 2])
            rotate([0, 0, mount_angle])
            translate([base_radius + mount_gap, 0, 0])
            rotate([0, 90, 0])
            cylinder(h = 500, r = 1, center = true);
    }
}

// Żółte Słońce - dolna część na górnej powierzchni podstawy
sun_center_z = base_thickness + sun_radius - 10;
color(color_sun)
    translate([0, 0, sun_center_z])
        sphere(r = sun_radius, $fn = 150);
