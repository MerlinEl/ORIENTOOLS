using System;
using System.Collections.Generic;
using System.Linq;

namespace Orien.Tools {
    class McLinq {
    }
    static class McLinqExtensions {
        /// <summary>
        /// Join all string arrays inside a List (Transmutation from array2D to simple array)
        /// var list = new List<string[]> { new[] {"He", "l", "o"}, new[] {"b","oy"} };
        /// list.CondenseStrings()
        /// -> 
        /// </summary>
        public static List<string> CondenseStrings(this List<string[]> items) {
            return new List<string>(items.Select(s => String.Join("", s)));
        }
        /*public static IEnumerable<T> Replace<T>(this IEnumerable<T> items, Func<T, T> replaceAction) {
            return items.Select(item => replaceAction(item));
        }*/
        /// <summary>
        /// Replace items in List by given condition (conditional rplacement)
        /// var names = new[] { "Hasan", "Jack", "Josh" };
        /// names = names.Replace(x => x == "Hasan", _ => "Khan").ToArray();
        /// </summary>
        public static IEnumerable<T> Replace<T>(this IEnumerable<T> items, Predicate<T> condition, Func<T, T> replaceAction) {
            return items.Select(item => condition(item) ? replaceAction(item) : item);
        }
    }
}


/*
 * FROM >
List<string[]> map_data = new List<string[]>();
string[] map_data_array = new string[11];

for(int i = 0; i < 2000; i++)
{
    map_data_array = PopulateDataFromFile(); // it returns different data every call
    map_data.Add(map_data_array); // store to List
}
 * TO >
List<string[]> map_data = new List<string[]>();
foreach (var batch in PopulateDataFromFile().Batch(11))
{
       map_data.Add((batch.ToArray());
}
public static IEnumerable<IEnumerable<T>> Batch<T>(this IEnumerable<T> items, int batchSize)
{
     return items.Select((item, inx) => new { item, inx })
                 .GroupBy(x => x.inx / batchSize)
                 .Select(g => g.Select(x => x.item));
}
 */
