using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ScriptEditor
{
    public class ShowEditorAction : UiViewModels.Actions.CuiActionCommandAdapter
    {
        static EditorForm ef;

        public override string ActionText
        {
            get { return "Script editor"; }
        }

        public override string Category
        {
            get { return ".NET Plug-ins"; }
        }

        public override string InternalActionText
        {
            get { return ActionText; }
        }

        public override string InternalCategory
        {
            get { return Category; }
        }

        public override void Execute(object param)
        {
            try
            {
                if (ef == null) ef = new EditorForm();
                ef.Show();
            }
            catch (Exception e)
            {
                Utilities.WriteLine("Error occured " + e.Message);
            }
        }
    }
}
