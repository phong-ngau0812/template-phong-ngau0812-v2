using System.Diagnostics;
using System;
using System.Data;
using System.Collections;
using System.IO;


namespace SystemFrameWork
{
    public class Log
    {

        public static void writeLog(string logContent, string methodName)
        {
            //get filename
            string currentDate = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString();
            string strFileName = AppDomain.CurrentDomain.BaseDirectory + "LogPath\\" + currentDate + "Log.txt";
            string strLogString;
            strLogString = "\r\n";
            strLogString += "===========  " + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString() + "  " + methodName + "  ==============" + "\r\n";
            strLogString += logContent + "\r\n";
            strLogString += "===================================================================";
            try
            {
                System.Text.Encoding charset = System.Text.Encoding.GetEncoding(65001); //"UTF-8"
                if (!File.Exists(strFileName))
                {
                    FileStream oFile;
                    oFile = File.Create(strFileName);
                    StreamWriter oReader = new StreamWriter(oFile, charset);
                    oReader.WriteLine(strLogString);
                    oReader.Close();
                    oFile.Close();
                }
                else
                {
                    // Append text in file when file exitsed
                    FileStream oFile1 = new FileStream(strFileName, FileMode.Open, FileAccess.Read, FileShare.Read);
                    if (oFile1.Length > 1048576)
                    {
                        oFile1.Close();
                        File.Delete(strFileName);
                    }
                    else
                    {
                        oFile1.Close();
                    }
                    StreamWriter oReader = new StreamWriter(strFileName, true, charset);
                    oReader.WriteLine(strLogString);
                    oReader.Close();
                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}
