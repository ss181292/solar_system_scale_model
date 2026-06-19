// Merkury - Model w skali 1:10^10
// Średnica: 0,49 mm
// Kolor: Grey (#808080)
// Księżyce: Brak

// Parametry
planet_diameter = 0.49;
planet_radius = planet_diameter / 2;
base_diameter = 78;
base_thickness = 1;

// Kolor Grey
color_mercury = [128/255, 128/255, 128/255];
color_white = [1, 1, 1];
color_black = [0, 0, 0];
orbit_height = 0.2;

// Podstawa
color(color_white)
    cylinder(h = base_thickness, r = base_diameter / 2, center = false, $fn = 100);

// Strzałka wskazująca model - czarna, dla planet o średnicy < 4mm
arrow_length = 14;
arrow_shaft_width = 3;
arrow_head_length = 4;
arrow_head_width = 6;
translate([-13, -13, base_thickness])
    rotate([0, 0, 45])
        color(color_black)
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
color(color_mercury)
    intersection() {
        translate([0, 0, planet_center_z])
            sphere(r = planet_radius, $fn = 100);
        translate([-1000, -1000, 0])
            cube([2000, 2000, 1000]);
    }
