using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Common.DisposeUser();
        Session.Abandon();
        Session.RemoveAll();
        Response.Redirect("/Backend/Login.aspx",false);
    }
}
