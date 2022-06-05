using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace SystemFrameWork
{
    /// <summary>
    /// Đây là class xây dựng các phương thức dùng chung trong hệ thống
    /// </summary>
    public class CommonBO
    {
        public static String HomePhysicalPath
        {
            get
            {
                return AppDomain.CurrentDomain.BaseDirectory.ToString();
            }
        }
        public static String HomePath
        {
            get
            {
                return System.Configuration.ConfigurationSettings.AppSettings["Domain"].ToString();
            }
        }
        public static String GetDocumentFolder
        {
            get
            {
                return System.Configuration.ConfigurationSettings.AppSettings["document"].ToString();
            }
        }

        public static String GetDocumentFolderHomePath
        {
            get
            {
                return HomePath + GetDocumentFolder;
            }
        }
        public static String GetDocumentFolderPhysicalPath
        {
            get
            {
                return HomePhysicalPath + GetDocumentFolder;
            }
        }


        public static String GetResultFolder
        {
            get
            {
                return System.Configuration.ConfigurationSettings.AppSettings["result"].ToString();
            }
        }

        public static String GetResultFolderHomePath
        {
            get
            {
                return HomePath + GetResultFolder;
            }
        }
        public static String GetResultFolderPhysicalPath
        {
            get
            {
                return HomePhysicalPath + GetResultFolder;
            }
        }
    }

}

