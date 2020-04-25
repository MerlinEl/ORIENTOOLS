using System.Collections.Generic;
using System.Dynamic;

namespace Orien.Tools {

    public class McDynObj : DynamicObject {
        // The inner dictionary.
        readonly Dictionary<string, object> dictionary = new Dictionary<string, object>();
        // This property returns the number of elements
        // in the inner dictionary.
        public int Count => dictionary.Count;
        // If you try to get a value of a property 
        // not defined in the class, this method is called.
        public override bool TryGetMember(
            GetMemberBinder binder, out object result) {
            // Converting the property name to lowercase
            // so that property names become case-insensitive.
            string name = binder.Name.ToLower();
            // If the property name is found in a dictionary,
            // set the result parameter to the property value and return true.
            // Otherwise, return false.
            return dictionary.TryGetValue(name, out result);
        }
        // If you try to set a value of a property that is
        // not defined in the class, this method is called.
        public override bool TrySetMember(
            SetMemberBinder binder, object value) {
            // Converting the property name to lowercase
            // so that property names become case-insensitive.
            dictionary[binder.Name.ToLower()] = value;
            // You can always add a value to a dictionary,
            // so this method always returns true.
            return true;
        }
        public GetMemberBinder GetGetBinderInstance(string str, bool ignoreCase) {
            GetMemberBinder bi = new GetMemberBinderChild(str, ignoreCase);
            return bi;
        }
        public SetMemberBinder GetSetBinderInstance(string str, bool ignoreCase) {
            SetMemberBinder bi = new SetMemberBinderChild(str, ignoreCase);
            return bi;
        }
    }


    public class SetMemberBinderChild : SetMemberBinder {
        
        public SetMemberBinderChild(string name, bool ignoreCase):base(name, ignoreCase) {
            
        }

        public override DynamicMetaObject FallbackSetMember(DynamicMetaObject target, DynamicMetaObject value, DynamicMetaObject errorSuggestion) {
            System.Console.WriteLine("ss");
            return null;
        }
    }

    public class GetMemberBinderChild : GetMemberBinder {

        public GetMemberBinderChild(string name, bool isBig) : base(name, isBig) {

        }

        public override DynamicMetaObject FallbackGetMember(DynamicMetaObject target, DynamicMetaObject errorSuggestion) {
            System.Console.WriteLine("ss");
            return null;
        }
    }
}

/*
dotNet.loadAssembly (micra.AssemblyDir + "Orien.Tools.dll") --load dll in to memory
cls = dotNet.getType "Orien.Tools.McDynObj"
inst = (dotNetClass "System.Activator").CreateInstance cls --create class instance 

---------------------------------------------------------
--we want to create person
getBinder = inst.GetGetBinderInstance "age" true

outObj = undefined
ageProperty = inst.TryGetMember getBinder &outObj	-- only boolean, needs to implement get value method
if(ageProperty)then
(
	-- now you get outObj which is value of age
	return outObj
	-- setBinder = inst.GetSetBinderInstance "age" true
	-- outObj = outObj + 10
	-- inst.TrySetMember setBinder outObj
)
else
(
	setBinder = inst.GetSetBinderInstance "age" true
	inst.TrySetMember setBinder 25
)
 */

