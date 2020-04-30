using System.Collections.Generic;
using System.IO;
using System.Xml;

namespace Orien.Tools {
    class McXML {
        readonly XmlDocument doc;
        public string url = "";
        public bool loaded = false;
        public string xmlNodeQuan = ( typeof(XmlNode) ).AssemblyQualifiedName;
        /// <summary>
        /// Open or Create XML file
        /// </summary>
        /// <param name="xmlPath">XML file path</param>
        public McXML(string xmlPath) {

            url = xmlPath;
            doc = new XmlDocument();
            if ( File.Exists(xmlPath) ) {

                doc.Load(xmlPath);

            } else {

                XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
                doc.AppendChild(docNode);
            }
            loaded = true;
        }
        public string Body => doc.OuterXml.ToString();
        /**
        *@Usage
        *   nodePath  "/ACTIONS/Object/Clone_2"
        */
        public MaxXmlNode GetNode(string nodePath) {
            if ( nodePath.Length == 0 ) {
                return null;
            }

            XmlNode target_node = doc.DocumentElement.SelectSingleNode(nodePath);
            if ( target_node == null ) {
                return null;
            }

            return ( new MaxXmlNode(doc, target_node, nodePath) );
        }
        /**
        *@Usage
        *   nodePath  "/ACTIONS/Object"
        */
        public List<MaxXmlNode> GetNodes(string nodePath) {

            if ( nodePath.Length == 0 ) {
                return new List<MaxXmlNode>();
            }

            XmlNode target_node = doc.DocumentElement.SelectSingleNode(nodePath);
            if ( target_node == null ) {
                return new List<MaxXmlNode>();
            }

            XmlNodeList nodes = target_node.ChildNodes;
            List<MaxXmlNode> nodes_list = new List<MaxXmlNode>();
            foreach ( XmlNode n in nodes ) {
                nodes_list.Add(new MaxXmlNode(doc, n, nodePath));
            }
            return nodes_list;
        }
        /**
        *Usage
        *   not used
        *   not tested
        *   get nodes with given Name 
        * <Names>
            <Name>
                <FirstName>John</FirstName>
                <LastName>Smith</LastName>
            </Name>
            <Name>
                <FirstName>James</FirstName>
                <LastName>White</LastName>
            </Name>
        *</Names>
        *   nodePath   "/Names/Name" 
        */
        public List<MaxXmlNode> GetNodesByName(string nodePath) {
            if ( nodePath.Length == 0 ) {
                return new List<MaxXmlNode>();
            }

            XmlNodeList nodes = doc.DocumentElement.SelectNodes(nodePath);
            if ( nodes == null ) {
                return new List<MaxXmlNode>();
            }

            var nodes_list = new List<MaxXmlNode>();
            foreach ( XmlNode n in nodes ) {
                nodes_list.Add(new MaxXmlNode(doc, n, nodePath));
            }
            return nodes_list;
        }
        /**
        *Usage
        *   not used
        *   not tested
        *   find one person in xml
        */
        public MaxXmlNode FindNodeByName(string nodePath, string nodeName) {
            if ( nodePath.Length == 0 ) {
                return null;
            }

            XmlNodeList nodes = doc.DocumentElement.SelectNodes(nodePath);
            //List<MaxXmlNode> nodes_list = new List<MaxXmlNode>();
            MaxXmlNode max_node = null;
            foreach ( XmlNode n in nodes ) {

                if ( n.LocalName == nodeName ) {

                    max_node = new MaxXmlNode(doc, n, nodePath);
                    break;
                }
            }
            return max_node;
        }
        public void Save() => doc.Save(url);
    }
    class MaxXmlNode {

        public XmlDocument doc; //debug only, must be private and invisible
        public XmlNode node; //debug only, must be private and invisible
        public string url; //debug only, must be private and invisible
        public MaxXmlNode(XmlDocument xmlDoc, XmlNode xmlNode, string nodePath) {
            this.doc = xmlDoc;
            this.node = xmlNode;
            this.url = nodePath;
        }
        public string Name => node.LocalName;
        public string Body => node.OuterXml.ToString();
        public XmlNode Parent => node.ParentNode;
        public string Text {
            get => node.InnerText.Trim();
            set => node.InnerText = value;
        }
        public string GetAttribute(string attribName) {

            XmlAttribute attr = node.Attributes[attribName];
            return ( attr == null ) ? "" : attr.Value.ToString();
        }
        public string SetAttribute(string attribName, string value) {

            if ( node.Attributes != null && node.Attributes[attribName] != null ) {
                node.Attributes[attribName].Value = value;
            } else {
                XmlAttribute attr = doc.CreateAttribute(attribName);
                attr.Value = value;
                node.Attributes.Append(attr);
            }
            return value;
        }
    }
}

//;
//name = nodeName;
//, XmlNode ParentNode
//text = node_text;
//attribs = node_attribs;
//var doc = new XmlDocument();
//doc.LoadXml("<root><child /><child /></root>");
//var xmlNodeList = doc.ChildNodes;
//var nodees = new List<XmlNode>(xmlNodeList.Cast<XmlNode>());


//XmlNodeList name = xDoc.GetElementsByTagName("myName");
//XmlNodeList age = xDoc.GetElementsByTagName("myAge");
//MessageBox.Show("Name: " + name[0].InnerText);  
//string node_text = node.InnerText.Trim();
//System.IO.FileStream fs = new FileStream(xml_file, FileMode.Open, FileAccess.Read);
//doc.Load(fs);
//XmlNodeList xmlnode = doc.GetElementsByTagName(nodePath);
//class XmlNode {
//    public string name;
//    public string text;
//    public string[] attribs;
//    public void Main(string nodeName, string node_text, string[] node_attribs) {

//        name = nodeName;
//        text = node_text;
//        attribs = node_attribs;
//    }
//}