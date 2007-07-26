#!/bin/bash -x

# Defines functions to handle colors.
# André dos ANJOS <Andre.dos.Anjos@cern.ch>

# Prints an usage message with the colors and the program name
# Takes two arguments, the program name and the wrong spelled
# color. This function is only used internally.
function print_ansi_usage () {
    echo "usage: $1 <color> <string>";
    if [ $# = 2 ]; then #gave the wrong color
	echo " ->> "`mkcolour yellow $2`" is not a valid color.";
    fi
    return;
}

# Prints a list of valid colours. Only used internally.
function print_colors () {
    echo "Valid colors are:";
    mkcolour lightgray \"black\"; echo -n " ";
    mkcolour red red; echo -n " ";
    mkcolour green green; echo -n " ";
    mkcolour brown brown ; echo -n " ";
    mkcolour blue blue; echo -n " ";
    mkcolour purple purple; echo -n " ";
    mkcolour cyan cyan; echo -n " ";
    mkcolour lightgray lightgray; echo;
    mkcolour darkgray darkgray; echo -n " ";
    mkcolour lightred lightred; echo -n " ";
    mkcolour lightgreen lightgreen; echo -n " ";
    mkcolour yellow yellow; echo -n " ";
    mkcolour lightblue lightblue; echo -n " ";
    mkcolour lightpurple lightpurple; echo -n " ";
    mkcolour lightcyan lightcyan; echo -n " ";
    mkcolour white white; echo;
    return;
}

# Get colour code, by giving the colour name. Takes a single argument,
# the color name. If it doesn't exist, echoes 0.
function ansi_colour_code () {
    local clesc="";
    case $1 in
	black)       clesc="0;30m";;
	red)         clesc="0;31m";;
	green)       clesc="0;32m";;
	brown)       clesc="0;33m";;
	blue)        clesc="0;34m";;
	purple)      clesc="0;35m";;
	cyan)        clesc="0;36m";;
	lightgray)   clesc="0;37m";;
	darkgray)    clesc="1;30m";;
	lightred)    clesc="1;31m";;
	lightgreen)  clesc="1;32m";;
	yellow)      clesc="1;33m";;
	lightblue)   clesc="1;34m";;
	lightpurple) clesc="1;35m";;
	lightcyan)   clesc="1;36m";;
	white)       clesc="1;37m";;
	*) clesc=0;;
    esac
    echo -n $clesc;
    return;
}

# This one gets one color parameter and the text to highlight.  It
# returns you the highlighted string, by concatenating the color you
# have chosen and the text:
# <color-escape>your-text<back-to-previous-escape> 
function colourise () {
    local nargs=$(( $# < 2 ));
    if [ $nargs = 1 ]; then
	print_ansi_usage "colourise"
	return;
    fi

    local clesc=`ansi_colour_code $1`;
    if [ $clesc != 0 ]; then
	shift;
	echo -en "\[\033[$clesc\]$*\[\033[0m\]";
    else
	print_ansi_usage $FUNCNAME $1;
	print_colors
    fi
    return;
}

# Prepares the string to be output by echo and not by the system
function mkcolour () {
    local nargs=$(( $# < 2 ));
    if [ $nargs = 1 ]; then
	print_ansi_usage "mkcolour"
	return;
    fi

    local clesc=`ansi_colour_code $1`;
    if [ $clesc != 0 ]; then
	shift;
	echo -en "\033[$clesc$*\033[0m";
    else
	print_ansi_usage $FUNCNAME $1;
	print_colors
    fi
    return;
}

