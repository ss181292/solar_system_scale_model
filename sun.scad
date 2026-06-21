// Słońce - Model w skali 1 : 10 000 000 000
// Średnica: 139,1 mm
// Kolor: Żółty (#FFFF00)

// Parametry
sun_diameter = 139.1;
sun_radius = sun_diameter / 2;
base_diameter = 110;
base_radius = base_diameter / 2;
base_thickness = 15;

// Kolory
color_sun = [1, 1, 0];
color_base = [0.2, 0.4, 0.8];

// Niebieska podstawa
color(color_base)
    cylinder(h = base_thickness, r = base_radius, center = false);

// Żółte Słońce - dolna część na górnej powierzchni podstawy
sun_center_z = base_thickness + sun_radius - 10;
color(color_sun)
    translate([0, 0, sun_center_z])
        sphere(r = sun_radius, $fn = 150);
