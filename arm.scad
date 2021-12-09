include <config.scad>;

use <armPaddle.scad>;
use <armConnector.scad>;
use <armSpacer.scad>;
use <armMount.scad>;
use <armSlide.scad>;

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

module armAssembly(z_a) {
  armLength = 22.5;
  th = asin((z_a*(armLength - 7.5) + 7.5)/22.5);

  for (m = [0, 1])
    mirror([0, m, 0])
      translate([-15, 0, -22.5])
        rotate([90, 0, 0])
          rotate([0, 0, 180-th])
            translate([armLength, 0, armatureThickness/2 + 6])
              rotate([0, 0, th])
                armConnector();
      
  for (x = [0, 1])
    translate([-toteTopWidth/4 - x*(totesPerRow-2)*toteTopWidth, 0, -armLength]) {
      rotate([90, 0, 0]) {
        rotate([0, 0, 180-th])
          armPaddle(armLength);
        for (m = [0, 1])
          mirror([0, 0, m]) {
            translate([0, 0, (toteBottomLength - baseThickness)/2])
              armMount();
            translate([0, 0, armatureThickness/2])
              armSpacer();
            rotate([0, 0, 180-th])
              translate([armLength, 0, armatureThickness/2])
                rotate([0, 0, th])
                  armSlide();
          }
      }
    }
}
