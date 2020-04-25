using System;

namespace Orien.Tools {
    public class McEvent {
        public readonly Action<McEventArgs> eventAction;
        public readonly string eventType;
        public McEvent(string event_type, Action<McEventArgs> event_action) {

            eventType = event_type;
            eventAction = event_action;
        }
        internal void Dispatch(McEventArgs event_args) => eventAction(event_args);
    }

    public class McEventType {
        public static string DOWNLOAD_COMPLETE => "download_complete";
        public static string DOWNLOAD_PROGRESS => "download_progress";
        public static string DOWNLOAD_FAILED => "download_failed";
    }

    public class McEventArgs {
        public string Tag { get; private set; }
        public McEventDispatcher Sender { get; private set; }
        public string EventId { get; private set; }
        public object Target { get; private set; }
        public string ErrorMsg { get; private set; }
        public McEventArgs(McEventDispatcher evt_dispatcher, string evt_id, object evt_target, string evt_tag = "", string error_msg = "None") {
            Tag = evt_tag;
            Sender = evt_dispatcher;
            EventId = evt_id;
            Target = evt_target;
            ErrorMsg = error_msg;
        }
    }
}