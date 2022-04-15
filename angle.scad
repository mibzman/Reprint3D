include <relativity.scad> 

$fn=20;

rod_diamater = 3;
rod_distance = 22;

plate_thickness = 3;
plate_width = 30;
plate_height = 15;

differed("hole")
  box([plate_width,plate_height,plate_thickness])
  translated(rod_distance*x, [-1,1]/2)
  translate([0, -plate_height/4, 0]){
    rod(d=rod_diamater, h=plate_thickness+1, $class="hole");
  }


