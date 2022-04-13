echo Building all stls, this will take 20-25 minutes;
echo Generating motor-mount-top
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=1 -o build/motor-mount-top.stl
echo Generating motor-mount-bottom
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=2 -o build/motor-mount-bottom.stl
echo Generating motor-gear
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=3 -o build/motor-gear.stl
echo Generating main-gear
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=4 -o build/main-gear.stl
echo Generating geanules-pipe
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=6 -o build/granules-pipe.stl
echo Generating hopper, this will take 15-20 minutes
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD Extruder.scad -D Assembled=0 -D Part=5 -o build/hopper.stl
