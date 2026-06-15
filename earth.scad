// Ziemia - Model w skali 1:10^10
// Średnica: 1,28 mm
// Kolor: Sky Blue (#87CEEB)
// Księżyce: Księżyc (76,88)

// Parametry
planet_diameter = 1.28;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.5;
orbit_height = 0.4;

// Kolor Sky Blue
color_earth = [135/255, 206/255, 235/255];
color_white = [1, 1, 1];
color_black = [0, 0, 0];

// Księżyce - średnice orbit (tylko te, które się zmieszczą na podstawie)
moons = [
    ["Księżyc", 76.88]
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
                text("♁", size = 10, halign = "center", valign = "center", font = "DejaVu Sans");

// Planeta (kula) - wystaje 75% średnicy powyżej podstawy, ścięta poniżej dna podstawy
planet_center_z = base_thickness + 0.25 * planet_diameter;
color(color_earth)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
