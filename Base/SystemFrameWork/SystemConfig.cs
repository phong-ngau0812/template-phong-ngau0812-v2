
// <fileinfo name="SystemConfig.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
// </fileinfo>


using System.Web;
using System.Configuration;

public class SystemConfig
{
    	
	public static string GetConnectionString()
	{
        //return ConfigurationManager.ConnectionStrings["MasterNewsDependency"].ConnectionString;
        return System.Configuration.ConfigurationSettings.AppSettings["Main.ConnectionString"].ToString();
	}

    public static string GetLicenseKey()
    {
        return "po2UhpWVhpSfkYaUiJaGlZeIl5SIn5+fnw==";
    }

}



