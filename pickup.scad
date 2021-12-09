include <config.scad>;
use <tote.scad>;

module pickup_piece() {
  difference() {
    translate([0, 0, (fingerHeight + armatureHeight)/2 - armatureHeight])
      cube([toteTopWidth + boltDiameter*3, armatureThickness, fingerHeight + armatureHeight], center = true);
    tote();
    for (x = [-1, -0.5, 0, 0.5, 1])
      translate([x*toteTopWidth/2, 0, -armatureHeight/2]) {
        cylinder(d = boltDiameter, h = armatureThickness + fingerHeight + 1, center = true);
        rotate([90, 0, 0])
          cylinder(d = boltDiameter, h = armatureThickness + 1, center = true);
      }
  }
}

module pickup() {
  for (x = [0:(totesPerRow-1)])
    translate([-x*toteTopWidth, 0, 0])
      pickup_piece();
}

pickup();
