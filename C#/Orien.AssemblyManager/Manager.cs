using System;
using System.IO;
using System.Security.Policy;
using System.Windows.Forms;

namespace Orien.AssemblyManager {

    public partial class Manager : Form {
        private AppDomain newDomain;
        private Proxy loader;
        private readonly string Domain_Name = "newDomain";
        public Manager() {
            InitializeComponent();
        }

        private void button6_Click(object sender, EventArgs e) {

            AppDomainSetup domaininfo = new AppDomainSetup {
                ApplicationBase = Path.GetDirectoryName(TbxAssemblyPath.Text)
            };

            MessageBox.Show("ApplicationBase:" + domaininfo.ApplicationBase);

            Evidence adevidence = AppDomain.CurrentDomain.Evidence;

            MessageBox.Show("CurrentDomain:" + AppDomain.CurrentDomain.FriendlyName);

            newDomain = AppDomain.CreateDomain(Domain_Name, adevidence, domaininfo);

            MessageBox.Show("NewDomain:" + newDomain.FriendlyName);

            Type type = typeof(Proxy);
            loader = (Proxy)newDomain.CreateInstanceAndUnwrap(
                type.Assembly.FullName,
                type.FullName
            );



            /*AppDomainSetup domaininfo = new AppDomainSetup {
                ApplicationBase = Environment.CurrentDirectory
            };
            Evidence adevidence = AppDomain.CurrentDomain.Evidence;
            newDomain = AppDomain.CreateDomain(Domain_Name, adevidence, domaininfo);

            MessageBox.Show("Created New Domain:" + newDomain.FriendlyName);
            
            Type type = typeof(Proxy);
            string assemblyName = type.Assembly.FullName;
            string assemblyType = type.FullName;

            MessageBox.Show(String.Format("assemblyName:{0} assemblyType:{1}", assemblyName, assemblyType));
            
            System.Runtime.Remoting.ObjectHandle obj = newDomain.CreateInstance(assemblyName, assemblyType);
 
            //As the object we are creating is from another appdomain hence we will get that object in wrapped format and hence in next step we have unwrappped it
            loader = (Proxy)obj.Unwrap();*/


            //Creating a new appdomain


            /*AppDomainSetup setup = AppDomain.CurrentDomain.SetupInformation;
            setup.ApplicationBase = Path.GetFullPath(dllFilePath);
            setup.ShadowCopyFiles = "true";
            PermissionSet permissions = SecurityManager.GetStandardSandbox(AppDomain.CurrentDomain.Evidence);
            newDomain = AppDomain.CreateDomain(Domain_Name, AppDomain.CurrentDomain.Evidence, setup, permissions);

            string assemblyName = typeof(MxAssembly).Assembly.FullName;
            string assemblyType = typeof(MxAssembly).FullName;
            MessageBox.Show(String.Format("assemblyName:{0} assemblyType:{1}", assemblyName, assemblyType));
            loader = (MxAssembly)newDomain.CreateInstanceFromAndUnwrap(assemblyName, assemblyType);
            MessageBox.Show("loader was defined");
            loader.LoadAssembly(TbxAssemblyPath.Text);*/
            //var type = typeof(CompiledTemplate);
            //loader = (LoadMyAssembly)newDomain.CreateInstanceFromAndUnwrap(type.Assembly.FullName, type.FullName);
        }

        private void Old2(object sender, EventArgs e) {

            AppDomainSetup domaininfo = new AppDomainSetup {
                ApplicationBase = Environment.CurrentDirectory
            };
            Evidence adevidence = AppDomain.CurrentDomain.Evidence;
            newDomain = AppDomain.CreateDomain(Domain_Name, adevidence, domaininfo);

            Type type = typeof(Proxy);
            loader = (Proxy)newDomain.CreateInstanceAndUnwrap(
                type.Assembly.FullName,
                type.FullName);

        }


        private void Old1(object sender, EventArgs e) {
            //Creating a new appdomain
            /*AppDomainSetup setup = AppDomain.CurrentDomain.SetupInformation;
            newDomain = AppDomain.CreateDomain("newDomain", AppDomain.CurrentDomain.Evidence, setup); //Create an instance of loader class in new appdomain

            string assemblyName = typeof(MxAssembly).Assembly.FullName;
            string assemblyType = typeof(MxAssembly).FullName;

            MessageBox.Show(String.Format("assemblyName:{0} assemblyType:{1}", assemblyName, assemblyType));
            
            ---------------------------
            assemblyName:Orien.AssemblyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null 
            assemblyType:Orien.AssemblyManager.LoadMyAssembly
            ---------------------------
            */


            //System.Runtime.Remoting.ObjectHandle obj = newDomain.CreateInstance(assemblyName, assemblyType);

            //loader = (MxAssembly)obj.Unwrap();//As the object we are creating is from another appdomain hence we will get that object in wrapped format and hence in next step we have unwrappped it
        }


        public void TestMethod(string str_param) {

            MessageBox.Show("Method Executed with param:" + str_param);
        }

        private void button7_Click(object sender, EventArgs e) {
            //After the method has been executed call unload method of the appdomain.
            AppDomain.Unload(newDomain);
            //Wow you have unloaded the new appdomain and also unloaded the loaded assembly from memory.
        }

        private void button10_Click(object sender, EventArgs e) {

            //Call loadassembly method so that the assembly will be loaded into the new appdomain amd the object will also remain in new appdomain only.
            MessageBox.Show("Does File Exists:" + File.Exists(TbxAssemblyPath.Text));
            //loader.LoadAssembly(TbxAssemblyPath.Text);
            var assembly = loader.LoadAssembly(TbxAssemblyPath.Text);
            MessageBox.Show("Assembly was loaded:" + assembly.FullName);
        }

        private void button8_Click(object sender, EventArgs e) {

            //Call exceuteMethod and pass the name of the method from assembly and the parameters.
            //loader.ExecuteStaticMethod("AssemblyManager", "TestMethod", new object[] { "girish" });
        }

        private void button1_Click(object sender, EventArgs e) {
            SAALoader salo = new SAALoader();
            salo.LoadAssembly(new FileInfo(TbxAssemblyPath.Text));
        }
    }
}
