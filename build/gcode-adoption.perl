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


open(FILEIN, '< chain-40mps-08.gcode') || die 'File chain-10mps-08.gcode not found!';
push(@file_content, ";New Gcode file created by script\n");
  while(!eof(FILEIN)){
    $line_read = <FILEIN>;
    $line_read_copy = $line_read;
    $line_read =~ s/\R//g;
    if(index($line_read, ";")>-1){
      $line_read=substr($line_read, 0, index($line_read, ";"));
      $line_read =~ s/ //g;
    }
    push(@file_content, $line_read_copy);
    if(index($line_read, "G92 E0")>-1){
      push(@file_content, "G1 E5.05000 F9000.00000 ; Extra filament forwarding\n");
    }
#    print "line_read=>" . $line_read . "<\n";
    $current_line++;
    $max_line++;
  }
close (FILEIN);

open(FILEOUT, '> new.gcode') || die 'could not create new.gcode!';
  print FILEOUT @file_content;
close (FILEOUT);

