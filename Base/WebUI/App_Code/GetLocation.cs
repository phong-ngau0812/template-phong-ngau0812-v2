using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for GetLocation
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class GetLocation : System.Web.Services.WebService
{

    public GetLocation()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
    public string GetAddressLocation(string Latitude, string Longitude)
    {
        string Address = "";
        string ResponseString = "";
        string URL = "https://maps.googleapis.com/maps/api/geocode/json";
        string Key = "AIzaSyBrEsVnV1XM8_Q0PX7PhJF67Lr2gSnmt_0";

        URL += "?latlng=" + Latitude + "," + Longitude + "&key=" + Key;

        var httpWebRequest = (HttpWebRequest)WebRequest.Create(URL);
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";

        using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
        {
            streamWriter.Write("");
            streamWriter.Flush();
            streamWriter.Close();
        }

        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            ResponseString = streamReader.ReadToEnd();
        }

        var a = (JObject)JsonConvert.DeserializeObject(ResponseString);
        Address = a["results"][0]["formatted_address"].ToString();

        return Address;
    }
}
