//using DbObj;
//using System;
//using System.Collections.Generic;
//using System.Data;
//using System.Globalization;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using SystemFrameWork;

//public partial class Backend_Admin_Product_Product_Add : System.Web.UI.Page
//{
//    public string avatar = "";
//    public int Location_Id;
//    protected void Page_Load(object sender, EventArgs e)
//    {
//        txtBirth.Attributes.Add("readonly", "readonly");
//        CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser();
//        _FileBrowser.BasePath = "/ckfinder";
//        _FileBrowser.SetupCKEditor(txtDescription);

//        if (!Page.IsPostBack)
//        {
//            txtBirth.Text = DateTime.Now.ToString("dd/MM/yyyy");
//            FillLocation();
//            //  FillQuality();
//            FillBrand();
//            LoadCateProduct();
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

//                        DataRow itemProductsCategoryParent = dt.NewRow();
//                        itemProductsCategoryParent["ProductsCategory_ID"] = itemChild["ProductCategory_ID"];
//                        itemProductsCategoryParent["Parent_ID"] = ParentID;
//                        itemProductsCategoryParent["Title"] = Cha + " --> " + itemChild["Name"];
//                        itemProductsCategoryParent["Status"] = itemChild["Status"];
//                        dt.Rows.Add(itemProductsCategoryParent);
//                        DeQuyDanhMuc(dt, itemProductsCategoryParent["Title"].ToString(), Convert.ToInt32(itemProductsCategoryParent["ProductsCategory_ID"]));
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
//            DataTable dtProductsCategoryParent = new DataTable();
//            dtProductsCategoryParent.Clear();
//            dtProductsCategoryParent.Columns.Add("ProductsCategory_ID");
//            dtProductsCategoryParent.Columns.Add("Parent_ID");
//            dtProductsCategoryParent.Columns.Add("Title");
//            dtProductsCategoryParent.Columns.Add("Status");
//            DataTable dt = new DataTable();
//            dt = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable(" Parent_ID=0 and Status<>-1", " ProductCategory_ID ASC");
//            foreach (DataRow item in dt.Rows)
//            {
//                DataRow itemProductsCategoryParent = dtProductsCategoryParent.NewRow();
//                itemProductsCategoryParent["ProductsCategory_ID"] = item["ProductCategory_ID"];
//                itemProductsCategoryParent["Parent_ID"] = item["Parent_ID"];
//                itemProductsCategoryParent["Title"] = "" + item["Name"] + "";
//                itemProductsCategoryParent["Status"] = item["Status"];
//                dtProductsCategoryParent.Rows.Add(itemProductsCategoryParent);
//                DeQuyDanhMuc(dtProductsCategoryParent, itemProductsCategoryParent["Title"].ToString(), Convert.ToInt32(itemProductsCategoryParent["ProductsCategory_ID"]));
//            }

//            if (dtProductsCategoryParent.Rows.Count > 0)
//            {
//                ddlCate.DataSource = dtProductsCategoryParent;
//                ddlCate.DataTextField = "Title";
//                ddlCate.DataValueField = "ProductsCategory_ID";
//                ddlCate.DataBind();
//                ddlCate.Items.Insert(0, new ListItem("-- Danh mục --", ""));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("LoadCateProduct", ex.ToString());
//        }
//    }
//    protected void FillLocation()
//    {
//        try
//        {
//            DataTable dt = BusinessRulesLocator.GetLocationBO().GetAsDataTable(" Location_ID=1", "");
//            if (dt.Rows.Count > 0)
//            {
//                ddlLocation.DataSource = dt;
//                ddlLocation.DataTextField = "Name";
//                ddlLocation.DataValueField = "Location_ID";
//                ddlLocation.DataBind();
//                //ddlLocation.Items.Insert(0, new ListItem("-- Tỉnh thành --", ""));
//                FillDistrict(1);
//                //  ddlDistrict.Items.Insert(0, new ListItem("-- Huyện --", ""));

//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillLocation", ex.ToString());
//        }
//    }
//    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        Location_Id = Convert.ToInt32(ddlLocation.SelectedValue);
//        FillDistrict(Location_Id);

//    }

//    void FillDistrict(int Location_Id)
//    {

//        try
//        {
//            if (Location_Id > 0)
//            {
//                DataTable dt = BusinessRulesLocator.GetDistrictBO().GetAsDataTable("Location_ID = " + Location_Id + "", "");
//                if (dt.Rows.Count > 0)
//                {
//                    ddlDistrict.DataSource = dt;
//                    ddlDistrict.DataTextField = "Name";
//                    ddlDistrict.DataValueField = "District_ID";
//                    ddlDistrict.DataBind();
//                    ddlDistrict.Items.Insert(0, new ListItem("-- Huyện --", ""));

//                }
//            }
//            else
//            {
//                ddlDistrict.Items.Clear();

//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillDistrict", ex.ToString());
//        }
//    }
//    protected void FillProductCategory()
//    {

//    }
//    protected void FillProductType()
//    {

//    }
//    //protected void FillQuality()
//    //{
//    //    try
//    //    {
//    //        DataTable dt = BusinessRulesLocator.GetQualityBO().GetAllAsDataTable();
//    //        if (dt.Rows.Count > 0)
//    //        {
//    //            ddlQuality.DataSource = dt;
//    //            ddlQuality.DataTextField = "Title";
//    //            ddlQuality.DataValueField = "Quality_ID";
//    //            ddlQuality.DataBind();
//    //            ddlQuality.Items.Insert(0, new ListItem("-- Chất lượng --", "0"));
//    //        }
//    //    }
//    //    catch (Exception ex)
//    //    {
//    //        Log.writeLog("FillQuality", ex.ToString());
//    //    }
//    //}

//    protected void FillBrand()
//    {
//        try
//        {
//            DataTable dt = BusinessRulesLocator.GetProductBrandBO().GetAsDataTable(" Status=1", " Title Asc");
//            if (dt.Rows.Count > 0)
//            {
//                ddlProductBrand.DataSource = dt;
//                ddlProductBrand.DataTextField = "Title";
//                ddlProductBrand.DataValueField = "ProductBrand_ID";
//                ddlProductBrand.DataBind();
//                ddlProductBrand.Items.Insert(0, new ListItem("-- Chủ thể --", ""));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillQuality", ex.ToString());
//        }
//    }
//    protected void AddProduct()
//    {
//        try
//        {

//            ProductRow _ProductRow = new ProductRow();
//            _ProductRow.Name = string.IsNullOrEmpty(txtTitle.Text.Trim()) ? "" : txtTitle.Text.Trim();
//            if (ddlLocation.SelectedValue != "")
//            {
//                _ProductRow.Location_ID = Convert.ToInt32(ddlLocation.SelectedValue);
//            }
//            if (ddlDistrict.SelectedValue != "")
//            {
//                _ProductRow.District_ID = Convert.ToInt32(ddlDistrict.SelectedValue);
//            }
//            //if (ddlQuality.SelectedValue != "")
//            //{
//            //    _ProductRow.Quality_ID = Convert.ToInt32(ddlQuality.SelectedValue);
//            //}
//            if (ddlCate.SelectedValue != "")
//            {
//                _ProductRow.ProductCategory_ID = Convert.ToInt32(ddlCate.SelectedValue);
//            }
//            _ProductRow.ProductType_ID = 0;
//            //_ProductRow.Price = Convert.ToDecimal(string.IsNullOrEmpty(txtPrice.Text.Trim()) ? "" : txtPrice.Text.Replace(",", ""));
//            _ProductRow.Description = string.IsNullOrEmpty(txtDescription.Text.Trim()) ? "" : txtDescription.Text.Trim();
//            _ProductRow.Contact = string.IsNullOrEmpty(txtContact.Text.Trim()) ? "" : txtContact.Text.Trim();
//            _ProductRow.No = string.IsNullOrEmpty(txtNo.Text.Trim()) ? "" : txtNo.Text.Trim();
//            _ProductRow.Status = 1;
//            _ProductRow.ProductBrand_ID = Convert.ToInt32(ddlProductBrand.SelectedValue);
//            if (!string.IsNullOrEmpty(txtBirth.Text.Trim()))
//            {
//                DateTime birth = DateTime.ParseExact(txtBirth.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
//                _ProductRow.YearEvaluate = birth;
//            }
//            //_ProductRow.PriceOld = Convert.ToDecimal(string.IsNullOrEmpty(txtPriceOld.Text.Trim()) ? "" : txtPriceOld.Text.Replace(",", ""));
//            _ProductRow.CreateDate = DateTime.Now;
//            _ProductRow.CreateBy = Convert.ToInt32(Session["SessionUserID"]);
//            _ProductRow.Star = Convert.ToInt32(ddlStar.SelectedValue);
//            _ProductRow.IsHome = 0;
//            _ProductRow.IsHot = 0;
//            _ProductRow.Product_Code = string.IsNullOrEmpty(txtProductCode.Text.Trim()) ? "" : txtProductCode.Text.Trim();

//            string fileimage = "";
//            if (fulAnh.HasFile)
//            {
//                fileimage = "/Backend/data/product/" + Common.CreateImgName(fulAnh.FileName);
//                fulAnh.SaveAs(Server.MapPath(fileimage));
//                if (!string.IsNullOrEmpty(fileimage))
//                {
//                    _ProductRow.Image = fileimage;
//                }
//            }
//            string fileimageLabel = "";
//            if (fulAnhLable.HasFile)
//            {
//                fileimageLabel = "/Backend/data/product/" + Common.CreateImgName(fulAnhLable.FileName);
//                fulAnhLable.SaveAs(Server.MapPath(fileimageLabel));
//                if (!string.IsNullOrEmpty(fileimageLabel))
//                {
//                    _ProductRow.ImageLabel = fileimageLabel;
//                }
//            }
//            string fileImageCertificate = "";
//            if (fulAnhCertificate.HasFile)
//            {
//                fileImageCertificate = "/Backend/data/product/" + Common.CreateImgName(fulAnhCertificate.FileName);
//                fulAnhCertificate.SaveAs(Server.MapPath(fileImageCertificate));
//                if (!string.IsNullOrEmpty(fileImageCertificate))
//                {
//                    _ProductRow.ImageCertificate = fileImageCertificate;
//                }
//            }

//            BusinessRulesLocator.GetProductBO().Insert(_ProductRow);
//            //lblMessage.Text = ("Thêm mới thành công!");
//            //lblMessage.Visible = true;
//            //ClearForm();
//            //Response.Redirect("Product_List.aspx", false);

//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("AddProduct", ex.ToString());
//        }
//    }

//    protected void ClearForm()
//    {
//        //txtTitle.Text = txtNote.Text = txtUrl.Text = string.Empty;

//    }

//    protected void btnBack_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("Product_List.aspx", false);
//    }


//    protected void btnSave_Click(object sender, EventArgs e)
//    {
//        try
//        {
//            if (Page.IsValid)
//            {
//                if (Session["SessionUserID"] != null)
//                {
//                    AddProduct();
//                    lblMessage.Text = ("Thêm mới thành công!");
//                    lblMessage.Visible = true;
//                    ClearForm();
//                    Response.Redirect("Product_List.aspx?mode=sc", false);
//                }
//                else
//                {
//                    Response.Redirect("/Backend/Logout.aspx", false);
//                }
//            }

//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("btnSave_Click", ex.ToString());
//        }
//    }
//}