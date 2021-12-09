use <assembly.scad>

/*******************************************************************************
********************************************************************************
*******************************************************************************/
// Animation

module animation() {
  t = $t * 6;

  if (t < 0.5) { // 0.5
    x = 0;
    z = t*2;

    assembly(x, x, z);
  } else if (t < 1.5) { // 1
    x = t-0.5;
    z = 1;

    assembly(x, x, z);
  } else if (t < 2) { // 0.5
    x = 1;
    z = 1-(t-1.5)*2;

    assembly(x, x, z);
  } else if (t < 3) { // 1
    x = 1-(t-2);
    z = 0;

    assembly(x, 1, z);
  } else if (t < 4) { // 1
    x = t - 3;
    z = 0;

    assembly(x, 1, z);
  } else if (t < 4.5) { // 0.5
    x = 1;
    z = (t - 4) * 2;

    assembly(x, 1, z);
  } else if (t < 5.5) { // 1
    x = 1-(t-4.5);
    z = 1;

    assembly(x, x, z);
  } else if (t < 6) { // 0.5
    x = 0;
    z = 1-(t-5.5)*2;

    assembly(x, x, z);
  }
}

animation();
