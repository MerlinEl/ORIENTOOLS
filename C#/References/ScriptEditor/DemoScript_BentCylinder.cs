using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Autodesk.Max;

namespace SampleCSharp3dsMaxScripts
{
    /// <summary>
    /// Creates a cylinder in the scene and applies a bend modifier. 
    /// </summary>
    public class SampleBentCylinder
    {
        /// <summary>
        /// Returns a pointer to the IGlobal instance.
        /// </summary>
        public static IGlobal Global { get { return GlobalInterface.Instance; } }

        /// <summary>
        /// Returns a pointer to the most recent CORE interface.
        /// </summary>
        public static IInterface14 Core { get { return Global.COREInterface14; } }

        /// <summary>
        /// Returns the current time value. 
        /// </summary>
        public static int Now { get { return Core.Time; } }

        /// <summary>
        /// Prints a line of text to the MAXScript listener. 
        /// </summary>
        /// <param name="s"></param>
        public static void WriteLine(string s)
        {
            Global.TheListener.EditStream.Wputs(s);
            Global.TheListener.EditStream.Wputs("\n");
            Global.TheListener.EditStream.Flush();
        }

        /// <summary>
        /// Creates a new geometric object of the specified class ID. 
        /// </summary>
        /// <param name="cid"></param>
        /// <returns></returns>
        public static IGeomObject CreateGeomObject(IClass_ID cid)
        {
            return Core.CreateInstance(SClass_ID.Geomobject, cid) as IGeomObject;
        }

        /// <summary>
        /// Creates a cylinder object. 
        /// </summary>
        /// <returns></returns>
        public static IObject CreateCylinder()
        {
            var cid = Global.Class_ID.Create((uint)BuiltInClassIDA.CYLINDER_CLASS_ID, 0);
            var cyl = CreateGeomObject(cid);
            if (cyl == null)
               throw new Exception("Failed to create cylinder geometric object");
            // The cylinder uses old style IParamArray types to store parameters. 
            var pa = cyl.ParamBlock;
            if (pa == null)
               throw new Exception("Failed to retrieve the parameter block for the cylinder");
            pa.SetValue(0, Now, 20.0f);
            pa.SetValue(1, Now, 40.0f);
            pa.SetValue(2, Now, 10);
            return cyl;
        }

        /// <summary>
        /// Creates a new object space modifier of the specified class ID. 
        /// </summary>
        /// <param name="cid"></param>
        /// <returns></returns>
        public static IModifier CreateModifier(IClass_ID cid)
        {
            return Global.COREInterface14.CreateInstance(SClass_ID.Osm, cid) as IModifier;
        }

        /// <summary>
        /// Creates an instance of the bend modifier. 
        /// </summary>
        /// <returns></returns>
        public static IModifier CreateBend()
        {
            var cid = Global.Class_ID.Create((uint)BuiltInClassIDA.BENDOSM_CLASS_ID, 0);
            var bend = CreateModifier(cid);
            if (bend == null)
               throw new Exception("Failed to create bend modifier");            
            var pb = bend.GetParamBlock(0);
            if (pb == null)
               throw new Exception("Failed to retrieve the parameter block for the bend modifier");
            pb.SetValue(0, Now, 60.0f, 0);
            return bend;
        }

        /// <summary>
        /// Creates a modifier with a bend modifier applied. 
        /// </summary>
        public static void DemoBentCylinder()
        {
            var cyl = CreateCylinder();
            var node = Core.CreateObjectNode(cyl);
            var bend = CreateBend();
            Core.AddModifier(node, bend, 0);
        }

        /// <summary>
        /// Script entry point.
        /// </summary>
        /// <param name="args"></param>
        public static void Main(string[] args)
        {
            try 
            {
              DemoBentCylinder();
            }
            catch (Exception e)
            {
               WriteLine(e.Message);
            }
        }
    }
}

