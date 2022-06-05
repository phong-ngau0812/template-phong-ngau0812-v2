//using DbObj;
//using System;
//using System.Collections.Generic;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using SystemFrameWork;

//public partial class Backend_Admin_Product_ProductCategory : System.Web.UI.Page
//{
//    protected void Page_Load(object sender, EventArgs e)
//    {
//		if (!IsPostBack)
//		{
//            LoadProductCategoty();
//        }
//        ResetMsg();
//    }
//    protected void ResetMsg()
//    {
//        lblMessage.Text = "";
//        lblMessage.Visible = false;
//    }
//    public string Level(string level)
//    {
//        string html = string.Empty;
//        if (level == "2")
//        {
//            html = " <span style='color:red;'>  --  </span> ";
//        }
//        if (level == "3")
//        {
//            html = " <span style='color:red;'>  ----  </span> ";
//        }
//        return html;
//    }
//    protected DataTable DeQuyDanhMuc(DataTable dt, int ParentID)
//    {
//		try
//		{
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
//                        itemNewsCategoryParent["Name"] = Level(itemChild["Level"].ToString()) + itemChild["Name"];
//                        itemNewsCategoryParent["Status"] = itemChild["Status"];
//                        itemNewsCategoryParent["Sort"] = itemChild["Sort"];
//                        dt.Rows.Add(itemNewsCategoryParent);
//                        DeQuyDanhMuc(dt,  Convert.ToInt32(itemNewsCategoryParent["ProductCategory_ID"]));
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
//    protected void LoadProductCategoty()
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
//                itemProductCategoryParent["Name"] = "<b>" + item["Name"] + "</b>";
//                itemProductCategoryParent["Status"] = item["Status"];
//                itemProductCategoryParent["Sort"] = item["Sort"];
//                dtProductCategoryParent.Rows.Add(itemProductCategoryParent);
//                DeQuyDanhMuc(dtProductCategoryParent,Convert.ToInt32(itemProductCategoryParent["ProductCategory_ID"]));
//            }
//            rptProductCategory.DataSource = dtProductCategoryParent;
//            rptProductCategory.DataBind();
//        }
//        catch (Exception ex)
//        {

//            Log.writeLog("LoadProductCategoty", ex.ToString());
//        }
//    }

//    protected void btnAdd_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("ProductCategory_Add.aspx", false);
//    }
//    protected void rptProductCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
//    {
//        try
//        {
//            int ProductCategory_ID = Convert.ToInt32(e.CommandArgument.ToString());
//            ProductCategoryRow u = new ProductCategoryRow();
//            u = BusinessRulesLocator.GetProductCategoryBO().GetByPrimaryKey(ProductCategory_ID);
//            if (u != null)
//            {
//                switch (e.CommandName)
//                {
//                    case "Delete":
//                        u.Status = -1;
//                        BusinessRulesLocator.GetProductCategoryBO().Update(u);
//                        lblMessage.Text = ("Xóa bản ghi thành công !");
//                        lblMessage.Visible = true;
//                        break;
//                    case "Active":
//                        u.Status = 1;
//                        BusinessRulesLocator.GetProductCategoryBO().Update(u);
//                        lblMessage.Text = ("Kích hoạt thành công !");
//                        lblMessage.Visible = true;
//                        break;
//                    case "Deactive":
//                        u.Status = 0;
//                        BusinessRulesLocator.GetProductCategoryBO().Update(u);
//                        lblMessage.Text = ("Ngừng kích hoạt thành công !");
//                        lblMessage.Visible = true;
//                        break;
//                }
//            }
//            LoadProductCategoty();
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("rptProductCategory_ItemCommand", ex.ToString());
//        }
//    }
//    protected void rptProductCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
//    {
//        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
//        {
//            Literal lblApproved = e.Item.FindControl("lblApproved") as Literal;
//            LinkButton btnActive = e.Item.FindControl("btnActive") as LinkButton;
//            LinkButton btnDeactive = e.Item.FindControl("btnDeactive") as LinkButton;
//            // CheckBox ckActive = e.Item.FindControl("ckActive") as CheckBox;
//            Literal lblText = e.Item.FindControl("lblText") as Literal;
//            TextBox txtSort = e.Item.FindControl("txtSort") as TextBox;
//            Literal lblSort = e.Item.FindControl("lblSort") as Literal;
//            if (lblSort != null)
//            {
//                if (!string.IsNullOrEmpty(lblSort.Text))
//                {
//                    txtSort.Text = lblSort.Text;
//                }
//            }
//            if (lblApproved != null)
//            {
//                if (lblApproved.Text == "0")
//                {
//                    btnDeactive.Visible = true;
//                    btnActive.Visible = false;
//                    //lblText.Text = "<span class=\"badge badge-soft-danger\">Ngừng kích hoạt</span>";
//                    lblText.Text = "<span class=\" text-danger \">Ngừng kích hoạt</span>";
//                }
//                else

//                {
//                    btnDeactive.Visible = false;
//                    btnActive.Visible = true;
//                    //lblText.Text = "<span class=\"badge badge-soft-success\">Đã kích hoạt</span>";
//                    lblText.Text = "<span class=\"text-success\">Đã kích hoạt</span>";
//                }
//            }

//        }
//    }
//    protected void btnSave_Click(object sender, EventArgs e)
//    {
//        try
//        {
//            foreach (RepeaterItem item in rptProductCategory.Items)
//            {
//                Literal lblProductCategory_ID = item.FindControl("lblProductCategory_ID") as Literal;
//                TextBox txtSort = item.FindControl("txtSort") as TextBox;
//                if (lblProductCategory_ID != null)
//                {
//                    ProductCategoryRow _ProductCategoryRow = BusinessRulesLocator.GetProductCategoryBO().GetByPrimaryKey(Convert.ToInt32(lblProductCategory_ID.Text));
//                    if (_ProductCategoryRow != null)
//                    {
//                        if (!string.IsNullOrEmpty(txtSort.Text))
//                        {
//                            _ProductCategoryRow.Sort = Convert.ToInt32(txtSort.Text);
//                        }
//                        else
//                        {
//                            _ProductCategoryRow.Sort = 99;
//                        }

//                        BusinessRulesLocator.GetProductCategoryBO().Update(_ProductCategoryRow);
//                        lblMessage.Text = ("Sắp xếp thành công !");
//                        lblMessage.Visible = true;
//                    }
//                }
//            }
//        }
//        catch (Exception ex)
//        {
//            Log.writeLog("btnSave_Click", ex.ToString());
//        }
//    }
//}