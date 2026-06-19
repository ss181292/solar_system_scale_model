// Neptun - Model w skali 1:10^10
// Średnica: 4,92 mm
// Kolor: Klein Blue (#002FA7)
// Księżyce: Proteus (23,53), Tryton (70,95), Nereida (1102,78)

// Parametry
planet_diameter = 4.92;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.4;
orbit_height = 0.2;

// Kolor Klein Blue
color_neptune = [0/255, 47/255, 167/255];
color_white = [1, 1, 1];
color_black = [0, 0, 0];

// Księżyce - średnice orbit (Nereida: 1102,78 - znacznie za duża na podstawę)
// Proteus (23,53) i Tryton (70,95) mieszczą się na podstawie ø78mm
moons = [
    ["Proteus", 23.53],
    ["Tryton", 70.95]
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

// Planeta (kula) - wystaje 75% średnicy powyżej podstawy, ścięta poniżej dna podstawy
planet_center_z = base_thickness + 0.35 * planet_diameter;
color(color_neptune)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
