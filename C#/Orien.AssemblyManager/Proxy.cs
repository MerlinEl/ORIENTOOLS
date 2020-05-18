using System;
using System.Reflection;

namespace Orien.AssemblyManager {
    class Proxy : MarshalByRefObject {
        public Assembly LoadAssembly(string assemblyPath) {
            try {
                return Assembly.LoadFrom(assemblyPath);
            } catch ( Exception ex ) {
                throw new InvalidOperationException(ex.Message);
            }
        }
    }
}