#!/bin/sh
# Configuration file
BASEDIR=$(dirname $0)
BAKFILENAME=".SenchaCMD-automatorConfig.conf"
VARBACKUP="$BASEDIR/$BAKFILENAME";

#  HELP FILES
#  -----------------------------------------------------------
function help () {
#   This project needs to be rewritten for updated workflows.
#  -----------------------------------------------------------
	echo "\n##Structure\n --------------------------"
	echo "\nSenchaCMD-automator.sh [Arguments] [Path (if required)]\n"
	echo "\n ##Arguments\n --------------------------\n"
	echo "setpath       :  Sets the path to the Sencha Application that SenchaCMD-automator will use."
	echo " 				 Example - ~/MyFirstSenchaApp/"
	echo "settheme      :  Set the name of the theme package Sencha Update will use. Default is myapp."
	echo "				 Example - MyFirstTheme"
	echo "getpath       :  Get the current Applicaiton path."
	echo "\ngettheme      :  Get the current working Theme for the Application."
	echo "\nfullsassbuild :  Run a complete update of your theme, including package build, Compass source-mapping and then updating the application with ant sass."
	echo "\npackagebuild :  Update your working Theme's package build."
	echo "\nantsass       :  The quick way to compile your application. This is not a full update and will not compile any NEW .scss files or do IE image slicing."
	echo "\nappbuild      :  Create a new build of your Sencha Application. This includes compiling any new .scss files from your Theme and IE image slicing."
	echo "\ncompassbuild  :  Create just a new Compass sourcemap for your working Theme."
	echo "\nfullappbuild  :  This is a complete recompiling of everything in your Application. Including a new Application build, new package build, and Compass source-mapping. This should not have to be done very often."
	echo ""
   }

#  Functions for Commands
#  ----------------------------------------------
# # Initialize and check what the first command is. 
function runcase () {
	. $VARBACKUP
	APP_PATH=$APPPATH
	THEME_NAME=$THEMENAME
	case $arguments in
		"setpath")
			if [ $path ] ; then
				if [ -d "$path.sencha" ]; then
					# Check if Variables have already been set in the Config file.
					if [ $APP_PATH ]; then
						# Replace the current VAR with a new one.
						sed -i.bak 's|'$APP_PATH'|'$path'|g' $VARBACKUP
					   	echo "\nThe Application path has changed from $APP_PATH to $path\n"
					else
						# Create a new VAR if none exist.
					   echo "APPPATH=$path" >> $VARBACKUP
					   echo "\nThe application path has been set to $path\n"
					fi
				else
					echo "\nThis is not a valid Sencha Application. \nA valid Sencha App will have a .sencha directory.\n"
				fi
			else
				echo "\nPlease enter a path to your Sencha application.\n"
			fi	
		;;
		"settheme")
			if [ $path ] ; then
				# Check if Theme has already been set in the Config file.
				if [ $APP_PATH ]; then
					if [ -d "$APP_PATH/packages/$path" ]; then
						if [ $THEME_NAME ]
							then
							# Replace the current VAR with a new one.
							sed -i.bak 's|'$THEME_NAME'|'$path'|g' $VARBACKUP
							echo "\nThe Sencha Theme has changed from $THEME_NAME to $path.\n"
						else
							# Create a new VAR if none exist.
							echo "THEMENAME=$path" >> $VARBACKUP
							echo "\nThe Sencha Theme has been set to $path\n"	
						fi
					else
						echo "\nThat is not a Sencha Theme in your application. \nLook for your theme under $ ~/your-sencha-app-path/packages/\n"
					fi
				else
					echo "\nPlease set your Sencha Application Path first.\n"
				fi
			else
				echo "\nPlease enter the name of your Sencha application theme.\n"
			fi
		;;
		"getpath" )
			# Check if Variables have already been set in the Config file.
			if [ $APP_PATH ]; then
				echo "\n The current Sencha Application Path is $APP_PATH\n"
			else
				# Create a new VAR if none exist.
				echo "\n No Sencha Application Path has been set. \n"
			fi
		;;
		"gettheme" )
			# Check if Variables have already been set in the Config file.
			if [ $THEME_NAME ]; then
				echo "\nThe current Sencha Application Theme is $THEME_NAME\n"
			else
				# Create a new VAR if none exist.
				echo "\nNo Sencha theme has been set.\n"
			fi
		;;
		"appbuild")
			if [ $APP_PATH ] ; then
				cd $APP_PATH
				sencha app build
				echo "\nNew Sencha App build complete.\n"
			else
				echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		"fullsassbuild" )
			if [ $APP_PATH ] ; then
					if [ $THEME_NAME ] ; then
							cd $APP_PATH/packages/$THEME_NAME/
							sencha package build
							cd  build
							sass --compass --sourcemap $THEME_NAME-all-debug.scss:resources/$THEME_NAME-all.css
							cd ../../../
							sencha ant sass
							echo "\nSencha full theme style update complete.\n Includes:\n -sencha package build\n -sencha --compass --sourcemap\n -sencha ant sass\n"
						else
							echo "\nPlease set a Sencha theme name.\n"
					fi
				else
					echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		"packagebuild" )
			if [ $APP_PATH ] ; then
					if [ $THEME_NAME ] ; then
							cd $APP_PATH/packages/$THEME_NAME/
							sencha package build
							echo "\nSencha package $THEME_NAME has been built.\n"
						else
							echo "\nPlease set a Sencha theme name.\n"
					fi
				else
					echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		"antsass")
			if [ $APP_PATH ]
				then
					cd $APP_PATH/
					sencha ant sass
					echo "\nSencha working Theme styles update complete.\n"
				else
					echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		"compassbuild" )
			if [ $APP_PATH ] ; then
					if [ $THEME_NAME ] ; then
							cd $APP_PATH/packages/$THEME_NAME/
							sencha package build
							cd  build
							sass --compass --sourcemap $THEME_NAME-all-debug.scss:resources/$THEME_NAME-all.css
							echo "\nCompass sourcemap for your Sencha application updated.\n"
						else
							echo "\nPlease set a Sencha theme name.\n"
					fi
				else
					echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		"fullappbuild" )
			if [ $APP_PATH ] ; then
				if [ $THEME_NAME ] ; then
					cd $APP_PATH/
					sencha app build
					cd packages/$THEME_NAME/
					sencha package build
					cd  build
					sass --compass --sourcemap $THEME_NAME-all-debug.scss:resources/$THEME_NAME-all.css
					echo "\nYour Sencha application has been fully updated.\n Including app, package and Compass source-mapping.\n"
				else
					echo "\nPlease set the name of your Sencha application theme.\n"
				fi
			else
				echo "\nPlease set a path to your Sencha application.\n"
			fi
		;;
		*)
			help
		;;
	esac
}
if [ $1 ]; then
	arguments=$1
	if [ $2 ]; then
		path=$2
	fi
	if [ -f ./$VARBACKUP ]; then
			runcase 
	else
		touch $VARBACKUP
		runcase
	fi		
else
	help;
fi