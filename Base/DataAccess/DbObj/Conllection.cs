
// <fileinfo name="DbObj\Conllection.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			You can update this source code manually. If the file
//			already exists it will not be rewritten by the generator.
//		</remarks>
//		<generator rewritefile="False" >Smc SaleFrame1.0</generator>
// </fileinfo>


using System;
using System.Data;
using System.Data.SqlClient;

namespace DbObj
{

    public class Conllection
            : Base.ConllectionBase
    {

        /// <summary>
        /// Initializes a new instance of the <see cref="Conllection"/> class.
        /// </summary>
        public Conllection()
        {
        }
        public DataSet GetProductV2(int currPage, int recodperpage, int Pagesize, int ProductCategory_ID, int Quality_ID, int ProductBrand_ID, int Country_ID, string CreateBy, DateTime FromDate, DateTime ToDate, string Name, string Where, string orderby)
        {
            DataSet dtResult = new DataSet();
            string LOCATION = "GetProductV2(int currPage, int recodperpage, int Pagesize, int ProductCategory_ID, int Quality_ID , int ProductBrand_ID, int Country_ID, string CreateBy, DateTime FromDate, DateTime ToDate, string Name, string orderby)";
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("spGetProduct_paging");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@currPage", currPage));
                cmd.Parameters.Add(new SqlParameter("@recodperpage", recodperpage));
                cmd.Parameters.Add(new SqlParameter("@Pagesize", Pagesize));
                cmd.Parameters.Add(new SqlParameter("@ProductCategory_ID", ProductCategory_ID));
                cmd.Parameters.Add(new SqlParameter("@Quality_ID", Quality_ID));
                cmd.Parameters.Add(new SqlParameter("@ProductBrand_ID", ProductBrand_ID));
                cmd.Parameters.Add(new SqlParameter("@Country_ID", Country_ID));
                cmd.Parameters.Add(new SqlParameter("@CreateBy", CreateBy));
                cmd.Parameters.Add(new SqlParameter("@FromDate", FromDate));
                cmd.Parameters.Add(new SqlParameter("@ToDate", ToDate));
                cmd.Parameters.Add(new SqlParameter("@Name", Name));
                cmd.Parameters.Add(new SqlParameter("@Where", Where));
                cmd.Parameters.Add(new SqlParameter("@orderby", orderby));
                return Retrieve(cmd).DataSet;
            }
            catch (Exception ex)
            {
                throw new Exceptions.DatabaseException(LOCATION, ex);
            }
            return dtResult;
        }
        ~Conllection()
        {
        }
    }
}

