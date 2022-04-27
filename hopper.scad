include <util.scad>
include <sizes.scad>

Assembled = 0;
hopper(mode=2);

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

