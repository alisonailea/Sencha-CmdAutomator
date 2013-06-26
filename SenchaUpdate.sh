#!/bin/sh
comd_set="${1-empty}"
if [ "$comd_set" = "-h" -o "$comd_set" = "--help" -o "$comd_set" = "empty" ] ; then
    echo "\nStructure : $ ./SenchaUpdate.sh [arguments] [paths]\n"
    echo "ARGUMENTS"
 	echo "sass_fullbuild : requires [path to the APP] and the [THEME NAME]
 	jumps to sencha theme defined by the theme name and runs complete sass
 	update with compass sourcemapping
 	EXAMPLE: $ ./SenchaUpdate.sh sass_fullbuild ~/path-to-app/ theme-name\n"
 	echo "sass_build : requires [path to the APP]
 	jumps to sencha app and builds a new sass connection with 
 	sencha ant sass
 	EXAMPLE: $ ./SenchaUpdate.sh sass_build ~/path-to-app/\n"
 	echo "app_build : requires [path to the APP]
 	jumps to sencha app and builds a new build of the app
 	EXAMPLE: $ ./SenchaUpdate.sh app_build ~/path-to-app/"
 	echo "\n"
elif [ "$comd_set" = "sass_fullbuild" ] ; then
    sencha_app_path="${2}"
    theme_name="${3}"
    cd $sencha_app_path/packages/$theme_name/
 	sencha package build
	cd  build
	sass --compass --sourcemap item-viewer-all-debug.scss:resources/item-viewer-all.css
	cd ../../../
	sencha ant sass
	echo "Full Sencha Theme and App SASS update complete"
elif [ "$comd_set" = "sass_build" ] ; then
	sencha_app_path="${2}"
	cd $sencha_app_path/
	sencha ant sass
	echo "Sencha App SASS updated"
elif [ "$comd_set" = "app_build" ] ; then
	sencha_app_path="${2}"
	cd $sencha_app_path/
	sencha app build
	echo "New "
else
    echo "There has been an error. Please enter a command."
fi
