using System.Threading;
/*
*@Author Erik 
usage

    void startthework()
    {
        ThreadedExecuter<string> executer = new ThreadedExecuter<string>(someLongFunction, longFunctionComplete);
        executer.Start();
    }
    string someLongFunction()
    {
        while(!workComplete)
            WorkWork();
        return resultOfWork;
    }
    void longFunctionComplete(string s)
    {
        PrintWorkComplete(s);
    } 
*/
namespace Orien.Tools {
    public class McThreadedExecuter<T> where T : class {

        public delegate void CallBackDelegate(T returnValue);
        public delegate T MethodDelegate();
        private readonly CallBackDelegate callback;
        private readonly MethodDelegate method;
        private readonly Thread t;

        public McThreadedExecuter(MethodDelegate method, CallBackDelegate callback) {
            this.method = method;
            this.callback = callback;
            t = new Thread(this.Process);
        }
        public void Start() {
            t.Start();
        }
        public void Abort() {
            t.Abort();
            callback(null); //can be left out depending on your needs
        }
        private void Process() {
            T stuffReturned = method();
            callback(stuffReturned);
        }
    }
}
