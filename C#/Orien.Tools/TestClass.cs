using System;

namespace Orien.Tools {
    public class TestClass {
        public static void TestFn() {
            //manual comments
            //https://docs.microsoft.com/cs-cz/dotnet/csharp/language-reference/language-specification/documentation-comments
            //manual snippet designer
            //https://github.com/mmanela/SnippetDesigner

            McXML doc = new McXML("c:/temp/text_01.xml");
            Console.WriteLine("XML body:", doc.Body);

            int result = McMath.MinMax(20, 1, 100);
            Console.WriteLine("Min Max result:", result);

            //Add Snippet > 2x Tab
            //multi rename Ctrl+rx2
            //int val = McMath.MinMax(45, 10, 100);
        }
    }
}
