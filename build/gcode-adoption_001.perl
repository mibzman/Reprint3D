#!/usr/bin/perl -w
#Homepage: www.HomoFaciens.de
#Author Norbert Heinz


use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use Getopt::Long;
use File::Basename;
use LWP::Simple;
use Time::HiRes qw(usleep nanosleep);

$|=1 ;

my $i;
my $line_read;
my $line_read_copy;
my $extrusion = 0;
my $extrusion_old = 0;
my @file_content;
my $extrude_retract = 0;
my $retract_l_moving = 4;
my $retract_l_total = 4;
my $extra_length = 1.5;
my $forward_total = $retract_l_total + $extra_length;
my $retract_factor = 1;
my $retract_line_start = 0;
my $current_line = 0;
my $reverse_line = 0;
my $max_line = 0;
my $X = 0;
my $Y = 0;
my $Z = 0;
my $X_1 = 0;
my $Y_1 = 0;
my $Z_1 = 0;

my $extrusion_1 = 0;
my $feedrate = 0;
my $feedrate_old = 0;
my $extrusion_exist = 0;
my $feedrate_exist = 0;


open(FILEIN, '< chain-10mps-10.gcode') || die 'File chain-10mps-10.gcode not found!';
push(@file_content, ";New Gcode file created by script");
  while(!eof(FILEIN)){
    $line_read = <FILEIN>;
    $line_read_copy = $line_read;
    $line_read =~ s/\R//g;
    if(index($line_read, ";")>-1){
      $line_read=substr($line_read, 0, index($line_read, ";"));
      $line_read =~ s/ //g;
    }
    if(index($line_read, "E")>-1){
      print "line_read=>" . $line_read . "<\n";
      &GetExtrusion($line_read);
      if($extrusion < $extrusion_old && $extrusion > 0 && $current_line > 10){
        print "Retract detected!\n";
        $reverse_line = $max_line;
        $extrude_retract = 0;
        print "extrusion_old = " . $extrusion_old . ", ";
        while($extrude_retract < $retract_l_moving && $extrusion != $forward_total && $reverse_line > 1){
          $reverse_line--;
          $extrusion = $extrusion_old;
          &GetExtrusion($file_content[$reverse_line]);
          $extrude_retract = $extrusion_old - $extrusion;
        }
        if($extrusion * 1.0 == 4.50000){
          print "Extrusion=$extrusion total detected!!!\n";
          #exit(0);
        }
        &GetExtrusion($file_content[$reverse_line+1]);
        $extrusion_1 = $extrusion;
        &GetX($file_content[$reverse_line+1]);
        $X_1 = $X;
        &GetY($file_content[$reverse_line+1]);
        $Y_1 = $Y;
        &GetX($file_content[$reverse_line]);
        &GetY($file_content[$reverse_line]);
        &GetExtrusion($file_content[$reverse_line]);
        my $extrusion_plus = $extrusion_old - $extrusion - $retract_l_moving;
        my $X_diff = $X-$X_1;
        my $Y_diff = $Y-$Y_1;
        my $move_length = sqrt(($X_diff)*($X_diff)+($Y_diff)*($Y_diff));
        my $extract_length = $extrusion-$extrusion_1;
        my $X_new = 0;
        if($extract_length - $extrusion_plus != 0){
          $X_new = $X - $X_diff * $extract_length / ($extract_length - $extrusion_plus);
         }
        my $Y_new = 0;
        if($extract_length - $extrusion_plus != 0){
          $Y_new = $Y - $Y_diff * $extract_length / ($extract_length - $extrusion_plus);
        }
        my $extrusion_new = ($extrusion-$extrusion_plus);
        print "extrusion = " . $extrusion . "\n\n\n";
        $file_content[$reverse_line]=substr($file_content[$reverse_line], 0, length($file_content[$reverse_line])-1) . " ; Retract from extrusion_old=$extrusion_old, extrusionPlus=$extrusion_plus\n";
        #Insert coordinates of retract start
        &GetFeedrate($file_content[$reverse_line+1]);
        if($feedrate_exist == 1){
          splice @file_content, $reverse_line+1, 0, 'G1 X' . sprintf("%0.3f", $X_new) . ' Y' . sprintf("%0.3f", $Y_new) . " E"  . sprintf("%0.5f", $extrusion+$extrusion_plus) . " F"  . sprintf("%0.3f", $feedrate) . " ; Inserted line, $X, $X_1, $X_diff, $Y_diff\n";
        }
        else{
          splice @file_content, $reverse_line+1, 0, 'G1 X' . sprintf("%0.3f", $X_new) . ' Y' . sprintf("%0.3f", $Y_new) . " E"  . sprintf("%0.5f", $extrusion+$extrusion_plus) . " ; Inserted line, $X, $X_1, $X_diff, $Y_diff\n";
        }
        $max_line++;
        $reverse_line += 2;
        #Now turn extrusion into reverse
        &GetExtrusion($file_content[$reverse_line-1]);
        $extrusion_old  = $extrusion;
        $extrusion_1 = $extrusion;
        while($reverse_line < $max_line + 1){
          $extrusion_old  = $extrusion;
          &GetExtrusion($file_content[$reverse_line]);
          &GetX($file_content[$reverse_line]);
          &GetY($file_content[$reverse_line]);
          $Z=-1;
          &GetZ($file_content[$reverse_line]);
          $extrusion_1 = $extrusion_1 - ($extrusion-$extrusion_old);
          &GetFeedrate($file_content[$reverse_line]);
          if(index($file_content[$reverse_line], "M") != 0){
            if($feedrate_exist == 1){
              if($Z != -1){
                $file_content[$reverse_line] = 'G1 X' . sprintf("%0.3f", $X) . ' Y' . sprintf("%0.3f", $Y) . ' Z' . sprintf("%0.3f", $Z) . " E"  . sprintf("%0.5f", $extrusion_1) . " F"  . sprintf("%0.3f", $feedrate) . " ; Reverse Extrusion\n";
              }
              else{
                $file_content[$reverse_line] = 'G1 X' . sprintf("%0.3f", $X) . ' Y' . sprintf("%0.3f", $Y) . " E"  . sprintf("%0.5f", $extrusion_1) . " F"  . sprintf("%0.3f", $feedrate) . " ; Reverse Extrusion\n";
              }
            }
            else{
              if($Z != -1){
                $file_content[$reverse_line] = 'G1 X' . sprintf("%0.3f", $X) . ' Y' . sprintf("%0.3f", $Y) . ' Z' . sprintf("%0.3f", $Z) . " E"  . sprintf("%0.5f", $extrusion_1) . " ; Reverse Extrusion\n";
              }
              else{
                $file_content[$reverse_line] = 'G1 X' . sprintf("%0.3f", $X) . ' Y' . sprintf("%0.3f", $Y) . " E"  . sprintf("%0.5f", $extrusion_1) . " ; Reverse Extrusion\n";
              }
            }
          }
          #$file_content[$reverse_line]=substr($file_content[$reverse_line], 0, length($file_content[$reverse_line])-1) . "; Add retract E" . sprintf("%0.5f", $extrusion_1 - ($extrusion-$extrusion_old)) . ", extrusion_1=$extrusion_1, extrusion_old=$extrusion_old\n";
          $reverse_line++;
        }

        push(@file_content, "G1 E"  . sprintf("%0.5f", $extrusion_1-($retract_l_total-$retract_l_moving)) . " F9000.00000 ; Remaining retract\n");
      }
      else{
        push(@file_content, $line_read_copy);
      }
      $extrusion_old = $extrusion;
    }
    else{
      push(@file_content, $line_read_copy);
    }
#    print "line_read=>" . $line_read . "<\n";
    $current_line++;
    $max_line++;
  }
close (FILEIN);

open(FILEOUT, '> new.gcode') || die 'could not create new.gcode!';
  print FILEOUT @file_content;
close (FILEOUT);

sub GetExtrusion(){
  my $line_temp = $_[0];
  $line_temp =~ s/\R//g;
  if(index($line_temp, ";")>-1){
    $line_temp = substr($line_temp, 0, index($line_temp, ";"));
    $line_temp =~ s/ //g;
  }
  if(index($line_temp, "E")>-1){
    $line_temp = substr($line_temp, index($line_temp, "E")+1, length($line_temp)-index($line_temp, "E"));
    $line_temp = $line_temp ." ";
    $extrusion = substr($line_temp, 0, index($line_temp, " "));
    print "extrusion=>" . $extrusion . "<\n";
    $extrusion_exist = 1;
  }
  else{
    $extrusion_exist = 0;
  }
}

sub GetX(){
  my $line_temp = $_[0];
  $line_temp =~ s/\R//g;
  if(index($line_temp, ";")>-1){
    $line_temp = substr($line_temp, 0, index($line_temp, ";"));
    $line_temp =~ s/ //g;
  }
  if(index($line_temp, "X")>-1){
    $line_temp = substr($line_temp, index($line_temp, "X")+1, length($line_temp)-index($line_temp, "X"));
    $line_temp = $line_temp ." ";
    $X = substr($line_temp, 0, index($line_temp, " "));
    print "currentX=>" . $X . "<\n";
  }
}

sub GetY(){
  my $line_temp = $_[0];
  $line_temp =~ s/\R//g;
  if(index($line_temp, ";")>-1){
    $line_temp = substr($line_temp, 0, index($line_temp, ";"));
    $line_temp =~ s/ //g;
  }
  if(index($line_temp, "Y")>-1){
    $line_temp = substr($line_temp, index($line_temp, "Y")+1, length($line_temp)-index($line_temp, "Y"));
    $line_temp = $line_temp ." ";
    $Y = substr($line_temp, 0, index($line_temp, " "));
    print "currentY=>" . $Y . "<\n";
  }
}

sub GetZ(){
  my $line_temp = $_[0];
  $line_temp =~ s/\R//g;
  if(index($line_temp, ";")>-1){
    $line_temp = substr($line_temp, 0, index($line_temp, ";"));
    $line_temp =~ s/ //g;
  }
  if(index($line_temp, "Z")>-1){
    $line_temp = substr($line_temp, index($line_temp, "Z")+1, length($line_temp)-index($line_temp, "Z"));
    $line_temp = $line_temp ." ";
    $Z = substr($line_temp, 0, index($line_temp, " "));
    print "currentZ=>" . $Z . "<\n";
  }
}

sub GetFeedrate(){
  my $line_temp = $_[0];
  $line_temp =~ s/\R//g;
  if(index($line_temp, ";")>-1){
    $line_temp = substr($line_temp, 0, index($line_temp, ";"));
    $line_temp =~ s/ //g;
  }
  if(index($line_temp, "F")>-1){
    $line_temp = substr($line_temp, index($line_temp, "F")+1, length($line_temp)-index($line_temp, "F"));
    $line_temp = $line_temp ." ";
    $feedrate_old = $feedrate;
    $feedrate = substr($line_temp, 0, index($line_temp, " "));
    print "currentFeedrate=>" . $feedrate . "<\n";
    $feedrate_exist = 1;
  }
  else{
    $feedrate_exist = 0;
  }
}
