﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Orien.NetUi {
    class McMaxConsole : McConsole {

        McMaxConsole() {
            /// <summary>
            /// CConsole = new McConsole(progBar);
            /// CConsole.msg "@" --clear log
            /// CConsole.msg "ASSET BUILDER LOG:" ti:"Initialize...." ty:"new_task"
            /// CConsole.msg "Creating Max File" ti:"3DsMax..." ty:"task_open"
            /// CConsole.msg "Paths and Name is OK" ty:"proc"
            /// CConsole.msg "Name OK" ty:"proc"
            /// output_dir = @"E:\Aprog\Orien\Micra\Micra4\_New\AssetBulider"
            /// mcProgLog.msg("Failed Save Max File. Unable to find Directory.\n\tPath:[ "+output_dir+" ]") ti:"Aborted!" ty:"error"
            /// mcProgLog.msg "All Done" ty:"task_close"
            /// </summary>
            /// <param name="msg"></param>
            /// if (msg == "@") { RichTextBox1.Text = ""; } RichTextBox1.AppendText(msg + "\n");
        }
    }
}