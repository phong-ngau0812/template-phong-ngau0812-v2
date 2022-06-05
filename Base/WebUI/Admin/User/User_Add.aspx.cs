using DbObj;
using evointernal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using SystemFrameWork;
using Telerik.Web.UI;

public partial class User_Add : System.Web.UI.Page
{
    public string title = "Thêm mới tài khoản";
    public string avatar = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        txtBirth.Attributes.Add("readonly", "readonly");
        if (!IsPostBack)
        {
        }
        lblMessage.Text = lblMessage1.Text = "";
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                if (Session["SessionUserID"] != null)
                {
                    DataTable dt = BusinessRulesLocator.GetUserBO().GetAsDataTable(" UserName='" + txtUser.Text.Trim() + "' and Status<>-1", " ");
                    if (dt.Rows.Count == 0)
                    {
                        UserRow _UserRow = new UserRow();
                        _UserRow.UserName = string.IsNullOrEmpty(txtUser.Text.Trim()) ? "" : txtUser.Text.Trim();
                        _UserRow.FullName = string.IsNullOrEmpty(txtFullName.Text.Trim()) ? "" : txtFullName.Text.Trim();
                        _UserRow.Email = string.IsNullOrEmpty(txtEmail.Text.Trim()) ? "" : txtFullName.Text.Trim();
                        _UserRow.Address = string.IsNullOrEmpty(txtAddress.Text.Trim()) ? "" : txtAddress.Text.Trim();
                        _UserRow.Phone = string.IsNullOrEmpty(txtPhone.Text.Trim()) ? "" : txtPhone.Text.Trim();
                        _UserRow.Password = Common.MD5Decrypt(txtPass.Text.Trim());
                        if (!string.IsNullOrEmpty(txtBirth.Text.Trim()))
                        {
                            DateTime birth = DateTime.ParseExact(txtBirth.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                            _UserRow.BirthDay = birth;
                        }
                        _UserRow.Status = 1;
                        _UserRow.CreateBy = Convert.ToInt32(Session["SessionUserID"]);
                        _UserRow.CreateDate = DateTime.Now;
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
                        BusinessRulesLocator.GetUserBO().Insert(_UserRow);
                        Response.Redirect("User_List.aspx", false);
                    }
                    else
                    {
                        lblMessage.Text = "Tài khoản " + txtUser.Text + " đã tồn tại trên hệ thống, vui lòng nhập tên khác !!!";
                        lblMessage.Visible = true;
                        lblMessage.Style.Add("background", "wheat");
                        lblMessage.ForeColor = Color.Red;
                    }
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