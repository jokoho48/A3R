using System;
using System.Collections.Generic;

namespace ArmaAAR
{
    internal class Frame
    {

        public List<string> frameData = new List<string>();
        private int currentDataIndex = 0;
        public Frame() {}

        internal void AddFrameData(string args)
        {
            frameData.Add(args);
        }

        internal string ReadFrameData()
        {
            if (frameData.Count == 0)
            {
                currentDataIndex = 0;
                return "DONE";
            }
            if (frameData.Count == currentDataIndex)
            {
                currentDataIndex = 0;
                return "DONE";
            }
            return frameData[currentDataIndex++];
        }
        internal void Clear()
        {
            frameData.Clear();
            currentDataIndex = 0;
        }
    }
}
