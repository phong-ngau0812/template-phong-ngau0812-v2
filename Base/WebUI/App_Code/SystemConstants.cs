using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Systemconstants
/// </summary>
public class Systemconstants
{
    public Systemconstants()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public const string key= "b1a76556447c964f657efd81906f51c5";
    public const string VersionCSS = "1.0.9";
    public const string VersionJS = "1.0.9";
    private static Random random = new Random();

    public static string Version(int length)
    {
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }
 

}
