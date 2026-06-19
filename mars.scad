// Mars - Model w skali 1 : 10 000 000 000
// Średnica: 0,68 mm
// Kolor: Red (#FF0000)
// Księżyce: Fobos (1,88), Deimos (4,69)

// Parametry
planet_diameter = 0.68;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;
orbit_line_width = 0.4;
orbit_height = 0.2;

// Kolor Red
color_mars = [1, 0, 0];
color_white = [1, 1, 1];
color_black = [0, 0, 0];
color_gray = [128/255, 128/255, 128/255];

// Księżyce - średnice orbit
moons = [
    ["Fobos", 1.88],
    ["Deimos", 4.69]
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

// Strzałka wskazująca model - czarna, dla planet o średnicy < 4mm
arrow_length = 14;
arrow_shaft_width = 3;
arrow_head_length = 4;
arrow_head_width = 6;
translate([-13, -13, base_thickness])
    rotate([0, 0, 45])
        color(color_gray)
            linear_extrude(height = orbit_height)
                polygon(points = [
                    [0, -arrow_shaft_width / 2],
                    [0, arrow_shaft_width / 2],
                    [arrow_length - arrow_head_length, arrow_shaft_width / 2],
                    [arrow_length - arrow_head_length, arrow_head_width / 2],
                    [arrow_length, 0],
                    [arrow_length - arrow_head_length, -arrow_head_width / 2],
                    [arrow_length - arrow_head_length, -arrow_shaft_width / 2]
                ]);

// Planeta (kula) - wystaje 75% średnicy powyżej podstawy, ścięta poniżej dna podstawy
planet_center_z = base_thickness + 0.25 * planet_diameter;
color(color_mars)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
