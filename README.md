SenchaCMD-automator
===================

A small shell script to automate some of my common Sencha terminal commands.

##Requirements
0. Basic knowledge of CLI
1. [Sencha CMD tool](http://www.sencha.com/products/sencha-cmd/download)
2. A [Sencha application](http://docs.sencha.com/extjs/4.2.1/) to work with

##Structure

SenchaCMD-automator.sh Arguments Path(if required)

##Arguments

setpath       :  Sets the path to the Sencha Application that SenchaCMD-automator will use.
				 Example - ~/MyFirstSenchaApp/

settheme      :  Set the name of the theme package Sencha Update will use. Default is myapp.
				 Example - MyFirstTheme

getpath       :  Get the current Applicaiton path.

gettheme      :  Get the current working Theme for the Application.

fullsassbuild :  Run a complete update of your theme, including package build, Compass source-mapping and then updating the application with ant sass.

packagebuild  :  Update your working Theme's package build.

antsass       :  The quick way to compile your application. This is not a full update and will not compile any NEW .scss files or do IE image slicing.

appbuild      :  Create a new build of your Sencha Application. This includes compiling any new .scss files from your Theme and IE image slicing.

compassbuild  :  Create just a new Compass sourcemap for your working Theme.

fullappbuild  :  This is a complete recompiling of everything in your Application. Including a new Application build, new package build, and Compass source-mapping. This should not have to be done very often.
   

 ##Notes
 This script will automatically create a hidden config file within it's same directory. Which will store your Path and Theme so you only have to set them up once.

 It is recommended that you create an Alias for this file so that it may be run more efficiently.
  - Example: alias senchaupdate="~/path-to-file/SenchaCMD-automator.sh