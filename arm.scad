include <config.scad>;

module arm(armLength) {
  difference() {
    hull()
      for (x = [0, 1])
        translate([x*armLength, 0, 0])
          cylinder(d = 7, h = 5, center = true, $fn = 24);

    for (x = [0, 1])
      translate([x*armLength, 0, 0])
        cylinder(d = 3.5, h = 5 + e, center = true, $fn = 24);
  }
}
//!arm(22.5);

module armSpacer1() {
  difference() {
    cylinder(d = 7, h = 19, center = true);
    cylinder(d = 4, h = 19 + e, center = true);
  }
}

module armSpacer2() {
  difference() {
    cylinder(d = 7, h = 22, center = true);
    cylinder(d = 3, h = 22 + e, center = true);
  }
}

module shelf_part() {
  difference() {
    cylinder(d = 7, h = 22, center = true);
    cylinder(d = 3, h = 22 + e, center = true);
  }
}

module shelf() {
  translate([0, 0, 2])
    rotate([90, 0, 0])
      difference() {
        hull()
          for (x = [-6:3])
            translate([x*15, 0, 0])
              cylinder(d = 6.5, h = 22, center = true);
        for (x = [-6:3])
          translate([x*15, 0, 0])
            cylinder(d = 3, h = 22 + e, center = true);
      }
}

module armMount() {
  difference() {
    union() {
      cylinder(d = 10, h = baseThickness, center = true);
      translate([0, 8/2, 0])
        cube([10, 8, baseThickness], center = true);
      translate([0, -4/2 + 8, 0])
        cube([40, 4, baseThickness], center = true);
    }

    cylinder(d = 4, h = baseThickness + e, center = true);
    for (x = [-1, 1])
      translate([x*15, 6, 0])
        rotate([90, 0, 0])
          cylinder(d = 3.5, h = 4 + e, center = true);
  }
}

module armAssembly(z_a) {
  armLength = 22.5;
  th = asin((z_a*(armLength - 7.5) + 7.5)/22.5);

  translate([-toteTopWidth/4, 0, -armLength + 2]) {
    rotate([90, 0, 0]) {
      armSpacer2();
      for (m = [0, 1])
        mirror([0, 0, m]) {
          translate([0, 0, (toteBottomLength - baseThickness)/2])
            armMount();
          translate([0, 0, (19/2 + 16)])
            armSpacer1();
          rotate([0, 0, 180-th])
            translate([0, 0, 16 - 5/2])
              arm(armLength);
        }
    }
  }
}
