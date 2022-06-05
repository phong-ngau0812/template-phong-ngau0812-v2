using DbObj;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SystemFrameWork;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadChartNewsByYear();
        }
    }
    protected void LoadChartNewsByYear()
    {
        //int Year = DateTime.Now.Year;
        //try
        //{
        //    DataTable dt = BusinessRulesLocator.Conllection().GetChartNews(Year);
        //    if (dt.Rows.Count == 1)
        //    {
        //        NowYear.Value = dt.Rows[0]["DataNow"].ToString();
        //        LastYear.Value = dt.Rows[0]["DataLast"].ToString();
        //    }
        //}
        //catch (Exception ex)
        //{
        //    Log.writeLog("LoadChartNewsByYear", ex.ToString());
        //}
    }

}