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

//public partial class Backend_Admin_Product_Product_Edit : System.Web.UI.Page
//{
//    public string avatar = "";
//    public int Product_ID;
//    public int Location_Id;
//    public string Image = "";
//    public string ImageLable = "";
//    public string ImageCertificate = "";
//    public string getPrice = string.Empty;

//    protected void Page_Load(object sender, EventArgs e)
//    {
//        txtBirth.Attributes.Add("readonly", "readonly");
//        CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser();
//        _FileBrowser.BasePath = "/ckfinder";
//        _FileBrowser.SetupCKEditor(txtDescription);
//        if (!string.IsNullOrEmpty(Request["Product_ID"]))
//            Product_ID = Convert.ToInt32(Request["Product_ID"].ToString());

//        if (!Page.IsPostBack)
//        {
//            FillLocation();
//            //  FillQuality();
//            LoadCateProduct();
//            FillBrand();
//            FillProduct();
//        }
//    }
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
//            DataTable dt = BusinessRulesLocator.GetLocationBO().GetAllAsDataTable();
//            if (dt.Rows.Count > 0)
//            {
//                ddlLocation.DataSource = dt;
//                ddlLocation.DataTextField = "Name";
//                ddlLocation.DataValueField = "Location_ID";
//                ddlLocation.DataBind();
//                ddlLocation.Items.Insert(0, new ListItem("-- Tỉnh thành --", ""));
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

//    protected void FillProduct()
//    {
//        try
//        {
//            if (Product_ID > 0)
//            {
//                ProductRow _ProductRow = BusinessRulesLocator.GetProductBO().GetByPrimaryKey(Product_ID);
//                if (_ProductRow != null)
//                {
//                    txtTitle.Text = _ProductRow.IsNameNull ? string.Empty : _ProductRow.Name;
//                    if (!_ProductRow.IsLocation_IDNull)
//                    {
//                        ddlLocation.SelectedValue = _ProductRow.Location_ID.ToString();
//                        FillDistrict(_ProductRow.Location_ID);
//                        if (!_ProductRow.IsDistrict_IDNull)
//                        {
//                            ddlDistrict.SelectedValue = _ProductRow.District_ID.ToString();
//                        }
//                    }
//                    //if (!_ProductRow.IsQuality_IDNull)
//                    //{
//                    //    ddlQuality.SelectedValue = _ProductRow.Quality_ID.ToString();
//                    //}

//                    if (!_ProductRow.IsProductCategory_IDNull)
//                    {
//                        ddlCate.SelectedValue = _ProductRow.ProductCategory_ID.ToString();
//                    }

//                    //getPrice = Convert.ToString(_ProductRow.Price);
//                    //CultureInfo cul = CultureInfo.GetCultureInfo("vi-VN");   // try with "en-US"
//                    //string lastPrice = double.Parse(getPrice).ToString("#,###", cul.NumberFormat);
//                    ddlProductBrand.SelectedValue = _ProductRow.IsProductBrand_IDNull ? string.Empty : _ProductRow.ProductBrand_ID.ToString();

//                    txtDescription.Text = _ProductRow.IsDescriptionNull ? string.Empty : _ProductRow.Description;
//                    //txtPriceOld.Text = _ProductRow.IsPriceOldNull ? string.Empty : (_ProductRow.PriceOld.ToString("N0"));
//                    //txtPrice.Text = _ProductRow.IsPriceNull ? string.Empty : (_ProductRow.Price.ToString("N0"));
//                    txtContact.Text = _ProductRow.IsContactNull ? string.Empty : _ProductRow.Contact;
//                    txtNo.Text = _ProductRow.IsNoNull ? string.Empty : _ProductRow.No;
//                    txtProductCode.Text = _ProductRow.IsProduct_CodeNull ? string.Empty : _ProductRow.Product_Code;
//                    Image = _ProductRow.IsImageNull ? "../../images/no-image-icon.png" : _ProductRow.Image;


//                    if (_ProductRow.YearEvaluate != null)
//                        txtBirth.Text = _ProductRow.YearEvaluate.ToString("dd/MM/yyyy");
//                    if (Image != null)
//                    {
//                        imganh.ImageUrl = Image;
//                    }
//                    else
//                    {
//                        Image = "../../images/no-image-icon.png";
//                    }
//                    ImageLable = _ProductRow.IsImageLabelNull ? "../../images/no-image-icon.png" : _ProductRow.ImageLabel;
//                    if (ImageLable != null)
//                    {
//                        Image1.ImageUrl = ImageLable;
//                    }
//                    else
//                    {
//                        Image = "../../images/no-image-icon.png";
//                    }
//                    ImageCertificate = _ProductRow.IsImageCertificateNull ? "../../images/no-image-icon.png" : _ProductRow.ImageCertificate;
//                    if (ImageCertificate != null)
//                    {
//                        Image2.ImageUrl = ImageCertificate;
//                    }
//                    else
//                    {
//                        Image = "../../images/no-image-icon.png";
//                    }
//                    ckStatus.Checked = _ProductRow.IsStatusNull ? false : true;
//                    if (!_ProductRow.IsStarNull)
//                    {
//                        ddlStar.SelectedValue = _ProductRow.Star.ToString();
//                    }
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillProduct", ex.ToString());
//        }
//    }


//    protected void EditProduct()
//    {
//        try
//        {
//            ProductRow _ProductRow = new ProductRow();
//            _ProductRow = BusinessRulesLocator.GetProductBO().GetByPrimaryKey(Product_ID);
//            if (_ProductRow != null)
//            {

//                _ProductRow.Name = string.IsNullOrEmpty(txtTitle.Text.Trim()) ? "" : txtTitle.Text.Trim();
//                if (ddlLocation.SelectedValue != "")
//                {
//                    _ProductRow.Location_ID = Convert.ToInt32(ddlLocation.SelectedValue);
//                }
//                if (ddlDistrict.SelectedValue != "")
//                {
//                    _ProductRow.District_ID = Convert.ToInt32(ddlDistrict.SelectedValue);
//                }
//                //if (ddlQuality.SelectedValue != "")
//                //{
//                //    _ProductRow.Quality_ID = Convert.ToInt32(ddlQuality.SelectedValue);
//                //}
//                if (ddlCate.SelectedValue != "")
//                {
//                    _ProductRow.ProductCategory_ID = Convert.ToInt32(ddlCate.SelectedValue);
//                }
//                _ProductRow.ProductType_ID = 0;

//                _ProductRow.ProductBrand_ID = Convert.ToInt32(ddlProductBrand.SelectedValue);


//                //_ProductRow.Price = Convert.ToDecimal(string.IsNullOrEmpty(txtPrice.Text.Trim()) ? "" : txtPrice.Text.Replace(",", ""));
//                //_ProductRow.PriceOld = Convert.ToDecimal(string.IsNullOrEmpty(txtPriceOld.Text.Trim()) ? "" : txtPriceOld.Text.Replace(",", ""));

//                if (!string.IsNullOrEmpty(txtBirth.Text.Trim()))
//                {
//                    DateTime birth = DateTime.ParseExact(txtBirth.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
//                    _ProductRow.YearEvaluate = birth;
//                }
//                //_ProductRow.ProductBrandName = string.IsNullOrEmpty(txtProductBrandName.Text.Trim()) ? "" : txtProductBrandName.Text.Trim();

//                _ProductRow.Description = string.IsNullOrEmpty(txtDescription.Text.Trim()) ? "" : txtDescription.Text.Trim();
//                _ProductRow.Contact = string.IsNullOrEmpty(txtContact.Text.Trim()) ? "" : txtContact.Text.Trim();
//                _ProductRow.No = string.IsNullOrEmpty(txtNo.Text.Trim()) ? "" : txtNo.Text.Trim();
//                _ProductRow.Status = ckStatus.Checked ? 1 : 0;
//                _ProductRow.ModifyDate = DateTime.Now;
//                _ProductRow.Star = Convert.ToInt32(ddlStar.SelectedValue);
//                _ProductRow.ModifyBy = Convert.ToInt32(Session["SessionUserID"]);
//                _ProductRow.Product_Code = string.IsNullOrEmpty(txtProductCode.Text.Trim()) ? "" : txtProductCode.Text.Trim();
//                string fileimage = "";
//                if (fulAnh.HasFile)
//                {
//                    fileimage = "/Backend/data/product/" + Common.CreateImgName(fulAnh.FileName);
//                    fulAnh.SaveAs(Server.MapPath(fileimage));
//                    if (!string.IsNullOrEmpty(fileimage))
//                    {
//                        _ProductRow.Image = fileimage;
//                    }
//                }
//                string fileimageLabel = "";
//                if (fulAnhLable.HasFile)
//                {
//                    fileimageLabel = "/Backend/data/product/" + Common.CreateImgName(fulAnhLable.FileName);
//                    fulAnhLable.SaveAs(Server.MapPath(fileimageLabel));
//                    if (!string.IsNullOrEmpty(fileimageLabel))
//                    {
//                        _ProductRow.ImageLabel = fileimageLabel;
//                    }
//                }
//                string fileImageCertificate = "";
//                if (fulAnhCertificate.HasFile)
//                {
//                    fileImageCertificate = "/Backend/data/product/" + Common.CreateImgName(fulAnhCertificate.FileName);
//                    fulAnhCertificate.SaveAs(Server.MapPath(fileImageCertificate));
//                    if (!string.IsNullOrEmpty(fileImageCertificate))
//                    {
//                        _ProductRow.ImageCertificate = fileImageCertificate;
//                    }
//                }

//                BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                //lblMessage.Text = ("Cập nhật thành công");
//                //lblMessage.Visible = true;
//                //ClearForm();
//                //Response.Redirect("Product_List.aspx", false);
//            }

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
//                    EditProduct();
//                    lblMessage.Text = "Thêm mới thành công!";
//                    lblMessage.Visible = true;
//                    ClearForm();
//                    Response.Redirect("Product_List.aspx?modeE=sc", false);
//                }
//                else
//                {
//                    Response.Redirect("/Backend/Login.aspx", false);
//                }
//            }

//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("btnSave_Click", ex.ToString());
//        }
//    }
//}