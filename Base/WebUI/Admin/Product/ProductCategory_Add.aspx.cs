//using DbObj;
//using System;
//using System.Collections.Generic;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using SystemFrameWork;

//public partial class Backend_Admin_Product_ProductCategory_Add : System.Web.UI.Page
//{
//	public String title = "Thêm mới danh mục sản phẩm";
//	public String avatar = string.Empty;
//	protected void Page_Load(object sender, EventArgs e)
//	{
//		CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser
//		{
//			BasePath = "/ckfinder"
//		};
//		_FileBrowser.SetupCKEditor(txtDescription);
//		if (!IsPostBack)
//		{
//			LoadCateProduct();
//		}
//	}
//	protected DataTable DeQuyDanhMuc(DataTable dt, string Cha, int ParentID)
//	{
//		try
//		{
//			if (ParentID > 0)
//			{

//				DataTable dtChild = new DataTable();
//				dtChild = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable(" Parent_ID =" + ParentID + "  and Status<>-1", " Name ASC");
//				if (dtChild.Rows.Count > 0)
//				{
//					foreach (DataRow itemChild in dtChild.Rows)
//					{
//						DataRow itemNewsCategoryParent = dt.NewRow();
//						itemNewsCategoryParent["ProductCategory_ID"] = itemChild["ProductCategory_ID"];
//						itemNewsCategoryParent["Parent_ID"] = ParentID;
//						itemNewsCategoryParent["Name"] = Cha + " --> " + itemChild["Name"];
//						itemNewsCategoryParent["Status"] = itemChild["Status"];
//						itemNewsCategoryParent["Sort"] = itemChild["Sort"];
//						dt.Rows.Add(itemNewsCategoryParent);
//						DeQuyDanhMuc(dt, itemNewsCategoryParent["Name"].ToString(), Convert.ToInt32(itemNewsCategoryParent["ProductCategory_ID"]));
//					}
//				}
//			}
//		}
//		catch (Exception ex)
//		{
//			Log.writeLog("DeQuyDanhMuc", ex.ToString());
//		}
//		return dt;
//	}
//	protected void LoadCateProduct() {
//		try
//		{
//			DataTable dtProductCategoryParent = new DataTable();
//			dtProductCategoryParent.Clear();
//			dtProductCategoryParent.Columns.Add("ProductCategory_ID");
//			dtProductCategoryParent.Columns.Add("Parent_ID");
//			dtProductCategoryParent.Columns.Add("Name");
//			dtProductCategoryParent.Columns.Add("Status");
//			dtProductCategoryParent.Columns.Add("Sort");
//			DataTable dt = new DataTable();
//			dt = BusinessRulesLocator.GetProductCategoryBO().GetAsDataTable("Parent_ID=0 and Status <> -1", "ProductCategory_ID ASC");
//			foreach (DataRow item in dt.Rows)
//			{
//				DataRow itemProductCategoryParent = dtProductCategoryParent.NewRow();
//				itemProductCategoryParent["ProductCategory_ID"] = item["ProductCategory_ID"];
//				itemProductCategoryParent["Parent_ID"] = item["Parent_ID"];
//				itemProductCategoryParent["Name"] = "" + item["Name"] + "";
//				itemProductCategoryParent["Status"] = item["Status"];
//				itemProductCategoryParent["Sort"] = item["Sort"];
//				dtProductCategoryParent.Rows.Add(itemProductCategoryParent);
//				DeQuyDanhMuc(dtProductCategoryParent, itemProductCategoryParent["Name"].ToString(), Convert.ToInt32(itemProductCategoryParent["ProductCategory_ID"]));
//			}
//			if (dtProductCategoryParent.Rows.Count > 0)
//			{
//				ddlCate.DataSource = dtProductCategoryParent;
				
//				ddlCate.DataTextField = "Name";
//				ddlCate.DataValueField = "ProductCategory_ID";
//				ddlCate.DataBind();
//			}
//			ddlCate.Items.Insert(0, new ListItem("-- Danh mục --", "0"));
		
//		}
//		catch (Exception ex)
//		{
//			Log.writeLog("LoadCateProduct",ex.ToString());
//		}
//	}
//	protected void btnSave_Click(object sender, EventArgs e)
//	{
//		try
//		{
//			if (Page.IsValid)
//			{
//				ProductCategoryRow _ProductCategoryRow = new ProductCategoryRow();
//				_ProductCategoryRow.Name = string.IsNullOrEmpty(txtTitle.Text) ? "" : txtTitle.Text;
//				_ProductCategoryRow.Description = string.IsNullOrEmpty(txtDescription.Text) ? "" : txtDescription.Text;
//				_ProductCategoryRow.Summary = string.IsNullOrEmpty(txtSummary.Text) ? "" : txtSummary.Text;
//				_ProductCategoryRow.Status = ckStatus.Checked ? 1 : 0;
//				_ProductCategoryRow.CreateBy = Convert.ToInt32(Session["SessionUserID"]);
//				_ProductCategoryRow.CreateDate = DateTime.Now;
//				_ProductCategoryRow.Level = Convert.ToInt32(ddlLevel.SelectedValue);
//				string fileimage = "";
//				if (fulAnh.HasFile)
//				{
//					fileimage = "/Backend/data/product/" + Common.CreateImgName(fulAnh.FileName);
//					fulAnh.SaveAs(Server.MapPath(fileimage));
//					if (!string.IsNullOrEmpty(fileimage))
//					{
//						_ProductCategoryRow.Image = fileimage;
//					}
//				}
//				if (ddlCate.SelectedValue != "0")
//				{
//					_ProductCategoryRow.Parent_ID = Convert.ToInt32(ddlCate.SelectedValue);
//				}
//				else
//				{
//					_ProductCategoryRow.Parent_ID = 0;
//				}
//				BusinessRulesLocator.GetProductCategoryBO().Insert(_ProductCategoryRow);
//				Response.Redirect("ProductCategory_List.aspx",false);
//			}
//		}
//		catch (Exception ex)
//		{
//			Log.writeLog("btnSave_Click", ex.ToString());
//		}
//	}
//	protected void btnBack_Click(object sender, EventArgs e)
//	{
//		Response.Redirect("ProductCategory_List.aspx", false);
//	}

//	protected void ddlCate_SelectedIndexChanged(object sender, EventArgs e)
//	{
//		if (ddlCate.SelectedValue != "0")
//		{
//			string[] listvalue = ddlCate.SelectedItem.Text.Split(' ');
//			int level = 2;
//			foreach (var item in listvalue)
//			{
//				if (item.Contains("-->"))
//				{
//					level++;
//				}
//			}
//			ddlLevel.SelectedValue = level.ToString();
//		}
//		else
//		{
//			ddlLevel.SelectedValue = "1";
//		}
//	}
//}