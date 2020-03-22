Dim swf_file, target_dir, fso
Const OverwriteExisting = TRUE

set fso = CreateObject("Scripting.FileSystemObject")
swf_file = fso.GetAbsolutePathName("bin\OrienTools.swf")
target_dir = fso.GetFolder("..\@CLASSES\libs\")

'WScript.Echo "copy file:" & swf_file & " to:" & target_dir & "\"

'send new swf
fso.CopyFile swf_file , target_dir & "\" , OverwriteExisting
'done pop up
WScript.Echo "Update was Successful!"
