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

//public partial class Backend_Admin_Product_Product_List : System.Web.UI.Page
//{
//    public int Location_Id;
//    protected void Page_Load(object sender, EventArgs e)
//    {
//        if (Request.QueryString["mode"] != null)
//        {
//            lblMessage.Text = "Thêm mới sản phẩm thành công!";
//            lblMessage.Visible = true;
//            //Request.QueryString.Remove("mode");
//        }
//        if (Request.QueryString["modeE"] != null)
//        {
//            lblMessage.Text = "Cập nhật sản phẩm thành công!";
//            lblMessage.Visible = true;
//            //Request.QueryString.Remove("modeE");
//        }
//        if (!Page.IsPostBack)
//        {
//            FillBrand();
//            FillDistrict();
//            LoadCateProduct();
//            LoadProduct();
           
//        }
//    }
//    protected DataTable DeQuyDanhMuc(DataTable dt, int ParentID)
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
//                        if (itemChild["Level"].ToString() == "2")
//                        {
//                            itemProductsCategoryParent["Title"] = "--- " + itemChild["Name"];
//                        }
//                        if (itemChild["Level"].ToString() == "3")
//                        {
//                            itemProductsCategoryParent["Title"] = "------ " + itemChild["Name"];
//                        }
//                        itemProductsCategoryParent["Status"] = itemChild["Status"];
//                        dt.Rows.Add(itemProductsCategoryParent);
//                        DeQuyDanhMuc(dt, Convert.ToInt32(itemProductsCategoryParent["ProductsCategory_ID"]));
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
//            dt = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable(" Parent_ID=0 and Status=1", " ProductCategory_ID ASC");
//            foreach (DataRow item in dt.Rows)
//            {
//                DataRow itemProductsCategoryParent = dtProductsCategoryParent.NewRow();
//                itemProductsCategoryParent["ProductsCategory_ID"] = item["ProductCategory_ID"];
//                itemProductsCategoryParent["Parent_ID"] = item["Parent_ID"];
//                itemProductsCategoryParent["Title"] = "" + item["Name"] + "";
//                itemProductsCategoryParent["Status"] = item["Status"];
//                dtProductsCategoryParent.Rows.Add(itemProductsCategoryParent);
//                DeQuyDanhMuc(dtProductsCategoryParent, Convert.ToInt32(itemProductsCategoryParent["ProductsCategory_ID"]));
//            }

//            if (dtProductsCategoryParent.Rows.Count > 0)
//            {
//                ddlCate.DataSource = dtProductsCategoryParent;
//                ddlCate.DataTextField = "Title";
//                ddlCate.DataValueField = "ProductsCategory_ID";
//                ddlCate.DataBind();
//                ddlCate.Items.Insert(0, new ListItem("-- Danh mục --", "0"));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("LoadCateProduct", ex.ToString());
//        }
//    }
//    //    protected void FillLocation()
//    //{
//    //    try
//    //    {
//    //        DataTable dt = BusinessRulesLocator.GetLocationBO().GetAllAsDataTable();
//    //        if (dt.Rows.Count > 0)
//    //        {
//    //            ddlLocation.DataSource = dt;
//    //            ddlLocation.DataTextField = "Name";
//    //            ddlLocation.DataValueField = "Location_ID";
//    //            ddlLocation.DataBind();
//    //            ddlLocation.Items.Insert(0, new ListItem("-- Tỉnh thành --", "0"));
//    //        }
//    //    }
//    //    catch (Exception ex)
//    //    {
//    //        Log.writeLog("FillLocation", ex.ToString());
//    //    }
//    //}
//    //protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
//    //{
//    //    Location_Id = Convert.ToInt32(ddlLocation.SelectedValue);
//    //    FillDistrict(Location_Id);
//    //    LoadProduct();
//    //}
//    void FillDistrict()
//    {
//        try
//        {
//            DataTable dt = BusinessRulesLocator.GetDistrictBO().GetAsDataTable("Location_ID =1", "");
//            if (dt.Rows.Count > 0)
//            {
//                ddlDistrict.DataSource = dt;
//                ddlDistrict.DataTextField = "Name";
//                ddlDistrict.DataValueField = "District_ID";
//                ddlDistrict.DataBind();
//                ddlDistrict.Items.Insert(0, new ListItem("-- Huyện --", "0"));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillDistrict", ex.ToString());
//        }
//    }
//    //    protected void LoadProduct()
//    //    {
//    //        try
//    //        {
//    //            string where = "";
//    //            string sub = "";
//    //            //if (ddlLocation.SelectedValue != "0")
//    //            //{
//    //            //    where += " and p.Location_ID = " + ddlLocation.SelectedValue;
//    //            //}
//    //            if (ddlDistrict.SelectedValue != "0" && ddlDistrict.SelectedValue != "")
//    //            {
//    //                where += " and d.District_ID = " + ddlDistrict.SelectedValue;
//    //            }
//    //            if (ddlProductBrand.SelectedValue != "0")
//    //            {
//    //                where += " and p.ProductBrand_ID = " + ddlProductBrand.SelectedValue;
//    //            }
//    //            if (ddlStar.SelectedValue != "0")
//    //            {
//    //                where += " and p.Star = " + ddlStar.SelectedValue;
//    //            }
//    //            if (txtName.Text != "")
//    //            {
//    //                where += " and p.Name like  N'%" + txtName.Text.Trim() + "%'";
//    //            }
//    //            if (ddlCate.SelectedValue != "0" && ddlCate.SelectedValue != "")
//    //            {
//    //                where += " and pc.ProductCategory_ID = " + ddlCate.SelectedValue;
//    //                sub = "or pc.ProductCategory_ID in (Select ProductCategory_ID from ProductCategory where Parent_ID = " + ddlCate.SelectedValue + ")";
//    //            }

//    //            DataTable dt = new DataTable();
//    //            dt = BusinessRulesLocator.Conllection().GetAllList(@"    Select p.Product_ID as Product_ID,p.Name as ProductName,U.FullName,P.IsHome,P.Status, p.Price as Price,P.ModifyDate,pc.Name as CateName,d.Name as District,
//    //p.Image as Image from Product p 
//    //left join ProductBrand PB on PB.ProductBrand_ID=P.ProductBrand_ID
//    //left join District d on PB.District_ID = d.District_ID 
//    //left join [User] U on U.User_ID = P.CreateBy
//    //left join ProductCategory pc on p.ProductCategory_ID = pc.ProductCategory_ID  where p.Status <>- 1 " + where + sub);
//    //            rptBNN_Product.DataSource = dt;
//    //            rptBNN_Product.DataBind();
//    //        }
//    //        catch (Exception ex)
//    //        {
//    //            Log.writeLog("LoadProduct", ex.ToString());
//    //        }
//    //    }
//    public int TotalPage = 1;
//    public int TotalItem = 0;
//    int pageSize = 10;//Số bản ghi 1 trang
//    private void LoadProduct()
//    {
//        try
//        {
//            //pageSize = Convert.ToInt32(ddlItem.SelectedValue);
//            Pager1.PageSize = pageSize = Convert.ToInt32(ddlItem.SelectedValue);
//            DataSet dtSet = new DataSet();
//            DataTable dt = new DataTable();
//            dtSet = BusinessRulesLocator.Conllection().GetProductBackend_Paging(Pager1.CurrentIndex, pageSize, 7, txtName.Text.Trim(), Convert.ToInt32(ddlProductBrand.SelectedValue), Convert.ToInt32(ddlCate.SelectedValue), Convert.ToInt32( ddlDistrict.SelectedValue), Convert.ToInt32(ddlStar.SelectedValue),0, ctlDatePicker1.FromDate, ctlDatePicker1.ToDate,"","");
//            grdProduct.DataSource = dtSet.Tables[0];
//            grdProduct.DataBind();
//            if (dtSet.Tables[0].Rows.Count > 0)
//            {
//                TotalItem = Convert.ToInt32(dtSet.Tables[1].Rows[0]["TotalRecord"]);
//                if (Convert.ToInt32(dtSet.Tables[1].Rows[0]["TotalRecord"]) % pageSize != 0)
//                {
//                    TotalPage = (Convert.ToInt32(dtSet.Tables[1].Rows[0]["TotalRecord"]) / pageSize) + 1;
//                }
//                else
//                {
//                    TotalPage = Convert.ToInt32(dtSet.Tables[1].Rows[0]["TotalRecord"]) / pageSize;
//                }
//                Pager1.ItemCount = Convert.ToInt32(dtSet.Tables[1].Rows[0]["TotalRecord"]);
//                x_box_pager.Visible = Pager1.ItemCount > pageSize ? true : false;
//            }
//            else
//            {
//                x_box_pager.Visible = false;
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("LoadProduct", ex.ToString());
//        }
//    }
//    protected void Pager1_Command(object sender, CommandEventArgs e)
//    {
//        int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
//        Pager1.CurrentIndex = currnetPageIndx;
//        LoadProduct();
//        lblMessage.Visible = false;
//    }
//    protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        LoadProduct();
//        lblMessage.Visible = false;
//    }
//    protected void btnSearch_Click(object sender, EventArgs e)
//    {

//        LoadProduct();
//        lblMessage.Visible = false;
//    }
//    protected void btnAdd_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("Product_Add.aspx", false);
//    }
  
//    protected void ddlItem_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        LoadProduct();
//        lblMessage.Visible = false;
//    }
//    protected void rptBNN_Product_ItemCommand(object source, RepeaterCommandEventArgs e)
//    {
//        int Product_ID = Convert.ToInt32(e.CommandArgument);
//        ProductRow _ProductRow = new ProductRow();
//        _ProductRow = BusinessRulesLocator.GetProductBO().GetByPrimaryKey(Product_ID);
//        if (_ProductRow != null)
//        {
//            switch (e.CommandName)
//            {
//                case "Delete":

//                    _ProductRow.Status = -1;
//                    BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                    lblMessage.Text = ("Xóa bản ghi thành công !");
//                    break;
//                case "Active":
//                    _ProductRow.Status = 1;
//                    BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                    lblMessage.Text = ("Kích hoạt thành công !");
//                    lblMessage.Visible = true;
//                    break;
//                case "Deactive":
//                    _ProductRow.Status = 0;
//                    BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                    lblMessage.Text = ("Ngừng kích hoạt thành công !");
//                    lblMessage.Visible = true;
//                    break;
//                case "ActiveHome":
//                    _ProductRow.IsHome = 1;
//                    BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                    lblMessage.Text = ("Kích hoạt thành công !");
//                    lblMessage.Visible = true;
//                    break;
//                case "DeactiveHome":
//                    _ProductRow.IsHome = 0;
//                    BusinessRulesLocator.GetProductBO().Update(_ProductRow);
//                    lblMessage.Text = ("Ngừng kích hoạt thành công !");
//                    lblMessage.Visible = true;
//                    break;
//            }
//        }
//        lblMessage.Visible = true;
//        LoadProduct();
//    }
//    protected void ddlCate_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        LoadProduct();
//        lblMessage.Visible = false;
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
//                ddlProductBrand.Items.Insert(0, new ListItem("-- Chủ thể --", "0"));
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("FillQuality", ex.ToString());
//        }
//    }

//    protected void ddlBrand_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        LoadProduct();
//        lblMessage.Visible = false;
//    }

//    protected void rptBNN_Product_ItemDataBound(object sender, RepeaterItemEventArgs e)
//    {
//        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
//        {
//            Literal lblApproved = e.Item.FindControl("lblApproved") as Literal;
//            Literal lblHome = e.Item.FindControl("lblHome") as Literal;
//            Literal lblHot = e.Item.FindControl("lblHot") as Literal;
//            LinkButton btnActive = e.Item.FindControl("btnActive") as LinkButton;
//            LinkButton btnDeactive = e.Item.FindControl("btnDeactive") as LinkButton;

//            LinkButton btnActiveHome = e.Item.FindControl("btnActiveHome") as LinkButton;
//            LinkButton btnDeactiveHome = e.Item.FindControl("btnDeactiveHome") as LinkButton;


//            //Literal lblText = e.Item.FindControl("lblText") as Literal;
//            if (lblApproved != null)
//            {
//                if (lblApproved.Text == "0")
//                {
//                    btnDeactive.Visible = true;
//                    btnActive.Visible = false;
//                    //lblText.Text = "<span class=\"badge badge-soft-danger\">Ngừng kích hoạt</span>";
//                    //lblText.Text = "<span class=\" text-danger \">Ngừng kích hoạt</span>";
//                }
//                else

//                {
//                    btnDeactive.Visible = false;
//                    btnActive.Visible = true;
//                    //lblText.Text = "<span class=\"badge badge-soft-success\">Đã kích hoạt</span>";
//                    //lblText.Text = "<span class=\"text-success\">Đã kích hoạt</span>";
//                }
//            }

//            if (lblHome != null)
//            {
//                if (lblHome.Text == "0")
//                {
//                    btnDeactiveHome.Visible = false;
//                    btnActiveHome.Visible = true;
//                    //lblText.Text = "<span class=\"badge badge-soft-danger\">Ngừng kích hoạt</span>";
//                }
//                else
//                {
//                    btnDeactiveHome.Visible = true;
//                    btnActiveHome.Visible = false;
//                    //lblText.Text = "<span class=\"badge badge-soft-success\">Đã kích hoạt</span>";
//                }
//            }

//        }
//    }
//    protected void ctlDatePicker1_DateChange(object sender, EventArgs e)
//    {
//        if (IsPostBack)
//        {
//            Pager1.CurrentIndex = 1;
//            LoadProduct();
//            lblMessage.Visible = false;
//        }
//    }

//    protected void ddlStar_SelectedIndexChanged(object sender, EventArgs e)
//    {
//        LoadProduct();
//        lblMessage.Visible = false;
//    }
//    protected void ExportFile()
//    {


//        string ASProductBrandName = "";


//        if (ddlProductBrand.SelectedValue != "0")
//        {

//            ASProductBrandName += "DANH SÁCH SẢN PHẨM" + " ( chủ thể:" + ddlProductBrand.SelectedItem.ToString() + ")\n";
//        }
//        else
//        {
//            ASProductBrandName += "DANH SÁCH TẤT CẢ CÁC SẢN PHẨM \n ";
//        }
//        DataTable dt = new DataTable();

//        dt = BusinessRulesLocator.Conllection().GetProductBackend_Paging(1, 10000, 100000, txtName.Text.Trim(), Convert.ToInt32(ddlProductBrand.SelectedValue), Convert.ToInt32(ddlCate.SelectedValue), Convert.ToInt32(ddlDistrict.SelectedValue), Convert.ToInt32(ddlStar.SelectedValue), 0, ctlDatePicker1.FromDate, ctlDatePicker1.ToDate, "", "").Tables[0];
//        //remove productid,image, status, sort, createdate,modifydate,is home, districtid, districtname,nguoitao,nguoisua
//        dt.Columns.Remove("Product_ID");
//        dt.Columns.Remove("Image");
//        dt.Columns.Remove("Status");
//        dt.Columns.Remove("Sort");
//        dt.Columns.Remove("CreateDate");
//        dt.Columns.Remove("ModifyDate");
//        dt.Columns.Remove("IsHome");
//        dt.Columns.Remove("District_ID");
//        dt.Columns.Remove("DistrictName");
//        dt.Columns.Remove("NguoiTao");
//        dt.Columns.Remove("NguoiSua");
//        //rename rownum,productname,star,catename,productbrandname,no
//        dt.Columns["RowNum"].ColumnName = "STT";
//        dt.Columns["ProductName"].ColumnName = "Tên sản phẩm";
//        dt.Columns["Star"].ColumnName = "Số sao";
//        dt.Columns["No"].ColumnName = "Số quyết định";
//        dt.Columns["CateName"].ColumnName = "Nhóm SP";
//        dt.Columns["ProductBrandName"].ColumnName = "Tên Chủ thể";
//        dt.AcceptChanges();

//        string tab = ASProductBrandName + "<br>";
//        tab += "(Tổng: " + dt.Rows.Count + ")<br><br>";
//        GridView gvDetails = new GridView();

//        gvDetails.DataSource = dt;

//        gvDetails.AllowPaging = false;

//        gvDetails.DataBind();

//        Response.ClearContent();
//        Response.Buffer = true;
//        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "danh-sach-san-pham.xls"));
//        Response.ContentEncoding = System.Text.Encoding.Unicode;
//        Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
//        Response.ContentType = "application/vnd.ms-excel";
//        StringWriter sw = new StringWriter();
//        HtmlTextWriter htw = new HtmlTextWriter(sw);



//        //Change the Header Row back to white color
//        // gvDetails.HeaderRow.Style.Add("background-color", "#7e94eb");
//        gvDetails.HeaderRow.Style.Add("color", "#fff");
//        //Applying stlye to gridview header cells
//        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
//        {
//            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#7e94eb");
//        }
//        gvDetails.RenderControl(htw);

//        Response.Write(tab + sw.ToString());
//        Response.End();
//    }
//    protected void btnExportFile_Click(object sender, EventArgs e)
//    {
//        ExportFile();
//    }
//}