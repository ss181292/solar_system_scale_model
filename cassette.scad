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

// Parametry pokrywki
cover_outer_diameter = 110;
cover_outer_radius = cover_outer_diameter / 2;
cover_inner_diameter = 92;
cover_inner_radius = cover_inner_diameter / 2;
cover_top_thickness = 3;
cover_inner_depth = 15;
cover_total_height = cover_top_thickness + cover_inner_depth;
cover_hole_diameter = 4;
cover_hole_radius = cover_hole_diameter / 2;
countersink_diameter = 7;
countersink_radius = countersink_diameter / 2;
countersink_depth = 2;
top_hole_diameter = 80;
top_hole_radius = top_hole_diameter / 2;
cover_hole_radius_from_center = 50;

// Pokrywka
translate([0, 120, 0]) {
    difference() {
        // Część stała pokrywki
        union() {
            // Górna część (płaska)
            cylinder(h = cover_top_thickness, r = cover_outer_radius, center = false);
            
            // Dolna część (ścianki)
            translate([0, 0, cover_top_thickness])
                cylinder(h = cover_inner_depth, r = cover_outer_radius, center = false);
        }
        
        // Wewnętrzna wnęka
        translate([0, 0, cover_top_thickness])
            cylinder(h = cover_inner_depth, r = cover_inner_radius, center = false);
        
        // Okrągły otwór z góry (80mm)
        translate([0, 0, -0.5])
            cylinder(h = cover_top_thickness + 1, r = top_hole_radius, center = false);
        
        // Cztery otwory do wkrętów
        for (i = [0:num_holes-1]) {
            angle = i * 360 / num_holes;
            x = cover_hole_radius_from_center * cos(angle);
            y = cover_hole_radius_from_center * sin(angle);
            
            // Otwór główny: 4mm średnicy na większości długości
            translate([x, y, 0])
                cylinder(h = cover_total_height, r = cover_hole_radius, center = false);
            
            // Pogłębienie stożkowe: na ostatnich 2.5mm zmienia się od 4mm do 7mm
            translate([x, y, 0])
                cylinder(h = 2.5, r1 = countersink_radius, r2 = cover_hole_radius, center = false);
        }
    }
}
