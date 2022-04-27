//Direct granules extruder
//https://homofaciens.de/technics-machines-3D-printer-Granule-Extruder_ge.htm

include <util.scad>

M4_hole = 4.2;
M4_nut_e = 7.66+1.0;
M5_nut_e = 8.79+1.0;
M6_nut_e = 11.05+1.5;
M8_nut_e = 14.38+1.5;
M3_hole = 3.3;
M3_nut_e = 6.3;
$fn=200;
alu_edge = 16.2;
motor_e = 42;
motor_l = 40;

motor_shaft = 5.5;
motor_shaft_shift = 4.9;

//Motor mount
//mm_r = 22;
mm_d1 = motor_e + 15;
mm_d2 = motor_l - 5;
motor_m = 31;

//Ball bearing
bb_do = 22;
bb_di = 8;
bb_w = 7;

Assembled = 1;
Part = 1;

if(Assembled){
  translate([0, 0, 0])rotate([90, 0, 0]){
    hopper();
  }
  translate([0, -70, 72])rotate([0,0,270]){
    motor_mount_2(type=1);
  }
  translate([0, 45, 47])rotate([0,0,270]){
    motor_mount_2(type=2);
  }
  translate([-25, -45, 75])rotate([0,180,0]){
    translate([-25, 0, 5]){
      gear(teeth=89,h=10, shaft=bb_do+0.3);  
      translate([0, 0, 10]){
        rotate([0, 0, 0])motor_coupler_2();
      }
    }
  }
  translate([0, -100, 60])rotate([0,0,-5]){
    gear(teeth=20,h=10, shaft=-1);
  }
}
else{
  if (Part == 1) {
      motor_mount_2(type = 1);
  } else if (Part == 2) {
      motor_mount_2(type=2);
  } else if (Part == 3) {
      gear(teeth=20,h=10, shaft=-1);
  } else if (Part == 4) {
      gear(teeth=89,h=10, shaft=bb_do+0.3);  
  } else if (Part == 5) {
    hopper(mode = 2);
  } else if (Part == 6) {
      hopper(mode = 1);
  } else {
     stirrer_20();
     stirrer();
  }
}

module motor_coupler_2(nut=M8_nut_e, insert=0){
  mc_d = 26;
  extra_h = 5*0;
  mc_h = 27+extra_h;
  mc_shaft_h = 15;
  mc_wall = 2;
  mc_shaft = motor_shaft;
  mc_shaft_shift = motor_shaft_shift;
  
  a = mc_h-mc_shaft_h-mc_wall;
  if(insert==0){  
    difference(){
      translate([0, 0, mc_h/2]){
        cylinder(d=mc_d, h=mc_h, center=true);
      }
      
      //Center nut hole
      translate([0, 0, mc_h-a/2+0.1]){
        cylinder(d=nut, h=a, center=true, $fn=6);
      }

      // Center hole stepper motor shaft
      translate([0, 0, mc_shaft_h-1.1]){
        rotate([90, 0, 0]){
          cylinder(d=2, h=mc_d*2, center=true);
        }
      }
      translate([0, 0, mc_shaft_h/2-0.1]){
        cylinder(d=bb_do+0.3, h=mc_shaft_h, center=true);
      }
    }
  }
  else{
    //Insert M5
    translate([0, 60, a/2]){
      difference(){
        cylinder(d=nut-0.2, h=a, center=true, $fn=6);
        cylinder(d=M5_nut_e, h=a+0.1, center=true, $fn=6);
      }
    }
    //Insert M4
    translate([20, 60, a/2]){
      difference(){
        cylinder(d=nut-0.2, h=a, center=true, $fn=6);
        cylinder(d=M4_nut_e, h=a+0.1, center=true, $fn=6);
      }
    }
  }
}

module motor_mount_2(type = 0){
  mm_distance = 55;
  mm_distance2 = 95;
  mm_wall = 3;
  mm_l1 = 110;
  mm_l2 = 60;
  mm_l3 = mm_l1 - mm_l2;
  mm_l4 = 45;
  mm_w1 = 50;
  mm_w2 = mm_distance2+20;
  mm_center_1 = 23;
  mm_center_2 = 30;
  motor_shift = 35;
  mount_shift = 25;
  
  mm_h1 = 10;
  mm_h2 = 20;
  
  //Mount plate on motor side
  if(type == 0 || type == 1){
    translate([0, 0, 0]){
      difference(){
        union(){
          //Base plate
          translate([mm_l2/2, 0, 0]){
            roundedRect(size=[mm_l2, mm_w1, mm_wall], radius=5, edges=[0,1,0,1]);
          }
          translate([-mm_l3/2, 0, mm_wall/2]){
            cube(size=[mm_l3, mm_w2, mm_wall], center=true);
          }
          //walls
          translate([-mm_l3/2, (mm_w2-mm_wall)/2, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }
          translate([-mm_l3/2, -(mm_w2-mm_wall)/2, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }
          translate([0, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }
          translate([-mm_l3, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }

          translate([mm_l2/2-4, mm_w1/2, mm_h2/2]){
            rotate([0, 90, 90]){
              roundedRect(size=[mm_h2, mm_l2-5, mm_wall], radius=5, edges=[1,0,0,0]);
            }
          }
          translate([mm_l2/2-4, -mm_wall-mm_w1/2, mm_h2/2]){
            rotate([0, 90, 90]){
              roundedRect(size=[mm_h2, mm_l2-5, mm_wall], radius=5, edges=[1,0,0,0]);
            }
          }
          // Enforecements main gear shaft
          translate([-mount_shift, 0, mm_h2/2]){
            cylinder(d=25, h=mm_h2, center=true);
          }

          translate([-mount_shift, 0, mm_h2/2]){
            cube(size=[mm_wall, mm_w2, mm_h2], center=true);
          }
          translate([-mount_shift, 0, mm_h2/2]){
            cube(size=[mm_l3, mm_wall, mm_h2], center=true);
          }

        }
        
        //Motor center hole
        hull(){
          translate([motor_shift, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
          translate([motor_shift-15, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
        }

       
        //Motor mount plate holes
        translate([-mount_shift, 0, 0]){
          translate([motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_h2/2]){
            cylinder(d=8.2, h=mm_h2*1.1, center=true);
          }
        }


        //Motor mount holes
        translate([motor_shift, 0, 0]){
          for(i=[0:1:1])mirror([0,i,0]){
            hull(){
              translate([motor_m/2, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
              translate([motor_m/2-15, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
            }
            hull(){
              translate([-motor_m/2, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
              translate([-motor_m/2-15, motor_m/2, mm_wall/2]){
                cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
              }
            }
          }

        }
      }
    }
  }
  
  //Mount plate on hopper side
  if(type == 0 || type == 2){
    translate([90, 0, 0]){
        difference(){
          union(){
            roundedRect(size=[mm_l4, mm_w2, mm_wall], radius=5);
            translate([mm_l4/2, 0, mm_h1/2]){
              rotate([0, 90, 0]){
                roundedRect(size=[mm_h1, mm_w2-10, mm_wall], radius=5, edges=[1,0,1,0]);
              }
            }
            translate([-mm_wall-mm_l4/2, 0, mm_h1/2]){
              rotate([0, 90, 0]){
                roundedRect(size=[mm_h1, mm_w2-10, mm_wall], radius=5, edges=[1,0,1,0]);
              }
            }
          }
          //Mounts hopper side
          translate([motor_m/2, mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_wall/2]){
            cylinder(d=mm_center_2, h=mm_wall*1.1, center=true);
          }
          //Mounts top side
          translate([motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([-motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([motor_m/2, -mm_distance2/2, mm_wall/2]){
            cylinder(d=M3_hole, h=mm_wall*1.1, center=true);
          }
          translate([0, 0, mm_wall/2]){
            cylinder(d=mm_center_1, h=mm_wall*1.1, center=true);
          }
      
      }
      
      
    }
  }
  
}

module hopper(mode = 0){
  h_w = 40;
  h_l = 80;
  h_h = 50;
  h_wall = 3;
  h_shift = 10;
  
  //Filler pipe mount
  fp_w = 29.2;
  fp_w2 = fp_w-1;
  fp_d = fp_w+2*h_wall;
  fp_l = 30;
  fp_il = 15;
  fp_h = 32;
  fp_e = 10;
  
  fp_mh1 = 20;
  fp_mh2 = 24;
  fp_m_h = 10;
  fp_m_dis = 20;
  
  //Alu mount screws
  am_dis = 44;
  //Motor mount
  mm_h = 20;
  mm_wall = 24;
  mm_d1 = 30;
  mm_distance = 55;
  
  
//  cone_d1 = 53; 
//  cone_d2 = 8; 
//  cone_h = h_h - alu_edge+0.2;
  
  //Cold end fan dimensions
  fan_d = 40;
  fan_h = 15;
  fan_holes = 32.5;
  fan_shift = 15;
  fan_shift2 = 19;
  
  //Linear bearings
  lb_d = 15.5;
  lb_w = 25;
  lb_dis = 44;
  lb_m_dis = 55;
  lb_shift = 10;
  lb_shift_z = 1.2;
  alu_l = 70;
  
  //Timing belt
  tb_w = 15;
  tb_h = 6;
  tb_dis = 17;
  
  if (mode == 0 || mode ==1) {
  //Granules pipe mount
  translate([(h_l/2+fp_w)*(1-Assembled), -5.5*Assembled, h_wall/2+65.5*Assembled]){
    difference(){
      union(){
        hull(){
          cube(size=[fp_w2, h_wall, h_wall], center=true);
          translate([0, fp_h-h_wall, 0]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_l+fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, 0, fp_il]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
        }
        //Mount point filler tube
        hull(){
          translate([0, fp_h-h_wall, fp_il+2]){
            cube(size=[fp_w2, h_wall, h_wall], center=true);
          }
          translate([0, fp_h-h_wall, fp_il+fp_e+2]){
            cube(size=[fp_w2+2*fp_e, h_wall, h_wall], center=true);
          }
          translate([fp_w/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
          translate([-fp_w2/2, fp_h-h_wall, fp_l+fp_il]){
            rotate([90, 0, 0]){
              cylinder(r=fp_e, h=h_wall, center=true);
            }
          }
        }
        
      }
      translate([0, h_wall, -h_wall]){
        //Cut inner part
        difference(){
          hull(){
            cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            translate([0, fp_h-h_wall, 0]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, fp_h-h_wall, fp_l+fp_il]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
            translate([0, 0, 17]){
              cube(size=[fp_w2-2*h_wall-4, h_wall, h_wall], center=true);
            }
          }
        }
        //Cut filler pipe mount holes
        translate([0, h_wall, fp_il-(fp_m_h/2)]){
          translate([0, (h_h-fp_h-fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
          translate([0, (h_h-fp_h+fp_m_dis)/2-0.5, 0]){
            rotate([0, 90, 0]){
              cylinder(d=M3_hole, h=fp_w*1.5, center=true);
              cylinder(d=M3_nut_e, h=fp_w-2*h_wall+2, center=true, $fn=6);
            }
          }
        }

        translate([0, fp_h, fp_l+fp_il+fp_e/2+h_wall]){
          translate([0, 0, 0]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
          translate([-(fp_w+fp_e)/2, 0, -fp_mh1]){
            rotate([90, 0, 0]){
              cylinder(d=M3_hole, h=h_wall*100.1, center=true);
            }
          }
        }
      }
    }
  }
 } 
 
  if (mode == 0 || mode == 2) {
  difference(){
    union(){
      translate([0, 0, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_h, h_w+lb_w+h_wall], center=true);
      }
      //Filler pipe mount
      translate([0, (h_h-h_wall)/2-fp_h, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[fp_w+h_wall*2, h_wall, fp_m_h], center=true);
      }
      translate([(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      translate([-(fp_w+h_wall)/2, (h_h-fp_h)/2, h_w+lb_w+fp_m_h/2+h_wall]){
        cube(size=[h_wall, fp_h, fp_m_h], center=true);
      }
      
      //Motor mount
      translate([h_l/2-h_wall, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([h_wall-h_l/2, (h_h+mm_h)/2, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_wall*2, mm_h, h_w+lb_w+h_wall], center=true);
      }
      translate([0, (h_h+mm_h)/2, (mm_wall)/2]){
        cube(size=[h_l, mm_h, mm_wall], center=true);
      }
      translate([0, (h_h+h_wall)/2+mm_h, (h_w+lb_w+h_wall)/2]){
        cube(size=[h_l, h_wall,h_w+lb_w+h_wall], center=true);
      }
    }

    //Cut filler pipe mount holes
    translate([0, 0, h_w+lb_w+fp_m_h/2+h_wall]){
      translate([0, (h_h-fp_h-fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
      translate([0, (h_h-fp_h+fp_m_dis)/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=fp_w*1.5, center=true);
        }
      }
    }

    //Cut filler pipe mount
    translate([0, h_h/2-16+0.1, h_w+lb_w-16]){
      intersection(){
        hull(){
          translate([0, 0, 20]){
            cube(size=[fp_w, 32, 40], center=true);
          }
          translate([0, 0, 9-fp_w/2]){
            rotate([90, 0, 0]){
              cylinder(d=fp_w, h=32, center=true);
            }
          }
        }
      }
    }
    
    //Cut filler pipe mount holes
      translate([fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([-fp_mh1, (h_h-h_wall)/2, h_w+lb_w+fp_l-5]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }
      translate([0, (h_h-h_wall)/2, h_w+lb_w+fp_l+fp_mh2]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=h_wall*1.1, center=true);
        }
      }


    //Cut Alu mount holes
    translate([am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    translate([-am_dis/2, h_shift, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole, h=h_h+0.1, center=true);
      }
    }
    translate([-am_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=M4_hole*2.5, h=20, center=true);
      }
    }
    
    //Cut hotend nuts holes
    hm_dis = 20;
    translate([hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([-hm_dis/2, -h_h/2+alu_edge, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        rotate([0, 0, 30]){
          cylinder(d=M4_hole*2.5, h=20, center=true, $fn=6);
        }
      }
    }
    translate([0, -h_h/2+alu_edge, h_w/2+lb_w]){
      cube(size=[hm_dis, 20, M4_hole*2.5], center=true);
    }

    //Cut alu
    translate([(h_l-alu_l)/2+0.1, (alu_edge-h_h)/2, h_w/2+lb_w]){
      cube(size=[alu_l, alu_edge+0.1, alu_edge], center=true);
    }
    //Cut fan tunnel
    translate([(h_l-alu_l)/2+0.1, alu_edge-h_h/2, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        linear_extrude(height=alu_edge+0.1, scale=[1, 2.0]){
          translate([0, 0, 0]){
            square(size=[alu_l+6, alu_edge*1.3], center=true);
          }
        }
      }
    }
    //Cut fan cone
    difference(){
      translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift-fan_shift2, h_w/2+lb_w]){
        rotate([0, 90, 0]){
          linear_extrude(height=fan_h, scale=0.35){
            translate([0, fan_shift2, 0]){
              circle(d=fan_d);
            }
          }
        }
      }
      translate([-am_dis/2, h_shift, h_w/2+lb_w]){
        rotate([90, 0, 0]){
          cylinder(d=M4_hole*3.5, h=h_h+0.1, center=true);
        }
      }
    }
    //Cut fan mount holes
    translate([-h_l/2-0.1, (alu_edge-h_h)/2+fan_shift, h_w/2+lb_w]){
      rotate([0, 90, 0]){
        translate([fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, -fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
        translate([-fan_holes/2, fan_holes/2, 0]){
          cylinder(d=3, h=40, center=true);
        }
      }
    }
    
    //Cut part fan mount holes
    translate([-25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }
    translate([25, -h_h/2+25, h_w+lb_w+h_wall]){
      cylinder(d=3, h=20, center=true);
    }

    //Cut linear bearings
    translate([0, 0, lb_shift_z]){
      translate([0, lb_shift+lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      translate([0, lb_shift-lb_dis/2, lb_w/2]){
        rotate([0, 90, 0]){
          cylinder(d=lb_d, h=h_l+0.1, center=true);
        }
      }
      //Cut linear bearings mount holes
      translate([lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift+lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([-lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      translate([lb_m_dis/2, lb_shift-lb_dis/2, 0]){
        cylinder(d=3, h=15, center=true);
        translate([0, 0, 8]){
          cylinder(d=M3_nut_e, h=15, center=true, $fn=6);
        }
      }
      
      
      //Cut timing belt
      translate([0, lb_shift-tb_dis/2, lb_w/2]){
        cube(size=[h_l+0.1, tb_h, tb_w], center=true);
      }
      //Cut timing belt mounts
      mount_shift = 10;
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([h_l/2-mount_shift/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift);
      }
      translate([h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }

      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=mount_shift, h=tb_w, center=true);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, (lb_w+tb_w)/2]){
        sphere(d=mount_shift);
      }
      translate([mount_shift/2-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cylinder(d=3, h=tb_w*3, center=true);
      }
      translate([-h_l/2, lb_shift+tb_dis/2, lb_w/2]){
        cube(size=[mount_shift, mount_shift, tb_w], center=true);
      }
      
    }
    
    //Cut central hole motor mount
    translate([0, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=mm_d1, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_d1/2-2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    translate([2-mm_d1/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w]){
      rotate([90, 0, 0]){
        cylinder(d=12, h=h_wall*1.1, center=true);
      }
    }
    //Cut motor mount holes
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w-motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([-mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    translate([mm_distance/2, (h_h+h_wall)/2+mm_h, h_w/2+lb_w+motor_m/2]){
      rotate([90, 0, 0]){
        cylinder(d=M3_hole, h=h_wall*1.1, center=true);
      }
    }
    
    
  }
  }
}
