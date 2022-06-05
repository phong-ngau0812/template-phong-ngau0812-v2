//using DbObj;
//using System;
//using System.Collections.Generic;
//using System.Data;
//using System.IO;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using SystemFrameWork;

//public partial class Backend_Admin_Product_ProductCategory_Edit : System.Web.UI.Page
//{
//	public string title = "Cập nhật danh mục sản phẩm";
//	public string avatar = string.Empty;
//	public int ProductCategory_ID = 0;
//	protected void Page_Load(object sender, EventArgs e)
//	{
//        if (!string.IsNullOrEmpty(Request["ProductCategory_ID"]))
//            ProductCategory_ID = Convert.ToInt32(Request["ProductCategory_ID"].ToString());
//        CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser
//        {
//            BasePath = "/ckfinder"
//        };
//        _FileBrowser.SetupCKEditor(txtDescription);
//        if (!IsPostBack)
//        {
//			LoadCateProduct();
//            FillInfoProductCategory();

//        }
//    }
//    protected DataTable DeQuyDanhMuc(DataTable dt, string Cha, int ParentID)
//    {
//        try
//        {
//            if (ParentID > 0)
//            {

//                DataTable dtChild = new DataTable();
//                dtChild = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable(" Parent_ID =" + ParentID + "  and Status<>-1", " Name ASC");
//                if (dtChild.Rows.Count > 0)
//                {
//                    foreach (DataRow itemChild in dtChild.Rows)
//                    {
//                        DataRow itemNewsCategoryParent = dt.NewRow();
//                        itemNewsCategoryParent["ProductCategory_ID"] = itemChild["ProductCategory_ID"];
//                        itemNewsCategoryParent["Parent_ID"] = ParentID;
//                        itemNewsCategoryParent["Name"] = Cha + " --> " + itemChild["Name"];
//                        itemNewsCategoryParent["Status"] = itemChild["Status"];
//                        itemNewsCategoryParent["Sort"] = itemChild["Sort"];
//                        dt.Rows.Add(itemNewsCategoryParent);
//                        DeQuyDanhMuc(dt, itemNewsCategoryParent["Name"].ToString(), Convert.ToInt32(itemNewsCategoryParent["ProductCategory_ID"]));
//                    }
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("DeQuyDanhMuc", ex.ToString());
//        }
//        return dt;
//    }
//    protected void LoadCateProduct()
//    {
//        try
//        {
//            DataTable dtProductCategoryParent = new DataTable();
//            dtProductCategoryParent.Clear();
//            dtProductCategoryParent.Columns.Add("ProductCategory_ID");
//            dtProductCategoryParent.Columns.Add("Parent_ID");
//            dtProductCategoryParent.Columns.Add("Name");
//            dtProductCategoryParent.Columns.Add("Status");
//            dtProductCategoryParent.Columns.Add("Sort");
//            DataTable dt = new DataTable();
//            dt = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable("Parent_ID=0 and Status <> -1", "ProductCategory_ID ASC");
//            foreach (DataRow item in dt.Rows)
//            {
//                DataRow itemProductCategoryParent = dtProductCategoryParent.NewRow();
//                itemProductCategoryParent["ProductCategory_ID"] = item["ProductCategory_ID"];
//                itemProductCategoryParent["Parent_ID"] = item["Parent_ID"];
//                itemProductCategoryParent["Name"] = "" + item["Name"] + "";
//                itemProductCategoryParent["Status"] = item["Status"];
//                itemProductCategoryParent["Sort"] = item["Sort"];
//                dtProductCategoryParent.Rows.Add(itemProductCategoryParent);
//                DeQuyDanhMuc(dtProductCategoryParent, itemProductCategoryParent["Name"].ToString(), Convert.ToInt32(itemProductCategoryParent["ProductCategory_ID"]));
//            }
//            if (dtProductCategoryParent.Rows.Count > 0)
//            {
//                ddlCate.DataSource = dtProductCategoryParent;

//                ddlCate.DataTextField = "Name";
//                ddlCate.DataValueField = "ProductCategory_ID";
//                ddlCate.DataBind();
//                ddlCate.Items.Insert(0, new ListItem("-- Danh mục --", "0"));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("LoadCateProduct", ex.ToString());
//        }
//    }
//    protected void FillInfoProductCategory()
//    {
//        try
//        {
//            if (ProductCategory_ID > 0)
//            {
//                ProductCategoryRow _ProductCategoryRow = BusinessRulesLocator.GetProductCategoryBO().GetByPrimaryKey(ProductCategory_ID);
//                if (_ProductCategoryRow != null)
//                {
//                    txtTitle.Text = _ProductCategoryRow.IsNameNull ? string.Empty : _ProductCategoryRow.Name;
//                    txtSummary.Text = _ProductCategoryRow.IsSummaryNull ? string.Empty : _ProductCategoryRow.Summary;
//                    txtDescription.Text = _ProductCategoryRow.IsDescriptionNull ? string.Empty : _ProductCategoryRow.Description;
//                    ddlCate.SelectedValue = _ProductCategoryRow.IsParent_IDNull ? "0" : _ProductCategoryRow.Parent_ID.ToString();
//                    ckStatus.Checked = _ProductCategoryRow.Status == 1 ? true : false;
//                    avatar = _ProductCategoryRow.IsImageNull ? "../../images/no-image-icon.png" : _ProductCategoryRow.Image;
//                    ddlLevel.SelectedValue = _ProductCategoryRow.IsLevelNull ? "" : _ProductCategoryRow.Level.ToString();
//                    if (avatar != null)
//                    {
//                        imganh.ImageUrl = avatar;
//                    }
//                    else
//                    {
//                        avatar = "../../images/no-image-icon.png";
//                    }
//                }
//            }

//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillInfoProductCategory", ex.ToString());
//        }
//    }
//    private void UpdateProductCategory()
//    {
//        try
//        {
//            ProductCategoryRow _ProductCategoryRow = BusinessRulesLocator.GetProductCategoryBO().GetByPrimaryKey(ProductCategory_ID);
//            if (_ProductCategoryRow != null)
//            {
//                _ProductCategoryRow.Name = string.IsNullOrEmpty(txtTitle.Text.Trim()) ? "" : txtTitle.Text.Trim();
//                _ProductCategoryRow.Summary = string.IsNullOrEmpty(txtSummary.Text.Trim()) ? "" : txtSummary.Text.Trim();
//                _ProductCategoryRow.Description = string.IsNullOrEmpty(txtDescription.Text.Trim()) ? "" : txtDescription.Text.Trim();
//                _ProductCategoryRow.Status = ckStatus.Checked ? 1 : 0;
//                _ProductCategoryRow.ModifyBy = Convert.ToInt32(Session["SessionUserID"]);
//                _ProductCategoryRow.ModifyDate = DateTime.Now;
//                _ProductCategoryRow.Level = Convert.ToInt32(ddlLevel.SelectedValue);
//                if (ddlCate.SelectedValue != "0")
//                {
//                    _ProductCategoryRow.Parent_ID = Convert.ToInt32(ddlCate.SelectedValue);
//                }
//                else
//                {
//                    _ProductCategoryRow.Parent_ID = 0;
//                }
//                string fileimage = "";
//                if (fulAnh.HasFile)
//                {
//                    //Xóa file
//                    if (!_ProductCategoryRow.IsImageNull)
//                    {
//                        if (_ProductCategoryRow.Image != null)
//                        {
//                            string strFileFullPath = AppDomain.CurrentDomain.BaseDirectory.ToString() + _ProductCategoryRow.Image.Replace("../", "");
//                            if (File.Exists(strFileFullPath))
//                            {
//                                File.Delete(strFileFullPath);
//                            }
//                        }
//                    }
//                    fileimage = "/Backend/data/product" + Common.CreateImgName(fulAnh.FileName);
//                    fulAnh.SaveAs(Server.MapPath(fileimage));
//                    if (!string.IsNullOrEmpty(fileimage))
//                    {
//                        _ProductCategoryRow.Image = fileimage;
//                    }
//                }
//                BusinessRulesLocator.GetProductCategoryBO().Update(_ProductCategoryRow);
//            }

//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("UpdateDocumentCategory", ex.ToString());
//        }
//    }
//    protected void btnSave_Click(object sender, EventArgs e)
//    {
//        try
//        {
//            if (Page.IsValid)
//            {
//                UpdateProductCategory();
//                lblMessage.Text = "Cập nhật thông tin thành công!";
//                lblMessage.Visible = true;
//                FillInfoProductCategory();
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("btnSave_Click", ex.ToString());
//        }
//    }
//    protected void btnBack_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("ProductCategory_List.aspx", false);
//    }

//    protected void ddlCate_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        if (ddlCate.SelectedValue != "0")
//        {
//            string[] listvalue = ddlCate.SelectedItem.Text.Split(' ');
//            int level = 2;
//            foreach (var item in listvalue)
//            {
//                if (item.Contains("-->"))
//                {
//                    level++;
//                }
//            }
//            ddlLevel.SelectedValue = level.ToString();
//        }
//        else
//        {
//            ddlLevel.SelectedValue = "1";
//        }
//    }
//}