using DbObj;
using evointernal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using SystemFrameWork;
using Telerik.Web.UI;

public partial class User_Edit : System.Web.UI.Page
{
    public int User_Id = 0;
    public string title = "Thông tin tài khoản";
    public string avatar = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        txtBirth.Attributes.Add("readonly", "readonly");
        if (!string.IsNullOrEmpty(Request["User_Id"]))
            User_Id = Convert.ToInt32(Request["User_Id"].ToString());

        if (!IsPostBack)
        {
            FillInfoUser();
        }
    }

    protected void FillInfoUser()
    {
        try
        {
            if (User_Id > 0)
            {
                UserRow _UserRow = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(User_Id);
                if (_UserRow != null)
                {
                    txtUser.Text = _UserRow.IsUserNameNull ? string.Empty : _UserRow.UserName;
                    txtFullName.Text = _UserRow.IsFullNameNull ? string.Empty : _UserRow.FullName;
                    txtPhone.Text = _UserRow.IsPhoneNull ? string.Empty : _UserRow.Phone;
                    txtEmail.Text = _UserRow.IsEmailNull ? string.Empty : _UserRow.Email;
                    txtAddress.Text = _UserRow.IsAddressNull ? string.Empty : _UserRow.Address;
                    if (!_UserRow.IsGenderNull)
                    {
                        ddlGioiTinh.SelectedValue = _UserRow.Gender.ToString();
                    }
                    if (_UserRow.BirthDay != null)
                        txtBirth.Text = _UserRow.BirthDay.ToString("dd/MM/yyyy");
                    avatar = _UserRow.IsAvatarNull? "../../images/no-image-icon.png" : _UserRow.Avatar;
                    if (avatar != null)
                    {
                        imganh.ImageUrl = avatar;
                    }
                    else
                    {
                        avatar = "../../images/no-image-icon.png";
                    }
                }
            }
          
        }
        catch (Exception ex)
        {
            Log.writeLog("FillInfoUser", ex.ToString());
        }
    }



    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Default.aspx", false);
        }
        catch (Exception ex)
        {
            Log.writeLog("btnReset_Click", ex.ToString());
        }
    }

    private void UpdateUser()
    {
        try
        {
            UserRow _UserRow = BusinessRulesLocator.GetUserBO().GetByPrimaryKey(User_Id);
            if (_UserRow != null)
            {
                _UserRow.FullName = string.IsNullOrEmpty(txtFullName.Text.Trim()) ? "" : txtFullName.Text.Trim();
                _UserRow.Email = string.IsNullOrEmpty(txtEmail.Text.Trim()) ? "" : txtEmail.Text.Trim();
                _UserRow.Address = string.IsNullOrEmpty(txtAddress.Text.Trim()) ? "" : txtAddress.Text.Trim();
                _UserRow.Phone = string.IsNullOrEmpty(txtPhone.Text.Trim()) ? "" : txtPhone.Text.Trim();
                if (!string.IsNullOrEmpty(txtBirth.Text.Trim()))
                {
                    DateTime birth = DateTime.ParseExact(txtBirth.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    _UserRow.BirthDay = birth;
                }
                _UserRow.ModifyBy = Convert.ToInt32(Session["SessionUserID"]);
                _UserRow.ModifyDate = DateTime.Now;
                if (ddlGioiTinh.SelectedValue != "-1")
                {
                    _UserRow.Gender = Convert.ToInt32(ddlGioiTinh.SelectedValue);
                }
                string fileimage = "";
                if (fulAnh.HasFile)
                {
                    fileimage = "/Backend/data/user/" + Common.CreateImgName(fulAnh.FileName);
                    fulAnh.SaveAs(Server.MapPath(fileimage));
                    if (!string.IsNullOrEmpty(fileimage))
                    {
                        _UserRow.Avatar = fileimage;
                    }
                }
                BusinessRulesLocator.GetUserBO().Update(_UserRow);
            }
            
        }
        catch (Exception ex)
        {
            Log.writeLog("UpdateUser", ex.ToString());
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                if (Session["SessionUserID"] != null)
                {
                    UpdateUser();
                    lblMessage.Text = "Cập nhật thông tin thành công!";
                    lblMessage.Visible = true;
                    FillInfoUser();
                }
                else
                {
                    Response.Redirect("/Backend/Login.aspx", false);
                }
            }
        }
        catch (Exception ex)
        {
            Log.writeLog("btnSave_Click", ex.ToString());
        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("User_List.aspx", false);
    }

}