using System.Collections.Generic;
using System.Dynamic;
namespace Orien.Tools {

    public class mcDynObj2 {
        private Dictionary<string, object> _dict = new Dictionary<string, object>();

        public object GetProperty(string name) {
            return _dict[name];
        }

        public void SetProperty(string name, object value) {
            _dict[name] = value;
        }
    }
}

