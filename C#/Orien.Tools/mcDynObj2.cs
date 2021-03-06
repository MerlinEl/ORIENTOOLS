﻿using System.Collections.Generic;
namespace Orien.Tools {

    public class McDynObj2 {
        private readonly Dictionary<string, object> _dict = new Dictionary<string, object>();

        public object GetProperty(string name) {
            return _dict[name];
        }

        public void SetProperty(string name, object value) {
            _dict[name] = value;
        }
    }
}

