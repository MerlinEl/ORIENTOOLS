using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Xml.Linq;

namespace Orien.Tools {
    public class mcNet {
        public static bool IsInternetAviable() => (NetworkInterface.GetIsNetworkAvailable()) ? true : false;
        public static XDocument ReadXmlFile(string url) {
            XDocument doc;
            try {
                doc = XDocument.Load(url);
            } catch {

                var webRequest = WebRequest.Create(url);
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

/*
 * 
 * setings_xml.Root.Element("item").Attribute("label").Value;
 * 
public MaxXmlNode GetNode(string nodePath) {

    XmlNode target_node = doc.DocumentElement.SelectSingleNode(nodePath);
    if (target_node == null) return null;
    return (new MaxXmlNode(doc, target_node, nodePath));

    doc.SelectSingleNode("/MyConfiguration/@SuperNumber").Value;
}*/
