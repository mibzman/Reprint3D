include <relativity.scad> 

$fn=200;

rod_diamater = 3.3;
rod_distance = 22;

plate_thickness = 3;
plate_width = 30;
plate_height = 15;

differed("hole")
  box([plate_width,plate_height,plate_thickness])
  translated(rod_distance*x, [-1,1]/2)
  translate([0, -plate_height/4, 0]){
    rod(d=rod_diamater, h=plate_thickness, $class="hole");
  }
align([0,1,4])
orient([0,1,0])
differed("hole")
  box([plate_width,plate_height-plate_thickness,plate_thickness])
  translate([0, plate_height/5, 0]){
    rod(d=rod_diamater, h=plate_thickness, $class="hole");
  }
