include <config.scad>;
use <tote.scad>;

module rest_piece() {
  difference() {
    translate([0, 0, (fingerHeight + baseHeight)/2 - baseHeight])
      cube([toteTopWidth + boltDiameter*3, baseThickness, fingerHeight + baseHeight], center = true);
    tote();
    for (x = [-1, 0, 1])
      translate([x*toteTopWidth/2, 0, -baseHeight/2]) {
        cylinder(d = boltDiameter, h = baseHeight + fingerHeight*2 + 1, center = true);
        rotate([90, 0, 0])
          cylinder(d = boltDiameter, h = baseThickness + 1, center = true);
      }
  }
}

module rest() {
  for (x = [0:(totesPerRow-1)])
    translate([-x*toteTopWidth, baseThickness/2 - toteBottomWidth, 0])
      rest_piece();
}

rest();
