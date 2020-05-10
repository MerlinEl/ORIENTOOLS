using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.NetworkInformation;
using System.Windows.Forms;
using System.Xml.Linq;

namespace Orien.Tools {
    public class McNet {
        public static bool IsInternetAviable() => (NetworkInterface.GetIsNetworkAvailable()) ? true : false;
        public static bool SendEmail(McEmailArgs data) {

            using (SmtpClient smtpClient = new SmtpClient()) {
                var basicCredential = new NetworkCredential(data.username, data.password);
                using (MailMessage message = new MailMessage()) {
                    MailAddress fromAddress = new MailAddress(data.mail_from);

                    smtpClient.Host = data.smptp;
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = basicCredential;
                    //smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    //smtpClient.Port = data.port;
                    //smtpClient.EnableSsl = data.enable_ssl;
                    //smtpClient.Timeout = 10000;

                    message.From = fromAddress;
                    message.Subject = data.subject;
                    //message.IsBodyHtml = true;
                    message.Body = data.message; //"<h1>Iuč Manažer Test message 01</h1>";
                    message.To.Add(data.mail_to);

                    try {
                        smtpClient.Send(message);
                    } catch (Exception ex) {
                        MessageBox.Show(ex.Message);
                        return false;
                    }
                }
            }
            return true;
        }
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

        public static string[] GetXmlItemsLabel(XDocument setings_xml) {

            IEnumerable<XElement> items = setings_xml.Descendants("item");
            string[] labels = items
                .Select(item => item.Attribute("label").Value)
                .ToArray();
            return labels;
        }

        public static string GetXmlItemValue(XDocument setings_xml, string item_attr, string item_value, string attribute_name = "value") {

            string result = "";
            //XElement allData = XElement.Load("Authors.xml");
            IEnumerable<XElement> items = setings_xml.Descendants("item");
            foreach (XElement item in items) {

                if (item.Attribute(item_attr).Value == item_value) {
                    result = item.Attribute(attribute_name) != null ?
                        item.Attribute(attribute_name).Value :
                        "null";
                    break;
                }
            }
            return result;
        }
    }
    public class McEmailArgs {

        public string mail_from;
        public string mail_to;
        public string subject;
        public string message;
        public string username;
        public string password;
        public string smptp = "smtp.gmail.com";
        public int port = 587;
        public bool enable_ssl = true;

        public void FromString(string data_str) {
            string[] data_arr = data_str.Split(';');
            mail_from = data_arr[0];
            mail_to = data_arr[1];
            message = data_arr[2];
            subject = data_arr[3];
            username = data_arr[4];
            password = data_arr[5];
            smptp = data_arr[6];
            port = Int32.Parse(data_arr[7]);
            enable_ssl = data_arr[8].ToLower() == "true";
        }
        override public string ToString() {
            string str = "McEmailArgs > \n" +
                 "\tmail_from:  " + mail_from + "\n" +
                 "\tmail_to:    " + mail_to + "\n" +
                 "\tsubject:    " + subject + "\n" +
                 "\tmessage:    " + message + "\n" +
                 "\tusername:   " + username + "\n" +
                 "\tpassword:   " + password + "\n" +
                 "\tsmptp:      " + smptp + "\n" +
                 "\tport:       " + port + "\n" +
                 "\tenable_ssl: " + enable_ssl + "\n";
            return str;
        }
    }
    public static class McNetExtensions {
        // NTESTED
        /*public static bool IsValidMail(this string str) {
            Regex reg = new Regex(@"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
            return reg.IsMatch(str);
        }*/
    }
}