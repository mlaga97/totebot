include <config.scad>;

module leg() {
  translate([0, 0, -base2Height/2 - baseHeight])
    difference() {
      cube([10, toteBottomLength, base2Height], center = true);
      for (y = [-1, 1])
        translate([0, y*(toteBottomWidth - baseThickness/2), 0])
          cylinder(d = pinDiameter, h = base2Height + 1, center = true);
    }
}

leg();
