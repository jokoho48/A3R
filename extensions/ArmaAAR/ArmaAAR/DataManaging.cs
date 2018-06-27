using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmaAAR
{
    static class DataManaging
    {
        public static void ExportRecording(Dictionary<string, Frame> frames, string filename)
        {
            using (FileStream fs = File.OpenWrite(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "A3R", filename + ".A3R")))
            {
                GZipStream cmp = new GZipStream(fs, CompressionLevel.Optimal);
                using (BinaryWriter writer = new BinaryWriter(cmp))
                {
                    writer.Write(frames.Count);
                    foreach (var pair in frames)
                    {
                        writer.Write(pair.Key);
                        List<string> data = pair.Value.frameData;
                        writer.Write(data.Count);
                        foreach (var item in data)
                        {
                            writer.Write(item);
                        }
                    }
                }
            }
        }

        public static Dictionary<string, Frame> ImportRecording(string filename)
        {
            Dictionary<string, Frame> database = new Dictionary<string, Frame>();
            using (FileStream fs = File.OpenRead(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "A3R", filename + ".A3R")))
            {
                GZipStream dcmp = new GZipStream(fs, CompressionMode.Decompress);

                using (BinaryReader reader = new BinaryReader(dcmp))
                {
                    int count = reader.ReadInt32();
                    for (int i = 0; i < count; i++)
                    {
                        string key = reader.ReadString();
                        Frame value = new Frame();
                        int countData = reader.ReadInt32();
                        for (int j = 0; j < countData; j++)
                        {
                            value.AddFrameData(reader.ReadString());
                        }
                        database.Add(key, value);
                    }
                }
            }
            DllEntry.currentRecName = filename;
            return database;
        }
    }
}
