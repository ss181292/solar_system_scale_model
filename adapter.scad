// Adapter pomiędzy tabliczką a słupkiem
// Szerokość i przekrój jak element mocujący w cassette_lid.scad

adapter_width  = 22;    // mount_width z cassette_lid.scad
adapter_depth  = 10;    // mount_depth z cassette_lid.scad
adapter_height = 170;   // taka sama jak tabliczka

// Wklęsłość ściany (y=0) — parametry z cassette_lid.scad
concave_r     = 13.5; // mount_concave_r
concave_r_top = concave_r + 4; // poszerzony promień w górnej strefie
// oś walca leży za ścianą y=0 tak, by cylinder dokładnie zahaczył o obie krawędzie (x=0 i x=22)
dish_axis_y = -sqrt(concave_r*concave_r - (adapter_width/2)*(adapter_width/2));

// Otwory 2mm wyrównane z otworami montażowymi tabliczki
hole_d            = 2;
screw_edge_margin = 8;
hole_x            = adapter_width / 2;
hole_z_bottom     = screw_edge_margin;
hole_z_top        = adapter_height - screw_edge_margin;

// Uszy — pogrubienie w +Y przy otworach (płynne przejście)
ear_extra_depth = 8;
ear_depth       = adapter_depth + ear_extra_depth; // 18 mm

// Otwory montażowe i wysepki (z cassette_lid.scad, element mocujący)
mount_hole_d      = 5.5;  // mount_hole_d
mount_boss_r      = 6;    // mount_inner_boss_r
mount_boss_base_r = 8.5;  // mount_inner_boss_base_r
mount_boss_len    = 2;    // mount_inner_boss_len
mount_hole_offset = 41; // odsunięcie od końca adaptera
mount_hole_z1 = adapter_height - mount_hole_offset;  // 129 mm od dołu
mount_hole_z2 = mount_hole_offset;                   //  41 mm od dołu (symetrycznie)

// Wysepka wzmacniająca — wychodzi z tylnej płaskiej ściany (y=adapter_depth) w +y
// rotate([90,0,0]) obraca oś z → −y, więc cylinder idzie od y=adapter_depth do y=adapter_depth+len
module mount_boss(z_pos) {
    translate([adapter_width/2, adapter_depth + mount_boss_len, z_pos])
        rotate([90, 0, 0])
            cylinder(h = mount_boss_len, r1 = mount_boss_r, r2 = mount_boss_base_r, $fn = 32);
}

// Otwór montażowy — przelotowy przez wysepkę i cały adapter
module mount_screw_hole(z_pos) {
    translate([adapter_width/2, adapter_depth + mount_boss_len + 0.5, z_pos])
        rotate([90, 0, 0])
            cylinder(h = adapter_depth + mount_boss_len + 1, r = mount_hole_d / 2, $fn = 32);
}

difference() {
    union() {
        // Dolne ucho (płaskie)
        cube([adapter_width, ear_depth, 2 * screw_edge_margin]);

        // Przejście dolne
        hull() {
            translate([0, 0, 2 * screw_edge_margin])
                cube([adapter_width, ear_depth, 0.01]);
            translate([0, 0, 3 * screw_edge_margin])
                cube([adapter_width, adapter_depth, 0.01]);
        }

        // Środkowa część
        translate([0, 0, 3 * screw_edge_margin])
            cube([adapter_width, adapter_depth, adapter_height - 6 * screw_edge_margin]);

        // Przejście górne
        hull() {
            translate([0, 0, adapter_height - 3 * screw_edge_margin])
                cube([adapter_width, adapter_depth, 0.01]);
            translate([0, 0, adapter_height - 2 * screw_edge_margin])
                cube([adapter_width, ear_depth, 0.01]);
        }

        // Górne ucho (płaskie)
        translate([0, 0, adapter_height - 2 * screw_edge_margin])
            cube([adapter_width, ear_depth, 2 * screw_edge_margin]);

        // Wysepki wzmacniające
        mount_boss(mount_hole_z1);
        mount_boss(mount_hole_z2);
    }

    // Wklęsłość na ścianie y=0 (pełna wysokość)
    translate([adapter_width/2, dish_axis_y, -0.5])
        cylinder(h = adapter_height + 1, r = concave_r, $fn = 64);

    // Poszerzenie wklęsłości w górnych 2*screw_edge_margin mm
    translate([adapter_width/2, dish_axis_y, adapter_height - 2 * screw_edge_margin])
        cylinder(h = 2 * screw_edge_margin + 0.5, r1 = concave_r, r2 = concave_r_top, $fn = 64);

    // Otwory 2mm przez pełną głębokość ucha
    for (z = [hole_z_bottom, hole_z_top]) {
        translate([hole_x, -0.5, z])
            rotate([-90, 0, 0])
                cylinder(h = ear_depth + 1, r = hole_d / 2, $fn = 32);
    }

    // Otwory montażowe (przez wysepki i adapter)
    mount_screw_hole(mount_hole_z1);
    mount_screw_hole(mount_hole_z2);
}
