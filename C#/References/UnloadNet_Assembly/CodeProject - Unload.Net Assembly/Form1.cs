using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using MySpace;
namespace MyApp
{
    public partial class Form1 : Form
    {
		Proxy DefaultProxy;
        
		public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //loads lower version of the assembly during the startup
            //Creates a new Assembly Proxy
            DefaultProxy = new Proxy("Assembly v1.0.dll", "Domain1");
            lblCurrentAppDomain.Text = DefaultProxy.DefaultAppDomain;
            lblCurrentAssembly.Text = DefaultProxy.DefaultAssemblyFileName;
            lblMainAppDomian.Text = AppDomain.CurrentDomain.FriendlyName;
        }
        //loads the initial version of assembly
        private void LoadAssemblyVersion1(object sender, EventArgs e)
        {
			//Creates a new Assembly Proxy. Here GC is clearing the old Appdomin automaticaly
			DefaultProxy = new Proxy("Assembly v1.0.dll", "Domain1");
            lblCurrentAppDomain.Text = DefaultProxy.DefaultAppDomain;
            lblCurrentAssembly.Text = DefaultProxy.DefaultAssemblyFileName;
            lblMainAppDomian.Text = AppDomain.CurrentDomain.FriendlyName;
            

            //Extras
            errorProvider1.BlinkStyle = ErrorBlinkStyle.AlwaysBlink;
            errorProvider1.SetError(radioAssembly2, "");
            errorProvider1.SetError(radioAssembly1,"This Dll is a Beta Version. It won't reverse the string properly");
        }

        //loads the second version of assembly
        private void LoadAssemblyVersion2(object sender, EventArgs e)
        {
			//Creates a new Assembly Proxy. Here GC is clearing the old Appdomin automaticaly
			DefaultProxy = new Proxy("Assembly v2.0.dll", "Domain2");
            lblCurrentAppDomain.Text = DefaultProxy.DefaultAppDomain;
            lblCurrentAssembly.Text = DefaultProxy.DefaultAssemblyFileName;
            lblMainAppDomian.Text = AppDomain.CurrentDomain.FriendlyName;

            //Extras.
            errorProvider1.BlinkStyle = ErrorBlinkStyle.AlwaysBlink;
            errorProvider1.SetError(radioAssembly1, "");
            errorProvider1.SetError(radioAssembly2,"This Dll is the Final Version");
        }
        
        //performs the reverse string with loded assembly
        private void btnCalculate_Click(object sender, EventArgs e)
        {
            txtReverseData.Text =  DefaultProxy.ReverseValue(txtReverseData.Text);
        }
        
        //returns the data from currently loaded assembly
        private void btnGetValue_Click(object sender, EventArgs e)
        {
            txtReturnedData.Text = DefaultProxy.ReturnBaseValue();
        }
    }
}