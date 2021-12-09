include <config.scad>;

module armSlide() {
  translate([0, -5 - armatureHeight/2, 0])
    difference() {
      hull() {
        translate([-25, 0, 0])
          cylinder(d = armatureHeight - 1, h = 6);
        translate([5, 0, 0])
          cylinder(d = armatureHeight - 1, h = 6);
        translate([0, 5 + armatureHeight/2, 0])
          cylinder(d = 7, h = 6);
      }

      hull() {
        translate([-(25), 0, -e])
          cylinder(d = 6, h = 3.5 + e);
        translate([-(25 + 5), 0, -e])
          cylinder(d = 8, h = 3.5 + e);
      }
      hull() {
        translate([5, 0, -e])
          cylinder(d = 6, h = 3.5 + e);
        translate([5 + 5, 0, -e])
          cylinder(d = 8, h = 3.5 + e);
      }
      hull() {
        translate([-25, 0, -e])
          cylinder(d = 6, h = 3.5 + e);
        translate([5, 0, -e])
          cylinder(d = 6, h = 3.5 + e);
      }
      translate([0, 5 + armatureHeight/2, -e])
        cylinder(d = 4, h = 6 + 2*e);
    }
}

translate([0, 16, 0])
  mirror([0, 0, 1])
    armSlide();
translate([0, -16, 0])
  rotate([180, 0, 0])
    armSlide();
