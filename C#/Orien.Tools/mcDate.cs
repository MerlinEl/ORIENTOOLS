using System;
using System.Globalization;

namespace Orien.Tools {
    public class McDate {
        /// <summary>
        /// Convert string to date object
        /// Example > mcDate.FromString( 02/25/2000 )
        /// </summary>
        /// <param name="date_str">Date in string format</param>
        /// <param name="culture_id">Default is Eng</param>
        /// <returns></returns>
        public static DateTime FromString(string date_str, string culture_id = "en-US") { //"cs-CZ"
            // Parse date-only value without leading zero in month using "d" format.
            // Should throw a FormatException because standard short date pattern of 
            // invariant culture requires two-digit month.
            string format = "d";
            CultureInfo provider = new CultureInfo(culture_id);
            return DateTime.ParseExact(date_str, format, provider);
        }

        public static int GetDaysOffset(DateTime StartDate, DateTime EndDate) {
            return Convert.ToInt32(( EndDate - StartDate ).TotalDays);
        }
    }
}