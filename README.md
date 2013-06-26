Sencha-CmdAutomator
===================

A small shell script to automate some of my common Sencha terminal commands.

Structure : $ ./SenchaUpdate.sh [arguments] [paths]

ARGUMENTS
--------------------
sass_fullbuild : requires [path to the APP] and the [THEME NAME]
 	jumps to sencha theme defined by the theme name and runs complete sass update with compass sourcemapping
 	EXAMPLE: $ ./SenchaUpdate.sh sass_fullbuild ~/path-to-app/ theme-name
 
 sass_build : requires [path to the APP]
 	jumps to sencha app and builds a new sass connection with sencha ant sass
 	EXAMPLE: $ ./SenchaUpdate.sh sass_build ~/path-to-app/

app_build : requires [path to the APP]
 	jumps to sencha app and builds a new build of the app
 	EXAMPLE: $ ./SenchaUpdate.sh app_build ~/path-to-app/
