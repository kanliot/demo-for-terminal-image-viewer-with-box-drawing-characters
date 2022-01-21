# demo-for-terminal-image-viewer-with-box-drawing-characters
just fooling around in perl, so i wrote an image viewer requiring cpan's Image::Magick

If you look at https://en.wikipedia.org/wiki/Box-drawing_character#Block_Elements

you can see that the terminal has 15 or so characters, that can be used to emulate pixels in a terminal output.   So the main work of this program, is getting a function to print out 4x4 black and white pixels as black and white terminal characters.  This is achieved by an array of length 16, containing all the characters, but the index of the array is that character by the bitfield.   Once that was done, I added some new features. 

It is not useful in any way, but I wrote it. 

The program should work fine with a single argument if xtty and CPAN's Image:Magick is installed.
Since ImageMagick is the back end, the image file does not matter, but it's pretty slow since it calls GetPixel for each pixel in the image. 

#### question from reddit forums:
> Can we see some examples? Maybe add them to the README.md on Github?

#### *Answer*
> I will do this. What do you need?

> The perl program on my github isn't finished or polished. It is, I think very helpful for anyone wanting to draw with unicode block drawing characters. I wish I could say it's a code sample for CPAN's Image::Magick, but I'm learning perl, so no.

