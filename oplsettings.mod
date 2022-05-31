execute
{

thisOplModel.settings.locations=true;
thisOplModel.settings.forceUsage=true;
thisOplModel.settings.displayWidth=100;
thisOplModel.settings.displayPrecision=3;
thisOplModel.settings.displayIndex=true;
thisOplModel.settings.displayComponentName=true;
thisOplModel.settings.displayOnePerLine=true;
thisOplModel.settings.bigMapThreshold=100;
thisOplModel.settings.names=true;
thisOplModel.settings.resolverPath="c:\\temp";
thisOplModel.settings.relaxationLevel=1;
thisOplModel.settings.tmpDir="C:/";
thisOplModel.settings.keepTmpFiles=true;
thisOplModel.settings.run_maxErrors=10;
thisOplModel.settings.run_maxWarnings=8;
thisOplModel.settings.run_processFeasible=true;
thisOplModel.settings.run_displaySolution=false;
thisOplModel.settings.run_displayRelaxations=false;
thisOplModel.settings.run_displayConflicts=false;
thisOplModel.settings.run_displayProfile=false;
thisOplModel.settings.run_engineLog="log.txt";
thisOplModel.settings.run_engineExportExtension=".txt";
thisOplModel.settings.run_exportExternalData=true;
thisOplModel.settings.run_exportInternalData=true;
thisOplModel.settings.cloudMode=true;

writeln("list of settings")
for (var a in thisOplModel.settings) 
{
 writeln(a);
}
writeln();

writeln("thisOplModel.settings.run_maxWarnings = ",thisOplModel.settings.run_maxWarnings);
}

/*

which gives

list of settings
locations
forceUsage
displayWidth
displayPrecision
displayIndex
displayComponentName
displayOnePerLine
names
resolverPath
relaxationLevel
tmpDir
keepTmpFiles
run_maxErrors
run_maxWarnings
run_processFeasible
run_displaySolution
run_displayRelaxations
run_displayConflicts
run_displayProfile
run_engineLog
run_engineExportExtension
run_exportExternalData
run_exportInternalData
cloudMode

thisOplModel.settings.run_maxWarnings = 8

*/
