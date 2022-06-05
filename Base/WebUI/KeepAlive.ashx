<%@ WebHandler Language="C#" Class="KeepAlive" %>

using System;
using System.Web;

public class KeepAlive : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("I'm here");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}