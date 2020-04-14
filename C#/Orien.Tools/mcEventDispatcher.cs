using System;
using System.Collections.Generic;
/**
 *@Example
    mcWebClient web_client = new mcWebClient(); //new EventDispatcher > new client
    web_client.addEventListener(mcEventType.DOWNLOAD_COMPLETE, OnFileDownloaded);
    web_client.addEventListener(mcEventType.DOWNLOAD_PROGRESS, OnFileDownloadProgress);
    public void OnFileDownloadProgress(mcEventArgs e) {}
    public void OnFileDownloaded(mcEventArgs e) {
    
         e.sender.removeEventListener(mcEventType.DOWNLOAD_PROGRESS, OnFileDownloadProgress);
         e.sender.removeEventListener(mcEventType.DOWNLOAD_COMPLETE, OnFileDownloaded);
    }
    mcEventArgs event_args = new mcEventArgs(this, "download_progress:", e.ProgressPercentage, Tag);
    dispatchEvent(mcEventType.DOWNLOAD_PROGRESS, event_args);
*/
namespace Orien.Tools {
    public class mcEventDispatcher {
        //list of active events
        List<mcEvent> REGISTRED_EVENTS = new List<mcEvent>();
        public mcEventDispatcher() { }
        public void AddEventListener(string event_type, Action<mcEventArgs> event_action) {

            // Console.WriteLine("mcEventDispatcher > AddEventListener >\n\tEvent_Type:\t" + event_type + "\n\tAction:\t" + event_action.ToString());
            mcEvent OnEventComplete = new mcEvent(event_type, event_action); // Create new event
            REGISTRED_EVENTS.Add(OnEventComplete);
        }
        public void RemoveEventListener(string event_type, Action<mcEventArgs> event_action) {

            // Console.WriteLine("mcEventDispatcher > RemoveEventListener >\n\tEvent_Type:\t" + event_type + "\n\tAction:\t" + event_action.ToString());
            foreach (mcEvent evt in REGISTRED_EVENTS) {
                if (evt.eventType == event_type && evt.eventAction == event_action) {
                    REGISTRED_EVENTS.Remove(evt);
                    break;
                }
            }
        }
        public void RemoveAllListeners() => REGISTRED_EVENTS = new List<mcEvent>();
        public void DispatchEvent(string event_type, mcEventArgs event_args) {

            mcEvent evt = REGISTRED_EVENTS.Find(delegate (mcEvent i) {
                return i.eventType == event_type;
            });
            if (evt != null) evt.Dispatch(event_args);
        }
    }
}

//---------------//
//-Other Methods-//
//---------------//

/// <summary>
/// Collection of Events
/// </summary>
/// Example
/// FormattedAddresses events = new FormattedAddresses() {
/// {"download_complete", fnA},
/// {"download_progress", fnB}
/// }
/// foreach (string eventEntry in events) {Console.WriteLine("\r\n" + eventEntry);}
/*class Events_Collection : IEnumerable<string> {
    private List<string> internalList = new List<string>();
    public IEnumerator<string> GetEnumerator() => internalList.GetEnumerator();
    System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() => internalList.GetEnumerator();
    public void Add(string event_type, Action<mcEventArgs> event_action) {

        internalList.Add($@"{event_type}{event_action}");
    }
    public void Remove(string event_type, Action<mcEventArgs> event_action) {


    }
}*/

/*mcEvent e = null;
foreach (mcEvent evt in REGISTRED_EVENTS) {
    if (evt.eventType == event_type) {
        e = evt;
        break;
    }
}
if (e != null) e.Dispatch(event_args);*/
