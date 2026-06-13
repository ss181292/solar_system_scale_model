// Wenus - Model w skali 1:10^10
// Średnica: 1,21 mm
// Kolor: Lemon Yellow (#FFFACD)
// Księżyce: Brak

// Parametry
planet_diameter = 1.21;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;

// Kolor Lemon Yellow
color_venus = [255/255, 250/255, 205/255];
color_white = [1, 1, 1];

// Podstawa
color(color_white)
    cylinder(h = base_thickness, r = base_diameter / 2, center = false, $fn = 100);

// Planeta (kula) - wystaje 75% średnicy powyżej podstawy, ścięta poniżej dna podstawy
planet_center_z = base_thickness + 0.25 * planet_diameter;
color(color_venus)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
