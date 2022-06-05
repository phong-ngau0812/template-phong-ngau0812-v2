using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using SystemFrameWork;
using DbObj;
using System.Net;
public partial class Admin_Template_CMS : System.Web.UI.MasterPage
{
    protected string indexmenu = "1";
    protected int _UserID = 0;
    protected string avatar, avatar_dn, ProductBrandName = string.Empty;
    protected string password, key = string.Empty;
    public string MaDN = "";
    public string ReturnURL = string.Empty;
    public int Count = 0;
    protected void Page_Init(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request["ReturnURL"]))
            ReturnURL = (Request["ReturnURL"].ToString());
        if (!Page.IsPostBack)
        {
            LoadNotifi();
        }
    }
    public string html = string.Empty;
    private void LoadNotifi()
    {
        DataTable dt = new DataTable();
        // dt = BusinessRulesLocator.GetContactBO().GetAsDataTable("Status = 0", "");
        if (dt.Rows.Count > 0)
        {
            Count = dt.Rows.Count;
            lblCheckNotify.Visible = true;
        }
        //lblnotify.Text = html;
    }

    private void FillMenu()
    {
        try
        {

        }
        catch (Exception ex)
        {
            Log.writeLog("FillDDLCha", ex.ToString());
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckAccount();
    }
    protected void CheckAccount()
    {
        try
        {

            if (Session["SessionUserID"] == null)
            {
                Response.Redirect("~/Login.aspx", false);
            }
            else
            {
                UserRow _UserRow = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(Convert.ToInt32(Session["SessionUserID"]));
                if (_UserRow != null)
                {
                    avatar = (_UserRow.IsAvatarNull) ? "../../images/no-image-icon.png" : _UserRow.Avatar;
                }
            }
            //else
            //{
            //    if (MyActionPermission.CheckURLPermission() == 0)
            //    {
            //        Response.Redirect("/", false);
            //    }
            //    if (!string.IsNullOrEmpty(ReturnURL))
            //    {
            //        Response.Redirect("/Admin/ProductPackage/ProductPackage_List?Code=" + ReturnURL, false);
            //    }
            //    ProfileUser = UserProfile.GetProfile(Context.User.Identity.Name);
            //    avatar = string.IsNullOrEmpty(ProfileUser.AvatarUrl) ? "../../images/no-image-icon.png" : ProfileUser.AvatarUrl;
            //}
        }
        catch (Exception ex)
        {
            //Response.Redirect("~/Login.aspx", false);
            Log.writeLog(ex.ToString(), "CheckAccount");
        }
    }

}