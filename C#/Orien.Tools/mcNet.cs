using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Xml.Linq;

namespace Orien.Tools {
    public class McNet {
        public static bool IsInternetAviable() => (NetworkInterface.GetIsNetworkAvailable()) ? true : false;
        public static long GetFileSize(string url) {

            long result = 0;
            WebRequest req = WebRequest.Create(url);
            req.Method = WebRequestMethods.Http.Head;
            using (WebResponse resp = req.GetResponse()) {
                if (long.TryParse(resp.Headers.Get("Content-Length"), out long contentLength)) {
                    result = contentLength;
                }
            }
            return result;
        }
        public static XDocument ReadXmlFile(string url) {
            // BUGTRACK 003 AVG crashing app
            /*WebClient wc = new WebClient();
            string download_fpath = Path.Combine(McDesktop.User_Directory, @"Downloads\NS_Downloads\Settings.xml");
            wc.DownloadFile(url, download_fpath);*/

            XDocument doc;
            try {
                doc = XDocument.Load(url);
            } catch {

                var webRequest = WebRequest.Create(url);
                webRequest.Method = "GET";
                using (var response = webRequest.GetResponse())
                using (var content = response.GetResponseStream())
                using (var reader = new StreamReader(content)) {
                    doc = XDocument.Parse(reader.ReadToEnd());
                }
            }
            return doc;
        }

        public static string GetXmlItemValue(XDocument setings_xml, string label_name, string attribute_name = "value") {

            string result = "";
            //XElement allData = XElement.Load("Authors.xml");
            IEnumerable<XElement> items = setings_xml.Descendants("item");
            foreach (XElement item in items) {

                if (item.Attribute("label").Value == label_name) {
                    result = item.Attribute(attribute_name).Value;
                    break;
                }
            }
            return result;
        }
    }
}