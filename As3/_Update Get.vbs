Dim source_dir, target_dir, fso
Const DeleteReadOnly = TRUE
Const OverwriteExisting = TRUE

set fso = CreateObject("Scripting.FileSystemObject")
target_dir = fso.GetAbsolutePathName("src\orien\tools\")
source_dir = fso.GetFolder("..\@CLASSES\orien\tools\")

'WScript.Echo "source_dir:" & source_dir & vbCrLf & "target_dir:" & target_dir
'WScript.Echo (source_dir & "\*.*") 

'remove all old scripts from src
fso.DeleteFile( target_dir & "\*.*"), DeleteReadOnly

'copy new scripts from @CLASSES\orien\tools\
fso.CopyFile (source_dir & "\*.*") , target_dir , OverwriteExisting
'done pop up
WScript.Echo "Update was Successful!"
