# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

# https://wiki.gentoo.org/wiki/Fish#fish_as_a_default_shell_with_bash_as_the_login_shell
# Use fish in place of bash
# keep this line at the bottom of ~/.bashrc
[ -x /bin/fish ] && SHELL=/bin/fish exec fish
