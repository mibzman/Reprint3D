
// util
module roundedRect(size, radius, edges=[1, 1, 1, 1], vscale=[1,1], shift=0){
  x = size[0];
  y = size[1];
  z = size[2];

  translate([0, -shift*2, 0]){
    linear_extrude(height=z, scale=[vscale[0], vscale[1]]){
      translate([0, shift*2, 0]){
        hull(){
            // place 4 circles in the corners, with the given radius
            if(edges[0]){
              translate([(-x/2)+(radius), (-y/2)+(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
              square(size=[radius, radius], center=true);
            }
            if(edges[1]){
              translate([(x/2)-(radius), (-y/2)+(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
              square(size=[radius, radius], center=true);
            }

            if(edges[2]){
              translate([(-x/2)+(radius), (y/2)-(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
              square(size=[radius, radius], center=true);
            }

            if(edges[3]){
              translate([(x/2)-(radius), (y/2)-(radius), 0])
              circle(r=radius);
            }
            else{
              translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
              square(size=[radius, radius], center=true);
            }
          }
       }
    }
  }
}

module gear(teeth = 10,h = 5, shaft=M3_hole){
  mod = 3;
  alpha = 180/teeth;
  r1 = mod*teeth/(2*3.14159);
  r=(mod/2)/tan(alpha);
  
  difference(){
    linear_extrude(height=h){
      for(i=[0:1:teeth]){
        rotate([0, 0, i*360/teeth]){
          x1=r;
          y1=mod/2;
          x2=r+mod;
          y2=0;
          x3=r;
          y3=-mod/2;
          x4=0;
          y4=0;
          polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
        }
      }
    }
    translate([0, 0, h/2]){
      cylinder(d=shaft, h=h*1.1, center=true);
    }
    if(shaft==-1){
      translate([0, 0, h/2]){
        difference(){
          cylinder(d=motor_shaft, h=h*1.1, center=true);
          translate([0, motor_shaft_shift, 0]){
            cube(size=[motor_shaft, motor_shaft, 16], center=true);
          }
        }
      }
    }
  }
  
}
