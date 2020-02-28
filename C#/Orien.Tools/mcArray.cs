using System.Collections.Generic;

namespace Orien.Tools {
    public class mcArray {

        public static void AddItem<T>(List<T> list, T item, bool unique = false) {

            if (unique && !list.Contains(item)) {
                list.Add(item);
            } else {

                list.Add(item);
            }
        }
        public static void Prepend<T>(List<T> list, T item) {

            list.Insert(0, item);
        }
    }
}
