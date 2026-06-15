// Saturn - Model w skali 1:10^10
// Średnica: 11,65 mm
// Kolor: Lemon Yellow (#FFFACD)
// Pierścienie: średnica zewnętrzna 35,79 mm, średnica wewnętrzna 12,97 mm (uwzględniają średnicę planety), nachylenie 27°, lite
// Księżyce: Titan (122,19), Reya (52,72), Dione (37,77)

// Parametry
planet_diameter = 11.65;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.4;
orbit_height = 0.2;
ring_diameter_outer = 35.79;
ring_radius_outer = ring_diameter_outer / 2;
ring_diameter_inner = 12.97;
ring_radius_inner = ring_diameter_inner / 2;
ring_thickness = 0.8; // Grubość pierścienia
ring_angle = 27; // Kąt nachylenia pierścieni

// Przerwa Cassiniego - radius od centrum planety: 117 580 - 122 170 km -> 11,76 - 12,22 mm
cassini_radius_inner = 11.76;
cassini_radius_outer = 12.22;

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

// Symbol astronomiczny - czarny, szerokość 11mm, w prawym górnym rogu podstawy
symbol_width = 11;
translate([19, 19, base_thickness])
    color(color_black)
        resize([symbol_width, symbol_width, orbit_height], auto = [false, false, false])
            linear_extrude(height = 1)
                text("♄", size = 10, halign = "center", valign = "center", font = "DejaVu Sans");

// Planeta (kula) + pierścienie - wystają 75% średnicy planety powyżej podstawy, ścięte poniżej dna podstawy
planet_center_z = base_thickness + 0.40 * planet_diameter;
color(color_saturn)
    intersection() {
        union() {
            // Kula planety
            translate([0, 0, planet_center_z])
                sphere(r = planet_radius, $fn = 100);

            // Pierścienie - lite, nachylone pod kątem 27°, z przerwą Cassiniego
            translate([0, 0, planet_center_z])
                rotate([ring_angle, 0, 0])
                    difference() {
                        cylinder(h = ring_thickness, r = ring_radius_outer, center = true, $fn = 100);
                        cylinder(h = ring_thickness + 0.1, r = ring_radius_inner, center = true, $fn = 100);
                        // Przerwa Cassiniego
                        difference() {
                            cylinder(h = ring_thickness + 0.1, r = cassini_radius_outer, center = true, $fn = 100);
                            cylinder(h = ring_thickness + 0.2, r = cassini_radius_inner, center = true, $fn = 100);
                        }
                    }
        }
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
