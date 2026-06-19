// Parametry kasety
outer_diameter = 110;
inner_diameter = 80;
outer_radius = outer_diameter / 2;
inner_radius = inner_diameter / 2;
height = 20;
bottom_thickness = 5;
reduction_height = 13;
reduced_outer_diameter = 86.5;
reduced_outer_radius = reduced_outer_diameter / 2;
wall_thickness = outer_radius - inner_radius;
reduced_inner_radius = reduced_outer_radius - wall_thickness;
hole_diameter = 2;
hole_radius = hole_diameter / 2;
hole_radius_from_center = outer_radius - 5;
num_holes = 4;

// Parametry otworów wentylacyjnych
vent_hole_diameter = 1;
vent_hole_radius = vent_hole_diameter / 2;
vent_rings = 5;
vent_holes_per_ring = 20;
vent_max_radius = inner_radius - 4;

// Parametry rowków
groove_count = 5;
groove_width = 2;
groove_depth = 1;
groove_angle_offset = 45;

// Parametry wypustek
bump_per_ring = 5;
bump_height = 1;
bump_base_radius = 1.5;
bump_ring_radius_1 = 12;
bump_ring_radius_2 = 26;
bump_angle_offset = 9;

// Główna kaseta
difference() {
    // Część zewnętrzna
    union() {
        // Cylinder dolny (stała średnica)
        cylinder(h = height - reduction_height, r = outer_radius, center = false);
        
        // Część ze zmniejszoną średnicą (skokowo)
        translate([0, 0, height - reduction_height])
            cylinder(h = reduction_height, r = reduced_outer_radius, center = false);
    }
    
    // Wyjęcie wewnętrzne (wnęka)
    translate([0, 0, bottom_thickness])
        cylinder(h = height - bottom_thickness, r = inner_radius, center = false);
    
    // Cztery otwory rozmieszczone równomiernie
    for (i = [0:num_holes-1]) {
        angle = i * 360 / num_holes;
        translate([hole_radius_from_center * cos(angle), hole_radius_from_center * sin(angle), -0.5])
            cylinder(h = height + 1, r = hole_radius, center = false);
    }

    // Rowki na górnej powierzchni dolnej części kasety (pierścieniowy stopień)
    for (i = [0:groove_count-1]) {
        angle = i * 360 / groove_count + groove_angle_offset;
        rotate([0, 0, angle])
            translate([reduced_outer_radius, -groove_width/2, height - reduction_height - groove_depth])
                cube([outer_radius - reduced_outer_radius + 1, groove_width, groove_depth + 0.5]);
    }

    // Otwory wentylacyjne - pionowe, przez dno kasety (~100 otworów)
    for (ring = [1:vent_rings]) {
        ring_radius = ring * vent_max_radius / vent_rings;
        for (hole = [0:vent_holes_per_ring-1]) {
            angle = hole * 360 / vent_holes_per_ring;
            translate([ring_radius * cos(angle), ring_radius * sin(angle), -0.5])
                cylinder(h = bottom_thickness + 1, r = vent_hole_radius, center = false);
        }
    }
}

// Wypustki wewnątrz kasety (na dnie wnęki, wyrastające w górę, dwa okręgi)
for (i = [0:bump_per_ring-1]) {
    angle = i * 360 / bump_per_ring + bump_angle_offset;
    translate([bump_ring_radius_1 * cos(angle), bump_ring_radius_1 * sin(angle), bottom_thickness])
        cylinder(h = bump_height, r = bump_base_radius, center = false);
    translate([bump_ring_radius_2 * cos(angle), bump_ring_radius_2 * sin(angle), bottom_thickness])
        cylinder(h = bump_height, r = bump_base_radius, center = false);
}

