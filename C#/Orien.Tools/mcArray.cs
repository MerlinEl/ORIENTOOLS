using System;
using System.Collections.Generic;

namespace Orien.Tools {
    public static class mcArray {

        public static void AddItemUnique<T>(this List<T> list, T item) {

            if ( !list.Contains(item) ) {
                list.Add(item);
            }
        }
        public static void TestFn(string s) {

            //https://docs.microsoft.com/cs-cz/dotnet/csharp/language-reference/language-specification/documentation-comments
            mcXML doc = new mcXML("c:/temp/text_01.xml");
            Console.WriteLine("XML body:", doc.Body);
            int result = mcMath.MinMax(20, 1, 100);
            Console.WriteLine("Min Max result:", result);
        }
    }
}
