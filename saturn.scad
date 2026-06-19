// Saturn - Model w skali 1 : 10 000 000 000
// Średnica: 11,65 mm
// Kolor: Lemon Yellow (#FFFACD)
// Pierścienia: Pierścień B (9 200 - 117 580 km), Pierścień A (122 170 - 136 775 km), Przerwa Cassiniego, nachylenie 27°
// Księżyce: Titan (122,19), Reya (52,72), Dione (37,77)

// Parametry
planet_diameter = 11.65;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.4;
orbit_height = 0.2;
ring_thickness = 0.8; // Grubość pierścienia
ring_angle = 27; // Kąt nachylenia pierścieni

// Pierścień B - radius od centrum planety: 92 000 - 117 580 km -> 9,2 - 11,758 mm
ring_b_radius_inner = 9.2;
ring_b_radius_outer = 11.758;

// Pierścień A - radius od centrum planety: 122 170 - 136 775 km -> 12,217 - 13,6775 mm
ring_a_radius_inner = 12.217;
ring_a_radius_outer = 13.6775;

// Przerwa Cassiniego - między pierścieniami B i A
cassini_radius_inner = 11.758;
cassini_radius_outer = 12.217;

// Kolor Lemon Yellow
color_saturn = [255/255, 250/255, 205/255];
color_white = [1, 1, 1];
color_black = [0, 0, 0];

// Księżyce - średnice orbit (Titan: 244,38, Reya: 105,44, Japet: 712,34 - za duże na podstawę)
// Dione (75,54) mieści się na podstawie ø78mm
moons = [
    ["Dione", 75.54]
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

// Planeta (kula) + pierścienia - wysteją 75% średnicy planety powyżej podstawy, ścięte poniżej dna podstawy
planet_center_z = base_thickness + 0.40 * planet_diameter;
color(color_saturn)
    intersection() {
        union() {
            // Kula planety
            translate([0, 0, planet_center_z])
                sphere(r = planet_radius, $fn = 100);

            // Pierścień B - wewnętrzny pierścień
            translate([0, 0, planet_center_z])
                rotate([ring_angle, 0, 0])
                    difference() {
                        cylinder(h = ring_thickness, r = ring_b_radius_outer, center = true, $fn = 100);
                        cylinder(h = ring_thickness + 0.1, r = ring_b_radius_inner, center = true, $fn = 100);
                    }

            // Pierścień A - zewnętrzny pierścień
            translate([0, 0, planet_center_z])
                rotate([ring_angle, 0, 0])
                    difference() {
                        cylinder(h = ring_thickness, r = ring_a_radius_outer, center = true, $fn = 100);
                        cylinder(h = ring_thickness + 0.1, r = ring_a_radius_inner, center = true, $fn = 100);
                    }
        }
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
