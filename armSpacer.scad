include <config.scad>;

module armSpacer() {
  difference() {
    cylinder(d = 7, h = 25);
    translate([0, 0, -e/2])
      cylinder(d = 4, h = 25 + e);
  }
}

armSpacer();
