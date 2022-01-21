#! /usr/bin/perl -w
use strict;
use 5.010;
use open ":std",":utf8"; 

#uh really you want ovals, since every character in the terminal is about 51% as wide as it is high
# but you really want the x canvas to be twice as wide. 

# put the characters in an array.. only 16 combinations of a 2x2 monocolor grid

#block elements 
# lsb bits 
# 3210
# orientation
# 01
# 23 
# above 5 lines is key to bit value 
my @block;
$#block=16; 
$block[0]=' ';

$block[4]= chr 9622;
$block[8]= chr 9623;
$block[1]= chr 9624;
$block[13]=chr 9625;
$block[9]= chr 9626;
$block[7]= chr 9627;
$block[11]=chr 9628;
$block[2] =chr 9629; #9D
$block[6]= chr 9630;
$block[14]=chr 9631;

$block[15]="\x{2588}";# full block
$block[12]="\x{2584}";# lower half
$block[3] ="\x{2580}";# upper half
$block[10]="\x{2590}";# right half
$block[5] ="\x{258c}";# left  half

# draw circle 
our ($canvas_w, $canvas_h);
our @canvas;
my @dcanvas;
# halve grid 
# new grid will be a 2 dimensional array of 2-bit values
#does it matter if it does vert first? 
sub make_canvas { 
	for (my $x =0;$x<$canvas_w*2;$x+=2){
		no warnings 'uninitialized';
		for (my $y=0;$y<$canvas_h*2;$y+=2){
			my $bits; 
			$bits += 1 if $dcanvas[$x][$y] !=0; 
			$bits += 2 if $dcanvas[$x+1][$y] !=0;  
			$bits += 4 if $dcanvas[$x][$y+1] !=0; 
			$bits += 8 if $dcanvas[$x+1][$y+1] !=0; 
			$canvas[$x/2][$y/2] = $bits;
		}
	}
}

# now print out the picture
# jesus what a nasty bug.  it was a bug in the display, but i was sure it was a bug in the binary rejigger. 

sub duh { 
	my ($ysize, $xsize)= split( ' ', `stty size`) ;
	$xsize = $xsize < $canvas_w ? $xsize:$canvas_w;
	$ysize = $ysize < $canvas_h ? $ysize:$canvas_h;
	for (my $y =0;$y<$ysize;$y+=1){
		for (my $x=0;$x<$xsize;$x+=1){
			my $bits = " ";
			$bits = $block[ $canvas[$x][$y] ] if defined $canvas[$x][$y]; 
			print $bits;
		}
		say ""; 
	}
}

#huh convert... 

use Image::Magick;
my $imgfile;
$imgfile = shift;

my $image = Image::Magick->new();
my $wh = $image->Read($imgfile); 
warn $wh if $wh; 
my $dw = $image->Get('width');
my $dh =  $image->Get('height');


# reset canvas to half height and width
$canvas_w = int(  ($dw +1 ) /2); 
$canvas_h = int(  ($dh +1 ) /2);

$image->set('monochrome'=>'True');
for (my $x =0;$x<$dw;$x++){
	for (my $y=0;$y<$dh;$y++){
		my @pixels = $image->GetPixel("x"=>$x,"y",$y); 
		$dcanvas[$x][$y]=1 if $pixels[1];
	}
}
make_canvas();
duh();
#say "$dw x $dh; $canvas_w x $canvas_h";

