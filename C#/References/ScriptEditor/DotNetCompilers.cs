using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.CodeDom;
using System.CodeDom.Compiler;
using Microsoft.CSharp;
using Microsoft.VisualBasic;
using System.Reflection;
using System.IO;

namespace ScriptEditor
{
    public class DotNetCompilers
    {
        /// <summary>
        /// Looks for and executes a public static function named Main by searching all types in the assembly.
        /// If more than one Main function is found or no Main function is found an exception is thrown. 
        /// </summary>
        /// <param name="asm"></param>
        /// <param name="args"></param>
        public static void RunMain(Assembly asm, params string[] args)
        {
            MethodInfo main = null;
            foreach (var t in asm.GetTypes())
                foreach (var mi in t.GetMethods(BindingFlags.Public | BindingFlags.Static))
                    if (mi.Name == "Main")
                        if (main != null)
                            throw new Exception("Multiple Main methods found");
                        else
                            main = mi;
            if (main == null)
                throw new Exception("No static public Main method found in assembly");
            main.Invoke(null, new object[] { args });
        }

        /// <summary>
        /// Compiles source code given the language provider (e.g. CSharpCodeProvider or VBCodeProvider). The named assemblies 
        /// are referenced. The contents of each source code file is passed as a separate "input" string. 
        /// Returns the generated assembly if successful or a list of errors if not in the CompilerResults class. 
        /// </summary>
        /// <param name="lang"></param>
        /// <param name="assemblies"></param>
        /// <param name="input"></param>
        /// <returns></returns>
        public static CompilerResults Compile(CodeDomProvider provider, IEnumerable<string> assemblies, params string[] input)
        {
            var param = new System.CodeDom.Compiler.CompilerParameters();
            param.GenerateInMemory = true;
            foreach (var asm in assemblies)
                param.ReferencedAssemblies.Add(asm);
            return provider.CompileAssemblyFromSource(param, input);
        }
    }
}
