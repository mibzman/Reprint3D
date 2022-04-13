// reference scad for parts that are not printed

module cold_end(){
  
  translate([0, 0, alu_edge/2]){
    difference(){
      translate([alu_edge/4, 0, 0]){
        cube(size=[alu_edge/2, 70, alu_edge], center=true);
      }
      cylinder(d1=10, d2=6, h=alu_edge*1.1, center=true);
    }
  }
  
  
}

module hot_end(){  
  translate([0, -43, 45]){
    rotate([90, 0, 0]){
      cube(size=[35, alu_edge, alu_edge], center=true);
      translate([0, 0, alu_edge/2+3]){
        cylinder(d1=8, d2=1, h=6, center=true);
      }
    }
  }
}

module stirrer(){
  s_d = 23;
  s_di = 9;
  s_w = 11;
  s_h = 10;
  s_h2 = 25;
  s_wall = 2;
  s_flaps = 2;
  s_flaps_gap = 10;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h2/2]){
      difference(){
        intersection(){
          cylinder(d=s_d, h=s_h2, center=true);
          cube(size=[s_d, s_w, s_h2], center=true);
        }
        translate([0, 0, s_h]){
          cube(size=[s_di, s_d, s_h2], center=true);
        }
        cylinder(d=8.2, h=s_h2*1.1, center=true);        
        translate([7, 0, -s_h2/2]){
          cube(size=[3.5,5.6,20], center=true);
        }
        translate([-7, 0, -s_h2/2]){
          cube(size=[3.5,5.6,20], center=true);
        }
        translate([0, 0, 5-s_h2/2]){
          rotate([0, 90, 0]){
            cylinder(d=M3_hole, h=s_d*1.1, center=true);
          }
        }
        difference(){
          union(){
            translate([s_d/2-2, 0, s_h2+1]){
              rotate([-s_angle, -20, 0]){
                cube(size=[s_d, s_d, s_h2], center=true);
              }
            }
            translate([-s_d/2+2, 0, s_h2+1]){
              rotate([s_angle, 20, 0]){
                cube(size=[s_d, s_d, s_h2], center=true);
              }
            }
          }
          cylinder(d=s_di, h=s_h*2, center=true);
        }

      }
    }
  }
}

module stirrer_20(){
  s_d = 20;
  s_di = 10;
  s_h = 20;
  s_wall = 4;
  s_flaps = 3;
  s_flaps_gap = 7;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h/2]){
      difference(){
        cylinder(d=s_d, h=s_h, center=true);
        cylinder(d=M3_hole, h=s_h*1.1, center=true);
        translate([0, 0, s_wall]){
          cylinder(d=s_di, h=s_h, center=true);
        }
        for(i=[0:1:s_flaps-1]){
          rotate([0, 0, i*360/s_flaps]){
            translate([s_d/2, 0, s_wall]){
              rotate([0, 0, s_angle]){
                cube(size=[28, s_flaps_gap, s_h], center=true);
                translate([s_d/2, 0, -s_h/2-s_wall-0.1]){
                  linear_extrude(height=s_wall*1.1, scale=[1.3,1]){
                    square(size=[24, s_flaps_gap], center=true);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

module stirrer_25(){
  s_d = 25;
  s_di = 17;
  s_h = 20;
  s_wall = 4;
  s_flaps = 3;
  s_flaps_gap = 10;
  s_angle = 17;
  mirror([1, 0, 0]){
    translate([0, 0, s_h/2]){
      difference(){
        cylinder(d=s_d, h=s_h, center=true);
        cylinder(d=M3_hole, h=s_h*1.1, center=true);
        translate([0, 0, s_wall]){
          cylinder(d=s_di, h=s_h, center=true);
        }
        for(i=[0:1:s_flaps-1]){
          rotate([0, 0, i*360/s_flaps]){
            translate([s_d/2, 0, s_wall]){
              rotate([0, 0, s_angle]){
                cube(size=[40, s_flaps_gap, s_h], center=true);
                translate([s_d/2, 0, -s_h/2-s_wall-0.1]){
                  linear_extrude(height=s_wall*1.1, scale=[1.3,1]){
                    square(size=[30, s_flaps_gap], center=true);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}



module mount_plate(){
  mp_w = 70;
  mp_w1 = 40;
  mp_h = 87;
  mp_h1 = 50;
  mp_wall = 5;
  mp_shift = 10;
  lb_d = 15;
  lb_l = 30*2;
  lb_distance = 45;
  
  //Position mount holes Zonestar P802
  mp_x1 = 36;
  mp_y1 = 7;
  mp_x2 = 0;
  mp_y2 = 46+mp_y1;
  
  //Position mount holes aluminum square extruder
  mp_x3 = extuder_m_x;
  mp_y3 = 15 + mp_y1;

  //Position mount hole bowl
  mp_x4 = 0;
  mp_y4 = mp_y3 + 68 - alu_edge/2;
  
  translate([0, 0, 0]){
    difference(){
      union(){
        translate([0, 0, 0]){
          roundedRect(size=[mp_w, mp_h, mp_wall], radius=5);
        }
        translate([0, lb_distance/2, (lb_d+2*mp_wall)/2+2]){
          rotate([0, 90, 0]){
            cylinder(d=lb_d+2*mp_wall, h=lb_l, center=true);
          }
        }
        translate([0, -lb_distance/2, (lb_d+2*mp_wall)/2+2]){
          rotate([0, 90, 0]){
            cylinder(d=lb_d+2*mp_wall, h=lb_l, center=true);
          }
        }
      }
      translate([0, lb_distance/2, (lb_d+2*mp_wall)/2+2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=lb_l*1.1, center=true);
        }
      }
      translate([0, -lb_distance/2, (lb_d+2*mp_wall)/2+2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=lb_l*1.1, center=true);
        }
      }

    }
  }
  
}
