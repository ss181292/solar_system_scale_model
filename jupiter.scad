// Jowisz - Model w skali 1:10^10
// Średnica: 13,98 mm
// Kolory: Biały, żółty, pomarańczowy (8 pasów)
// Księżyce: Io (42,17), Europa (67,11), Ganimedes (107,04), Kallisto (188,27)

// Parametry
planet_diameter = 13.98;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.4;
orbit_height = 0.2;

// Kolory
color_white = [1, 1, 1];
color_yellow = [1, 0.85, 0];
color_orange = [1, 0.65, 0];
color_black = [0, 0, 0];

// Księżyce - średnice orbit (Io: 84,34, Europa: 134,22, Ganimedes: 214,08, Kallisto: 376,54)
// Wszystkie orbity są za duże, by zmieścić się na podstawie ø78mm
moons = [
];

// Podstawa
color(color_white)
    cylinder(h = base_thickness, r = base_diameter / 2, center = false, $fn = 100);

// Orbity księżyców - czarne okręgi na powierzchni podstawy
for (moon = moons) {
    orbit_radius = moon[1] / 2;
    translate([0, 0, base_thickness])
        color(color_black)
            difference() {
                cylinder(h = orbit_height, r = orbit_radius, center = false, $fn = 100);
                translate([0, 0, -0.1])
                    cylinder(h = orbit_height + 0.2, r = orbit_radius - orbit_line_width, center = false, $fn = 100);
            }
}

// Symbol astronomiczny - czarny, szerokość 11mm, w prawym górnym rogu podstawy
symbol_width = 11;
translate([17, 17, base_thickness])
    color(color_black)
        resize([symbol_width, symbol_width, orbit_height], auto = [false, false, false])
            linear_extrude(height = 1)
                text("♃", size = 10, halign = "center", valign = "center", font = "DejaVu Sans");

// Planeta (kula) - 7 pasów o różnych kolorach, wg wymiarów zdjęcia
// Skala: 13.98 mm model = 98 mm na zdjęciu
planet_center_z = planet_radius;
scale_factor = planet_diameter / 98;

// Strefy wg wymiarów ze zdjęcia (od góry):
// 0-25mm: żółta, 25-35mm: biała, 35-44mm: pomarańczowa, 44-59mm: biała
// 59-68mm: żółta, 68-74mm: biała, 74-98mm: żółta

zone_1_height = (25 - 0) * scale_factor;           // 0-25mm żółta
zone_2_height = (35 - 25) * scale_factor;          // 25-35mm biała
zone_3_height = (44 - 35) * scale_factor;          // 35-44mm pomarańczowa
zone_4_height = (59 - 44) * scale_factor;          // 44-59mm biała
zone_5_height = (68 - 59) * scale_factor;          // 59-68mm żółta
zone_6_height = (74 - 68) * scale_factor;          // 68-74mm biała
zone_7_height = (98 - 74) * scale_factor;          // 74-98mm żółta

// Strefa 1 (góra) - żółta
color(color_yellow)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height])
            cube([2000, 2000, zone_1_height]);
    }

// Strefa 2 - biała
color(color_white)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height - zone_2_height])
            cube([2000, 2000, zone_2_height]);
    }

// Strefa 3 - pomarańczowa
color(color_orange)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height - zone_2_height - zone_3_height])
            cube([2000, 2000, zone_3_height]);
    }

// Strefa 4 - biała
color(color_white)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height - zone_2_height - zone_3_height - zone_4_height])
            cube([2000, 2000, zone_4_height]);
    }

// Strefa 5 - żółta
color(color_yellow)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height - zone_2_height - zone_3_height - zone_4_height - zone_5_height])
            cube([2000, 2000, zone_5_height]);
    }

// Strefa 6 - biała
color(color_white)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z + planet_radius - zone_1_height - zone_2_height - zone_3_height - zone_4_height - zone_5_height - zone_6_height])
            cube([2000, 2000, zone_6_height]);
    }

// Wielka Czerwona Plama - wymiary ze zdjęcia
grrs_width = 10 * scale_factor;
grrs_height = 7 * scale_factor;
grrs_center_from_top = 69 * scale_factor;
grrs_z = planet_center_z + planet_radius - grrs_center_from_top;

// Strefa 7 (dół) - żółta
color(color_yellow)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, planet_center_z - planet_radius])
            cube([2000, 2000, zone_7_height]);
    }

// Wielka Czerwona Plama - eliptyczny element na boku sfery, styczny do powierzchni
grrs_surface_distance = sqrt(planet_radius * planet_radius - (grrs_z - planet_center_z) * (grrs_z - planet_center_z));
grrs_rotation_angle = atan2(grrs_surface_distance, grrs_z - planet_center_z);

color(color_orange)
    translate([grrs_surface_distance, 0, grrs_z])
        rotate(grrs_rotation_angle, [0, 1, 0])
            linear_extrude(height = 0.03, center = true)
                scale([grrs_height / 2, grrs_width / 2, 1])
                    circle(r = 1, $fn = 60);
