using System;

namespace Orien.Tools {
    public class mcEvent {
        public readonly Action<mcEventArgs> eventAction;
        public readonly string eventType;
        public mcEvent(string event_type, Action<mcEventArgs> event_action) {

            eventType = event_type;
            eventAction = event_action;
        }
        internal void Dispatch(mcEventArgs event_args) => eventAction(event_args);
    }

    public class mcEventType {
        public static string DOWNLOAD_COMPLETE => "download_complete";
        public static string DOWNLOAD_PROGRESS => "download_progress";
        public static string DOWNLOAD_FAILED => "download_failed";
    }

    public class mcEventArgs {
        public string Tag { get; private set; }
        public mcEventDispatcher Sender { get; private set; }
        public string EventId { get; private set; }
        public object Target { get; private set; }
        public string ErrorMsg { get; private set; }
        public mcEventArgs(mcEventDispatcher evt_dispatcher, string evt_id, object evt_target, string evt_tag = "", string error_msg = "None") {
            Tag = evt_tag;
            Sender = evt_dispatcher;
            EventId = evt_id;
            Target = evt_target;
            ErrorMsg = error_msg;
        }
    }
}