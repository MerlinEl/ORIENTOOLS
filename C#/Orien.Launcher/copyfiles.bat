::call "$(SolutionDir)scripts\copyfiles.bat"

::SET CopyFilesOnBuild = False
:: if $(ConfigurationName) == "Debug" goto skip
::if $(CopyFilesOnBuild) == False goto skip
xcopy $(ProjectDir)bin\Debug\Orien.Tools.dll $(SolutionDir)..\..\..\Micra\Micra4\App\Assembly /Y /I
xcopy $(ProjectDir)bin\Debug\Orien.NetUi.dll $(SolutionDir)..\..\..\Micra\Micra4\App\Assembly /Y /I
:: :skip