SET OTSourceDir="%~dp0.\bin\Debug\"
SET OTTargetDir="%~dp0..\..\..\Micra\Micra4\App\Orien_Tools\"

xcopy /s /y "%OTSourceDir%Orien.Tools.dll" "%OTTargetDir%"
xcopy /s /y "%OTSourceDir%Orien.NetUi.dll" "%OTTargetDir%"
