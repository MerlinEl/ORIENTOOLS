package orien.tools {
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class mcSelfMail extends Sprite{
		
		private var stream:FileStream = new FileStream();
		private var _completeEvent:Event;
		private var _smtp:String;
		public var response:String = "";
		
		public function mcSelfMail() {
			
			_completeEvent = new Event(Event.COMPLETE, false, true);
		}
		
		public function send(mail:String, subject:String, msg:String, pass:String, smtp:String = "smtp.gmail.com"):void {
			
			_smtp = smtp;
			//var file:File = File.documentsDirectory.resolvePath("demo.vbs");
			//C:/Users/user/AppData/Roaming/airTest-email/Local Store
			var file:File = File.applicationStorageDirectory.resolvePath("demo.vbs");
			//file.parent.openWithDefaultApplication(); //open file directory
			
			stream.openAsync(file, FileMode.WRITE);
			var vbs:String = buildEmailVBS(mail, subject, msg, pass);
			ftrace("vbs:\n%", vbs)
			//stream.writeUTFBytes(vbs);
			//http://help.adobe.com/cs_CZ/FlashPlatform/reference/actionscript/3/charset-codes.html
			stream.writeMultiByte(vbs, "Windows-1250"); //Středoevropské (ISO) iso-8859-2		Středoevropské (Windows) windows-1250
			stream.close();
			
			var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			processInfo.workingDirectory = file.parent;
			processInfo.executable = getCmdEXE();
			
			var args:Vector.<String> = new Vector.<String>();
			args.push("/c");
			args.push(file.name);
			
			processInfo.arguments = args;
			
			var process:NativeProcess = new NativeProcess();
			process.addEventListener(NativeProcessExitEvent.EXIT, onCloseApp);
			try {
				
				process.start(processInfo);
				
			} catch (error:Error) {
				//give up - open the folder
				//file.parent.openWithDefaultApplication();
				response += "Error:" + error.message + "\n";
			}
		}
		
		private function onCloseApp(e:NativeProcessExitEvent):void {
			
			response += "onClose:Finished.\n";
			dispatchEvent(_completeEvent);
		}
		
		private function buildEmailVBS(mail:String, subject:String, msg:String, pass:String):String {
			
			var vbs:String = 'Dim objShell, objFSO, userName, emailTitle, emailBody\n';
			vbs += 'Set objShell = CreateObject( "WScript.Shell" )\n';
			vbs += 'Set objFSO   = CreateObject("Scripting.FileSystemObject")\n';
			vbs += 'Const fromEmail	= "' + mail + '"\n';
			vbs += 'Const toEmail   = "' + mail + '"\n';
			vbs += 'Const pass  = "' + pass + '"\n';
			vbs += 'userName   = objShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )\n';
			vbs += 'emailTitle = "' + subject + ' - " & userName\n';
			vbs += 'emailBody  = "' + msg + '"\n';
			vbs += 'sendGmail fromEmail, toEmail, emailTitle, emailBody, pass\n';
			vbs += 'Function sendGmail (strFrom, strTo, strTitle, strMsg, password)\n';
			vbs += 'Dim emailConfig, emailObj\n';
			vbs += 'Set emailObj      = CreateObject("CDO.Message")\n';
			vbs += 'emailObj.From     = strFrom\n';
			vbs += 'emailObj.To       = strTo\n';
			vbs += 'emailObj.Subject  = strTitle\n';
			//replace chars "|" with "new line" (it was compast to prevent crash)
			vbs += 'emailObj.TextBody = Replace(strMsg, "|", vbCrLf)\n';
			vbs += 'Set emailConfig = emailObj.Configuration\n';
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver")       = "'+_smtp+'"\n';
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")   = 25\n'; //465
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing")        = 2\n';
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1\n';
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl")       = false\n'; //true
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername")     = fromEmail\n';
			vbs += 'emailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword")     = password\n';
			vbs += 'emailConfig.Fields.Update\n';
			vbs += 'emailObj.Send\n';
			//vbs += 'If err.number = 0 then Msgbox "Zpráva zahrnující registrační údaje IUč byla odeslána našemu technikovi. Prosím vyčkejte na její zpracování, brzy se vám ozveme." & vbCrLf & "Nová škola – DUHA s.r.o.", 0, "Licence Inspektor:"\n';
			vbs += 'strScript = Wscript.ScriptFullName\n'
			vbs += 'objFSO.DeleteFile(strScript)\n'
			vbs += 'end function\n';
			return vbs;
		}
		
		public static function getCmdEXE():File {
			
			var system32_dir:String = getSystem32Directory();
			if (system32_dir == "false") return new File();
			return File.desktopDirectory.resolvePath(system32_dir + "\\cmd.exe");
		}
		
		public static function getSystem32Directory():String {
			
			var hd:Array = File.getRootDirectories();
			for each (var d:File in hd) {
				
				var path:String = d.nativePath + "Windows\\System32";
				if (File.desktopDirectory.resolvePath(path).exists) return path;
			}
			return "false"
		}
	}
}


/*
var sm:mcSelfMail = new mcSelfMail();
sm.addEventListener(Event.COMPLETE, onComplete);
var sub:String = "IUč Manažer";
var msg:String = user_text + "\nZasláno:" + mcDate.czDate() + "\n" + user_email;
msg = msg.replace(/[\r\n]+/g, "|");  //compact message to prevent crash
sm.send(iuGlobal.send_email, sub, msg, "1234", "smtp.gmail.com");
function onComplete(e:Event):void {
	sm.removeEventListener(Event.COMPLETE, onComplete);
}
*/