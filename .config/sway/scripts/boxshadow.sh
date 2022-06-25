#!/bin/sh
# Take $1 as input, add a box shadow, output to $2

# you can change background color here
background_color=none

convert $1 \
	\( -clone 0 -background black -shadow 40x5+12+16 \) \
	\( -clone 0 -background black -shadow 40x5-4-4 \) \
	\( -clone 0 -background black -shadow 40x12+12-4 \) \
	\( -clone 0 -background black -shadow 40x12-4+16 \) \
	-reverse -background $background_color -layers merge +repage \
	$2	
