include <config.scad>;

module armMount() {
  difference() {
    union() {
      hull() {
        cylinder(d = 10, h = baseThickness, center = true);
        translate([0, -4/2 + 10, 0])
          cube([16, 4, baseThickness], center = true);
      }
      translate([0, -4/2 + 10, 0])
        cube([40, 4, baseThickness], center = true);
    }

    cylinder(d = 4, h = baseThickness + e, center = true);
    for (x = [-1, 1])
      translate([x*15, 8, 0])
        rotate([90, 0, 0])
          cylinder(d = 3.5, h = 4 + e, center = true);
  }
}

armMount();
