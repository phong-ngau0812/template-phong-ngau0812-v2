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

public partial class User_ChangePassword : System.Web.UI.Page
{
    public string username;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
    }
    protected void CancelPushButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("User_List.aspx", false);
    }

    protected bool CheckOldPassword()
    {
        bool bvalue = false;
        try
        {
            UserRow _UserRow = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(Convert.ToInt32(Session["SessionUserID"]));
            if (_UserRow != null)
            {
                string pass = Common.MD5Decrypt(CurrentPassword.Text);
                if (_UserRow.Password.ToUpper().Equals(pass.ToUpper()))
                    bvalue = true;
            }
        }
        catch (Exception ex)
        {
            Log.writeLog(ex.ToString(), "CheckOldPassword");
        }
        return bvalue;
    }
    protected UserRow GetInfoUserById(int _Id)
    {
        UserRow _tblUserRow = new UserRow();
        try
        {
            _tblUserRow = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(_Id);
        }
        catch (Exception ex)
        {
            Log.writeLog("GetInfoUserById", ex.ToString());
        }
        return _tblUserRow;
    }

    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                if (CheckOldPassword())
                {
                    UserRow _UserRow = GetInfoUserById(Convert.ToInt32(Session["SessionUserID"]));
                    if (_UserRow != null)
                    {
                        _UserRow.Password = Common.MD5Decrypt(NewPasswordRequired.Text);
                        if (BusinessRulesLocator.GetUserBO().Update(_UserRow))
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Thay đổi mật khẩu thành công!";
                        }
                        else
                        {
                            lblMessage.Text = "Thay đổi mật khẩu thất bại!";
                            lblMessage.Visible = true;
                        }
                    }
                }
                else
                {
                    lblMessage.Text = "Mật khẩu cũ không chính xác!";
                }
            }
        }
        catch (Exception ex)
        {
            Log.writeLog("btnSave_Click", ex.ToString());
        }
    }
}