include <config.scad>;

// Components
use <tote.scad>;
use <pickup.scad>;
use <rest.scad>;
use <arm.scad>;
use <leg.scad>;

module assembly(x, xx, z) {
  x_travel = toteTopWidth;
  z_travel = fingerHeight + fingerClearance/2;

  translate([x * x_travel, 0, (z-0.5) * z_travel * 2]) {
    pickup();
  }

  if (z > 0.5) {
    translate([xx * x_travel, 0, (z-0.5)*2 * z_travel])
      totes();
  } else {
    translate([xx * x_travel, 0, 0])
      totes();
  }

  for (m = [0, 1])
    mirror([0, m, 0])
      rest();

  translate([0, 0, -7.5])
    armAssembly(z);

  translate([toteTopWidth/2, 0, 0])
    leg();
  translate([-(totesPerRow-0.5)*toteTopWidth, 0, 0])
    leg();
}
