using DbObj;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using SystemFrameWork;
public partial class User_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUser();
        }
        ResetMsg();
    }
    protected void ResetMsg()
    {
        lblMessage.Text = "";
        lblMessage.Visible = false;
    }
    protected void LoadUser()
    {
        try
        {
            DataTable dt = BusinessRulesLocator.GetUserBO().GetAsDataTable("Status<>-1 and User_ID<>1", " User_ID DESC");
            rptUser.DataSource = dt;
            rptUser.DataBind();
        }
        catch (Exception ex)
        {
            Log.writeLog("LoadUser", ex.ToString());
        }
    }
    protected void rptUser_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int User_ID = Convert.ToInt32(e.CommandArgument.ToString());
        UserRow u = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(User_ID);
        if (u != null)
        {
            switch (e.CommandName)
            {
                case "Delete":
                    u.Status = -1;
                    BusinessRulesLocator.GetUserBO().Update(u);
                    lblMessage.Text = Common.GetSuccessMsg("Xóa bản ghi thành công !");
                    lblMessage.Visible = true;
                    break;
                case "Reset":
                    u.Password = Common.MD5Decrypt("checkvn@123");
                    BusinessRulesLocator.GetUserBO().Update(u);
                    lblMessage.Text = Common.GetSuccessMsg("Tài khoản đã được khôi phục mật khẩu về: checkvn@123");
                    lblMessage.Visible = true; ;
                    break;
                case "Active":
                    u.Status = 1;
                    BusinessRulesLocator.GetUserBO().Update(u);
                    lblMessage.Text = Common.GetSuccessMsg("Kích hoạt thành công !");
                    lblMessage.Visible = true;
                    break;
                case "Deactive":
                    u.Status = 0;
                    BusinessRulesLocator.GetUserBO().Update(u);
                    lblMessage.Text = Common.GetSuccessMsg("Ngừng kích hoạt thành công !");
                    lblMessage.Visible = true;
                    break;
            }
        }
        LoadUser();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("User_Add.aspx", false);
    }
    protected void rptUser_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Literal lblApproved = e.Item.FindControl("lblApproved") as Literal;
            LinkButton btnActive = e.Item.FindControl("btnActive") as LinkButton;
            LinkButton btnDeactive = e.Item.FindControl("btnDeactive") as LinkButton;
            // CheckBox ckActive = e.Item.FindControl("ckActive") as CheckBox;
            Literal lblText = e.Item.FindControl("lblText") as Literal;
            if (lblApproved != null)
            {
                if (lblApproved.Text == "0")
                {
                    btnDeactive.Visible = true;
                    btnActive.Visible = false;
                    //lblText.Text = "<span class=\"badge badge-soft-danger\">Ngừng kích hoạt</span>";
                    lblText.Text = "<span class=\" text-danger \">Ngừng kích hoạt</span>";
                }
                else
                {
                    btnDeactive.Visible = false;
                    btnActive.Visible = true;
                    //lblText.Text = "<span class=\"badge badge-soft-success\">Đã kích hoạt</span>";
                    lblText.Text = "<span class=\"text-success\">Đã kích hoạt</span>";
                }
            }
        }
    }
}