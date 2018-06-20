using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
namespace ArmaAAR
{
    public class DllEntry
    {

        #region Variables
        private static Dictionary<string, Frame> frames = new Dictionary<string, Frame>();

        internal static Dictionary<string, Frame> Frames { get => frames; set => frames = value; }

        internal static string currentRecName = "";
        #endregion Variables

        #region Arma Calls
#if WIN64
        [DllExport("RVExtensionVersion", CallingConvention = CallingConvention.Winapi)]
#else
        [DllExport("_RVExtensionVersion@8", CallingConvention = CallingConvention.Winapi)]
#endif
        public static void RvExtensionVersion(StringBuilder output, int outputSize) => output.Append("0.1");
#if WIN64
        [DllExport("RVExtension", CallingConvention = CallingConvention.Winapi)]
#else
        [DllExport("_RVExtension@12", CallingConvention = CallingConvention.Winapi)]
#endif
        public static void RvExtension(StringBuilder output, int outputSize,
            [MarshalAs(UnmanagedType.LPStr)] string function)
        {
            if (function == "version")
            {
                output.Append("0.1");
            } else if (function.StartsWith("setFrameData"))
            {
                string[] args = function.Split(new char[] { ';' }, 3);
                if (!Frames.ContainsKey(args[1]))
                {
                    Frames.Add(args[1], new Frame());
                }
                Frames[args[1]].AddFrameData(args[2]);
            } else if (function.StartsWith("readFrame"))
            {
                string[] args = function.Split(new char[] { ';' }, 2);
                if (!Frames.ContainsKey(args[1]))
                {
                    output.Append(Frames[args[1]].ReadFrameData());
                }
            } else if (function.StartsWith("ClearFrameData"))
            {
                foreach (var item in Frames)
                {
                    item.Value.Clear();
                }
                Frames.Clear();
                currentRecName = "";
            } else if (function.StartsWith("ImportFrameData"))
            {
                string[] args = function.Split(new char[] { ';' }, 2);
                DataManaging.ImportRecording(args[1]);
            }
        }
        #endregion Arma Calls
    }
}
